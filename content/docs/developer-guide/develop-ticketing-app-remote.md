---
title: Develop a Remote Ticketing Application
type: book
toc: true
draft: false
weight: 320
---

## Overview

**Keyple provides the "Keyple Remote Plugin" solution which allows a terminal to communicate with a smart card reader available in another terminal**.

In this way, you can manage transactions within a distributed architecture.

The diagram below shows the role of the **Keyple Remote Plugin** components in the software layers used in a distributed architecture :

{{< figure library="true" src="remote-plugin/component/Remote_Component_Overview.svg" title="" >}}

## How to use it ?

1. In pre-requisite, read page [Develop a Local Ticketing Application]({{< relref "develop-ticketing-app-local.md" >}}) to understand the main concepts of Keyple in a local application.
1. Read chapter [Concepts](#concepts) to understand the main terms and concepts of the **Keyple Remote Plugin** solution.
1. Read the introduction of chapter [Remote Plugins](#remote-plugins) to be informed about the different plugins and APIs proposed by the solution.
1. Using chapter [Use cases](#use-cases), find your use case. This will help you to determine exactly which library and API to use.
1. Using chapter [Download](#download), import into your project the libraries specified by your use case.
1. Using chapter [Network configuration](#network-configuration), implement the transport layer adapted to your network configuration.
1. Implement your ticketing services as specified in the associated use case.

## Concepts

Here are the main concepts to keep in mind before continuing to read this developer guide :

<div id="concepts-table-1">

| Concept | Description |
| ------- | ----------- |
| **Virtual Lib** | This is the library `keyple-plugin-remote-virtual`.<br>It must be imported and used by the application installed on the terminal not having local access to the smart card reader and that wishes to control the reader remotely. |
| **Native Lib** | This is the library `keyple-plugin-remote-native`.<br>It must be imported and used by the application installed on the terminal having local access to the smart card reader but wishes to delegate all or part of the ticketing processing to a remote application. |
| **Remote Plugin** | Part of the **Virtual Lib**, this is a Keyple plugin which provides only **Virtual Readers** to the application. It manages data exchanges with the **Native Service**. This plugin must be registered to the smart card service like any Keyple plugin. |
| **Virtual Reader** | Part of the **Remote Plugin**, this is a Keyple reader which has some specificities :<br>- each virtual reader is connected to a native reader ;<br>- any command sent by the application to a virtual reader will be forwarded to the associated native reader ;<br>- any event occurs on a native reader or plugin will be forwarded to the associated remote virtual reader or plugin. |
| **Native Service** | Part of the **Native Lib**, this service ensures data exchange between the **Remote Plugin** and native plugins and readers. It must be initialized and started by the host application. |
| **Factory** | **Remote Plugin** and **Native Service** each have a specific factory class to initialize them. |
| **Utility** | **Remote Plugin** and **Native Service** each have a specific utility class to access them everywhere in the code. |
| **Node** | **Remote Plugin** and **Native Service** each are associated to a specific node which is responsible for the interfacing with the **Network Endpoint**. |
| **Network Endpoint** | At the user's charge, this component ensures the network exchanges between the **Remote Plugin** and **Native Service** nodes. | 

</div>
<style>
#concepts-table-1 table th:first-of-type {
    width: 120px;
}
</style>

The diagram below illustrates the main functional concepts through a standard use case :

{{< figure library="true" src="remote-plugin/component/Remote_Component_Concepts_1.svg" title="" >}}

The second diagram below illustrates an arbitrary more complex possible use case with several hardware readers connected to different terminals.

These could be for example a ticketing reloading service, where the intelligence would be on the terminal with virtual readers, with thin clients on A & B terminals communicating locally with the cards.

In this use case, the **Remote Plugin** is used for card communication.

{{< figure library="true" src="remote-plugin/component/Remote_Component_Concepts_2.svg" title="" >}}

Here is another example, but this time it illustrates several **Remote Plugins** connected to the same **Native Service**.

These could be for example ticketing terminals with transaction logic, which communicate locally with cards, but which do not have SAM, and which use a SAM server with hardware reader.

In this use case, the **Remote Plugin** is used for SAM communication.

{{< figure library="true" src="remote-plugin/component/Remote_Component_Concepts_3.svg" title="" >}}

## Remote Plugins
 
The **Keyple Remote Plugin** solution provides **3** different specific **Remote Plugin** components, each one having a specific API described in chapter [Remote Plugins APIs](#remote-plugins-apis) designed on a **Client-Server** model in which **the Client is always the initiator of the processing** :

<div id="plugins-table-1">

| Plugin | Description |
| ------ | ----------- |
| [RemoteServerPlugin](#remoteserverplugin) | Allows to control from a **server** terminal a smart card reader available on a **client** terminal (e.g. PO reader). |
| [RemoteClientPlugin](#remoteclientplugin) or<br>[RemoteClientObservablePlugin](#remoteclientobservableplugin) | Allows to control from a **client** terminal a smart card reader available on a **server** terminal (e.g. SAM reader). |
| [RemotePoolClientPlugin](#remotepoolclientplugin) | Allows to control from a **client** terminal a **pool** of smart cards readers available on a **server** terminal (e.g. HSM readers). |

</div>
<style>
#plugins-table-1 table th:first-of-type {
    width: 220px;
}
</style>

Moreover, some plugins have different modes in which they allow or not the observation of plugin or reader events (such as smart card insertion, reader connection, etc...).

Each **Remote Plugin** is connected to a specific **Native Service** and is dependent on a specific node type (synchronous or asynchronous).
That's why it's very important to understand the following coexistence limitations :

* There can be **only one instance** of a specific **Native Service** per application.
* There can be **only one instance** of a specific **Remote Plugin** per application and per network communication configuration. There can therefore be a maximum of 2 instances of a specific **Remote Plugin** per application, one with a synchronous and the other one with an asynchronous network communication configuration.

### RemoteServerPlugin

This plugin allows controlling from a **server** terminal a smart card reader available on a **client** terminal (e.g. PO reader). 

| API | Client | Server |
| --- | ------ | ------ |
| **Library** | Native Lib | Virtual Lib |
| **Remote Plugin** / **Native Service** | `NativeClientService` | `RemoteServerPlugin` |
| **Factory** | `NativeClientServiceFactory` | `RemoteServerPluginFactory` |
| **Utility** | `NativeClientServiceUtils` | `RemoteServerPluginUtils` |

#### USE AND SEQUENCE OF OPERATIONS

* Server side :
    1. configure the factory by providing the network and plugin observer implementation. Please note that **this plugin is observable only to trigger ticketing services** on the server side, but does not allow observation on the native plugin (reader insertion, etc...),
    1. register the **Remote Plugin** to the smart card service using the factory,
    1. await for events of type `PluginEvent.READER_CONNECTED`,
    1. when an event occurs, get the specified virtual reader from the **Remote Plugin**,
    1. use information inside the virtual reader to identify the ticketing service to execute,
    1. execute the specified ticketing service using the virtual reader and all of its others information,
    1. terminate the remote ticketing service using the **Remote Plugin** API by transmitting if needed personal information to the client.
* Client side :
    1. configure the factory and start the **Native Service** by providing the network implementation,
    1. register at least a native plugin to the smart card service and get the native reader to connect to the server,
    1. execute the remote service using the **Native Service** API by indicating the ticketing service id to execute and transmitting to the server if needed personal information or smart card content previously read.

#### ILLUSTRATION

The following sequence diagram shows the capabilities of the plugin through an arbitrary example that illustrates :

* the initialization phase of the native and virtual components ;
* the registration of the native plugin and observable reader ;
* the selection phase of an observable reader carried out directly by the client ;
* the sending of the selection result and additional information to the server to remotely perform a specific ticketing service (materialization, validation, etc...) ;
* the reception by the server of the transmitted data ;
* the execution of the remote ticketing service ;
* the server subscription to observable reader events ;
* the sending of information to the client at the end of processing.

Note that the network layer is deliberately hide in this diagram. Its implementation is describe in the [Network configuration](#network-configuration) chapter.

{{< figure library="true" src="remote-plugin/sequence/Remote_Sequence_RemoteServerPlugin_API.svg" title="" >}}

### RemoteClientPlugin

This plugin allows controlling from a **client** terminal a smart card reader available on a **server** terminal (e.g. SAM reader).

| API | Client | Server |
| --- | ------ | ------ |
| **Library** | Virtual Lib | Native Lib |
| **Remote Plugin** / **Native Service** | `RemoteClientPlugin` | `NativeServerService` |
| **Factory** | `RemoteClientPluginFactory` | `NativeServerServiceFactory` |
| **Utility** | `RemoteClientPluginUtils` | `NativeServerServiceUtils` |

#### USE AND SEQUENCE OF OPERATIONS

* Server side :
    1. configure the factory and start the **Native Service** by providing the network implementation,
    1. register at least a native plugin to the smart card service.
* Client side :
    1. configure the factory by providing the network implementation,
    1. register the **Remote Plugin** to the smart card service using the factory,
    1. use the **Remote Plugin** and its virtual readers as a native plugin with native readers.
    
### RemoteClientObservablePlugin

This plugin is a [RemoteClientPlugin](#remoteclientplugin) which also allows to observe the plugin events (such as reader connection, etc...).

Please note that this mode is possible only if the native plugin is observable.

| API | Client | Server |
| --- | ------ | ------ |
| **Library** | Virtual Lib | Native Lib |
| **Remote Plugin** / **Native Service** | `RemoteClientObservablePlugin` | `NativeServerService` |
| **Factory** | `RemoteClientPluginFactory` | `NativeServerServiceFactory` |
| **Utility** | `RemoteClientPluginUtils` | `NativeServerServiceUtils` |

#### USE AND SEQUENCE OF OPERATIONS

* Server side :
    1. configure the factory and start the **Native Service** by providing the network implementation,
    1. register at least a native plugin to the smart card service.
* Client side :
    1. configure the factory by providing the network implementation,
    1. register the **Remote Plugin** to the smart card service using the factory,
    1. use the **Remote Plugin** and its virtual readers as a native observable plugin with native readers.
    
### RemotePoolClientPlugin

This plugin allows controlling from a **client** terminal a pool of smart cards readers available on a **server** terminal (e.g. HSM readers).

| API | Client | Server |
| --- | ------ | ------ |
| **Library** | Virtual Lib | Native Lib |
| **Remote Plugin** / **Native Service** | `RemotePoolClientPlugin` | `NativePoolServerService` |
| **Factory** | `RemotePoolClientPluginFactory` | `NativePoolServerServiceFactory` |
| **Utility** | `RemotePoolClientPluginUtils` | `NativePoolServerServiceUtils` |

#### USE AND SEQUENCE OF OPERATIONS

* Server
    1. configure the factory and start the **Native Service** by providing the network implementation,
    2. register at least a native pool plugin to the smart card service.
* Client
    1. configure the factory by providing the network implementation,
    2. register the **Remote Plugin** to the smart card service using the factory,
    3. use the **Remote Plugin** and its virtual readers as a native pool plugin with native readers.

## Remote Plugins APIs

The class diagrams below shows the different APIs exposed and SPIs required by the **Keyple Remote Plugin** solution.

An **SPI** (Service Provider Interface) is an interface that must be implemented by the user.

Here are the available APIs depending on the library imported by your project :

|     | Virtual Lib | Native Lib |
| --- | :---------: | :--------: |
| [Common API](#common-api) | :heavy_check_mark: | :heavy_check_mark: |
| [Remote Plugin API](#remote-plugin-api) | :heavy_check_mark: | |
| [Native Service API](#native-service-api) | | :heavy_check_mark: |

### Common API

{{< figure library="true" src="remote-plugin/class/Remote_Class_Common_API.svg" title="" >}}

### Remote Plugin API

{{< figure library="true" src="remote-plugin/class/Remote_Class_RemotePlugin_API.svg" title="" >}}

### Native Service API

{{< figure library="true" src="remote-plugin/class/Remote_Class_NativeService_API.svg" title="" >}}

## Use cases

Here is a summary table of all proposed use cases. Search for the one that corresponds to your need and then look at the associated description :

<div id="use-cases-table-2">

| Use Case | Reader type | Reader endpoint | Reader observation | Plugin observation |
| :------: | :---------: | :-------------: | :----------------: | :----------------: |
| [UC 1](#uc-1) | Simple | Client | | |
| [UC 2](#uc-2) | Simple | Client | :heavy_check_mark: | |
| [UC 3](#uc-3) | Simple | Server | | |
| [UC 4](#uc-4) | Simple | Server | :heavy_check_mark: | |
| [UC 5](#uc-5) | Simple | Server | | :heavy_check_mark: |
| [UC 6](#uc-6) | Simple | Server | :heavy_check_mark: | :heavy_check_mark: |
| [UC 7](#uc-7) | Pool | Server | | |

</div>
<style>
#use-cases-table-2 table th:nth-of-type(6) {
    width: 240px;
}
</style>

#### UC 1

This use case requires to use the plugin [RemoteServerPlugin](#remoteserverplugin).

Use this mode if you don't plan to observe "remotely" the events related to the native reader (smart card insertion, removal, etc...).

Please note that it is still possible to observe locally the reader on the client side if needed. 

|     | Client | Server |
| --- | ------ | ------ |
| Methods to be used when initializing the factory | `withoutReaderObservation()` | - |
| Possible readers to use | `Reader` or `ObservableReader` | `RemoteServerReader` |

#### UC 2

This use case requires to use the plugin [RemoteServerPlugin](#remoteserverplugin).

Use this mode if you plan to observe "remotely" the events related to the native reader (smart card insertion, removal, etc...).

Please note that this mode is only possible if the native reader is observable.

|     | Client | Server |
| --- | ------ | ------ |
| Methods to be used when initializing the factory | `withReaderObservation(...)` | - |
| Possible readers to use | `ObservableReader` | `RemoteServerObservableReader` |

To observe "remotely" the reader events, you must :

* Server
    1. register at least one observer to the virtual reader created during the first client call and await for reader events,
    2. retrieve the virtual reader from the **Remote Plugin** **imperatively** using the reader name contained in the received event,
    3. execute the ticketing service associated to the event using the virtual reader and all of its others information,
    4. terminate the remote ticketing service associated to the event using the **Remote Plugin** API by transmitting if needed personal information to the client.
* Client
    1. execute a remote service first in order to connect a virtual reader to the native reader and to allow the remote application to subscribe to the events of the virtual reader.

#### UC 3

This use case requires to use the plugin [RemoteClientPlugin](#remoteclientplugin).

Use this mode if you don't plan to observe "remotely" the events related to the native reader (smart card insertion, removal, etc...).

Please note that it is still possible to observe locally the reader on the server side if needed. 

|     | Client | Server |
| --- | ------ | ------ |
| Methods to be used when initializing the factory | `withoutPluginObservation()`<br>`withoutReaderObservation()` | - |
| Possible readers to use | `Reader` | `Reader` or `ObservableReader` |

#### UC 4

This use case requires to use the plugin [RemoteClientPlugin](#remoteclientplugin).

Use this mode if you plan to observe "remotely" the events related to the native reader (smart card insertion, removal, etc...).

Please note that this mode is only possible if the native reader is observable.

|     | Client | Server |
| --- | ------ | ------ |
| Methods to be used when initializing the factory | `withoutPluginObservation()`<br>`withReaderObservation()` | - |
| Possible readers to use | `ObservableReader` | `ObservableReader` |

#### UC 5

This use case requires to use the plugin [RemoteClientObservablePlugin](#remoteclientobservableplugin).

Use this mode if you don't plan to observe "remotely" the events related to the native reader (smart card insertion, removal, etc...).

Please note that it is still possible to observe locally the reader on the server side if needed. 

|     | Client | Server |
| --- | ------ | ------ |
| Methods to be used when initializing the factory | `withPluginObservation()`<br>`withoutReaderObservation()` | - |
| Possible readers to use | `Reader` | `Reader` or `ObservableReader` |

#### UC 6

This use case requires to use the plugin [RemoteClientObservablePlugin](#remoteclientobservableplugin).

Use this mode if you plan to observe "remotely" the events related to the native reader (smart card insertion, removal, etc...).

Please note that this mode is only possible if the native reader is observable.

|     | Client | Server |
| --- | ------ | ------ |
| Methods to be used when initializing the factory | `withPluginObservation()`<br>`withReaderObservation()` | - |
| Possible readers to use | `ObservableReader` | `ObservableReader` |

#### UC 7

This use case requires to use the plugin [RemotePoolClientPlugin](#remotepoolclientplugin).

This unique mode proposed for this plugin does not allow to observe the native reader.

|     | Client | Server |
| --- | ------ | ------ |
| Methods to be used when initializing the factory | - | - |
| Possible readers to use | `Reader` | `Reader` |

## Network configuration

The **Keyple Remote Plugin** solution **does not provide** the network layer implementation, but it provides a set of SPIs (Service Provider Interfaces) to be implemented by the user in order to enable it to exchange data between **Remote Plugin** and **Native Service** components.

### Synchronous

Choose this mode if you want to implement a Client-Server **Synchronous** communication protocol, such as standard HTTP for example.

|     | Client | Server |
| --- | ------ | ------ |
| SPI to be implemented | `KeypleClientSync` | - |
| Node API | `KeypleClientSyncNode` | `KeypleServerSyncNode` |
| Methods to be used when initializing the factory | `withSyncNode(...)` | `withSyncNode()` |
| Utility method to use to access the node | - | `getSyncNode()` |

Here is the minimal algorithm to implement in a context with a **single server instance** :

{{< figure library="true" src="remote-plugin/sequence/Remote_Sequence_SyncNode_API.svg" title="" >}}

In a context with several server instances, a mechanism must be implemented to ensure that all messages containing information about a `serverNodeId` are routed to the server associated with a `KeypleServerSyncNode` node having the `serverNodeId`.

### Asynchronous

Choose this mode if you want to implement a Full-Duplex **Asynchronous** communication protocol, such as Web Sockets for example.

|     | Client | Server |
| --- | ------ | ------ |
| SPI to be implemented | `KeypleClientAsync` | `KeypleServerAsync` |
| Node API | `KeypleClientAsyncNode` | `KeypleServerAsyncNode` |
| Methods to be used when initializing the factory | `withAsyncNode(...)` | `withAsyncNode(...)` |
| Utility method to use to access the node | `getAsyncNode()` | `getAsyncNode()` |

Here is the minimal algorithm to implement :

{{< figure library="true" src="remote-plugin/sequence/Remote_Sequence_AsyncNode_API.svg" title="" >}}

### Exchanged data

The data exchanged between **Remote Plugin** and **Native Service** components are contain in the DTO (Data Transfer Object) `KeypleMessageDto`. It is built and processed by the plugin and **you don't need to modify it**.

However, it is necessary in some contexts to access certain information such as the `sessionId` in the case of asynchronous communication or the `serverNodeId` in the case of synchronous communication with several server instances.

## Download

### Releases

| Version | Date | Release note |
| ------- | ---- | ------------ |
| **1.0.0** | DD/MM/YYYY | First version |

### Using Gradle

Virtual Lib
```
implementation 'org.eclipse.keyple:keyple-java-plugin-remote-virtual:[TO_BE_REPLACED_BY_VERSION]' 
```

Native Lib
```
implementation 'org.eclipse.keyple:keyple-java-plugin-remote-native:[TO_BE_REPLACED_BY_VERSION]' 
```

### Using Maven

Virtual Lib
```
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-java-plugin-remote-virtual</artifactId>
  <version>[TO_BE_REPLACED_BY_VERSION]</version>
</dependency>
```

Native Lib
```
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-java-plugin-remote-native</artifactId>
  <version>[TO_BE_REPLACED_BY_VERSION]</version>
</dependency>
```

### Binaries & Documentation

| Version | Binaries | Javadoc |
| ------- | -------- | ------- |
| **1.0.0** | keyple-java-plugin-remote-virtual-1.0.0.jar<br>keyple-java-plugin-remote-native-1.0.0.jar | keyple-java-plugin-remote-virtual-doc-1.0.0.zip<br>keyple-java-plugin-remote-native-doc-1.0.0.zip |

### Sources

* [Virtual Lib {{< icon name="github" pack="fab" >}}](https://github.com/eclipse/keyple-java/tree/master/java/component/keyple-plugin/remote-plugin/virtual/README.md)
* [Native Lib {{< icon name="github" pack="fab" >}}](https://github.com/eclipse/keyple-java/tree/master/java/component/keyple-plugin/remote-plugin/native/README.md)
* [Common Lib {{< icon name="github" pack="fab" >}}](https://github.com/eclipse/keyple-java/tree/master/java/component/keyple-plugin/remote-plugin/common/README.md)
