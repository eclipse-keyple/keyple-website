---
title: Local application
type: book
toc: true
draft: false
weight: 310
---

> A local application is an application that runs in a device in contact with the end user.
> 
> It has at least one local smart card reader and manages itself the interaction with the user.
> 
> In the ticketing industry, it is typically the software that runs a validator, a vending machine or a control terminal.

## How to create such an application?
1. In pre-requisite, read the [common concepts]({{< relref "common-concepts.md" >}}) page and become familiar with the basic concepts on which **Keyple** is based.
1. Any implementation of a Keyple application starts with the implementation of **Keyple Core**, please study the [workflow](#workflow) proposed in the following chapter.
1. Explore the [Keyple Core API](#keyplecoreapi) to discover all the possibilities offered by **Keyple Core**.
1. Take inspiration from the [examples](#examples).
1. Follow the explanations given in the [Build your first app]({{< relref "build-your-first-app" >}}) section to configure your environment.
1. Using the [Component]({{< ref "components/index.md" >}}) link, import **Keyple Core** into your project and start playing with **Keyple**.
1. Don't forget to explore the potential of Keyple card-specific extensions such as **Keyple Calypso**.

## Workflow
**Keyple Core** is built around the concepts described [here]({{< relref "common-concepts.md" >}}) and sometimes proposes several ways to perform an action or to achieve a result depending on the needs of the application.

The purpose of this section is to guide you in its use.

### Creation of the Smart Card Service
This is the very first step in the realization of a Keyple application:

```java
    /* Get the instance of the SmartCardService */
    SmartCardService smartCardService = SmartCardService.getInstance();
```

The Smart Card Service is based on the SmartCardService object, which is a singleton that must be held by the application all along its execution.

Its main role is to centralize Keyple resources and manage their lifecycle.


### Choose the plugin

The Keyple application developer will choose the plugins he needs according to the equipment on which his Keyple application will run.

For example, if the environment is PC based, one will probably, but without obligation, go for the PC/SC plugin.

For an Andoid terminal environment, the plugin could be the standard Android NFC plugin or one of the plugins available from the industrial partners of the project. For a complete list of available plugins, please see this [page]({{< ref "components/index.md" >}}).

{{% alert note %}}
A new plugin can also be [created]({{< relref "create-plugin" >}}) if the envisaged hardware does not yet have its plugin.
{{% /alert %}}

### Register the plugin

The plugin registration consists in submitting its factory to the Smart Card Service.



```java
    /* Create a Exception Handler for plugin and reader observation */
    ExceptionHandlerImpl readerExceptionHandlerImpl = new ExceptionHandlerImpl();

    /* Assign PcscPlugin to the SmartCardService */
    plugin = smartCardService.registerPlugin(new PcscPluginFactory(null, readerExceptionHandlerImpl));
```

### Observation of the plugin
### Retrieve the reader
### Observation of the reader
### Container selection
### Implementation of the application service
### Stopping the application

## Keyple Core API

[Plugin-Reader class diagram]

[Selection class diagram]

## Examples

### UseCase1_ExplicitSelectionAid
### UseCase2_DefaultSelectionNotification
### UseCase3_SequentialMultiSelection
### UseCase4_GroupedMultiSelection
### Demo_CardProtocolDetection
### Demo_ObservableReaderNotification

## Download

[Keyple Core component]({{< ref "/components/_index.md" >}})