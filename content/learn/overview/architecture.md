---
title: Architecture
summary: Overall presentation of the Keyple architecture.
type: book
toc: true
draft: false
weight: 2
---

---
Keyple is designed to operate exchanges with secure data media such as smart cards, tags or smartphones.

Keyple is as much as possible agnostic towards the secured media as towards the hardware allowing to communicate with them.

In order to achieve these objectives Keyple consists of a central core to which can be attached add-ons providing solutions to the specific needs of the targeted application.
The core provides the basic services for registering add-ons and also provides generic interfaces independent of card and reader technologies. 

Add-ons are organized into four categories:
- Card extensions, offering high-level interfaces for managing exchanges between a client application and a particular card technology.
- Reader plugins, which interface with the hardware through unified APIs.
- Distributed libraries to manage readers remotely.
- Additional services such as the dynamic allocation of card resources.

The diagram below shows an overview of the Keyple layers:

{{< figure library="true" src="learn/overview/keyple_layers_overview.svg" >}}

The figure below illustrates the scope of the technical possibilities of the full Keyple ecosystem:

{{< figure library="true" src="learn/overview/architecture/Keyple_Components_Overview.svg" >}}
