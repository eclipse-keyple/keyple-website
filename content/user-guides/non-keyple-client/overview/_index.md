---
title: Non-Keyple Client User Guide
linktitle: Non-Keyple client
summary: How to connect a non-Keyple-based client application to a Keyple-based server application using simple JSON block exchanges.
type: book
toc: false
weight: 2
---

<style>
table th:nth-child(1) {
  width: 9rem;
}
</style>

<br>

This guide is designed for developers of non-Keyple client applications embedded in smart card processing terminals,
who need to delegate all or part of the management of the smart card ticketing transaction to a Keyple-based server
application.

{{< figure src="/media/learn/user-guide/distributed-application/distributed_solution_2_layers_overview.drawio.svg" caption="Keyple on server side only" >}}

For this purpose, the following specifications are provided:

<div id="overview-table-1">

| Specification                                                                    | Description                                                                                                                                                                     |
|----------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Server JSON API]({{< relref "server-json-api.md" >}})                           | Describes the workflow and the JSON format of data exchanged between terminal and server during a remote card transaction, as well as the corresponding business rules.         |
| [Selection JSON Specification]({{< relref "selection-json-specification.md" >}}) | Describes how to implement early card selection on the terminal before requesting the server to continue the card transaction, as well as the JSON format of the involved data. |

</div>
<style>
#overview-table-1 table th:nth-child(1) {
    width: 14rem;
}
</style>
