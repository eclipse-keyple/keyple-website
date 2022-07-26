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
4. [Set up the development environment](#set-up-dev-environment)
5. [Implement the solution](#implement-the-solution)

---
## Plugin architecture

A Keyple reader plugin consists of three objects, a **plugin factory**, a **plugin** and a **reader**, which meet the following two interface specifications:
* **Common API**: public contract containing only generic types common to all plugins.
* **Plugin API**: private contract based on two types of interfaces:
  * **API** (Application Programming Interface): interface implemented by Keyple Service and directly usable by the plugin code.
  * **SPI** (Service Provider Interface): interface to be implemented by the plugin and directly used by Keyple Service.

The component diagram below illustrates the internal API/SPI links between the plugin and Keyple Service, as well as the public APIs exposed to the client application:
{{< figure src="/media/learn/developer-guide/component-dependencies/plugin_api.svg" caption="" numbered="true" >}}

---
## Select predefined features

The diagram below helps you to determine exactly which interfaces to implement according to the characteristics of the reader:
{{< figure src="/media/learn/developer-guide/design-guides/reader_plugin_activity_diagram.svg" caption="" numbered="true" >}}

{{% callout warning %}}
The `XxxPluginFactory`, `XxxPlugin` and `XxxReader` interfaces must be created.
They are specific to the plugin `Xxx` to be created but can remain empty if there is no specific feature.
{{% /callout %}}

---
## Define specific features

Depending on the characteristics of the reader, it may be necessary to add in the specific APIs configuration methods appropriate to the technical context.

These features can be exposed at three levels:
* In the **plugin factory** (`XxxPluginFactory` interface), for the initial configuration of the plugin (e.g. set custom plugin name).
* In the **plugin** (`XxxPlugin` interface), for dynamic configurations that can be applied to all the readers (e.g. put the readers in sleep mode).<br>
  The API will then be directly accessible from the client application through the `getExtension(...)` method of the plugin registered with Keyple Service.
* In the **reader** (`XxxReader` interface), for dynamic configurations specific to each reader (e.g. activate/deactivate a LED).<br>
  The API will then be directly accessible from the client application through the `getReaderExtension(...)` method of the reader provided by the plugin registered with Keyple Service.

---
## Set up dev environment

{{% callout warning %}}
For Java and Android projects, the code should be compliant with **Java 1.6** in order to address a wide range of applications.
{{% /callout %}}

If the reader plugin add-on is to be integrated into the Eclipse Keyple® project, it must use one of the following project templates:
* {{% staticref "media/project-templates/java/keyple-plugin-[READER_PLUGIN_NAME]-java-lib.zip" "newtab" %}}Java template{{% /staticref %}}: adapt fields `[READER_PLUGIN_NAME]`, `Xxx`, `xxx`, `TODO`
* {{% staticref "media/project-templates/android/keyple-plugin-[ANDROID_READER_PLUGIN_NAME]-java-lib.zip" "newtab" %}}Android template{{% /staticref %}}: adapt fields `[ANDROID_READER_PLUGIN_NAME]`, `Xxx`, `xxx`, `TODO`

{{% callout warning %}}
Before pushing the project to GitHub the first time, you must give write permission to some scripts files via the following commands:
{{< code lang="ini" >}}
git update-index --chmod=+x "gradlew"
git update-index --chmod=+x "scripts/check_version.sh"
git update-index --chmod=+x "scripts/prepare_javadoc.sh"
{{< /code >}}
{{% /callout %}}

If examples are proposed, they should be placed in the [keyple-java-example](https://github.com/eclipse/keyple-java-example) repository.

The contribution procedure is described [here]({{< relref "contributing.md" >}}).

---
## Implement the solution

{{% callout warning %}}
It is important to hide the internal Keyple interfaces of the **Plugin API** from the client application.
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

---
## API

* [Keyple Common API](https://eclipse.github.io/keyple-common-java-api)
* [Keyple Plugin API](https://eclipse.github.io/keyple-plugin-java-api)

---
## Download

* [Java components]({{< ref "components-java/overview/configuration-wizard" >}})