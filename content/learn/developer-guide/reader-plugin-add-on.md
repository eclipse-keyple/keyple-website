---
title: Reader Plugin Add-on Developer Guide
linktitle: Reader plugin add-on
summary: How to develop an add-on to handle a specific hardware device.
type: book
toc: true
weight: 1
---

---
## Overview

This guide is intended to help developers who want to create a Keyple reader plugin add-on for a specific device.

---
## Operating mode

1. Learn the [plugin architecture](#plugin-architecture) concepts
2. [Select the predefined features](#select-predefined-features) that meet your need
3. [Define specific features](#define-specific-features) (optional)
4. [Implement the solution](#implement-the-solution)

---
## Plugin architecture

A Keyple reader plugin consists of three objects, a **plugin factory**, a **plugin** and a **reader**, which meet the following two interface specifications:
* **Common API**: public contract containing only generic types common to all plugins.
* **Plugin API**: private contract based on two types of interfaces:
  * **API** (Application Programming Interface): interface implemented by Keyple Service and directly usable by the plugin code.
  * **SPI** (Service Provider Interface): interface to be implemented by the plugin and directly used by Keyple Service.

The component diagram below illustrates the internal API/SPI links between the plugin and Keyple Service, as well as the public APIs exposed to the client application:
{{< figure library="true" src="learn/developer-guide/component-dependencies/plugin_api.svg" caption="" numbered="true" >}}

---
## Select predefined features

The diagram below helps you to determine exactly which interfaces to implement according to the characteristics of the reader:
{{< figure library="true" src="learn/developer-guide/design-guides/reader_plugin_activity_diagram.svg" caption="" numbered="true" >}}

{{% alert warning %}}
The `XxxPluginFactory`, `XxxPlugin` and `XxxReader` interfaces must be created.
They are specific to the plugin `Xxx` to be created but can remain empty if there is no specific feature.
{{% /alert %}}

---
## Define specific features

Depending on the characteristics of the reader, it may be necessary to add in the specific APIs configuration methods appropriate to the technical context.

These features can be exposed at three levels:
* In the **plugin factory** (`XxxPluginFactory` interface), for the initial configuration of the plugin (e.g. set custom plugin name).
* In the **plugin** (`XxxPlugin` interface), for dynamic configurations that can be applied to all the readers (e.g. put the readers in sleep mode).<br>
  The API will then be directly accessible from the client application through the `getExtension(...)` method of the plugin registered with Keyple Service.
* In the **reader** (`XxxReader` interface), for dynamic configurations specific to each reader (e.g. activate/deactivate a LED).<br>
  The API will then be directly accessible from the client application through the `getExtension(...)` method of the reader provided by the plugin registered with Keyple Service.

---
## Implement the solution

{{% alert warning %}}
It is important to hide the internal Keyple interfaces of the **Plugin API** from the client application.
{{% /alert %}}

For this purpose, it is suggested to respect the following programming pattern based on the use of:
* public interfaces,
* private interfaces adapters (package visibility) accessible from a public provider/builder.
{{< figure library="true" src="learn/developer-guide/design-guides/reader_plugin_class_diagram.svg" caption="" numbered="true" >}}

{{% alert note %}}
It is possible to use other alternatives to the factory provider depending on the need.
For example, if the plugin factory needs to expose specific configuration methods, it is recommended to use the builder pattern instead of the provider pattern in order to get a properly initialized factory.
Thus, the factory does not expose any method.
{{% /alert %}}

---
## API

* [Keyple Common API](https://eclipse.github.io/keyple-common-java-api)
* [Keyple Plugin API](https://eclipse.github.io/keyple-plugin-java-api)

---
## Download

* [Java components]({{< ref "components-java/overview/configuration-wizard" >}})