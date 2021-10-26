---
title: Common concepts
summary: Glossary of the key terms of the Keyple solution.
type: book
toc: true
draft: false
weight: 300
---
{{% callout warning %}}
Version 1.0 of the documentation is no longer actively maintained. The site that you are currently viewing is an archived snapshot. For up-to-date documentation, see the latest version.
{{% /callout %}}

This page describes the core elements of Keyple, i.e. the concepts and APIs of **Keyple Core** that are used to build any application implementing Keyple.
 
It is essential for the future user of Keyple to be familiar with what is said in this chapter because the other modules made available by the project are all dependent on **Keyple Core**.

---
## Reader

Keyple's primary goal being to interact with smart cards (or smartphones) worn by individuals, it is logical to put the Reader at the top of **Keyple Core**'s concepts.

Indeed, it is through the reader interfaces that all interactions with the smart cards will take place, either directly via **Keyple Core** or using an extension (such as **Keyple Calypso**).

These interfaces provide the means to
* identify the underlying physical reader,
* manage communication protocols,
* detect the presence and communicate with smart cards.

The reader concept also applies to the hardware interfaces used to communicate with security elements such as SAMs (Secure Access Modules), which are sometimes integrated into devices and the virtual interfaces represented by the remote implementations.

[More information]({{< relref "../architecture/keyple-core.md#reader-access" >}})

---
## Plugin

In Keyple language a plugin is a service that allows the management of readers of a certain type.
The plugin is responsible for informing the application about the availability of readers.
The readers of the same plugin are usually hardware linked to the same physical interface.

Depending on its profile, an application may use different types of plugins to communicate with the different elements it needs (card, SAM).

The Plugin interface essentially allows to list and retrieve the available readers.

[More information]({{< relref "../architecture/keyple-core.md#reader-access" >}})

---
## Smart card service

This is the **Keyple Core** service that concentrates the knowledge of active plugins and readers.

At startup, a Keyple application must register the plugins it uses. Conversely, it can also unregister them.

The **SmartCardService** will then make sure that the resources used are properly released.

[More information]({{< relref "../architecture/keyple-core.md#reader-access" >}})

---
## Observation

The observation concept applies to readers as well as to plugins; optional, it is used depending on the needs.

It consists in monitoring changes such as reader connection/disconnection or card insertion/removal and informing the observing application through a dedicated interface.

Not all plugins and readers are observable.

[More information]({{< relref "../architecture/keyple-core.md#reader-notifications" >}})

---
## Selection

In Keyple the concept of selection is derived from the application selection defined by the ISO7816-4 standard.

It supplements it by managing cards that do not have the standard command using identification mechanisms based on Answer To Reset and the communication protocol, and also by allowing the execution of commands immediately following application selection or detection.

This principle optimizes the processing by allowing the application to elaborate advanced card discovery requests.

Several targets can be defined by the application according to the different customer cards expected.

The **default selection** principle consists in providing an observable reader with a set of selection cases corresponding to the expected cards and receiving notifications containing not only the card identification but also the result of all additional commands that the application will have attached.

[More information]({{< relref "../architecture/keyple-core.md#card-selection" >}})

---
## Abstract smart card

The **abstract smart card** concept is used by specific extensions (e.g. **Keyple Calypso**) and by the **Keyple Core** selection mechanism.
It corresponds to an abstract container model implemented by the extension specific to a card type and returned by the selection process.

This container will be able to carry all the useful information known about the card.

Note: this concept, mentioned here for understanding, should not appear to the application developer if he uses a card extension.

[More information]({{< relref "../architecture/keyple-core.md#card-selection" >}})