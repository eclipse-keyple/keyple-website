---
title: Server JSON API (for non-Keyple client)
linktitle: Server JSON API
type: book
toc: true
weight: 3
---

<br>

The **Server JSON API** describes the workflow and the JSON format of data exchanged between terminal and server during 
a remote card transaction, as well as the corresponding business rules. 

{{% callout warning %}}
Please note that this guide does not specify the data transport layer on the network, which remains the responsibility
of the user.
{{% /callout %}}

<br>

## Workflow

The Keyple remote transaction involves four types of messages exchanged between the terminal and the server:

<div id="workflow-table-1">

| Message                    |  Direction  | Description                                                                                |
|----------------------------|:-----------:|--------------------------------------------------------------------------------------------|
| **Execute Remote Service** |  To server  | Allows the terminal to request the server to start a remote ticketing transaction.         |
| **Command**                | From server | Requests the terminal to process specific services with the card or the terminal's reader. |
| **Response**               |  To server  | Allows the terminal to send to the server the responses to the services it has performed.  |
| **End Remote Service**     | From server | Tells the terminal that the remote ticketing transaction is complete.                      |

</div>
<style>
#workflow-table-1 table th:nth-child(1) {
    width: 12rem;
}
</style>

On its own initiative (e.g. following the detection of a card), the terminal sends to the server an
"**Execute Remote Service**" message to request it to start a card transaction.
At this point, the terminal has the ability to tell the server which business service to run and also to provide
the result of an already processed card selection scenario
(e.g. [ProcessedCardSelectionScenarioJsonString]({{< relref "selection-json-specification.md#selection-result-processing" >}}))
and/or additional custom input data.

As long as the transaction is not completed, the terminal receives from the server "**Command**" messages
containing the actions to be performed with the card or the terminal's reader.
The responses are sent to the server in "**Response**" messages.

When the transaction is complete, the terminal receives from the server a final "**End Remote Service**" message
which optionally contains custom transaction output data.

The diagram below illustrates the messages exchange flow:

{{< figure src="/media/learn/user-guide/non-keyple-client/server-json-api-common/Sequence_ServerJsonApi.svg" caption="Keyple Server JSON API - Workflow" >}}

<br>

## Message format

The following table indicates the global JSON format of each message:

<div id="data-format-table-1">

| Message                    |  Direction  |       JSON       | Description                          |
|----------------------------|:-----------:|:----------------:|--------------------------------------|
| **Execute Remote Service** |  To server  |   `MessageDto`   | An object.                           |
| **Command**                | From server | `[ MessageDto ]` | An array containing a single object. |
| **Response**               |  To server  |   `MessageDto`   | An object.                           |
| **End Remote Service**     | From server | `[ MessageDto ]` | An array containing a single object. |

</div>
<style>
#data-format-table-1 table th:nth-child(1) {
    width: 12rem;
}
#data-format-table-1 table th:nth-child(3) {
    width: 10rem;
}
</style>

<br>

## JSON specification

{{< list_children >}}