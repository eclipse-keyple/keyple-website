---
title: Selection JSON Specification (for non-Keyple client)
linktitle: Selection JSON Specification
type: book
toc: true
weight: 4
---

<br>

The **Selection JSON Specification** describes how to implement early card selection on the terminal before requesting
the server to continue the card transaction, as well as the JSON format of the involved data.

{{% callout warning %}}
Implementing early card selection is **strongly recommended** for non-Keyple clients as it **increases performance** by
reducing the number of network exchanges, as the selection scenario can be processed autonomously by the terminal as
soon as a card is presented.
{{% /callout %}}

<br>

## Workflow

This specification is based on Keyple's
"[Import/Export Scenario]({{< ref "/learn/user-guide/standalone-application.md#importexport-a-scenario" >}})"
functionality, which enables to import/export prepared and processed card selection scenarios,
and therefore follows the same workflow.

The early card selection involves two JSON strings exchanged between the terminal and the server:

| JSON                                       |  Direction  | Description                                                                   |
|--------------------------------------------|:-----------:|-------------------------------------------------------------------------------|
| `CardSelectionScenarioJsonString`          | From server | A JSON string containing the exported card selection scenario.                |
| `ProcessedCardSelectionScenarioJsonString` |  To server  | A JSON string containing the result of the processed card selection scenario. |

On its own initiative (e.g. at startup), the terminal requests the server to export the card selection scenario to be
processed when a card is detected. The server returns a JSON string `CardSelectionScenarioJsonString` containing the 
scenario.

Later, when a card is detected, the terminal processes the scenario on the card.

Then, it generates a JSON string `ProcessedCardSelectionScenarioJsonString` containing the result of the 
processed scenario, and sends it to the server using the [Server JSON API]({{< relref "server-json-api.md" >}}) 
to continue the transaction.

The diagram below illustrates the workflow:

{{< figure src="/media/learn/user-guide/non-keyple-client/selection-json-specification-common/Sequence_SelectionJsonSpecification.svg" caption="Keyple Selection JSON Specification - Workflow" >}}

<br>

## Selection processing

The primary objective of selection step is to establish a logical communication channel with a card.

To enable processing of different card profiles, Keyple offers the creation of selection scenarios with integrated
selection cases. The scenario is provided by the server, and it involves checking whether the
card is compatible with at least one of the selection cases. The selection cases are processed successively, in the
order in which they are defined.

There are several options for executing the scenario:
- the process stops at the first selection case where the card matches, or all selection cases are systematically processed.
- the physical channel can be kept open or closed at the end of each selection case.

A card selection case incorporates various independent filters that can be applied individually or in combination
to determine if a detected card is suitable for performing a transaction. While some cards can be selected based on
communication protocol or response data from the power-on operation, most of the cards require a selection through
Application Identifier (AID) using the ISO7816-4 "Select Application" APDU command.

The structure outlined below allows for defining selection scenarios that combine these three types of filters:
- based on the communication protocol,
- based on the response data from the power on stage,
- based on the Application Identifier (AID).

When filtering by AID, the "Select Application" APDU command is sent to the card in accordance with the ISO7816-4
standard.
Additional parameters, also defined by the standard, can be set to specify the type of operation (`FileOccurrence`)
and the type of output (`FileControlInformation`).

Each filter is optional, and if none are defined, the selection is considered successful as soon as the card is
detected.
However, when a filter is specified, it becomes a prerequisite for the card selection.

In addition to card selection, a selection scenario can include a list of APDUs that are to be transmitted to the card
as soon as it becomes "selected".

The terminal must iterate over each selection cases of the scenario, determine which type of filter to apply and apply
it (e.g. protocol, power-on data, AID).

If all the defined filters are satisfied, the terminal must send any additional APDUs.

<br>

## Selection result processing

The JSON string `ProcessedCardSelectionScenarioJsonString` resulting from the processed card selection scenario 
must be transmitted to the server in the `inputData` property of the “**Execute Remote Service**” message 
of the [Server JSON API]({{< relref "server-json-api.md" >}}).

{{% callout note %}}
The JSON string can be wrapped inside a parent object if other
information needs to be transmitted to the server.
{{% /callout %}}

<br>

## JSON specification

{{< list_children >}}