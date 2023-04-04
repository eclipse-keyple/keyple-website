---
title: Calypso Application User Guide
linktitle: Calypso application
summary: How to develop an end-user application using the Calypso card extension add-on.
type: book
toc: true
draft: false
weight: 4
---

---
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
{{< figure src="/media/learn/user-guide/calypso-application/calypso_application_overview.svg" caption="" >}}

---
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

---
## The Calypso extension service

As part of the Calypso card extension add-on, the Calypso extension service is the provider of the API implementations.

The service is accessible by invoking the `CalypsoExtensionService.getInstance()` static method.

{{< code lang="java" >}}
CalypsoExtensionService calypsoExtensionService = CalypsoExtensionService.getInstance();
{{< /code >}}

During initialization, it is recommended to check the extension with the smart card service to ensure the compatibility of the different libraries involved.

In case of incompatibility a warning will be produced in the log file.

{{< code lang="java" >}}
smartCardService.checkCardExtension(calypsoExtensionService);
{{< /code >}}

---
## Select a card
In order to perform a transaction it is necessary to have selected the card first.

To do this, you must create a selection case for a selection scenario by invoking the `createCardSelection()` method.

In addition to the filtering capabilities offered by Keyple Service, the Calypso Selection API allows you to add commands that will be sent to the card after a successful selection (the details of these features are described in the API documentation). 

The resulting `SmartCard` can be cast to a `CalypsoCard` object which concentrate all known information about the card being processed.
Its content is dynamically updated during the transaction.
The client application will use it to get the data necessary for its business logic.

{{< code lang="java" >}}
// Create a card selection manager.
CardSelectionManager cardSelectionManager = smartCardService.createCardSelectionManager();

// Create a card selection using the Calypso card extension.
cardSelectionManager.prepareSelection(
        calypsoExtensionService
                .createCardSelection()
                .filterByDfName(AID));

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

---
## Set up security settings
{{% callout note %}}
The security settings must be initialized only for secure transactions.
{{% /callout %}}

The API offers several types of settings such as choosing the SAM to use, enabling various modes, specifying keys for legacy cards, etc... (see the API documentation for more information).

When using a SAM, it is necessary to select it on a relevant reader.
This selection can be done with the `createSamSelection()` method and its direct processing by a reader or with the Card Resource Service.

In the case of the Card Resource Service, you have to create a profile extension using the `createSamResourceProfileExtension(...)` method, specifying the previously built selection case, and then associate it to a dedicated profile in the service (see the [Card Resource Service User Guide]({{< relref "card-resource-service.md" >}})).

The following snippet shows the initialization of the card resource service with a SAM profile: 
{{< code lang="java" >}}
// Create a SAM selection case
CalypsoSamSelection samSelection = CalypsoExtensionService.getInstance().createSamSelection();

// Create a SAM resource profile extension
CardResourceProfileExtension samCardResourceExtension =
    CalypsoExtensionService.getInstance().createSamResourceProfileExtension(samSelection);

// Get the card resource service
CardResourceService cardResourceService = CardResourceServiceProvider.getService();

// Create a minimalist configuration (no plugin/reader observation)
cardResourceService
    .getConfigurator()
    .withPlugins(
        PluginsConfigurator.builder().addPlugin(plugin, new ReaderConfigurator()).build())
    .withCardResourceProfiles(
        CardResourceProfileConfigurator.builder(SAM_PROFILE_NAME, samCardResourceExtension)
            .withReaderNameRegex(readerNameRegex)
            .build())
    .configure();

// Start the card resource service
cardResourceService.start();

// Verify the resource availability
CardResource cardResource = cardResourceService.getCardResource(SAM_PROFILE_NAME);

if (cardResource == null) {
  throw new IllegalStateException(
      String.format(
          "Unable to retrieve a SAM card resource for profile '%s' from reader '%s' in plugin '%s'",
            SAM_PROFILE_NAME, readerNameRegex, plugin.getName()));
}

// Release the resource
cardResourceService.releaseCardResource(cardResource);
{{< /code >}}

Here is the creation of the security settings using a SAM resource obtained from the card resource service: 
{{< code lang="java" >}}
// Create security settings that reference the same SAM profile requested from the card resource service.
CardResource samResource = CardResourceServiceProvider.getService().getCardResource(SAM_PROFILE_NAME);

CardSecuritySetting cardSecuritySetting =
    CalypsoExtensionService.getInstance()
        .createCardSecuritySetting()
        .setControlSamResource(samResource.getReader(), (CalypsoSam) samResource.getSmartCard());
{{< /code >}}

---
## Operate a card transaction
It is possible to perform secure or non-secure transactions depending on the need.
A transaction is managed by a dedicated `CardTransactionManager` which is provided by the Calypso extension service.

The transaction manager provides high-level API to manage transactions with a Calypso card. 
The provided `CalypsoCard` object is kept and updated dynamically all along the transaction process.

The transaction takes place in several repeatable steps: 
* Preparation of the commands to be sent to the card. Several command preparations can be stacked (no communication neither with the card nor with the SAM).
* Processing of the prepared commands. Performs all necessary communications with the card and/or the SAM to carry out the previously prepared operations.

{{< code lang="java" >}}
try {
  // Performs file reads using the card transaction manager in secure mode.
  cardExtension
      .createCardTransaction(cardReader, calypsoCard, cardSecuritySetting)
      .prepareOpenSecureSession(WriteAccessLevel.DEBIT)
      .prepareReadRecord(SFI_ENVIRONMENT_AND_HOLDER, RECORD_NUMBER_1)
      .prepareCloseSecureSession()
      .processCommands(true);
} finally {
  try {
    CardResourceServiceProvider.getService().releaseCardResource(samResource);
  } catch (RuntimeException e) {
    logger.error("Error during the card resource release: {}", e.getMessage(), e);
  }
}
{{< /code >}}

---
## API

* [Calypsonet Terminal Reader API](https://terminal-api.calypsonet.org/apis/calypsonet-terminal-reader-api/)
* [Calypsonet Terminal Calypso API](https://terminal-api.calypsonet.org/apis/calypsonet-terminal-calypso-api/)
* [Keyple Common API](https://eclipse.github.io/keyple-common-java-api)
* [Keyple Card Calypso API](https://eclipse.github.io/keyple-card-calypso-java-lib)

---
## Examples

* [Java examples](https://github.com/eclipse/keyple-java-example)

---
## Download

* [Java components]({{< ref "components-java/overview/configuration-wizard" >}})