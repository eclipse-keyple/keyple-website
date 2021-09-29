---
title: Architecture
summary: Overall presentation of the Eclipse Keyple™ architecture.
type: book
toc: true
draft: false
weight: 2
---

---
## Overview

Keyple is designed to operate exchanges with secure data media such as smart cards, tags or smartphones.

Keyple is as much as possible agnostic towards the secured media as towards the hardware allowing to communicate with them.

In order to achieve these objectives Keyple consists of a central core to which can be attached add-ons providing solutions to the specific needs of the targeted application.
The core provides the basic services for registering add-ons and also provides generic interfaces independent of card and reader technologies. 

Add-ons are organized into four categories:
- Card extensions, offering high-level interfaces for managing exchanges between a client application and a particular card technology.
- Reader plugins, which interface with the hardware through unified APIs.
- Distributed libraries to manage readers remotely.
- Additional services such as the dynamic allocation of card resources.

**The figure below illustrates the scope of the technical possibilities of the Keyple ecosystem:**

{{< figure library="true" src="learn/overview/architecture/Keyple_Components_Overview.svg" caption="Global Architecture of Keyple" numbered="true" >}}

---
## Keyple solution

The Eclipse Keyple solution provides currently 2 modules:
- the **Keyple Core**, a universal smart card reader interface to manage the setting of smart card reader, the detection and the communication with smart card, and the selection of card application.
- the **Keyple Calypso**, a first smart card solution extension built on the Keyple Core, dedicated to manage Calypso processing, Calypso card identification, card command generation, card data recovery, authentication with the secure session.

{{< figure library="true" src="learn/overview/architecture/Keyple_Architecture_Global.svg" caption="Keyple Architecture Global" numbered="true" >}}

The Keyple Core provides 3 interfaces:
- the **Service API**, to allow the terminal application to manage the reader and select the card,
- the **Card API**, for APDU command transmission, card data parsing,
- the **Plugin API**, to integrate specific smart card reader solutions.

The Keyple Calypso extension provides the **Calypso API**: a high-level interface to manage Calypso card processing.

---
## Application integration

The Card API is a low-level interface to manage the transmission of APDU commands with a smart card.
A terminal application operating processing with a specific smart card solution could be implemented directly on top the Card API.

{{< figure library="true" src="learn/overview/architecture/Keyple_Architecture_Application_Integration.svg" caption="Keyple Architecture Application Integration" numbered="true" >}}

Another way offering a better abstraction on smart card technical settings could be to implement on the Card API a smart card solution library extension providing a high level interface: a specific Solution API.
This is how the Keyple Calypso extension has be defined, the Calypso API is a high level functional interface, which hides the low-level APDU operations.

---
## Reader integration

### Native integration

The smart card readers could be directly integrated with the Keyple Core.
By interfacing through the Plugin API,
a specific plugin dedicated to a smart card reader solution,
the Keyple Core could have the capability to fully manage the smart card readers corresponding to this native plugin.

{{< figure library="true" src="learn/overview/architecture/Keyple_Architecture_Reader_Integration_native.svg" caption="Keyple Architecture Reader Integration Native" numbered="true" >}}

The Eclipse Keyple project provides the plugin for the main standard smart card reader solutions.

{{< figure library="true" src="learn/overview/architecture/Keyple_Architecture_Native_Plugins.svg" caption="Keyple Architecture Native Plugins" numbered="true" >}}

- The PC/SC plugin is available for both the Java and the C++ implementation of Eclipse Keyple, it allows to interface PC/SC reader on Windows, Linux and Mac OS.
- For Android devices the NFC plugin allows to operate the standard NFC interface to handle external contactless smart card. And the OMAPI plugin provides the integration of internal eSE (embedded Secure Element) or UICC (SIM card). Both plugins support Keyple Java.
- The Remote plugin (part of the Core distributed extension) allows to operate remote smart card readers.

### Hybrid integration

It's also possible to integrate Keyple in a terminal solution already embedding not Keyple based terminal applications operating smart card solutions.
In those kinds of terminal, a Reader Manager has already the direct control on a smart card reader and manage the smart card detection:
depending on the type of smart card identified on the reader, a specific terminal application is requested to operated the processing of the smart card.

{{< figure library="true" src="learn/overview/architecture/Keyple_Architecture_Reader_Integration_hybrid.svg" caption="Keyple Architecture Hybrid Plugins" numbered="true" >}}

In this case a reader manager plugin, also based on the Plugin API,
could allow the Keyple Core to operate the processing of a specific smart card,
when requested by the Reader Manager.

For example, an EMV certified reader manager could call a Keyple application in case of PPSE selection failure.

---
## Smart card processing

### Stand-alone
By default, a terminal application manages the processing of a specific smart card in stand-alone with its local readers.

{{< figure library="true" src="learn/overview/architecture/Keyple_Architecture_Local_Plugin.svg" caption="Keyple Architecture Local Plugin" numbered="true" >}}

### Distributed
The **Distributed** extension of the Keyple Core provides a solution allowing a master terminal application to manage the processing of a smart card localized in a remote driven terminal.
{{< figure library="true" src="learn/overview/architecture/Keyple_Architecture_Remote_Plugin.svg" caption="Keyple Architecture Remote Plugin" numbered="true" >}}

---
## Smart card transaction
There are two ways for a terminal application to manage a transaction with a smart card:
- Either the smart card processing could be directly started by the terminal application.
- Otherwise, the smart card processing could be launched when a smart card is inserted in a reader of the terminal.

### Explicit selection
For a classic transaction,
- the presence of a card is firstly checked on a reader,
- then the car is selected and identified,
- finally, a transaction is processed with the card application.

{{< figure library="true" src="learn/overview/architecture/Keyple_CardTransaction_ActivityDiag_ExplicitSelection.svg" caption="Keyple Transaction Explicit Selection" numbered="true" >}}

### Default selection
- For automatons (e.g. a ticketing validator), the ticketing transaction is often driven by the insertion of a card.
- Keyple Core allows to define a default selection on Observable Reader, and in return to be notified of successful selections.

{{< figure library="true" src="learn/overview/architecture/Keyple_CardTransaction_ActivityDiag_DefaultSelection.svg" caption="Keyple Transaction Default Selection" numbered="true" >}}

