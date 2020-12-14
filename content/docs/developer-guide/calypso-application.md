---
title: Calypso application
type: book
toc: true
draft: false
weight: 330
---

## Overview

**Work in Progress**

Keyple API was designed to support an extension system. On top of **Keyple Core**, APIs can be developed to extend
Keyple features. For example, Calypso Network Association provides **Keyple Calypso Extension**. 

The use of **Keyple Calypso Extension** open the ability to operate commands with a calypso Portable Object and to manage a 
secure calypso transaction.

The diagram below shows the role of the **Keyple Calypso Extension** components in the software layers for a local application :

{{< figure library="true" src="calypso-app-development/component/Local_Component_Overview.svg" title="" >}}

## Before you start
1. In pre-requisite, have knowledge of the standard Calypso.
1. Read the [common concepts]({{< relref "common-concepts.md" >}}) page and become familiar with the basic concepts on which **Keyple** is based.
1. Any implementation of a Keyple application starts with the implementation of **Keyple Core**, please study the [workflow]({{< relref "local-application.md" >}}) proposed in Local application guide.
1. Read chapter [Concepts](#concepts) to understand the main terms and concepts of the  **Keyple Calypso Extension** API.
1. Explore the [Keyple Calypso API](#keyplecalypsoapi) to discover all the possibilities offered by **Keyple Calypso Extension**.
1. Take inspiration from the [examples](#examples).
1. Follow the explanations given in the [Build your first app]({{< relref "build-your-first-app" >}}) section to configure your environment.
1. Using the [component]({{< ref "components/index.md" >}}) page, import **Keyple Core** and **Keyple Calyspo Extension** into your project and start playing with **Keyple**.

## How to use it

1. In pre-requisite, read page [Develop a Local Application]({{< relref "local-application.md" >}}) to understand the main concepts of Keyple in a local application.
1. Read chapter [Concepts](#concepts) to understand the main terms and concepts of the  **Keyple Calypso Extension** API.

## Concepts

Here are the main concepts to keep in mind before continuing to read this developer guide :

### Calypso PO

Concentrate all known informations about the Personal Object being processed. Accessible informations are
* The application identification fields (revision/version, class, DF name, serial number, ATR, issuer)
* The indication of the presence of optional features (Stored Value, PIN, Rev3.2 mode, ratification management)
* The management information of the modification buffer
* The invalidation status
* The files, counters, SV data read or modified during the execution of the processes defined  by PoTransaction

Calypso PO fields are populated from a CardSelectionResponse obtained through the process of a PO selection.

### ElementaryFile

Object containing the description of a Calypso Elementary File. Can be retrieved from Calypso PO using its SFI. 

### PoSelection

Service extending Keyple Core Abstract Card Selection to manage specific features of Calypso POs during the selection:
* Send APDU Commands to the POs right after the card selection.
* Produce a Calypso PO from the CardSelectionResponse. The object is filled with the PO identification data from the FCI and the
possible responses to additional APDU commands executed after the selection.

```java
    ...
    // Prepare a Calypso PO selection
    CardSelectionsService cardSelectionsService = new CardSelectionsService();

    // Setting of an AID based selection of a Calypso REV3 PO
    // Select the first application matching the selection AID whatever the card communication
    // protocol keep the logical channel open after the selection

    // Calypso selection: configures a PoSelection with all the desired attributes to
    // make the selection and read additional information afterwards
    PoSelection poSelection =
        new PoSelection(
            PoSelector.builder()
                .cardProtocol(ContactlessCardCommonProtocols.ISO_14443_4.name())
                .aidSelector(
                    CardSelector.AidSelector.builder().aidToSelect(CalypsoClassicInfo.AID).build())
                .invalidatedPo(PoSelector.InvalidatedPo.REJECT)
                .build());

    // Prepare the reading order.
    poSelection.prepareReadRecordFile(
        CalypsoClassicInfo.SFI_EnvironmentAndHolder, CalypsoClassicInfo.RECORD_NUMBER_1);

    // Add the selection case to the current selection (we could have added other cases
    // here)
    cardSelectionsService.prepareSelection(poSelection);
    CalypsoPo calypsoPo = (CalypsoPo) cardSelectionsService.processExplicitSelections(poReader).getActiveSmartCard();
    ...
```

### Calypso SAM

Concentrates all the informations we know about the SAM currently selected. Accessible informations are:
 * The Sam Revision
 * The Serial number
 * The Platform identifier
 * The Application Type
 * The Application SubType
 * The Software Issuer identifier
 * The Software Version number
 * The Software Revision number

Calypso SAM fields are populated by analysis of the ATR within a CardSelectionResponse obtained through the process of a SAM selection.

### SamSelection

Service extending Keyple Core Abstract Card Selection specialized to manage the specific characteristics of Calypso SAMs. 
The service provides an instance of Calypso SAM and may execute the unlock command during the selection process.

### PoSecuritySettings

Concentrate the security settings involved in Calypso Secure Sessions:
* A reference to the Sam resource
* The default KIF  
* The default KVC
* The default Key Record Number
* The modification mode
* The ratification mode
* The pin transmission mode
* The default Pin Ciphering Key
* The SV Get Log Reade mode
* the SV Negative balance

 The fields are populated with default values when the object is instantiated but can be customized to adjust the settings
 to the application needs.
 
```java
    // Security settings
    // Both Reload and Debit SV logs are requested
    PoSecuritySettings poSecuritySettings =
        new PoSecuritySettings.PoSecuritySettingsBuilder(samResource)
            .svGetLogReadMode(SvSettings.LogRead.ALL)
            .build();
```

### SAM Resource Managers

Services providing methods to allocate/deallocate SAM resources. Keyple Calypso API provides 3 type of managers: Default, 
Factory, Pool. The choice of the manager to use depends on the abilities of the plugin used for the SAM connexion.

### PoTransaction

Service providing high-level API to manage transactions with a Calypso PO. The tied Calypso PO Object  is kept and updated at
each step of using this service. 

This service workflow is composed of two steps:
* Prepare the commands to be executed to the PO
* Process the prepared commands. Regarding of commands, the presence of SAM could be mandatory.

```java
    // Security settings
    // Both Reload and Debit SV logs are requested
    PoSecuritySettings poSecuritySettings =
        new PoSecuritySettings.PoSecuritySettingsBuilder(samResource)
            .svGetLogReadMode(SvSettings.LogRead.ALL)
            .build();
```

## API

## Examples