---
title: Distributed Application User Guide
linktitle: Distributed application
summary: How to develop an end-user application using network communications.
type: book
toc: true
draft: false
weight: 2
---

<br>

## Overview

Keyple provides the **Keyple Distributed** solution which allows an application to communicate with a smart card reader 
interfaced with another host.

In this way, you can manage transactions seamlessly within a distributed architecture.

The Keyple Distributed solution can be deployed in two ways:
- both client and server embed Keyple middleware,
- only the server embeds Keyple middleware, the client has its own libraries to communicate with its card reader.

The diagram below illustrates the first way, the use of the Keyple Distributed components when both client and 
server embed Keyple middleware (note that the card reader can be either client-side or server-side):

{{< figure src="/media/learn/user-guide/distributed-application/distributed_solution_1_layers_overview.drawio.svg" caption="Keyple on both client and server sides" numbered="true" >}}

The diagram below illustrates the second way, the architecture with a client not running Keyple but connected to a
Keyple-based server:

{{< figure src="/media/learn/user-guide/distributed-application/distributed_solution_2_layers_overview.drawio.svg" caption="Keyple on server side only" numbered="true" >}}

### User guides

- [How to build a full Keyple distributed application](#full-keyple-distributed-application)
- [How to make a non-Keyple client interact with a Keyple-based server application]({{< ref "/user-guides/non-keyple-client/content" >}})

## 
---

## Full Keyple distributed application

Steps:
1. In pre-requisite, read [Standalone Application User Guide]({{< relref "standalone-application.md" >}}) to understand the main concepts of Keyple in a standalone application.
2. Learn [main terms and concepts](#concepts) of the Keyple Distributed solution.
3. Find your [usage mode](#usage-modes). This will help you to determine exactly which library and API to use.
4. [Import](#download) into your project the libraries specified by your usage mode.
5. Implement the transport layer adapted to your [network configuration](#network-configuration).
6. Implement your ticketing services as specified in the associated usage mode.

<br>

## Concepts

Here are the main concepts to keep in mind before continuing to read this user guide:

<div id="concepts-table-1">

| Concept              | Description                                                                                                                                                                                                                                                                                                                                                                                                          |
|----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Remote Lib**       | This is the `keyple-distributed-remote-java-lib` library.<br>It must be imported and used by the application installed on the host not having local access to the smart card reader and that wishes to interact with the reader remotely.                                                                                                                                                                            |
| **Local Lib**        | This is the `keyple-distributed-local-java-lib` library.<br>It must be imported and used by the application installed on the host having local access to the smart card reader but wishes to delegate all or part of the ticketing processing to a remote application.                                                                                                                                               |
| **Network Lib**      | This is the `keyple-distributed-network-java-lib` library.<br>It must always be imported because it contains the network elements used by **Remote Lib** and **Local Lib**.                                                                                                                                                                                                                                          |
| **Remote Plugin**    | Part of the **Remote Lib**, this is a Keyple reader plugin extension which provides only **Remote Readers** to the application. It manages data exchanges with the **Local Service**. This reader plugin extension must be registered to the smart card service like any Keyple reader plugin.                                                                                                                       |
| **Remote Reader**    | Part of the **Remote Lib**, this is a Keyple reader extension which has some specificities:<br>- each remote reader is connected to a local reader;<br>- any command sent by the application to a remote reader will be forwarded to the associated local reader;<br>- in some cases only, an event occurring on a local reader or plugin will be automatically forwarded to the associated remote reader or plugin. |
| **Local Service**    | Part of the **Local Lib**, this is a Keyple distributed local service extension which ensures data exchange between the **Remote Plugin** and local plugins and readers. It must be registered to the smart card service.                                                                                                                                                                                            |
| **Factory**          | **Remote Plugin** and **Local Service** each have a specific factory class to initialize them.                                                                                                                                                                                                                                                                                                                       |
| **Node**             | **Remote Plugin** and **Local Service** each are bind to a specific internal node which is responsible for the interfacing with the **Network Endpoint**.                                                                                                                                                                                                                                                            |
| **Network Endpoint** | At the user's charge, this component ensures the network exchanges between the **Remote Plugin** and **Local Service** nodes.                                                                                                                                                                                                                                                                                        | 

</div>
<style>
#concepts-table-1 table th:first-of-type {
    width: 170px;
}
</style>

The diagram below illustrates the main functional concepts through a standard use case:

{{< figure src="/media/learn/user-guide/distributed-application/distributed_concepts_1.svg" caption="Concepts - Main use case" numbered="true" >}}

The second diagram below illustrates an arbitrary more complex possible use case with several hardware readers connected to different hosts.

These could be for example a ticketing reloading service, where the business logic would be on the host without local readers, with thin clients on A & B hosts communicating locally with the cards.

In this use case, the Keyple Distributed solution is use for card communication.

{{< figure src="/media/learn/user-guide/distributed-application/distributed_concepts_2.svg" caption="Concepts - One remote plugin connected to many local services" numbered="true" >}}

Here is another example, but this time it illustrates several remote plugins connected to the same local service.

These could be for example ticketing terminals with transaction logic, which communicate locally with cards, but which do not have SAM, and which use a SAM server with hardware reader.

In this use case, the Keyple Distributed solution is use for SAM communication.

{{< figure src="/media/learn/user-guide/distributed-application/distributed_concepts_3.svg" caption="Concepts - Many remote plugins connected to one local service" numbered="true" >}}

<br>

## Usage modes

The Keyple Distributed solution offers two different usage modes, each one having a specific API designed on a **Client-Server** model:

<div id="plugins-table-1">

| Usage mode                                | Description                                                                                                            |
|-------------------------------------------|------------------------------------------------------------------------------------------------------------------------|
| [Reader Client Side](#reader-client-side) | Allows a **server** application to interact with a smart card reader available on a **client** (e.g. Card reader).     |
| [Reader Server Side](#reader-server-side) | Allows a **client** application to interact with a smart card reader available on a **server** (e.g. SAM reader, HSM). |

</div>
<style>
#plugins-table-1 table th:first-of-type {
    width: 190px;
}
</style>

Each mode provides a different **Remote Plugin** and **Local Service** and their associated factories.

In an application, it is possible to use simultaneously several usage modes and as many instances of a usage mode as you want, as long as the components are initialized with different names.

### Reader Client Side

This usage mode allows a **server** application to interact with a smart card reader available on a **client** (e.g. Card reader).

In this mode, the client is the initiator of the application processing following the local plugin or reader events (reader connection/disconnection or card insertion/removal).

He can hand over to the server whenever he wants to perform a remote ticketing service on a card present in one of his local readers.

The table below shows the classes and interfaces available for this usage mode.<br>
Interfaces marked with an asterisk "*" come from the **Keypop Reader API**.<br>
Interfaces marked with an asterisk "**" come from the **Keyple Service API**:

| API                                         | Client                             | Server                             |
|---------------------------------------------|------------------------------------|------------------------------------|
| **Library to use**                          | Local Lib                          | Remote Lib                         |
| **Factory builder to be used**              | `LocalServiceClientFactoryBuilder` | `RemotePluginServerFactoryBuilder` |
| **Factory to be registered**                | `LocalServiceClientFactory`        | `RemotePluginServerFactory`        |
| **Local Service / Remote Plugin**           | `DistributedLocalService` **       | `ObservablePlugin` **              |
| **Local Service / Remote Plugin extension** | `LocalServiceClient`               | `RemotePluginServer`               |
| **Reader**                                  | Any kind of reader                 | `CardReader` *                     |
| **Reader extension**                        | Device specific                    | `RemoteReaderServer`               |

{{% callout warning %}} It is the responsibility of the client application to observe and configure the local plugins and readers. {{% /callout %}}

#### OPERATING MODE

* **Server**
    1. Build an instance of the `RemotePluginServerFactory` using the `RemotePluginServerFactoryBuilder` class, specifying a unique name for the **Remote Plugin** to be registered and your network endpoint implementation if required.
    2. Register the **Remote Plugin** to the smart card service by providing the previously built factory.
    3. Cast the registered plugin into an `ObservablePlugin` and add an event observer to it.<br><div class="alert alert-note"><div>Please note that this remote plugin is observable only to trigger ticketing services on the server side, but does not allow observation on the local plugin such as reader connection or disconnection.</div></div>
    4. Await for events of type `PluginEvent.Type.READER_CONNECTED`.<br><div class="alert alert-note"><div>This type of event indicates to the server that a client asks it to perform a specific ticketing service using the connected remote reader.</div></div>
    5. When an event occurs, you must retrieve the connected remote reader from the registered plugin using the name of the reader contained in the event.<br><div class="alert alert-note"><div>Please note that the remote reader is strictly an instance of `CardReader`, even if the local reader is an `ObservableCardReader`.<br>This usage mode does not allow to observe reader events such as card insertion or removal from the server.<br>It is the responsibility of the client to observe the local reader if needed, then to ask the server to execute a specific remote service depending on the case.</div></div>
    6. Use information inside the `RemoteReaderServer` extension of the remote reader to identify the ticketing service to execute.
    7. Execute the specified ticketing service using the remote reader and all of its other information.
    8. End the remote ticketing service by calling the associated method provided by the `RemotePluginServer` extension of the remote plugin.<br>It is then possible to send additional information to the client if necessary.
* **Client**
    1. Build an instance of the `LocalServiceClientFactory` using the `LocalServiceClientFactoryBuilder` class, specifying a unique name for the **Local Service** to be registered and your network endpoint implementation.
    2. Register the **Local Service** to the smart card service by providing the previously built factory.
    3. Register at least a local plugin to the smart card service and get the name of the local reader to connect to the server.
    4. Execute the desired remote service by calling the associated method provided by the `LocalServiceClient` 
       extension of the local service by specifying the identifier of the ticketing service to be executed, 
       the name of the target local reader, and transmitting to the server if necessary the contents of the previously 
       read smart card or additional information.<br><div class="alert alert-note"><div><p>Please note that if the 
       client does not use Keyple card extension locally, it is strongly recommended to use the card selection scenario
       import/export feature to reduce the number of network exchanges during the card transaction.</p><p>
       It will then be possible to process the card selection scenario locally following the detection of a card,
       then export the result of the selection and transmit it to the server in the `inputData` field.</p>
       [More information]({{< relref "standalone-application.md/#importexport-a-scenario" >}})</div></div>

### Reader Server Side

This usage mode allows a **client** application to interact with a smart card reader or a pool of smart card readers available on a **server** (e.g. SAM reader, HSM).

The Keyple Distributed solution offers for this usage mode a remote control of all types of plugins (`Plugin`, `ObservablePlugin`, `PoolPlugin`):

* **Regular plugin** (`Plugin` or `ObservablePlugin`)

During the remote plugin registration process, the client automatically creates a remote reader for each local reader of the set of local plugins on the server.

If the factory has been properly configured, then the remote plugin and reader behave like the local plugins and readers.

It is then possible to observe directly from the client the plugin and/or reader events (reader connection/disconnection or card insertion/removal) if desired.

The table below shows the classes and interfaces available for this usage mode in the case of a **regular plugin**.<br>
Interfaces marked with an asterisk "*" come from the **Keypop Reader API**.<br>
Interfaces marked with an asterisk "**" come from the **Keyple Service API**:

| API                                         | Client                                        | Server                             |
|---------------------------------------------|-----------------------------------------------|------------------------------------|
| **Library to use**                          | Remote Lib                                    | Local Lib                          |
| **Factory builder to be used**              | `RemotePluginClientFactoryBuilder`            | `LocalServiceServerFactoryBuilder` |
| **Factory to be registered**                | `RemotePluginClientFactory`                   | `LocalServiceServerFactory`        |
| **Remote Plugin / Local Service**           | `Plugin` ** or<br>`ObservablePlugin` **       | `DistributedLocalService` **       |
| **Remote Plugin / Local Service extension** | `RemotePluginClient`                          | `LocalServiceServer`               |
| **Reader**                                  | `CardReader` * or<br>`ObservableCardReader` * | Any kind of reader                 |
| **Reader extension**                        | `RemoteReaderClient`                          | Device specific                    |

* **Pool plugin** (`PoolPlugin`)

The dynamic reader allocation process will search for the first available reader among all or a subset of the pool plugins registered on the server.

It is possible to define during the configuration phase of the local service factory a filter on the names of the pool plugins to use.

The table below shows the classes and interfaces available for this usage mode in the case of a **pool plugin**.<br>
Interfaces marked with an asterisk "*" come from the **Keypop Reader API**.<br>
Interfaces marked with an asterisk "**" come from the **Keyple Service API**:

| API                                         | Client                                 | Server                             |
|---------------------------------------------|----------------------------------------|------------------------------------|
| **Library to use**                          | Remote Lib                             | Local Lib                          |
| **Factory builder to be used**              | `RemotePoolPluginClientFactoryBuilder` | `LocalServiceServerFactoryBuilder` |
| **Factory to be registered**                | `RemotePluginClientFactory`            | `LocalServiceServerFactory`        |
| **Remote Plugin / Local Service**           | `PoolPlugin` **                        | `DistributedLocalService` **       |
| **Remote Plugin / Local Service extension** | `RemotePluginClient`                   | `LocalServiceServer`               |
| **Reader**                                  | `CardReader` *                         | Any kind of reader                 |
| **Reader extension**                        | `RemoteReaderClient`                   | Device specific                    |

{{% callout warning %}} Whatever the type of plugin, it is the responsibility of the server application to configure the local plugins and readers. {{% /callout %}}

#### OPERATING MODE

* **Server**
    1. Build an instance of the `LocalServiceServerFactory` using the `LocalServiceServerFactoryBuilder` class, specifying a unique name for the **Local Service** to be registered and your network endpoint implementation if required.
    2. Register the **Local Service** to the smart card service by providing the previously built factory.
    3. Register at least a local plugin or pool plugin to the smart card service, depending on your case.
* **Client**
    1. Build an instance of the `RemotePluginClientFactory` using the `RemotePluginClientFactoryBuilder` or `RemotePoolPluginClientFactoryBuilder` class depends on the type of plugin that you want to manage, specifying a unique name for the **Remote Plugin** to be registered and your network endpoint implementation.
    2. Register the **Remote Plugin** to the smart card service by providing the previously built factory.
    3. Use the registered remote plugin as a local plugin.

<br>

## Network configuration

The Keyple Distributed solution **does not provide** the network layer implementation, but it provides a set of SPIs (Service Provider Interfaces) to be implemented by the user in order to enable it to exchange data between **Remote Plugin** and **Local Service** components.

### Synchronous

Choose this mode if you want to implement a Client-Server **synchronous** communication protocol, such as standard HTTP for example.

|                                                                                              | Client                  | Server              |
|----------------------------------------------------------------------------------------------|-------------------------|---------------------|
| Network endpoint SPI to be implemented                                                       | `SyncEndpointClientSpi` | -                   |
| Node API                                                                                     | `SyncNodeClient`        | `SyncNodeServer`    |
| Method to be used when initializing the factory                                              | `withSyncNode(...)`     | `withSyncNode(...)` |
| Method provided by the remote plugin or local service extension<br>to use to access the node | -                       | `getSyncNode()`     |

Here is the minimal algorithm to implement in a context with a **single server instance**:

{{< figure src="/media/learn/user-guide/distributed-application/distributed_synchronous.svg" caption="Synchronous network implementation" numbered="true" >}}

{{% callout warning %}}
In a context with several server instances, a mechanism must be implemented to ensure that all messages associated to
a functional transaction are routed to the same server instance.

For the **Reader Client Side** usage mode, 
the client endpoint can use the value of the `sessionId` field contained in the `MessageDto` object 
transmitted by the Keyple client node to identify transactions. 
This value is generated for each new execution of a remote service. 
When the client endpoint detects a new value, it can, for example, 
transmit the first message without a session cookie in order to be routed to the first available server,
then transmit the session cookie returned by the server in subsequent exchanges until a new transaction is detected.

For the **Reader Server Side** usage mode with **pool plugins**, 
if there are several server instances, 
each reader cycle (from reader allocation to reader release) must be performed on the same server instance. 
A mechanism must be put in place to inform the client endpoint that a new reader cycle is about to begin 
because the `sessionId` field is not relevant here. 
So, for example, when requested by the Keyple client node, 
the client endpoint can transmit the first message without a session cookie in order to be routed to the first 
available server, 
and then transmit the session cookie returned by the server in subsequent exchanges until the start of a new cycle.

For the **Reader Server Side** usage mode with **regular plugins (non-pool)**, 
if several server instances exist, 
a remote plugin must be created for each server instance, 
and each remote plugin must be associated with a distinct client endpoint dedicated to a server instance.

{{% /callout %}}

### Asynchronous

Choose this mode if you want to implement a Full-Duplex **asynchronous** communication protocol, such as Web Sockets for example.

|                                                                                              | Client                   | Server                   |
|----------------------------------------------------------------------------------------------|--------------------------|--------------------------|
| Network endpoint SPI to be implemented                                                       | `AsyncEndpointClientSpi` | `AsyncEndpointServerSpi` |
| Node API                                                                                     | `AsyncNodeClient`        | `AsyncNodeServer`        |
| Method to be used when initializing the factory                                              | `withAsyncNode(...)`     | `withAsyncNode(...)`     |
| Method provided by the remote plugin or local service extension<br>to use to access the node | `getAsyncNode()`         | `getAsyncNode()`         |

Here is the minimal algorithm to implement:

{{< figure src="/media/learn/user-guide/distributed-application/distributed_asynchronous.svg" caption="Asynchronous network implementation" numbered="true" >}}

### Exchanged data

The data exchanged between **Remote Plugin** and **Local Service** components are contained in the DTO (Data Transfer Object) `MessageDto`. It is built and processed by the plugin and **you don't need to modify it**.

However, it is necessary in some contexts to access certain information such as the `sessionId` in the case of communication with several server instances.

<br>

## API

* [Local API](https://docs.keyple.org/keyple-distributed-local-java-lib)
* [Network API](https://docs.keyple.org/keyple-distributed-network-java-lib)
* [Remote API](https://docs.keyple.org/keyple-distributed-remote-java-lib)

<br>

## Examples

* [Java examples](https://github.com/eclipse-keyple/keyple-java-example)

<br>

## Download

* [Java components]({{< ref "components/overview/configuration-wizard" >}})