---
title: The Keyple key concepts
linkTitle: Key concepts
summary: Understand the concepts behind Eclipse Keyple.
type: book
toc: true
draft: false
weight: 200
---

---
## Overview
This page describes the core elements of **Keyple**, i.e. the concepts and APIs of **Keyple Core** that are used to build any application implementing **Keyple**.
 
It is essential for the future user of **Keyple** to be familiar with what is said in this chapter because the other modules made available by the project are all dependent on **Keyple Core**.

---
## Reader

Keyple's primary goal being to interact with smart cards (or smartphones) worn by individuals, it is logical to put the Reader at the top of **Keyple Core**'s concepts.

Indeed, it is through the reader interfaces that all interactions with the smart cards will take place, either directly via the **Keyple Service** or using a card extension (such as **Keyple Calypso Card Extension**).

These interfaces provide the means to
* identify the underlying physical reader,
* manage communication protocols,
* detect the presence and communicate with smart cards.

The reader concept also applies to the hardware interfaces used to communicate with security elements such as SAMs (Secure Access Modules), which are sometimes integrated into devices and the virtual interfaces represented by the remote implementations.

To define the interface between an application and a player, Keyple relies on the [standard Terminal Reader API](https://calypsonet.github.io/calypsonet-terminal-reader-java-api/) proposed by Calypso Networks Association and thus inherits an existing modeling effort.

Another benefit of using this terminal API is the ability to certify the functioning of a Keyple terminal via the associated certification process.

This certification provides a guarantee that the terminal will function as expected.

[More information](keyple-core.md#reader-access)

---
## Plugin

In Keyple language a plugin is an add-on service that allows the management of readers of a certain type.
The plugin is responsible for informing the application about the availability of readers.
The readers of the same plugin are usually hardware linked to the same physical interface.

In order to be as independent as possible from the type of hardware used, Keyple proposes a plugin API.

The plugin API models the behavior of a smart card reader using a set of objects and methods that allow Keyple to work in the same way with different types of hardware.

Plugins covering standard interfaces are proposed directly (PC/SC, Andrdoid NFC/OMAPI) but it is also possible to develop a plugin to address the particularities of a specific hardware (see [Develop a plugin]({{< relref "learn/developer-guide/create-a-reader-plugin" >}}) and [Proprietary add-ons]({{< relref "external-extensions-and-support/proprietary-add-ons/" >}}))

Depending on its profile, an application may use different types of plugins to communicate with the different elements it needs (card, SAM).

[More information](keyple-core.md#reader-access)

---
## Card extension
A card extension is an add-on that provides high-level access to the features of a particular card technology.

The interface between the main Keyple service and a card extension is based on another API, the [standard Terminal Card API](https://calypsonet.github.io/calypsonet-terminal-card-java-api/), also proposed by the Calypso Networks Association.

This API models the operations that can be performed with a smart card through a reader. It also provides facilities for certifying the behavior of a system with respect to a card.

Two card extensions are provided natively by the Eclipse Keyple project:
- A generic card extension providing basic means to communicate with a card
- A Calypso card extension providing high level access to Calypso card features. It includes a Secure Session based transaction manager involving Calypso cards and SAMs.

---
## Smart card service

This is the **Keyple Core** service that concentrates the knowledge of active plugins and readers.

At startup, a Keyple application must register the add-ons (plugins and card extensions) it uses. Conversely, it can also unregister them.

The **SmartCardService** will then make sure that the resources used are properly released.

[More information](keyple-core.md#reader-access)

---
## Observation

The observation concept applies to readers as well as to plugins; optional, it is used depending on the needs.

It consists in monitoring changes such as reader connection/disconnection or card insertion/removal and informing the observing application through a dedicated interface.

Not all plugins and readers are observable.

[More information](keyple-core.md#reader-notifications)

---
## Selection

In Keyple the concept of selection is derived from the application selection defined by the ISO7816-4 standard.

It supplements it by managing cards that do not have the standard command using identification mechanisms based on Answer To Reset and the communication protocol, and also by allowing the execution of commands immediately following application selection or detection.

This principle optimizes the processing by allowing the application to elaborate advanced card discovery requests.

Several targets can be defined by the application according to the different customer cards expected.

The **default selection** principle consists in providing an observable reader with a set of selection cases corresponding to the expected cards and receiving notifications containing not only the card identification but also the result of all additional commands that the application will have attached.

[More information](architecture/keyple-core.md#card-selection)

---
## Abstract smart card

The **abstract smart card** concept is used by specific extensions (e.g. **Keyple Calypso**) and by the **Keyple Core** selection mechanism.
It corresponds to an abstract container model implemented by the extension specific to a card type and returned by the selection process.

This container will be able to carry all the useful information known about the card.

Note: this concept, mentioned here for understanding, should not appear to the application developer if he uses a card extension.

[More information](keyple-core.md#card-selection)