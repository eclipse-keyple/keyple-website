---
title: Global Solution
type: book
toc: true
draft: false
weight: 110
---
{{% callout warning %}}
Version 1.0 of the documentation is no longer actively maintained. The site that you are currently viewing is an archived snapshot. For up-to-date documentation, see the latest version.
{{% /callout %}}

## Overview

The Keyple solution provides currently 2 modules:
 - the **Keyple Core**, a universal smart card reader interface to manage the setting of smart card reader, the detection and the communication with smart card, and the selection of card application.
 - the **Keyple Calypso**, a first smart card solution extension built on the Keyple Core, dedicated to manage Calypso processing, Calypso card identification, card command generation, card data recovery, authentication with the secure session.

{{< figure src="/media/archive-1.0/architecture/Keyple_Architecture_Global.svg" title="Keyple Architecture Global" >}}

The Keyple Core provides 3 interfaces:
 - the **Service API**, to allow terminal application to handle reader & select card
 - the **Card API**, for APDU command transmission, card data parsing
 - the **Plugin API**, to integrate specific smart card reader solutions.

The Keyple Calypso extension provides the Calypso API: a high-level interface to manage Calypso card processing.

---
## Application integration

The Card API is a low-level interface to manage the transmission of APDU commands with a smart card.
A terminal application operating processing with a specific smart card solution could be implemented directly on top the Card API.

{{< figure src="/media/archive-1.0/architecture/Keyple_Architecture_Application_Integration.svg" title="Keyple Architecture Application Integration" >}}

Another way offering a better abstraction on smart card technical settings could be to implement on the Card API a smart card solution library extension providing a high-level interface: a specific Solution API.
This is how the Keyple Calypso extension has be defined, the Calypso API is a high-level functional interface, which hides the low-level APDU operations.

---
## Reader integration

### native integration

The smart card readers could be directly integrated with the Keyple Core. By interfacing through the Plugin API, a specific plugin dedicated to a smart card reader solution, the Keyple Core could have the capability to fully manage the smart card readers corresponding to this native plugin.

{{< figure src="/media/archive-1.0/architecture/Keyple_Architecture_Reader_Integration_native.svg" title="Keyple Architecture Reader Integration Native" >}}

The Eclipse Keyple® project provides the plugin for the main standard smart card reader solutions.

{{< figure src="/media/archive-1.0/architecture/Keyple_Architecture_Native_Plugins.svg" title="Keyple Architecture Native Plugins" >}}

 - The PC/SC plugin is available for both the Java and the C++ implementation of Keyple, it allows to interface PC/SC reader on Windows, Linux and Mac OS.
 - For Android devices the NFC plugin allows to operate the standard NFC interface to handle external contactless smart card. And the OMAPI plugin provides the integration of internal eSE (embedded Secure Element) or UICC (SIM card). Both plugins support Keyple Java.
 - The Remote plugin (part of the Core distributed extension) allows to operate remote smart card readers.

### hybrid integration

It's also possible to integrate Keyple in a terminal solution already embedding not Keyple based terminal applications operating smart card solutions. In those kinds of terminal, a Reader Manager has already the direct control on a smart card reader and manage the smart card detection: depending on the type of smart card identified on the reader, a specific terminal application is requested to operated the processing of the smart card.

{{< figure src="/media/archive-1.0/architecture/Keyple_Architecture_Reader_Integration_hybrid.svg" title="Keyple Architecture Hybrid Plugins" >}}

In this case a reader manager plugin, also based on the Plugin API, could allow the Keyple Core to operate the processing of a specific smart card, when requested by the Reader Manager.

For example, an EMV certified reader manager could call a Keyple application in case of PPSE selection failure.

---
## Smart card processing
### stand-alone
By default, a terminal application manages the processing of a specific smart card in stand-alone with its local readers.

{{< figure src="/media/archive-1.0/architecture/Keyple_Architecture_Local_Plugin.svg" title="Keyple Architecture Local Plugin" >}}

### distributed
The **Distributed** extension of the Keyple Core provides a solution allowing a master terminal application to manage the processing of a smart card localized in a remote driven terminal.
{{< figure src="/media/archive-1.0/architecture/Keyple_Architecture_Remote_Plugin.svg" title="Keyple Architecture Remote Plugin" >}}

---
## Smart card transaction
There are two ways for a terminal application to manage a transaction with a smart card.
 - Either the smart card processing could be directly started by the terminal application.
 - Otherwise, the smart card processing could be launched when a smart card is inserted in a reader of the terminal.
 
### explicit selection
For a classic transaction,
 - the presence of a card is firtsly checked on a reader,
 - then the car is selected and identified,
 - finally, a transaction is processed with the card application.

{{< figure src="/media/archive-1.0/architecture/Keyple_CardTransaction_ActivityDiag_ExplicitSelection.svg" title="[Keyple Transaction Explicit Selection" >}}
 
### default selection
 - For automatons (e.g. a ticketing validator), the ticketing transaction is often driven by the insertion of a card.
 - Keyple Core allows to define a default selection on Observable Reader, and in return to be notified of successful selections.

{{< figure src="/media/archive-1.0/architecture/Keyple_CardTransaction_ActivityDiag_DefaultSelection.svg" title="[Keyple Transaction Default Selection" >}}
