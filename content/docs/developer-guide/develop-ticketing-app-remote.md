---
title: Develop a Remote Ticketing Application
type: book
toc: true
draft: false
weight: 320
---

## Overview

In a Calypso context, it is useful when your SAM reader and/or your PO reader aren't connected to the same terminal.

To solve this need, **Keyple provides the "Keyple Remote Plugin" which allows a terminal to communicate with a smart card reader plugged into another terminal**.

In this way, you can manage Calypso transaction within a distributed architecture.

The diagram below shows the role of the **Keyple Remote Plugin** components in the software layers used in a distributed architecture :

{{< figure library="true" src="remote-plugin/component/Remote_Component_Layers_Overview.svg" title="" >}}

### Glossary

<div id="glossary-table-1">

|     | Description |
| --- | ----------- |
| **Virtual Lib** | This is the library `keyple-plugin-remote-virtual`. It must be imported and used by the application installed on the terminal not having local access to the smart card reader and that wishes to control the reader remotely. |
| **Native Lib** | This is the library `keyple-plugin-remote-native`. It must be imported and used by the application installed on the terminal having local access to the smart card reader but wishes to delegate all or part of the ticketing processing to a remote application. |
| **Remote Plugin** | Part of the **Virtual Lib**, it is a remote virtual plugin which provides only virtual readers to the application. It manages data exchanges with the **Native Service**. This plugin must be registered to the smart card service as a native plugin. |
| **Native Service** | Part of the **Native Lib**, this service ensures data exchange between the **Remote Plugin** and native plugins and readers. It must be initialized and started by the host application. |
| **Factory** | **Remote Plugin** and **Native Service** each have a specific factory class to initialize them. |
| **Utility** | **Remote Plugin** and **Native Service** each have a specific utility class to access them everywhere in the code. |
| **Node** | **Remote Plugin** and **Native Service** each are associated to a specific node which is responsible for the transport layer and the interfacing with the **Network Endpoint**. |
| **Network Endpoint** | At the user's charge, this component ensures the network exchanges between the **Remote Plugin** and **Native Service** nodes. | 

</div>
<style>
#glossary-table-1 table th:first-of-type {
    width: 120px;
}
</style>

### Concepts

The diagram below shows the main functional concepts of the **Keyple Remote Plugin** through an arbitrary situation :

{{< figure library="true" src="remote-plugin/component/Remote_Component_Concepts.svg" title="" >}}

Here are the main concepts to remember :

* The **Keyple Remote Plugin** is composed by two main components exchanging data with each other, the **Remote Plugin** and the **Native Service**.
* The application installed on the terminal **that does not have local access** to the smart card reader must register the **Remote Plugin** using the smart card service, as for a native plugin, but then manipulates **virtual readers** only.
* The application installed on the terminal **with local access** to the smart card reader must register one or many specific native plugins (PCSC,...) using the smart card service and start the **Native Service** in background.
* Each native reader has a remote virtual reader.
* Any command sent by the remote application to a virtual reader will be forwarded to the associated native reader.
* Any event received by a native reader or plugin will be forwarded to the associated remote virtual reader or plugin.

## How to use it ?

1. Read first [Overview](#overview) chapter to understand the main terms and concepts.
2. Using chapter [Use cases](#use-cases), find your use case. This will help you to determine exactly which API described in [Public API](#public-api) chapter and library to use.
3. Using chapter [Download](#download), import into your project the libraries specified by your use case.
4. Using chapters [Network configuration](#network-configuration) and [Public API](#public-api), implement the transport layer using the sequence diagram adapted to your network configuration.
5. Implement your ticketing services as specified in the associated use case.

## Use cases

There are 4 possible **Keyple Remote Plugin APIs** designed on a **Client-Server** model in which **the Client is always the initiator of the processing** :

<div id="use-cases-table-1">

| Plugin API | Description |
| ---------- | ----------- |
| Remote Server Plugin | Allows to control from a **server** terminal a smart card reader plugged into a **client** terminal (e.g. PO reader). |
| Remote Client Plugin,<br>Remote Client Observable Plugin | Allows to control from a **client** terminal a smart card reader plugged into a **server** terminal (e.g. SAM reader). |
| Remote Pool Client Plugin | Allows to control from a **client** terminal a **pool** of smart cards readers plugged into a **server** terminal (e.g. HSM readers). |

</div>
<style>
#use-cases-table-1 table th:first-of-type {
    width: 240px;
}
</style>

More over, some plugins have different modes in which they allow or not the observation of plugin or reader events (such as reader connection, smart card insertion, etc...).

Here is a summary table of all proposed use cases. Search for the one that corresponds to your need and then look at the description of the associated plugin to use :

<div id="use-cases-table-2">

| Use Case | Reader type | Reader endpoint | Reader observation | Plugin observation | Plugin to use |
| :------: | :---------: | :-------------: | :----------------: | :----------------: | :-----------: |
| UC 1 | Simple | Client | | | [Remote Server Plugin](#remote-server-plugin-uc-1-2) |
| UC 2 | Simple | Client | X | | [Remote Server Plugin](#remote-server-plugin-uc-1-2) |
| UC 3 | Simple | Server | | | [Remote Client Plugin](#remote-client-plugin-uc-3-4) |
| UC 4 | Simple | Server | X | | [Remote Client Plugin](#remote-client-plugin-uc-3-4) |
| UC 5 | Simple | Server | | X | [Remote Client Observable Plugin](#remote-client-observable-plugin-uc-5-6) |
| UC 6 | Simple | Server | X | X | [Remote Client Observable Plugin](#remote-client-observable-plugin-uc-5-6) |
| UC 7 | Pool | Server | | | [Remote Pool Client Plugin](#remote-pool-client-plugin-uc-7) |

</div>
<style>
#use-cases-table-2 table th:nth-of-type(6) {
    width: 240px;
}
</style>

### Remote Server Plugin

This plugin allows controlling from a **server** terminal a smart card reader plugged into a **client** terminal (e.g. PO reader). 

#### TECHNICAL SPECIFICATIONS

|     | Client | Server |
| --- | ------ | ------ |
| **Library** | Remote Native | Remote Virtual |
| **Remote Plugin** / **Native Service** | `NativeClientService` | `RemoteServerPlugin` |
| **Factory** | `NativeClientServiceFactory` | `RemoteServerPluginFactory` |
| **Utility** | `NativeClientUtils` | `RemoteServerUtils` |
| **Nb Max Instances/Application** | 1 | 2 (1 for **sync** node, 1 for **async** node) |

#### USE

* Server
    1. configure the factory by providing the network and plugin observer implementation,
    2. register the **Remote Plugin** to the smart card service using the factory,
    3. await for events of type `PluginEvent.READER_CONNECTED`,
    4. when an event occurs, get the specified virtual reader from the **Remote Plugin**,
    5. use information inside the virtual reader to identify the ticketing service to execute,
    6. execute the specified ticketing service using the virtual reader and all of its others information,
    7. terminate the remote ticketing service using the **Remote Plugin** API by transmitting if needed personal information to the client.
* Client
    1. configure the factory and start the **Native Service** by providing the network implementation,
    2. register at least a native plugin to the smart card service and get the native reader to connect to the server,
    3. execute the remote service using the **Native Service** API by indicating the ticketing service id to execute and transmitting to the server if needed personal information or smart card content previously read.

#### UC 1

Use this mode if you don't plan to observe "remotely" the events related to the smart card (insertion, removal,...).

Please note that it is still possible to observe locally the reader on the client side if needed. 

|     | Client | Server |
| --- | ------ | ------ |
| **Factory configuration** | `withoutReaderObservation()` | - |
| **Reader API** | `Reader` or `ObservableReader` | `RemoteServerReader` |

#### UC 2

Use this mode if you plan to observe "remotely" the events related to the smart card (insertion, removal,...).

Please note that this mode is only possible if the native reader is observable.

|     | Client | Server |
| --- | ------ | ------ |
| **Factory configuration** | `withReaderObservation(...)` | - |
| **Reader API** | `ObservableReader` | `RemoteServerObservableReader` |

To observe "remotely" the reader events, you must :

* Server
    1. register at least one observer to the virtual reader created during the first client call and await for reader events,
    2. retrieve the virtual reader from the "Remote Plugin" **imperatively** using the reader name contained in the received event,
    3. execute the ticketing service associated to the event using the virtual reader and all of its others information,
    4. terminate the remote ticketing service associated to the event using the **Remote Plugin** API by transmitting if needed personal information to the client.
* Client
    1. execute a remote service first in order to associate a remote virtual reader to the native reader and to allow the remote application to subscribe to the events of the virtual reader.

#### SEQUENCE DIAGRAM

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

### Remote Client Plugin

This plugin allows controlling from a **client** terminal a smart card reader plugged into a **server** terminal (e.g. SAM reader).

#### TECHNICAL SPECIFICATIONS

|     | Client | Server |
| --- | ------ | ------ |
| **Library** | Remote Virtual | Remote Native |
| **Remote Plugin** / **Native Service** | `RemoteClientPlugin` | `NativeServerService` |
| **Factory** | `RemoteClientPluginFactory` | `NativeServerServiceFactory` |
| **Utility** | `RemoteClientUtils` | `NativeServerUtils` |
| **Nb Max Instances/Application** | 2 (1 for **sync** node, 1 for **async** node) | 1 |

#### USE

* Server
    1. configure the factory and start the **Native Service** by providing the network implementation,
    2. register at least a native plugin to the smart card service.
* Client
    1. configure the factory by providing the network implementation,
    2. register the **Remote Plugin** to the smart card service using the factory,
    3. use the **Remote Plugin** and its virtual readers as a native plugin with native readers.

#### UC 3

Use this mode if you don't plan to observe "remotely" the events related to the smart card (insertion, removal,...).

Please note that it is still possible to observe locally the reader on the server side if needed. 

|     | Client | Server |
| --- | ------ | ------ |
| **Factory configuration** | `withoutPluginObservation()`<br>`withoutReaderObservation()` | - |
| **Reader API** | `Reader` | `Reader` or `ObservableReader` |

#### UC 4

Use this mode if you plan to observe "remotely" the events related to the smart card (insertion, removal,...).

Please note that this mode is only possible if the native reader is observable.

|     | Client | Server |
| --- | ------ | ------ |
| **Factory configuration** | `withoutPluginObservation()`<br>`withReaderObservation()` | - |
| **Reader API** | `ObservableReader` | `ObservableReader` |

### Remote Client Observable Plugin

This plugin is a variant of the **Remote Client Plugin** which also allows to observe the plugin events.

Please note that this mode is only possible if the native plugin is observable.

#### TECHNICAL SPECIFICATIONS

|     | Client | Server |
| --- | ------ | ------ |
| **Library** | Remote Virtual | Remote Native |
| **Remote Plugin** / **Native Service** | `RemoteClientObservablePlugin` | `NativeServerService` |
| **Factory** | `RemoteClientPluginFactory` | `NativeServerServiceFactory` |
| **Utility** | `RemoteClientUtils` | `NativeServerUtils` |
| **Nb Max Instances/Application** | 2 (1 for **sync** node, 1 for **async** node) | 1 |

#### USE

* Server
    1. configure the factory and start the **Native Service** by providing the network implementation,
    2. register at least a native plugin to the smart card service.
* Client
    1. configure the factory by providing the network implementation,
    2. register the **Remote Plugin** to the smart card service using the factory,
    3. use the **Remote Plugin** and its virtual readers as a native observable plugin with native readers.
    
#### UC 5

Use this mode if you don't plan to observe "remotely" the events related to the smart card (insertion, removal,...).

Please note that it is still possible to observe locally the reader on the server side if needed. 

|     | Client | Server |
| --- | ------ | ------ |
| **Factory configuration** | `withPluginObservation()`<br>`withoutReaderObservation()` | - |
| **Reader API** | `Reader` | `Reader` or `ObservableReader` |

#### UC 6

Use this mode if you plan to observe "remotely" the events related to the smart card (insertion, removal,...).

Please note that this mode is only possible if the native reader is observable.

|     | Client | Server |
| --- | ------ | ------ |
| **Factory configuration** | `withPluginObservation()`<br>`withReaderObservation()` | - |
| **Reader API** | `ObservableReader` | `ObservableReader` |

### Remote Pool Client Plugin

This plugin allows controlling from a **client** terminal a pool of smart cards readers plugged into a **server** terminal (e.g. HSM readers).

#### TECHNICAL SPECIFICATIONS

|     | Client | Server |
| --- | ------ | ------ |
| **Library** | Remote Virtual | Remote Native |
| **Remote Plugin** / **Native Service** | `RemotePoolClientPlugin` | `NativePoolServerService` |
| **Factory** | `RemotePoolClientPluginFactory` | `NativePoolServerServiceFactory` |
| **Utility** | `RemotePoolClientUtils` | `NativePoolServerUtils` |
| **Nb Max Instances/Application** | 2 (1 for **sync** node, 1 for **async** node) | 1 |

#### USE

* Server
    1. configure the factory and start the **Native Service** by providing the network implementation,
    2. register at least a native pool plugin to the smart card service.
* Client
    1. configure the factory by providing the network implementation,
    2. register the **Remote Plugin** to the smart card service using the factory,
    3. use the **Remote Plugin** and its virtual readers as a native pool plugin with native readers.

#### UC 7

This unique mode proposed for this plugin does not allow to observe the reader.

|     | Client | Server |
| --- | ------ | ------ |
| **Factory configuration** | - | - |
| **Reader API** | `Reader` | `Reader` |

## Network configuration

Usually distributed architecture will rely on a TCP/IP network to communicate. It is up to the users to choose which protocol to use on top of it.

The **Keyple Remote Plugin** does not provide the network implementation, but it provides a set of interfaces to be implemented by the user in order to enable it to exchange data between **Remote Plugin** and **Native Service** components.

### Synchronous

If you want to implement a Client-Server **Synchronous** communication protocol, such as standard HTTP for example, then you should use :
* on **client**, the `KeypleClientSyncNode` node and provide an implementation of the `KeypleClientSync` endpoint interface in order to be able to connect to a server to send the requests transmitted by the client node ;
* on **server**, the `KeypleServerSyncNode` node in order to be able to receive and process the requests received from the client ;

Here is the minimal algorithm to implement in a context with a **single server instance** :

{{< figure library="true" src="remote-plugin/sequence/Remote_Sequence_SyncNode_API.svg" title="" >}}

In a context with several server instances, a mechanism must be implemented to ensure that all messages containing information about a `serverNodeId` are routed to the server associated with a `KeypleServerSyncNode` node having the `serverNodeId`.

### Asynchronous

If you want to implement a Full-Duplex **Asynchronous** communication protocol, such as Web Sockets for example, then you should use :
* on **client**, the `KeypleClientAsyncNode` node and provide an implementation of the `KeypleClientAsync` endpoint interface in order to be able to open a session with a server and send the messages transmitted by the client node ;
* on **server**, the `KeypleServerAsyncNode` node and provide an implementation of the `KeypleServerAsync` endpoint interface in order to be able to send to the client the messages transmitted by the server node ;

Here is the minimal algorithm to implement :

{{< figure library="true" src="remote-plugin/sequence/Remote_Sequence_AsyncNode_API.svg" title="" >}}

### Exchanged data

The POJO object `KeypleMessageDto` contains data exchanged between **Remote Plugin** and **Native Service** components. It is built and processed by the plugin, and **you don't need to modified it**.

However, it is necessary in some contexts to access certain information such as the `sessionId` in the case of asynchronous communication or the `serverNodeId` in the case of synchronous communication with several server instances.

## Public API

{{< figure library="true" src="remote-plugin/class/Remote_Class_API.svg" title="" >}}

## Download

### Releases

| Version | Date | Release note |
| ------- | ---- | ------------ |
| **1.0.0** | DD/MM/YYYY | First version |

### Using Gradle

Virtual Lib
```
implementation 'org.eclipse.keyple:keyple-java-plugin-remote-virtual:[TO_REPLACE_BY_VERSION]' 
```

Native Lib
```
implementation 'org.eclipse.keyple:keyple-java-plugin-remote-native:[TO_REPLACE_BY_VERSION]' 
```

### Using Maven

Virtual Lib
```
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-java-plugin-remote-virtual</artifactId>
  <version>[TO_REPLACE_BY_VERSION]</version>
</dependency>
```

Native Lib
```
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-java-plugin-remote-native</artifactId>
  <version>[TO_REPLACE_BY_VERSION]</version>
</dependency>
```

### Binaries & Documentation

| Version | Binaries | Javadoc |
| ------- | -------- | ------- |
| **1.0.0** | keyple-java-plugin-remote-virtual-1.0.0.jar<br>keyple-java-plugin-remote-native-1.0.0.jar | keyple-java-plugin-remote-virtual-doc-1.0.0.zip<br>keyple-java-plugin-remote-native-doc-1.0.0.zip |

### Sources

* [Virtual Lib {{< icon name="github" pack="fab" >}}](https://github.com/eclipse/keyple-java/tree/master/java/component/keyple-plugin/remote-plugin/virtual/README.md)
* [Native Lib {{< icon name="github" pack="fab" >}}](https://github.com/eclipse/keyple-java/tree/master/java/component/keyple-plugin/remote-plugin/native/README.md)
* [Core Lib {{< icon name="github" pack="fab" >}}](https://github.com/eclipse/keyple-java/tree/master/java/component/keyple-plugin/remote-plugin/core/README.md)
