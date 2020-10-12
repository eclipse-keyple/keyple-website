---
title: (WIP)Develop a Remote Ticketing Application
type: book
toc: true
draft: false
weight: 320
---

## Overview

In a Calypso context, it is useful when your SAM reader and/or your PO reader aren't connected to the same terminal.

To solve this need, Keyple offers the **Keyple Remote Plugin** which allows a terminal to communicate with a smart card reader plugged into another terminal.

In this way, you can open Calypso transaction within a distributed architecture.

The **Keyple Remote Plugin** is composed of two main libraries, each depending on a common one:

<div id="overview-table-1">

| Library | Description | GitHub |
| ------- | ----------- | :----: |
| `Remote Native` | Must be used by the application installed on the terminal having local access to the smart card reader. | [{{< icon name="github" pack="fab" >}}](https://github.com/eclipse/keyple-java/tree/master/java/component/keyple-plugin/remote-se/nativese/README.md) |
| `Remote Virtual` | Must be used by the application installed on the terminal not having local access to the smart card reader and that wishes to control the reader remotely. | [{{< icon name="github" pack="fab" >}}](https://github.com/eclipse/keyple-java/tree/master/java/component/keyple-plugin/remote-se/virtualse/README.md) |
| `Remote Core` | Contains all the common components used by `Remote Native` and `Remote Virtual` libraries such as nodes used for communication management. **Therefore, you do not have to import it explicitly because it's imported by transitivity.** | [{{< icon name="github" pack="fab" >}}](https://github.com/eclipse/keyple-java/tree/master/java/component/keyple-plugin/remote-se/core/README.md) |

</div>
<style>
#overview-table-1 table th:first-of-type {
    width: 120px;
}
#overview-table-1 table th:nth-of-type(3) {
    width: 70px;
}
</style>

## How to use it ?

1. Read first [Overview](#overview) chapter.
2. Find your use case with the help of chapter [Use cases](#use-cases). This will help you determine exactly which interfaces to use.
3. Import [Remote Native](https://github.com/eclipse/keyple-java/tree/master/java/component/keyple-plugin/remote-se/nativese/README.md) and/or [Remote Virtual](https://github.com/eclipse/keyple-java/tree/master/java/component/keyple-plugin/remote-se/virtualse/README.md) libraries depending on your use case.
4. Using chapter [Network configuration](#network-configuration), you must implement the transport layer using the sequence diagram adapted to your network configuration.
5. Implement your ticketing services as specified in the associated use case.

## Use cases

There are 3 possible types of **Keyple Remote Plugin** designed on a **Client-Server** architecture in which the client is always the initiator of the processing:

<div id="use-cases-table-1">

| Plugin | Description |
| ------ | ----------- |
| `Remote Server Plugin` | Allows to control from a **server** terminal a smart card reader plugged into a **client** terminal (e.g. PO reader). |
| `Remote Client Plugin`,<br> `Remote Client Observable Plugin` | Allows to control from a **client** terminal a smart card reader plugged into a **server** terminal (e.g. SAM reader). |
| `Remote Pool Client Plugin` | Allows to control from a **client** terminal a pool of smart cards readers plugged into a **server** terminal (e.g. HSM readers). |

</div>
<style>
#use-cases-table-1 table th:first-of-type {
    width: 240px;
}
</style>

More over, each plugin has different modes in which it allows or not the observation of plugin or reader events (such as reader connection, smart card insertion, etc...).

Here is a summary table of all proposed use cases:

<div id="use-cases-table-2">

| Use Case | Reader type | Reader terminal | Plugin observation | Reader observation | Plugin to use |
| :------: | :---------: | :-------------: | :----------------: | :----------------: | :-----------: |
| [UC 1](#uc-1) | Simple | Client | | | `Remote Server Plugin` |
| [UC 2](#uc-2) | Simple | Client | | X | `-//-` |
| [UC 3](#uc-3) | Simple | Server | | | `Remote Client Plugin` |
| [UC 4](#uc-4) | Simple | Server | | X | `-//-` |
| [UC 5](#uc-5) | Simple | Server | X | | `Remote Client Observable Plugin` |
| [UC 6](#uc-6) | Simple | Server | X | X | `-//-` |
| [UC 7](#uc-7) | Pool | Server | | | `Remote Pool Client Plugin` |

</div>
<style>
#use-cases-table-2 table th:nth-of-type(6) {
    width: 240px;
}
</style>

### Remote Server Plugin

This plugin allows controlling from a **server** terminal a smart card reader plugged into a **client** terminal (e.g. PO reader). 

The following sequence diagram shows from a ticketing application point of view:

* the initialization phase of the native and virtual components;
* the registration of the native plugin and observable reader;
* the selection phase of an observable reader carried out directly by the client;
* the sending of the selection result to the server to remotely perform a specific ticketing service (materialization, validation, etc...);
* the sending of additional information to the server;
* the reception by the server of the transmitted data;
* the execution of the ticketing service;
* the server subscription to observable reader events;
* the sending of information to the client at the end of processing;

In this diagram, the network layer is deliberately hidden. Its implementation is described in the [Network configuration](#network-configuration) paragraph.

{{< figure library="true" src="remote-se/sequence/Remote_Sequence_RemoteServerPlugin_API.svg" title="" >}}

#### UC 1

{{< figure library="true" src="remote-se/component/Remote_Component_UC1_RemoteServerPlugin_Reader_API.svg" title="" >}}

#### UC 2

{{< figure library="true" src="remote-se/component/Remote_Component_UC2_RemoteServerPlugin_ObservableReader_API.svg" title="" >}}

### Remote Client Plugin

This plugin allows controlling from a **client** terminal a smart card reader plugged into a **server** terminal (e.g. SAM reader).

#### UC 3

{{< figure library="true" src="remote-se/component/Remote_Component_UC3_RemoteClientPlugin_Reader_API.svg" title="" >}}

#### UC 4

{{< figure library="true" src="remote-se/component/Remote_Component_UC4_RemoteClientPlugin_ObservableReader_API.svg" title="" >}}

#### UC 5

{{< figure library="true" src="remote-se/component/Remote_Component_UC5_RemoteClientObservablePlugin_Reader_API.svg" title="" >}}

#### UC 6

{{< figure library="true" src="remote-se/component/Remote_Component_UC6_RemoteClientObservablePlugin_ObservableReader_API.svg" title="" >}}

### Remote Pool Client Plugin

This plugin allows controlling from a **client** terminal a pool of smart cards readers plugged into a **server** terminal (e.g. HSM readers).

#### UC 7

{{< figure library="true" src="remote-se/component/Remote_Component_UC7_RemotePoolClientPlugin_Reader_API.svg" title="" >}}

## Network configuration

Usually distributed architecture will rely on a TCP/IP network to communicate. It is up to the users to choose which protocol to use on top of it.

The **Keyple Remote Plugin** does not provide the network implementation, but it provides a set of interfaces to be implemented by the user in order to enable it to exchange data between native and virtual components.

### Client-Server Synchronous communication

If you want to implement a Client-Server communication protocol, such as standard HTTP for example, then you should use:
* on **client**, the `KeypleClientSyncNode` node and provide an implementation of the `KeypleClientSync` endpoint interface in order to be able to connect to a server to send the requests transmitted by the client node;
* on **server**, the `KeypleServerSyncNode` node in order to be able to receive and process the requests received from the client;

Here is the minimal algorithm to implement in a context with a **single server instance**:

{{< figure library="true" src="remote-se/sequence/Remote_Sequence_SyncNode_API.svg" title="" >}}

In a context with several server instances, a mechanism must be implemented to ensure that all messages containing information about a `serverNodeId` are routed to the server associated with a `KeypleServerSyncNode` node having the `serverNodeId`.

### Full-Duplex Asynchronous communication

If you want to implement a Full-Duplex communication protocol, such as Web Sockets for example, then you should use:
* on **client**, the `KeypleClientAsyncNode` node and provide an implementation of the `KeypleClientAsync` endpoint interface in order to be able to open a session with a server and send the messages transmitted by the client node;
* on **server**, the `KeypleServerAsyncNode` node and provide an implementation of the `KeypleServerAsync` endpoint interface in order to be able to send to the client the messages transmitted by the server node;

Here is the minimal algorithm to implement:

{{< figure library="true" src="remote-se/sequence/Remote_Sequence_AsyncNode_API.svg" title="" >}}

## Exchanged data

The POJO object `KeypleMessageDto` contains data exchanged between **Remote Native** and **Remote Virtual** components. It is built and processed by the plugin, and **you don't need to modified it**.

However, it is necessary in some contexts to access certain information such as the `sessionId` in the case of asynchronous communication or the `serverNodeId` in the case of synchronous communication with several server instances.

## Public Global API

{{< figure library="true" src="remote-se/class/Remote_Class_API.svg" title="" >}}
