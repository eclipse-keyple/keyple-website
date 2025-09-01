---
title: Card Extension Add-on Developer Guide
linktitle: Card extension add-on
summary: How to develop an add-on to manage a specific type of card.
type: book
toc: true
weight: 2
---

<br>

## Overview

This guide is intended to help developers who want to create a Keyple card extension add-on for a specific card
technology.

<br>

## Operating mode

1. Learn the [card extension architecture](#card-extension-architecture) concepts
2. Take note of the [minimal requirements](#minimal-requirements)
3. [Define the card commands](#define-the-card-commands)
4. [Implement the solution](#implement-the-solution)

<br>

## Card extension architecture

A Keyple card extension contains a set of objects which meet the following three interface specifications:

* **Common API**: public contract including a generic type common to all card extensions.
* **Keypop Reader API**: public contract provided by the Eclipse Keypop project including two specific
  interfaces to be implemented by the card extension and required by the card selection manager.
* **Keypop Card API**: private contract provided by the Eclipse Keypop project based on two types of
  interfaces:
    * **API** (Application Programming Interface): interface implemented by Keyple Service and directly usable by the
      card extension code.
    * **SPI** (Service Provider Interface): interface to be implemented by the card extension and directly used by
      Keyple Service.

The component diagram below illustrates the internal API/SPI links between the card extension and Keyple Service, as
well as the public APIs exposed to the application:
{{< figure src="/media/learn/developer-guide/component-dependencies/Component_CardExtensionAddOn.svg" caption="" numbered="true" >}}

<br>

## Minimal requirements

The table below lists the objects that must be created and indicates the interfaces to be implemented for each of them:

| Object                     |      Common API       |       Keypop Reader API       |       Keypop Card API       |
|----------------------------|:---------------------:|:-----------------------------:|:---------------------------:|
| Card extension service     | `KeypleCardExtension` |                               |                             |
| Card selection parser      |                       |   `CardSelectionExtension`    | `CardSelectionExtensionSpi` |
| Smart card object          |                       | `SmartCard` or `IsoSmartCard` |       `SmartCardSpi`        |
| Card selection request DTO |                       |                               |  `CardSelectionRequestSpi`  |
| Card request DTO           |                       |                               |      `CardRequestSpi`       |
| APDU request DTO           |                       |                               |      `ApduRequestSpi`       |

{{% callout warning %}}
In the case where the smart card object has fields of type `interface`,
it will then be necessary to define for each of them and recursively a JSON deserializer and register it during the
service initialization with the method `JsonUtil.registerTypeAdapter(...)` provided by the
[Keyple Util]({{< ref "components/core/keyple-util-lib" >}}) library.

This will allow the transport of this object through the network when using the Keyple Distributed solution.
{{% /callout %}}

<br>

## Define the card commands

The card extension takes part in the communication with the card in two ways:

* **implicitly**, when the card is being selected, which is done directly by the application via the Keyple Service
  selection manager;
* **explicitly**, when the card has been selected, on request of the application, by direct use of the APIs exposed by
  the Card API.

For explicit communication, the card extension must require the application to provide a reference to a `CardReader` of
the Reader API.
This can then be cast internally to a `ProxyReaderApi` of the Card API through which it will be possible to transmit
card commands.

Each card extension is free to define the APIs it considers relevant to perform card transactions.

<br>

## Implement the solution

{{% callout warning %}}
It is recommended to hide the internal interfaces of the **Keypop Card API** from the application.
{{% /callout %}}

For this purpose, it is suggested to respect the following programming pattern based on the use of:

* public interfaces,
* private interfaces adapters (package visibility) not accessible from a public service.
  {{< figure src="/media/learn/developer-guide/design-guides/card_extension_class_diagram.svg" caption="" numbered="true" >}}

<br>

## API

* [Keyple Common API](https://docs.keyple.org/keyple-common-java-api)
* [Keypop Reader API](https://keypop.org/apis/reader-layer/reader-api/)
* [Keypop Card API](https://keypop.org/apis/reader-layer/card-api/)

<br>

## Download

* [Java components]({{< ref "components/overview/configuration-wizard" >}})
