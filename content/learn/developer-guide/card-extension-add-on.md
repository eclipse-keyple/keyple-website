---
title: Card Extension Add-on Developer Guide
linktitle: Card extension add-on
summary: How to develop an add-on to manage a specific type of card.
type: book
toc: true
weight: 2
---

---
## Overview

This guide is intended to help developers who want to create a Keyple card extension add-on for a specific card technology.

---
## Operating mode

1. Learn the [card extension architecture](#card-extension-architecture) concepts
2. Take note of the [minimal requirements](#minimal-requirements)
3. [Define the card commands](#define-the-card-commands)
4. [Implement the solution](#implement-the-solution)

---
## Card extension architecture

A Keyple card extension contains a set of objects which meet the following three interface specifications:
* **Common API**: public contract including a generic type common to all card extensions.
* **Calypsonet Terminal Reader API**: public contract provided be Calypso Networks Association including two specific interfaces to be implemented by the card extension and required by the card selection manager.
* **Calypsonet Terminal Card API**: private contract provided be Calypso Networks Association based on two types of interfaces:
  * **API** (Application Programming Interface): interface implemented by Keyple Service and directly usable by the card extension code.
  * **SPI** (Service Provider Interface): interface to be implemented by the card extension and directly used by Keyple Service.

The component diagram below illustrates the internal API/SPI links between the card extension and Keyple Service, as well as the public APIs exposed to the client application:
{{< figure library="true" src="learn/developer-guide/component-dependencies/card_api.svg" caption="" numbered="true" >}}

---
## Minimal requirements

The table below lists the objects that must be created and indicates the interfaces to be implemented for each of them:

| Object | Common API | Calypsonet Terminal Reader API | Calypsonet Terminal Card API |
|---|:---:|:---:|:---:|
| Card extension service | `KeypleCardExtension` | | |
| Card selection parser | | `CardSelection` | `CardSelectionSpi` |
| Smart card object | | `SmartCard` | `SmartCardSpi` |
| Card selector DTO | | | `CardSelectorSpi` |
| Card selection request DTO | | | `CardSelectionRequestSpi` |
| Card request DTO | | | `CardRequestSpi` |
| APDU request DTO | | | `ApduRequestSpi` |

{{% alert warning %}}
In the case where the smart card object has fields of type `interface`,
it will then be necessary to define for each of them and recursively a JSON deserializer and register it during the service initialization with the method `JsonUtil.registerTypeAdapter(...)` provided by the [Keyple Util]({{< ref "components-java/core/keyple-util-java-lib" >}}) library.

This will allow the transport of this object through the network when using the Keyple Distributed solution.
{{% /alert %}}

---
## Define the card commands

The card extension takes part in the communication with the card in two ways:
* **implicitly**, when the card is being selected, which is done directly by the client application via the Keyple Service selection manager;
* **explicitly**, when the card has been selected, on request of the client application, by direct use of the APIs exposed by the Card API.

For explicit communication, the card extension must require the client application to provide a reference to a `CardReader` of the Reader API.
This can then be casted internally to a `ProxyReaderApi` of the Card API through which it will be possible to transmit card commands.

Each card extension is free to define the APIs it considers relevant to perform card transactions.

---
## Implement the solution

{{% alert warning %}}
It is important to hide the internal Calypsonet interfaces of the **Calypsonet Terminal Card API** from the client application.
{{% /alert %}}

For this purpose, it is suggested to respect the following programming pattern based on the use of:
* public interfaces,
* private interfaces adapters (package visibility) accessible from a public service.
{{< figure library="true" src="learn/developer-guide/design-guides/card_extension_class_diagram.svg" caption="" numbered="true" >}}

---
## API

* [Keyple Common API](https://eclipse.github.io/keyple-common-java-api)
* [Calypsonet Terminal Reader API](https://calypsonet.github.io/calypsonet-terminal-reader-java-api)
* [Calypsonet Terminal Card API](https://calypsonet.github.io/calypsonet-terminal-card-java-api)

---
## Download

* [Java components]({{< ref "components-java/overview/configuration-wizard" >}})
