---
title: Non-Keyple Client User Guide
linktitle: Non-Keyple client
summary: How to connect a non-Keyple-based client application to a Keyple-based server application.
type: book
toc: true
weight: 2
---

<style>
table th:nth-child(1) {
  width: 9rem;
}
</style>

{{% callout note %}}
A "**non-Keyple client**" refers to a client application developed in a language **other than Java, Kotlin, or C++**, and
therefore **unable to directly integrate the core libraries of the Keyple ecosystem**.

This application is installed on a terminal equipped with a **card reader**. However, due to its technological environment,
it cannot locally use Keyple's core components to access the card or perform ticketing procedures. It must therefore
**rely on a remote Keyple-based component** (e.g., through a server API) to carry out these operations.
{{% /callout %}}

<br>

## Overview

This guide is designed for developers of non-Keyple client applications embedded in smart card processing terminals,
who need to delegate all or part of the management of the smart card ticketing transaction to a Keyple-based server
application.

{{% callout note %}}
This use case corresponds to the **Reader Client Side** usage mode of the **Keyple Distributed** solution.
{{% /callout %}}

{{< figure src="/media/learn/user-guide/distributed-application/distributed_solution_2_layers_overview.drawio.svg" caption="Keyple on server side only" numbered="true" >}}

<br>

## Operating mode

The client is the initiator of the application processing following a card event (card insertion/removal).
He can hand over to the server whenever he wants to perform a remote ticketing service on a card present in one of his
local readers.

There are two ways for a non-Keyple client application to communicate with a server based on the Keyple middleware:

1. [Manual implementation of the Keyple JSON specifications](#manual-implementation)
2. [Using the Keyple interop multiplatform libraries](#keyple-interop-libraries)

<br>

## Manual implementation

You can implement the communication logic manually by following the official Keyple JSON specifications:

{{< figure src="/media/learn/user-guide/non-keyple-client/Components_ManualImplementation.drawio.svg" caption="Manual implementation" numbered="true" >}}

<div id="content-table-1">

| Specification                                                                    | Description                                                                                                                                                                     |
|----------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Server JSON API]({{< relref "server-json-api.md" >}})                           | Describes the workflow and the JSON format of data exchanged between terminal and server during a remote card transaction, as well as the corresponding business rules.         |
| [Selection JSON Specification]({{< relref "selection-json-specification.md" >}}) | Describes how to implement early card selection on the terminal before requesting the server to continue the card transaction, as well as the JSON format of the involved data. |

</div>
<style>
#content-table-1 table th:nth-child(1) {
    width: 14rem;
}
</style>

This approach ensures maximum flexibility and autonomy for integrators. However, it requires full ownership of the
implementation, including the business logic defined in the Selection JSON Specification and the Server JSON API. It
also involves managing JSON (de)serialization of the corresponding data structures and implementing the card reader
access layer.

<br>

## Keyple interop libraries

To simplify development and ensure compliance with the specifications, you can integrate the following ready-to-use
Keyple interop multiplatform libraries into your application:

{{< figure src="/media/learn/user-guide/non-keyple-client/Components_KeypleInteropLibraries.drawio.svg" caption="Keyple interop multiplatform libraries" numbered="true" >}}

<div id="content-table-2">

| Keyple Interop Library                                                                                              |              Platform               | Description                                                                                                                                                                                  |
|---------------------------------------------------------------------------------------------------------------------|:-----------------------------------:|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [JSON API Client]({{< ref "components/interop-components/keyple-interop-jsonapi-client-kmp-lib" >}})                | Windows, Linux, macOS, Android, iOS | A Kotlin multiplatform client library that fully implements the Keyple Server JSON API and Selection JSON Specification. It enables direct interaction with a Keyple-based server over HTTP. |
| [Local Reader NFC Mobile]({{< ref "components/interop-components/keyple-interop-localreader-nfcmobile-kmp-lib" >}}) |            Android, iOS             | A Kotlin multiplatform adapter that provides access to mobile NFC readers. It allows smart card operations to be performed locally and used in conjunction with the JSON API Client library. |

</div>
<style>
#content-table-2 table th:nth-child(1) {
    width: 12rem;
}
</style>

This second option greatly reduces implementation effort and ensures compatibility with the evolving Keyple ecosystem.

<br>

### Workflow overview

The following sequence diagram shows the overall interaction flow between a client application and Keyple's interop
libraries:

{{< figure src="/media/learn/user-guide/non-keyple-client/Sequence_InteropWorkflow.svg" caption="Keyple interop libraries workflow" numbered="true" >}}

### Workflow details

1. Retrieve an export of the card selection scenario from the server using your preferred method.
   This scenario will be processed when a card is detected.
   For more details, refer to Keyple’s 
   [Import/Export Scenario]({{< ref "/learn/user-guide/standalone-application.md#importexport-a-scenario" >}})
   feature.<br><div class="alert alert-note"><div>Implementing early 
   card selection is **strongly recommended** for non-Keyple clients as it **increases performance** by reducing the 
   number of network exchanges, as the selection scenario can be processed autonomously by the terminal as
   soon as a card is presented.</div></div><div class="alert alert-note"><div>The scenario should be retrieved by 
   the customer **well before a card is presented**, for example **during installation, updating or application startup**.</div></div>
2. Build an instance of `KeypleTerminal`, providing a `LocalReader` implementation to access the card reader,
   a `SyncEndpointClient` implementation to access the server over HTTP,
   and possibly a card selection scenario export to be processed when a card is detected.<br><div class="alert alert-note"><div>The 
   **Keyple Interop Local Reader NFC Mobile Library** provides the `MultiplatformNfcReader` class as a `LocalReader` 
   implementation for NFC mobiles, but you can provide other implementations depending on your context.</div></div><div class="alert alert-note"><div><p>The implementation of the `SyncEndpointClient` remains your responsibility,
   as it is specific to the context of the client application.</p><p>In a context with several server instances, 
   a mechanism must be implemented to ensure that all messages associated to
   a functional transaction are routed to the same server instance.</p><p>The client network endpoint can use the value of the `sessionId` field contained in the `MessageDto` object
   transmitted by `KeypleTerminal` to identify transactions.
   This value is generated for each new execution of a remote service.
   When the client endpoint detects a new value, it can, for example,
   transmit the first message without a session cookie in order to be routed to the first available server,
   then transmit the session cookie returned by the server in subsequent exchanges until a new transaction is detected.</p></div></div><div class="alert alert-note"><div>The export of the selection scenario 
   can be provided at a later date using the dedicated setter function if required, for example, after the card has been detected,
   but before to execute the remote service.</div></div>
3. Wait for the card to be detected by calling the associated function provided by `KeypleTerminal`.<br><div class="alert alert-note"><div>Waiting 
   can be performed synchronously or asynchronously, and can also be cancelled.</div></div>
4. Execute the desired remote service by calling the associated function provided by the `KeypleTerminal`
   by specifying the identifier of the ticketing service to be executed 
   and transmitting to the server additional information if needed.<br><div class="alert alert-note"><div>The remote
   service execution is blocking.</div></div>

<br>

### API

* [Keyple Interop JSON API Client API](https://docs.keyple.org/keyple-interop-jsonapi-client-kmp-lib/)
* [Keyple Interop Local Reader NFC Mobile API](https://docs.keyple.org/keyple-interop-localreader-nfcmobile-kmp-lib/)

<br>

### Examples

Calypso Networks Association has provided an example of how to integrate these libraries.
It is available [here](https://github.com/calypsonet/keyple-demo-ticketing/tree/main/src/reloading-remote/client/interop-mobile-multiplatform).

<br>

### Download

* [Keyple Interop JSON API Client Library]({{< ref "components/interop-components/keyple-interop-jsonapi-client-kmp-lib" >}})
* [Keyple Interop Local Reader NFC Mobile Library]({{< ref "components/interop-components/keyple-interop-localreader-nfcmobile-kmp-lib" >}})

<br>
