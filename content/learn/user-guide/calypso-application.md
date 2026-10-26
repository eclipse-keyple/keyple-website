---
title: Calypso Application User Guide
linktitle: Calypso application
summary: How to develop an end-user application using the Calypso card extension add-on.
type: book
toc: true
draft: false
weight: 6
---

<br>

## Overview

Keyple provides a card extension add-on dedicated to the Calypso® card technology.

This component allows operating commands with a Calypso card and to manage a secure Calypso transaction in a simple way. 
It completely hides the details of APDU orders that are sent to Calypso cards and SAMs, which are usually tedious operations.

The main features are:
* support for different card revisions;
* object mapping of card data structures;
* complete management of the secure session with SAMs;
* PIN code management;
* Stored Value operations management;
* card invalidation / rehabilitation.

The diagram below illustrates the organization of a Calypso application based on Keyple:
{{< figure src="/media/learn/user-guide/calypso-application/calypso_application_overview.drawio.svg" caption="" >}}

<br>

## Operating mode
{{% callout warning %}}
Pre-requisites:
* Have a global view of Calypso product concepts (cards, SAM, security principles)
* Have read the [Standalone Application User Guide]({{< relref "standalone-application.md" >}}) to understand the main concepts of Keyple in a standalone application
{{% /callout %}}

1. Access to the [Calypso card extension service](#the-calypso-extension-service)
2. [Select a card](#select-a-card)
3. [Set up the security settings](#set-up-security-settings) (optional)
4. [Operate a card transaction](#operate-a-card-transaction)

<br>

## The Calypso extension service

As part of the Calypso card extension add-on, the Calypso extension service is the provider of the API implementations.

The service is accessible by calling the `CalypsoExtensionService.getInstance()` static method.

{{< code lang="java" >}}
CalypsoExtensionService calypsoExtensionService = CalypsoExtensionService.getInstance();
{{< /code >}}

During initialization, it is recommended to check the extension with the smart card service to ensure the compatibility of the different libraries involved.

In case of incompatibility a warning will be produced in the log file.

{{< code lang="java" >}}
smartCardService.checkCardExtension(calypsoExtensionService);
{{< /code >}}

<br>

## Select a card
In order to perform a transaction it is necessary to have selected the card first.

To do this, you must create a selection case for a selection scenario by calling the `createCardSelection()` method.

In addition to the filtering capabilities offered by Keyple Service, the Calypso Selection API allows you to add
commands that will be sent to the card after a successful selection (the details of these features are described in the
API documentation).

The resulting `IsoSmartCard` can be cast to a `CalypsoCard` object which concentrate all known information about the 
card being processed.
Its content is dynamically updated during the transaction.
The application will use it to get the data necessary for its business logic.

{{< code lang="java" >}}
// Create a card selection manager.
CardSelectionManager cardSelectionManager =
    smartCardService.getReaderApiFactory().createCardSelectionManager();

// Create a card selection using the Calypso card extension.
cardSelectionManager.prepareSelection(
    smartCardService.getReaderApiFactory()
        .createIsoCardSelector()
        .filterByDfName(AID),
    calypsoExtensionService.getCalypsoCardApiFactory()
        .createCalypsoCardSelectionExtension());

// Actual card communication: process the card selection.
CardSelectionResult cardSelectionResult =
    cardSelectionManager.processCardSelectionScenario(cardReader);

// Get the SmartCard resulting of the selection.
CalypsoCard calypsoCard = (CalypsoCard) cardSelectionResult.getActiveSmartCard();

// Check the selection result.
if (calypsoCard == null) {
    throw new IllegalStateException("The card selection failed.");
}
{{< /code >}}

<br>

## Set up security settings
{{% callout note %}}
The security settings must be initialized only for secure transactions.
{{% /callout %}}

The API offers several types of settings such as choosing the SAM to use, enabling various modes, specifying keys for
legacy cards, etc... (see the API documentation for more information).

If the card transaction is to be secured using a symmetrical key cryptographic module (such as a SAM), it will be
necessary to initialize a `SymmetricSecuritySetting`, associated with an implementation of the cryptographic module
to be used (e.g. Calypso Crypto Legacy SAM Lib).

The SAM must first be selected via the Calypso Crypto Legacy SAM Lib.

In the case of the Card Resource Service, you have to create a profile extension, specifying the previously built
selection case, and then associate it to a dedicated profile in the service (see
the [Card Resource Service User Guide]({{< relref "card-resource-service.md" >}})).

The following snippet shows the selection of the SAM and the initialization of the security settings: 
{{< code lang="java" >}}
// Create a SAM selection manager.
CardSelectionManager samSelectionManager = readerApiFactory.createCardSelectionManager();

// Create a card selector without filer
CardSelector<IsoCardSelector> cardSelector = readerApiFactory.createIsoCardSelector();

// Retrieve the Legacy SAM API factory
LegacySamApiFactory legacySamApiFactory =
    LegacySamExtensionService.getInstance().getLegacySamApiFactory();

// Create a SAM selection using the Calypso Legacy SAM card extension.
samSelectionManager.prepareSelection(
    cardSelector, legacySamApiFactory.createLegacySamSelectionExtension());

// SAM communication: run the selection scenario.
CardSelectionResult samSelectionResult =
    samSelectionManager.processCardSelectionScenario(reader);

// Check the selection result.
if (samSelectionResult.getActiveSmartCard() == null) {
  throw new IllegalStateException("The selection of the SAM failed.");
}

// Get the Calypso SAM SmartCard resulting of the selection.
LegacySam sam = (LegacySam) samSelectionResult.getActiveSmartCard();

// Build the security settings
symmetricCryptoSecuritySetting =
    calypsoCardApiFactory.createSymmetricCryptoSecuritySetting(
        LegacySamExtensionService.getInstance()
            .getLegacySamApiFactory()
            .createSymmetricCryptoCardTransactionManagerFactory(samReader, sam));
{{< /code >}}

<br>

## Operate a card transaction
It is possible to perform secure or non-secure transactions depending on the need.
A transaction is managed by a dedicated `CardTransactionManager` which is provided by the Calypso card extension service.

The transaction manager provides high-level API to manage transactions with a Calypso card. 
The provided `CalypsoCard` object is kept and updated dynamically all along the transaction process.

The transaction takes place in several repeatable steps:

* Preparation of the commands to be sent to the card. Several command preparations can be stacked (no communication
  neither with the card nor with the SAM).
* Processing of the prepared commands. Performs all necessary communications with the card and/or the SAM to carry out
  the previously prepared operations.

{{< code lang="java" >}}
// Execute the transaction: the environment file is read within a secure session to ensure data
// authenticity.
calypsoCardApiFactory
    .createSecureRegularModeTransactionManager(cardReader, calypsoCard, symmetricCryptoSecuritySetting)
    .prepareOpenSecureSession(WriteAccessLevel.DEBIT)
    .prepareReadRecords(SFI_ENVIRONMENT_AND_HOLDER, 1, 1, 29)
    .prepareCloseSecureSession()
    .processCommands(ChannelControl.CLOSE_AFTER);
{{< /code >}}

<br>

## Specific security measures

### Legacy card authentication

In order to **securely manage legacy card solutions configured with DES or DES-X keys**, it is **imperative** to exchange
with these cards in secure sessions only APDU commands for which the size of the response data can be predetermined.

For a Keyple-based processing, this means that the following methods of the `TransactionManager` must not be used 
within a secure session: `prepareReadRecord(...)`, `prepareReadRecordsPartially(...)`, `prepareSearchRecords(...)` and
`prepareGetData(...)`.
The only exception is `prepareGetData(GetDataTag.FCI_FOR_CURRENT_DF)`, which is allowed within a secure session since
the size of its response data is known.

As these methods could be useful for high-performance identification of some card data, here's how to use them safely on
legacy cards:
- first of all, exchange these commands before opening a secure session: this enables effective identification of the
  card data,
- then, if any of the data read out of session is sensitive and requires authentication, repeat a secure read of the
  sensitive data within the session, using commands that predetermine the size of the response data.

### HCE service handling

In the context of access control, it is necessary to check the validity of the **HCE token** in order to accept and
authenticate card solutions based on an HCE-type NFC service.

While the `CalypsoCard` API doesn't directly provide this information, the two bytes of the HCE validity token can be 
easily obtained using the following snippet:

{{< code lang="java" >}}

import org.eclipse.keyple.core.util.BerTlvUtil;

[...]

    if (calypsoCard.isHce()) {
      byte[] hceValidityToken = extractHceValidityToken(calypsoCard.getSelectApplicationResponse());
      // Check the validity for the current
      [...]
    }

[...]

private static byte[] extractHceValidityToken(byte[] selectApplicationResponse) {
    byte[] fullSerialNumber = BerTlvUtil.parseSimple(selectApplicationResponse, true).get(0xC7);
    return Arrays.copyOf(fullSerialNumber, 2);
}

[...]
{{< /code >}}

### Ratification mechanism

In contactless mode, the card may be removed before the terminal has received the acknowledgement of the
*Close Secure Session* command: the terminal then cannot know whether the card has actually committed the
modifications made during the session.

The **ratification mechanism** handles this early card removal. It is enabled on the security settings by calling
`enableRatificationMechanism()` (disabled by default):
- a ratification command is added after the closing command in contactless mode,
- the card considers the secure session *ratified* only once it has processed that command: if the card is removed
  beforehand, the session stays **unratified** in the card, which thus keeps the proof that the terminal may not have
  been informed of the outcome,
- on cards where ratification happens on deselect, no ratification command is required (see
  `CalypsoCard.isRatificationOnDeselectSupported()`).

When a new secure session is opened, `CalypsoCard.isDfRatified()` tells whether the previous session has been
ratified, allowing the terminal to detect an interrupted transaction and to handle its resumption.

{{< code lang="java" >}}
// Build the security settings with the ratification mechanism enabled
symmetricCryptoSecuritySetting =
    calypsoCardApiFactory
        .createSymmetricCryptoSecuritySetting(
            LegacySamExtensionService.getInstance()
                .getLegacySamApiFactory()
                .createSymmetricCryptoCardTransactionManagerFactory(samReader, sam))
        .enableRatificationMechanism();
{{< /code >}}

Whether to enable the mechanism depends on which terminal resumes an interrupted transaction:
- **enable it** when the resumption may be handled by **another terminal**, since the proof of the interruption is
  then carried by the card itself. Typical case: several gates on the same access line of a network,
- **leave it disabled** when the resumption is necessarily handled by the **same terminal**, which keeps the context
  of the interrupted transaction. Typical case: a remote ticket reloading server.

{{% callout note %}}
The ratification mechanism can only be used within the **anti-passback delay** defined by the transport operator:
beyond this delay, an unratified session can no longer be handled as the resumption of an interrupted transaction.
{{% /callout %}}

<br>

## API

* [Keypop Reader API](https://keypop.org/apis/reader-layer/reader-api/)
* [Keypop Calypso Card API](https://keypop.org/apis/calypso-layer/calypso-card-api/)
* [Keypop Calypso Crypto Legacy SAM API](https://keypop.org/apis/calypso-layer/calypso-legacysam-api/)
* [Keyple Common API](https://docs.keyple.org/keyple-common-java-api)
* [Keyple Card Calypso API](https://docs.keyple.org/keyple-card-calypso-java-lib)
* [Keyple Card Calypso Crypto Legacy SAM API](https://docs.keyple.org/keyple-card-calypso-crypto-legacysam-java-lib)

<br>

## Examples

* [Java examples](https://github.com/eclipse-keyple/keyple-java-example)
* [C++ examples](https://github.com/eclipse-keyple/keyple-cpp-example)

<br>

## Download

* [Java components]({{< ref "components/overview/configuration-wizard" >}})

<br>

