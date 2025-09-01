---
title: Reader Plugin Add-on Developer Guide
linktitle: Reader plugin add-on
summary: How to develop an add-on to handle a specific hardware device.
type: book
toc: true
weight: 1
---

<br>

## Overview

This guide is intended to help developers who want to create a Keyple reader plugin add-on for a specific device.

<br>

## Operating mode

1. Learn the [plugin architecture](#plugin-architecture) concepts
2. [Select the predefined features](#select-predefined-features) that meet your need
3. [Define specific features](#define-specific-features) (optional)
4. [Implement the solution](#implement-the-solution)

<br>

## Plugin architecture

A Keyple reader plugin consists of three objects, a **plugin factory**, a **plugin** and a **reader**, which meet the
following interface specifications:

* **Common API**: public contract containing only generic types common to all plugins.
* **Plugin API**: private contract based on two types of interfaces:
    * **API** (Application Programming Interface): interface implemented by Keyple Service and directly usable by the
      plugin code.
    * **SPI** (Service Provider Interface): interface to be implemented by the plugin and directly used by Keyple Service.
* **Plugin Storage Card API** _(optional)_: private contract that may be involved when interactions with storage cards
  are required, in order to rely on an APDU interpreter. It is also based on two types of interfaces:
    * **API** (Application Programming Interface): interface implemented by the plugin and directly usable by the APDU
      interpreter, allowing the interpreter to call back into the plugin to handle specific behaviors required during
      storage card interactions.
    * **SPI** (Service Provider Interface): interface to be implemented by the APDU interpreter and directly usable by the plugin, allowing the plugin to invoke interpreter functions for storage card operations.

The component diagram below illustrates the internal API/SPI links between the plugin and Keyple Service, as well as the
public APIs exposed to the application:

{{< figure src="/media/learn/developer-guide/component-dependencies/Component_ReaderPluginAddOn.svg" caption="" numbered="true" >}}

<br>

## Select predefined features

The diagram below helps you to determine exactly which interfaces to implement according to the characteristics of the reader:
{{< figure src="/media/learn/developer-guide/design-guides/reader_plugin_activity_diagram.svg" caption="" numbered="true" >}}

{{% callout warning %}}
The `XxxPluginFactory`, `XxxPlugin` and `XxxReader` interfaces must be created.
They are specific to the plugin `Xxx` to be created but can remain empty if there is no specific feature.
{{% /callout %}}

<br>

## Define specific features

Depending on the characteristics of the reader, it may be necessary to add in the specific APIs configuration methods appropriate to the technical context.

These features can be exposed at three levels:
* In the **plugin factory** (`XxxPluginFactory` interface), for the initial configuration of the plugin (e.g. set custom plugin name).
* In the **plugin** (`XxxPlugin` interface), for dynamic configurations that can be applied to all the readers (e.g. put the readers in sleep mode).<br>
  The API will then be directly accessible from the application through the `getExtension(...)` method of the plugin registered with Keyple Service.
* In the **reader** (`XxxReader` interface), for dynamic configurations specific to each reader (e.g. activate/deactivate a LED).<br>
  The API will then be directly accessible from the application through the `getReaderExtension(...)` method of the reader provided by the plugin registered with Keyple Service.

<br>

## Implement the solution

{{% callout warning %}}
It is recommended to hide the internal Keyple interfaces of the **Plugin API** from the application.
{{% /callout %}}

For this purpose, it is suggested to respect the following programming pattern based on the use of:
* public interfaces,
* private interfaces adapters (package visibility) accessible from a public provider/builder.
{{< figure src="/media/learn/developer-guide/design-guides/reader_plugin_class_diagram.svg" caption="" numbered="true" >}}

{{% callout note %}}
It is possible to use other alternatives to the factory provider depending on the need.
For example, if the plugin factory needs to expose specific configuration methods, it is recommended to use the builder pattern instead of the provider pattern in order to get a properly initialized factory.
Thus, the factory does not expose any method.
{{% /callout %}}

<br>

## API

* [Keyple Common API](https://docs.keyple.org/keyple-common-java-api)
* [Keyple Plugin API](https://docs.keyple.org/keyple-plugin-java-api)
* [Keyple Plugin Storage Card API](https://docs.keyple.org/keyple-plugin-storagecard-java-api/)

<br>

## Download

* [Java components]({{< ref "components/overview/configuration-wizard" >}})