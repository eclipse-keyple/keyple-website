---
title: Develop a Remote Ticketing Application
type: book
toc: true
draft: false
weight: 320
---

## Overview

**Keyple provides the "Keyple Remote Plugins" solution which allows a terminal to communicate with a smart card reader available in another terminal**.

In this way, you can manage transactions within a distributed architecture.

The diagram below shows the role of the **Keyple Remote Plugins** components in the software layers used in a distributed architecture :

{{< figure library="true" src="remote-plugin/component/Remote_Component_Overview.svg" title="" >}}

## How to use it ?

1. In pre-requisite, read page [Develop a Local Ticketing Application]({{< relref "develop-ticketing-app-local.md" >}}) to understand the main concepts of Keyple in a local application.
1. Read chapter [Concepts](#concepts) to understand the main terms and concepts of the **Keyple Remote Plugins** solution.
1. Read the introduction of chapter [Remote Plugins](#remote-plugins) to be informed about the different remote plugins and APIs proposed by the solution.
1. Using chapter [Use cases](#use-cases), find your use case. This will help you to determine exactly which library and API to use.
1. Using chapter [Download](#download), import into your project the libraries specified by your use case.
1. Using chapter [Network configuration](#network-configuration), implement the transport layer adapted to your network configuration.
1. Implement your ticketing services as specified in the associated use case.

## Concepts

Here are the main concepts to keep in mind before continuing to read this developer guide :

<div id="concepts-table-1">

| Concept | Description |
| ------- | ----------- |
| **Remote Lib** | This is the library `keyple-plugin-remote-remote`.<br>It must be imported and used by the application installed on the terminal not having local access to the smart card reader and that wishes to control the reader remotely. |
| **Local Lib** | This is the library `keyple-plugin-remote-local`.<br>It must be imported and used by the application installed on the terminal having local access to the smart card reader but wishes to delegate all or part of the ticketing processing to a remote application. |
| **Network Lib** | This is the library `keyple-plugin-remote-network`.<br>This library is **implicitly** imported by **Remote Lib** and **Local Lib** because it contains common network elements. |
| **Remote Plugin** | Part of the **Remote Lib**, this is a Keyple plugin which provides only **Remote Readers** to the application. It manages data exchanges with the **Local Service**. This plugin must be registered to the smart card service like any Keyple plugin. |
| **Remote Reader** | Part of the **Remote Plugin**, this is a Keyple reader which has some specificities :<br>- each remote reader is connected to a local reader ;<br>- any command sent by the application to a remote reader will be forwarded to the associated local reader ;<br>- any event occurs on a local reader or plugin will be forwarded to the associated remote reader or plugin. |
| **Local Service** | Part of the **Local Lib**, this service ensures data exchange between the **Remote Plugin** and local plugins and readers. It must be initialized and started by the host application. |
| **Factory** | **Remote Plugin** and **Local Service** each have a specific factory class to initialize them. |
| **Utility** | **Remote Plugin** and **Local Service** each have a specific utility class to access them everywhere in the code. |
| **Node** | **Remote Plugin** and **Local Service** each are bind to a specific internal node which is responsible for the interfacing with the **Network Endpoint**. |
| **Network Endpoint** | At the user's charge, this component ensures the network exchanges between the **Remote Plugin** and **Local Service** nodes. | 

</div>
<style>
#concepts-table-1 table th:first-of-type {
    width: 130px;
}
</style>

The diagram below illustrates the main functional concepts through a standard use case :

{{< figure library="true" src="remote-plugin/component/Remote_Component_Concepts_1.svg" title="" >}}

The second diagram below illustrates an arbitrary more complex possible use case with several hardware readers connected to different terminals.

These could be for example a ticketing reloading service, where the intelligence would be on the terminal with remote readers, with thin clients on A & B terminals communicating locally with the cards.

In this use case, the **Keyple Remote Plugins** solution is use for card communication.

{{< figure library="true" src="remote-plugin/component/Remote_Component_Concepts_2.svg" title="" >}}

Here is another example, but this time it illustrates several **Remote Plugin** components connected to the same **Local Service**.

These could be for example ticketing terminals with transaction logic, which communicate locally with cards, but which do not have SAM, and which use a SAM server with hardware reader.

In this use case, the **Keyple Remote Plugins** solution is use for SAM communication.

{{< figure library="true" src="remote-plugin/component/Remote_Component_Concepts_3.svg" title="" >}}

## Remote Plugins
 
The **Keyple Remote Plugins** solution provides **3** different specific **Remote Plugin** components, each one having a specific API described in chapter [Remote Plugins APIs](#remote-plugins-apis) designed on a **Client-Server** model in which **the Client is always the initiator of the communication** :

<div id="plugins-table-1">

| Plugin | Description |
| ------ | ----------- |
| [RemotePluginServer](#remotepluginserver) | Allows a **server** application to control a smart card reader available on a **client** (e.g. PO reader). |
| [RemotePluginClient](#remotepluginclient) or<br>[ObservableRemotePluginClient](#observableremotepluginclient) | Allows a **client** application to control a smart card reader available on a **server** (e.g. SAM reader). |
| [PoolRemotePluginClient](#poolremotepluginclient) | Allows a **client** application to control a **pool** of smart cards readers available on a **server** (e.g. HSM readers). |

</div>
<style>
#plugins-table-1 table th:first-of-type {
    width: 220px;
}
</style>

Moreover, some plugins have different modes in which they allow or not the observation of plugin or reader events (such as smart card insertion, reader connection, etc...).

Each **Remote Plugin** and **Local Service** has a default name, but it's possible to specify a custom name during the initialization phase.

It is thus possible to have within an application as many instances of a specific **Remote Plugin** or **Local Service** as desired.

### RemotePluginServer

This plugin allows a **server** application to control a smart card reader available on a **client** (e.g. PO reader).

| API | Client | Server |
| --- | ------ | ------ |
| **Library** | Local Lib | Remote Lib |
| **Remote Plugin** / **Local Service** | `LocalServiceClient` | `RemotePluginServer` |
| **Factory** | `LocalServiceClientFactory` | `RemotePluginServerFactory` |
| **Utility** | `LocalServiceClientUtils` | `RemotePluginServerUtils` |

#### USE AND SEQUENCE OF OPERATIONS

* Server side :
    1. configure the factory by providing the network and plugin observer implementation. Please note that **this plugin is observable only to trigger ticketing services** on the server side, but does not allow observation on the local plugin (reader insertion, etc...),
    1. register the **Remote Plugin** to the smart card service using the factory,
    1. await for events of type `PluginEvent.READER_CONNECTED`,
    1. when an event occurs, get the specified remote reader from the **Remote Plugin**,
    1. use information inside the remote reader to identify the ticketing service to execute,
    1. execute the specified ticketing service using the remote reader and all of its others information,
    1. terminate the remote ticketing service using the **Remote Plugin** API by transmitting if needed personal information to the client.
* Client side :
    1. configure the factory and start the **Local Service** by providing the network implementation,
    1. register at least a local plugin to the smart card service and get the local reader to connect to the server,
    1. execute the remote service using the **Local Service** API by indicating the ticketing service id to execute and transmitting to the server if needed personal information or smart card content previously read.

#### ILLUSTRATION

The following sequence diagram shows the capabilities of the plugin through an arbitrary example that illustrates :

* the initialization phase of the local and remote components ;
* the registration of the local plugin and observable reader ;
* the selection phase of an observable reader carried out directly by the client ;
* the sending of the selection result and additional information to the server to remotely perform a specific ticketing service (materialization, validation, etc...) ;
* the reception by the server of the transmitted data ;
* the execution of the remote ticketing service ;
* the server subscription to observable reader events ;
* the sending of information to the client at the end of processing.

Note that the network layer is deliberately hide in this diagram. Its implementation is described in the [Network configuration](#network-configuration) chapter.

{{< figure library="true" src="remote-plugin/sequence/Remote_Sequence_RemotePluginServer_API.svg" title="" >}}

### RemotePluginClient

This plugin allows a **client** application to control a smart card reader available on a **server** (e.g. SAM reader).

| API | Client | Server |
| --- | ------ | ------ |
| **Library** | Remote Lib | Local Lib |
| **Remote Plugin** / **Local Service** | `RemotePluginClient` | `LocalServiceServer` |
| **Factory** | `RemotePluginClientFactory` | `LocalServiceServerFactory` |
| **Utility** | `RemotePluginClientUtils` | `LocalServiceServerUtils` |

#### USE AND SEQUENCE OF OPERATIONS

* Server side :
    1. configure the factory and start the **Local Service** by providing the network implementation,
    1. register at least a local plugin to the smart card service.
* Client side :
    1. configure the factory by providing the network implementation,
    1. register the **Remote Plugin** to the smart card service using the factory,
    1. use the **Remote Plugin** and its remote readers as a local plugin with local readers.
    
### ObservableRemotePluginClient

This plugin is a [RemotePluginClient](#remotepluginclient) which also allows to observe the plugin events (such as reader connection, etc...).

Please note that this mode is possible only if the local plugin is observable.

| API | Client | Server |
| --- | ------ | ------ |
| **Library** | Remote Lib | Local Lib |
| **Remote Plugin** / **Local Service** | `ObservableRemotePluginClient` | `LocalServiceServer` |
| **Factory** | `RemotePluginClientFactory` | `LocalServiceServerFactory` |
| **Utility** | `RemotePluginClientUtils` | `LocalServiceServerUtils` |

#### USE AND SEQUENCE OF OPERATIONS

* Server side :
    1. configure the factory and start the **Local Service** by providing the network implementation,
    1. register at least a local plugin to the smart card service.
* Client side :
    1. configure the factory by providing the network implementation,
    1. register the **Remote Plugin** to the smart card service using the factory,
    1. use the **Remote Plugin** and its remote readers as a local observable plugin with local readers.
    
### PoolRemotePluginClient

This plugin allows a **client** application to control a **pool** of smart cards readers available on a **server** (e.g. HSM readers).

| API | Client | Server |
| --- | ------ | ------ |
| **Library** | Remote Lib | Local Lib |
| **Remote Plugin** / **Local Service** | `PoolRemotePluginClient` | `PoolLocalServiceServer` |
| **Factory** | `PoolRemotePluginClientFactory` | `PoolLocalServiceServerFactory` |
| **Utility** | `PoolRemotePluginClientUtils` | `PoolLocalServiceServerUtils` |

#### USE AND SEQUENCE OF OPERATIONS

* Server
    1. configure the factory and start the **Local Service** by providing the network implementation,
    2. register at least a local pool plugin to the smart card service.
* Client
    1. configure the factory by providing the network implementation,
    2. register the **Remote Plugin** to the smart card service using the factory,
    3. use the **Remote Plugin** and its remote readers as a local pool plugin with local readers.

## Remote Plugins APIs

The class diagrams below shows the different APIs exposed and SPIs required by the **Keyple Remote Plugins** solution.

An **SPI** (Service Provider Interface) is an interface that must be implemented by the user.

Here are the available APIs depending on the library imported by your project :

|     | Remote Lib | Local Lib |
| --- | :---------: | :--------: |
| [Network API](#network-api) | :heavy_check_mark: | :heavy_check_mark: |
| [Remote Plugin API](#remote-plugin-api) | :heavy_check_mark: | |
| [Local Service API](#local-service-api) | | :heavy_check_mark: |

The associated **API** documentations are accessible from the page [API Reference]({{< relref "api-reference.md" >}}).

### Network API

The associated **API** documentation is available <a href="../../api-reference/keyple-plugin-remote-network/1.0.0-alpha-1/index.html" target="blank">here</a>.

{{< figure library="true" src="remote-plugin/class/Remote_Class_Network_API.svg" title="" >}}

### Remote Plugin API

The associated **API** documentation is available <a href="../../api-reference/keyple-plugin-remote-remote/1.0.0-alpha-1/index.html" target="blank">here</a>.

{{< figure library="true" src="remote-plugin/class/Remote_Class_RemotePlugin_API.svg" title="" >}}

### Local Service API

The associated **API** documentation is available <a href="../../api-reference/keyple-plugin-remote-local/1.0.0-alpha-1/index.html" target="blank">here</a>.

{{< figure library="true" src="remote-plugin/class/Remote_Class_LocalService_API.svg" title="" >}}

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

This use case requires to use the plugin [RemotePluginServer](#remotepluginserver).

Use this mode if you don't plan to observe "remotely" the events related to the local reader (smart card insertion, removal, etc...).

Please note that it is still possible to observe locally the reader on the client side if needed. 

|     | Client | Server |
| --- | ------ | ------ |
| Methods to be used when initializing the factory | `withoutReaderObservation()` | - |
| Possible readers to use | `Reader` or `ObservableReader` | `RemoteReaderServer` |

#### UC 2

This use case requires to use the plugin [RemotePluginServer](#remotepluginserver).

Use this mode if you plan to observe "remotely" the events related to the local reader (smart card insertion, removal, etc...).

Please note that this mode is only possible if the local reader is observable.

|     | Client | Server |
| --- | ------ | ------ |
| Methods to be used when initializing the factory | `withReaderObservation(...)` | - |
| Possible readers to use | `ObservableReader` | `ObservableRemoteReaderServer` |

To observe "remotely" the reader events, you must :

* Server
    1. register at least one observer to the remote reader created during the first client call and await for reader events,
    2. retrieve the remote reader from the **Remote Plugin** **imperatively** using the reader name contained in the received event,
    3. execute the ticketing service associated to the event using the remote reader and all of its others information,
    4. terminate the remote ticketing service associated to the event using the **Remote Plugin** API by transmitting if needed personal information to the client.
* Client
    1. execute a remote service first in order to connect a remote reader to the local reader and to allow the remote application to subscribe to the events of the remote reader.

#### UC 3

This use case requires to use the plugin [RemotePluginClient](#remotepluginclient).

Use this mode if you don't plan to observe "remotely" the events related to the local reader (smart card insertion, removal, etc...).

Please note that it is still possible to observe locally the reader on the server side if needed. 

|     | Client | Server |
| --- | ------ | ------ |
| Methods to be used when initializing the factory | `withoutPluginObservation()`<br>`withoutReaderObservation()` | - |
| Possible readers to use | `Reader` | `Reader` or `ObservableReader` |

#### UC 4

This use case requires to use the plugin [RemotePluginClient](#remotepluginclient).

Use this mode if you plan to observe "remotely" the events related to the local reader (smart card insertion, removal, etc...).

Please note that this mode is only possible if the local reader is observable.

|     | Client | Server |
| --- | ------ | ------ |
| Methods to be used when initializing the factory | `withoutPluginObservation()`<br>`withReaderObservation()` | - |
| Possible readers to use | `ObservableReader` | `ObservableReader` |

#### UC 5

This use case requires to use the plugin [ObservableRemotePluginClient](#observableremotepluginclient).

Use this mode if you don't plan to observe "remotely" the events related to the local reader (smart card insertion, removal, etc...).

Please note that it is still possible to observe locally the reader on the server side if needed. 

|     | Client | Server |
| --- | ------ | ------ |
| Methods to be used when initializing the factory | `withPluginObservation()`<br>`withoutReaderObservation()` | - |
| Possible readers to use | `Reader` | `Reader` or `ObservableReader` |

#### UC 6

This use case requires to use the plugin [ObservableRemotePluginClient](#observableremotepluginclient).

Use this mode if you plan to observe "remotely" the events related to the local reader (smart card insertion, removal, etc...).

Please note that this mode is only possible if the local reader is observable.

|     | Client | Server |
| --- | ------ | ------ |
| Methods to be used when initializing the factory | `withPluginObservation()`<br>`withReaderObservation()` | - |
| Possible readers to use | `ObservableReader` | `ObservableReader` |

#### UC 7

This use case requires to use the plugin [PoolRemotePluginClient](#poolremotepluginclient).

This unique mode proposed for this plugin does not allow to observe the local reader.

|     | Client | Server |
| --- | ------ | ------ |
| Methods to be used when initializing the factory | - | - |
| Possible readers to use | `Reader` | `Reader` |

## Network configuration

The **Keyple Remote Plugins** solution **does not provide** the network layer implementation, but it provides a set of SPIs (Service Provider Interfaces) to be implemented by the user in order to enable it to exchange data between **Remote Plugin** and **Local Service** components.

### Synchronous

Choose this mode if you want to implement a Client-Server **Synchronous** communication protocol, such as standard HTTP for example.

|     | Client | Server |
| --- | ------ | ------ |
| SPI to be implemented | `SyncEndpointClient` | - |
| Node API | `SyncNodeClient` | `SyncNodeServer` |
| Methods to be used when initializing the factory | `withSyncNode(...)` | `withSyncNode()` |
| Utility method to use to access the node | - | `getSyncNode()` or<br> `getSyncNode(...)` |

Here is the minimal algorithm to implement in a context with a **single server instance** :

{{< figure library="true" src="remote-plugin/sequence/Remote_Sequence_SyncNode_API.svg" title="" >}}

In a context with several server instances, a mechanism must be implemented to ensure that all messages containing information about a `serverNodeId` are routed to the server associated with a `SyncNodeServer` node having the `serverNodeId`.

### Asynchronous

Choose this mode if you want to implement a Full-Duplex **Asynchronous** communication protocol, such as Web Sockets for example.

|     | Client | Server |
| --- | ------ | ------ |
| SPI to be implemented | `AsyncEndpointClient` | `AsyncEndpointServer` |
| Node API | `AsyncNodeClient` | `AsyncNodeServer` |
| Methods to be used when initializing the factory | `withAsyncNode(...)` | `withAsyncNode(...)` |
| Utility method to use to access the node | `getAsyncNode()` or<br> `getAsyncNode(...)` | `getAsyncNode()` or<br> `getAsyncNode(...)` |

Here is the minimal algorithm to implement :

{{< figure library="true" src="remote-plugin/sequence/Remote_Sequence_AsyncNode_API.svg" title="" >}}

### Exchanged data

The data exchanged between **Remote Plugin** and **Local Service** components are contained in the DTO (Data Transfer Object) `MessageDto`. It is built and processed by the plugin and **you don't need to modify it**.

However, it is necessary in some contexts to access certain information such as the `sessionId` in the case of asynchronous communication or the `serverNodeId` in the case of synchronous communication with several server instances.

## Examples

All examples are available [here](https://github.com/eclipse/keyple-java/tree/develop/java/example/generic/remote).

## Download

### JARs

All deliverables (JARs, changelogs, javadocs) are available on the [Maven Central Repository](https://search.maven.org/).

So you can use [Gradle](https://gradle.org/) or [Maven](https://maven.apache.org/) to import the JARs into your project or download them directly from the **Maven Central Repository**.

Note that it is **strongly recommended** to use the same version for **Remote Lib** and **Local Lib**.

#### GRADLE

* Remote Lib
```
implementation 'org.eclipse.keyple:keyple-plugin-remote-remote:1.0.0' 
```

* Local Lib
```
implementation 'org.eclipse.keyple:keyple-plugin-remote-local:1.0.0' 
```

#### MAVEN

* Remote Lib
```
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-plugin-remote-remote</artifactId>
  <version>1.0.0</version>
</dependency>
```

* Local Lib
```
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-plugin-remote-local</artifactId>
  <version>1.0.0</version>
</dependency>
```

#### MAVEN CENTRAL REPOSITORY

* <a href="https://search.maven.org/search?q=a:keyple-plugin-remote-network" target="blank">Network Lib</a>
* <a href="https://search.maven.org/search?q=a:keyple-plugin-remote-remote" target="blank">Remote Lib</a>
* <a href="https://search.maven.org/search?q=a:keyple-plugin-remote-local" target="blank">Local Lib</a>

### Sources

The sources are available on <a href="https://github.com/" target="blank">GitHub</a> :

* [Network Lib](https://github.com/eclipse/keyple-java/tree/develop/java/component/keyple-plugin/remote/network/)
* [Remote Lib](https://github.com/eclipse/keyple-java/tree/develop/java/component/keyple-plugin/remote/remote/)
* [Local Lib](https://github.com/eclipse/keyple-java/tree/develop/java/component/keyple-plugin/remote/local/)
