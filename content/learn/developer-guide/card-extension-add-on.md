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
4. [Set up the development environment](#set-up-dev-environment)
5. [Implement the solution](#implement-the-solution)

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
{{< figure src="/media/learn/developer-guide/component-dependencies/card_api.svg" caption="" numbered="true" >}}

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


## Set up dev environment

{{% callout warning %}}
For Java and Android projects, the code should be compliant with **Java 1.6** in order to address a wide range of
applications.
{{% /callout %}}

If the card extension add-on is to be integrated into the Eclipse Keyple® project, it must use the following project
template:

* {{% staticref "media/project-templates/java/keyple-card-[CARD_EXTENSION_NAME]-java-lib.zip" "newtab" %}}Java
  template{{% /staticref %}}: adapt fields `[CARD_EXTENSION_NAME]`, `Xxx`, `xxx`, `TODO`

{{% callout warning %}}
Before pushing the project to GitHub the first time, you must give write permission to some scripts files via the
following commands:
{{< code lang="ini" >}}
git update-index --chmod=+x "gradlew"
git update-index --chmod=+x "scripts/check_version.sh"
git update-index --chmod=+x "scripts/prepare_javadoc.sh"
{{< /code >}}
{{% /callout %}}

If examples are proposed, they should be placed in
the [keyple-java-example](https://github.com/eclipse-keyple/keyple-java-example) repository.

The contribution procedure is described [here]({{< relref "contributing.md" >}}).

<br>


## Implement the solution

{{% callout warning %}}
It is important to hide the internal interfaces of the **Keypop Card API** from the application.
{{% /callout %}}

For this purpose, it is suggested to respect the following programming pattern based on the use of:

* public interfaces,
* private interfaces adapters (package visibility) not accessible from a public service.
  {{< figure src="/media/learn/developer-guide/design-guides/card_extension_class_diagram.svg" caption="" numbered="true" >}}

<br>


## API

* [Keyple Common API](https://eclipse-keyple.github.io/keyple-common-java-api)
* [Keypop Reader API](https://keypop.org/apis/reader-layer/reader-api/)
* [Keypop Card API](https://keypop.org/apis/reader-layer/card-api/)

<br>


## Download

* [Java components]({{< ref "components/overview/configuration-wizard" >}})
