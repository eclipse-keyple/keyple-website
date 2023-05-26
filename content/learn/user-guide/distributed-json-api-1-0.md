---
title: Distributed JSON API 1.0 User Guide
linktitle: Distributed JSON API 1.0
summary: How to connect a non-Keyple based client application to a Keyple based server using simple JSON block exchanges.
type: book
toc: true
draft: false
weight: 3
---

---

<style>
table th:nth-child(1) {
  width: 9rem;
}
</style>

## Overview

This guide is specifically designed for users who are not currently using Keyple in their terminals, but wish to connect
to a Keyple server. It details the JSON data exchange between the terminal and the server, but does not cover the 
transport of this data.

This allows the development of a distributed solution in which the client reader terminal delegates the entire 
management of the card transaction to the server.

{{% callout warning %}}
This API is compliant with the following Keyple server side components:
- [Keyple Service Library]({{< ref "components-java/core/keyple-service-java-lib" >}}) version `2.1.4+`
- [Keyple Distributed Network Library]({{< ref "components-java/distributed/keyple-distributed-network-java-lib" >}}) version `2.2.0+`
- [Keyple Distributed Remote Library]({{< ref "components-java/distributed/keyple-distributed-remote-java-lib" >}}) version `2.2.0+`
{{% /callout %}}

### Principle

The Keyple remote transaction uses four types of messages exchanged between the terminal and the server in JSON format:

<div id="principles-table-1">

| Message                                           |  Direction  | Description                                                                                |
|---------------------------------------------------|:-----------:|--------------------------------------------------------------------------------------------|
| [Execute Remote Service](#execute-remote-service) |  To server  | Allows the terminal to request the server to start the remote ticketing transaction.       |
| [Command](#command)                               | From server | Requests the terminal to process specific services with the card or the terminal's reader. |
| [Response](#response)                             |  To server  | Allows the terminal to send to the server the responses to the services it has performed.  |
| [End Remote Service](#end-remote-service)         | From server | Tells the terminal that the remote ticketing transaction is complete.                      |

</div>
<style>
#principles-table-1 table th:nth-child(1) {
    width: 10.5rem;
}
</style>

The diagram below shows the global messaging flow:

{{< figure src="/media/learn/user-guide/distributed-json-api-1-0/distributedJsonApi_messagingFlow.svg" caption="Keyple Distributed JSON API - Messaging flow" numbered="true" >}}

On its own initiative (e.g. following the detection of a card), the terminal sends to the server a
message of type "[Execute Remote Service](#execute-remote-service)" to ask it to start a card transaction.
At this step, the terminal has the ability to tell the server which business service to run and also to provide
additional custom input data.

As long as the transaction is not completed, the terminal receives from the server messages of type "[Command](#command)" 
containing the actions to be performed with the card or the terminal's reader.
The responses are sent to the server in messages of type "[Response](#response)".

When the transaction is complete, the terminal receives from the server a final message
of type "[End Remote Service](#end-remote-service)" which optionally contains custom transaction output data.

### Data structure

Messages are in JSON format and have the following structure:

<div id="data-structure-table-1">

| Message                                           |  Direction  |  JSON Structure  | Description                          |
|---------------------------------------------------|:-----------:|:----------------:|--------------------------------------|
| [Execute Remote Service](#execute-remote-service) |  To server  |   `MessageDto`   | An object.                           |
| [Command](#command)                               | From server | `[ MessageDto ]` | An array containing a single object. |
| [Response](#response)                             |  To server  |   `MessageDto`   | An object.                           |
| [End Remote Service](#end-remote-service)         | From server | `[ MessageDto ]` | An array containing a single object. |

</div>
<style>
#data-structure-table-1 table th:nth-child(1) {
    width: 10.5rem;
}
#data-structure-table-1 table th:nth-child(3) {
    width: 8rem;
}
</style>

The diagram below shows the structure of the `MessageDto` object but the detailed content will be described in the
sections associated with each message type:

{{< figure src="/media/learn/user-guide/distributed-json-api-1-0/distributedJsonApi_classDiagram_MessageDto.svg" caption="Keyple Distributed JSON API - MessageDto" numbered="true" >}}

{{% callout note %}}
The value of the `action` property determines the message type.
{{% /callout %}}

---
## Execute Remote Service

The purpose of this message, sent to the server, is to initiate the server-controlled card 
transaction. 

By using the identification properties provided by the terminal in its subsequent responses, the server ensures 
consistent and accurate data flow management throughout the entire system.

Following the transmission of this message, the server will return a message of type "[Command](#command)", 
containing the first action to be performed with the card or the terminal's reader, or of type 
"[End Remote Service](#end-remote-service)" to terminate the transaction.

The following UML class diagram illustrates the structure of this object and may help to implement it in the development 
language of the target terminal.

{{< figure src="/media/learn/user-guide/distributed-json-api-1-0/distributedJsonApi_classDiagram_executeRemoteService.svg" 
caption="Keyple Distributed JSON API - \"Execute Remote Service\" class diagram" numbered="true" >}}

#### MessageDto {#messagedto-executeremoteservice}

|                    |                                                                                                                         |
|--------------------|-------------------------------------------------------------------------------------------------------------------------|
| `action`           | **String**<br>Constant value: "**EXECUTE_REMOTE_SERVICE**"                                                              |
| `body`             | **String**<br>A JSON string containing a [ExecuteRemoteServiceBody](#executeremoteservicebody) JSON object.             |
| `sessionId`        | **String**<br>The session identifier. It shall be unique per card transaction.                                          |
| `clientNodeId`     | **String**<br>The terminal identifier. It shall be unique per server.                                                   |
| `localReaderName`  | **String**<br>The identifier of the local reader used to perform the card transaction. It shall be unique per terminal. |
| `serverNodeId`     | **String (optional)**<br>Null or absent.                                                                                |
| `remoteReaderName` | **String (optional)**<br>Null or absent.                                                                                |

#### ExecuteRemoteServiceBody

|             |                                                                                                                                                                                      |
|-------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `serviceId` | **String**<br>The identifier of the business service to be executed by the server. It's a naming convention between the client and the server.                                       |
| `inputData` | **Object (optional)**<br>An optional object containing additional data to be provided to the remote business service. Its content is a convention between the client and the server. |

#### Example

{{< code lang="json" >}}
{
    "action": "EXECUTE_REMOTE_SERVICE",
    "body": "{\"serviceId\":\"AUTHENTICATE_CARD\",\"inputData\":{\"userId\":\"7b13592c-0d21-429b-80d2-3dc565338ea3\"}}",
    "sessionId": "b1b8ed38-bae6-4b2e-a747-67d233652ea9",
    "clientNodeId": "ca21fd3c-a055-4be5-aad1-c61af3528371",
    "localReaderName": "READER_1"
}
{{< /code >}}

---
## Command

The purpose of this message, received from the server, is to ask the terminal to perform a specific service with the
card or the terminal's reader.

There are four types of service potentially requested by the server:

<div id="command-table-1">

| Service                                                                   | Description                                                |
|---------------------------------------------------------------------------|------------------------------------------------------------|
| [Is Contactless](#is-contactless-cmd)                                     | Indicates if the reader is in contact or contactless mode. |
| [Is Card Present](#is-card-present-cmd)                                   | Indicates if a card is present in the reader.              |
| [Transmit Card Selection Requests](#transmit-card-selection-requests-cmd) | Establish a logical communication channel with a card.     |
| [Transmit Card Request](#transmit-card-request-cmd)                       | Perform APDU exchanges with the card.                      |

</div>
<style>
#command-table-1 table th:nth-child(1) {
    width: 14rem;
}
</style>

Following the reception of this message, the terminal will send to the server a message of type 
"[Response](#response)" containing the response of the operation.

The following UML class diagram illustrates the structure of this object and may help to implement it in the development 
language of the target terminal.

{{< figure src="/media/learn/user-guide/distributed-json-api-1-0/distributedJsonApi_classDiagram_cmd.svg" 
caption="Keyple Distributed JSON API - \"Command\" class diagram" numbered="true" >}}

{{% callout note %}}
The value of the `service` property determines the service to be performed.
{{% /callout %}}

{{% callout warning %}}
The `MessageDto` is contained in a single-element array!
{{% /callout %}}

---
### Is Contactless {#is-contactless-cmd}

This service allows the server to know if the reader is in contact or contactless mode.

There are no parameters for this service.

The terminal must then send the response to the server in a message of type
"[Is Contactless (Response)](#is-contactless-resp)".

{{% callout warning %}}
The `MessageDto` is contained in a single-element array!
{{% /callout %}}

#### MessageDto {#messagedto-is-contactless-cmd}

|                    |                                                                                                                   |
|--------------------|-------------------------------------------------------------------------------------------------------------------|
| `action`           | **String**<br>Constant value: "**CMD**"                                                                           |
| `body`             | **String**<br>A JSON string containing a [IsContactlessCmdBody](#iscontactlesscmdbody) JSON object.               |
| `sessionId`        | **String**<br>The current transaction identifier as provided by the initial "**Execute Remote Service**" message. |
| `clientNodeId`     | **String**<br>The terminal identifier as provided by the initial "**Execute Remote Service**" message.            |
| `localReaderName`  | **String**<br>The identifier of the local reader as provided by the initial "**Execute Remote Service**" message. |
| `serverNodeId`     | **String**<br>The server identifier.                                                                              |
| `remoteReaderName` | **String**<br>The identifier of the virtual remote reader linked to the local reader.                             |

##### IsContactlessCmdBody

|           |                                                    |
|-----------|----------------------------------------------------|
| `service` | **String**<br>Constant value: "**IS_CONTACTLESS**" |

##### Example

{{< code lang="json" >}}
[
    {
        "action": "CMD",
        "body": "{\"service\":\"IS_CONTACTLESS\"}",
        "clientNodeId": "ca21fd3c-a055-4be5-aad1-c61af3528371",
        "localReaderName": "READER_1",
        "remoteReaderName": "a65f4920-7e96-4082-986a-b58d85978c07",
        "serverNodeId": "4132f1ef-4386-49b0-acb6-cc16035c107a",
        "sessionId": "b1b8ed38-bae6-4b2e-a747-67d233652ea9"
    }
]
{{< /code >}}

---
### Is Card Present {#is-card-present-cmd}

This service allows the server to know if a card is inserted in the reader.

There are no parameters for this service.

The terminal must then send the response to the server in a message of type
"[Is Card Present (Response)](#is-card-present-resp)".

{{% callout warning %}}
The `MessageDto` is contained in a single-element array!
{{% /callout %}}

#### MessageDto {#messagedto-is-card-present-cmd}

|                    |                                                                                                                   |
|--------------------|-------------------------------------------------------------------------------------------------------------------|
| `action`           | **String**<br>Constant value: "**CMD**"                                                                           |
| `body`             | **String**<br>A JSON string containing a [IsCardPresentCmdBody](#iscardpresentcmdbody) JSON object.               |
| `sessionId`        | **String**<br>The current transaction identifier as provided by the initial "**Execute Remote Service**" message. |
| `clientNodeId`     | **String**<br>The terminal identifier as provided by the initial "**Execute Remote Service**" message.            |
| `localReaderName`  | **String**<br>The identifier of the local reader as provided by the initial "**Execute Remote Service**" message. |
| `serverNodeId`     | **String**<br>The server identifier.                                                                              |
| `remoteReaderName` | **String**<br>The identifier of the virtual remote reader linked to the local reader.                             |

##### IsCardPresentCmdBody

|           |                                                     |
|-----------|-----------------------------------------------------|
| `service` | **String**<br>Constant value: "**IS_CARD_PRESENT**" |

##### Example

{{< code lang="json" >}}
[
    {
        "action": "CMD",
        "body": "{\"service\":\"IS_CARD_PRESENT\"}",
        "clientNodeId": "ca21fd3c-a055-4be5-aad1-c61af3528371",
        "localReaderName": "READER_1",
        "remoteReaderName": "a65f4920-7e96-4082-986a-b58d85978c07",
        "serverNodeId": "4132f1ef-4386-49b0-acb6-cc16035c107a",
        "sessionId": "b1b8ed38-bae6-4b2e-a747-67d233652ea9"
    }
]
{{< /code >}}

---
### Transmit Card Selection Requests {#transmit-card-selection-requests-cmd}

The primary objective of this service is to establish a logical communication channel with a card.

To enable processing of different card profiles, it offers the creation of selection scenarios with integrated 
selection cases. The scenario is provided by the server after a card is detected, and it involves checking whether the 
card is compatible with at least one of the selection cases. The selection cases are processed successively, in the 
order in which they are defined.

There are several options for executing the scenario:
- the process stops at the first selection case where the card matches, or all scenarios are systematically processed.
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

The algorithm to be implemented by the terminal to process this service consists in iterating on the selection cases of 
the scenario.

For each selection case, the terminal must determine which type of filter to apply and apply it: protocol, power-on 
data, AID.

If all the defined filters are satisfied, the terminal must send any additional APDUs.

The terminal must then send the response to the server in a message of type 
"[Transmit Card Selection Requests (Response)](#transmit-card-selection-requests-resp)".

{{% callout warning %}}
The `MessageDto` is contained in a single-element array!
{{% /callout %}}

#### MessageDto {#messagedto-transmit-card-selection-requests-cmd}

|                    |                                                                                                                                     |
|--------------------|-------------------------------------------------------------------------------------------------------------------------------------|
| `action`           | **String**<br>Constant value: "**CMD**"                                                                                             |
| `body`             | **String**<br>A JSON string containing a [TransmitCardSelectionRequestsCmdBody](#transmitcardselectionrequestscmdbody) JSON object. |
| `sessionId`        | **String**<br>The current transaction identifier as provided by the initial "**Execute Remote Service**" message.                   |
| `clientNodeId`     | **String**<br>The terminal identifier as provided by the initial "**Execute Remote Service**" message.                              |
| `localReaderName`  | **String**<br>The identifier of the local reader as provided by the initial "**Execute Remote Service**" message.                   |
| `serverNodeId`     | **String**<br>The server identifier.                                                                                                |
| `remoteReaderName` | **String**<br>The identifier of the virtual remote reader linked to the local reader.                                               |

##### TransmitCardSelectionRequestsCmdBody

|              |                                                                                                                       |
|--------------|-----------------------------------------------------------------------------------------------------------------------|
| `service`    | **String**<br>Constant value: "**TRANSMIT_CARD_SELECTION_REQUESTS**"                                                  |
| `parameters` | [TransmitCardSelectionRequestsParameters](#transmitcardselectionrequestsparameters)<br>The card selection parameters. |

##### TransmitCardSelectionRequestsParameters

|                            |                                                                                                                                                                                                                                                                                                              |
|----------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `cardSelectionRequests`    | [CardSelectionRequest](#cardselectionrequest) **[ ]**<br>A non-empty array.                                                                                                                                                                                                                                  |
| `multiSelectionProcessing` | **String**<br>Can have one of the following values:<br>- "**FIRST_MATCH**": the selection process stops as soon as a selection case is successful.<br>- "**PROCESS_ALL**": the selection process performs all the selection cases provided (the logical channel is closed at the end of the selection case). |
| `channelControl`           | **String**<br>Can have one of the following values:<br>- "**KEEP_OPEN**": leaves the physical channel open.<br>- "**CLOSE_AFTER**": terminates communication with the card.                                                                                                                                  |

##### CardSelectionRequest

|                |                                                                                                                                                   |
|----------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| `cardSelector` | [CardSelector](#cardselector)<br>The card selection criteria.                                                                                     |
| `cardRequest`  | [CardRequest](#cardrequest) **(optional)**<br>An optional object containing a list of APDU requests to be sent after a successful card selection. |

##### CardSelector

|                                  |                                                                                                                                                                                                    |
|----------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `cardProtocol`                   | **String (optional)**<br>An optional name of the targeted card protocol.                                                                                                                           |
| `powerOnDataRegex`               | **String (optional)**<br>An optional regex to use to filter the power-on data.                                                                                                                     |
| `aid`                            | **String (optional)**<br>An optional Application Identifier (AID) as an hexadecimal string to be sent with ISO7816-4 "Select Application".                                                         |
| `fileOccurrence`                 | **String**<br>Can have one of the following values:<br>"**FIRST**", "**LAST**", "**NEXT**" or "**PREVIOUS**" according to the ISO7816-4 standard (only relevant when AID is set).                  |
| `fileControlInformation`         | **String**<br>Can have one of the following values:<br>"**FCI**", "**FCP**", "**FMD**" or "**NO_RESPONSE**" according to the ISO7816-4 standard (only relevant when AID is set).                   |
| `successfulSelectionStatusWords` | **String [ ]**<br>A non-empty array of 2-byte hexadecimal strings containing the status word of the "Select Application" APDU command to be considered successful (only relevant when AID is set). |

##### CardRequest

|                                    |                                                                                                                                                                                                                        |
|------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `apduRequests`                     | [ApduRequest](#apdurequest) **[ ]**<br>A non-empty array of APDU requests.                                                                                                                                             |
| `isStatusCodesVerificationEnabled` | **Boolean**<br>Set to **true** if the transmission of the APDUs should be interrupted as soon as the status word of a response does not belong to the associated list of successful status words, **false** otherwise. |

##### ApduRequest

|                         |                                                                                                                           |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------|
| `apdu`                  | **String**<br>An hexadecimal string containing the APDU to transmit to the card.                                          |
| `successfulStatusWords` | **String [ ]**<br>A non-empty array of 2-byte hexadecimal strings containing the status word to be considered successful. |
| `info`                  | **String (optional)**<br>An optional textual information about the command.                                               |

##### Example

{{< code lang="json" >}}
[
    {
        "action": "CMD",
        "body": "{\"service\":\"TRANSMIT_CARD_SELECTION_REQUESTS\",\"parameters\":{\"multiSelectionProcessing\":\"FIRST_MATCH\",\"channelControl\":\"KEEP_OPEN\",\"cardSelectionRequests\":[{\"cardSelector\":{\"cardProtocol\":\"ISO_14443_4_CARD\",\"aid\":\"315449432E49434131\",\"fileOccurrence\":\"FIRST\",\"fileControlInformation\":\"FCI\",\"successfulSelectionStatusWords\":[\"9000\"]},\"cardRequest\":{\"apduRequests\":[{\"apdu\":\"00B2013C00\",\"successfulStatusWords\":[\"9000\"],\"info\":\"Read Records - SFI: 7h, REC: 1, READMODE: ONE_RECORD, EXPECTEDLENGTH: 0\"}],\"isStatusCodesVerificationEnabled\":false}}]}}",
        "clientNodeId": "ca21fd3c-a055-4be5-aad1-c61af3528371",
        "localReaderName": "READER_1",
        "remoteReaderName": "a65f4920-7e96-4082-986a-b58d85978c07",
        "serverNodeId": "4132f1ef-4386-49b0-acb6-cc16035c107a",
        "sessionId": "b1b8ed38-bae6-4b2e-a747-67d233652ea9"
    }
]
{{< /code >}}

### Transmit Card Request {#transmit-card-request-cmd}

The role of this service is to perform APDU exchanges with the card.

The terminal must iterate over the list of APDUs present in the card request and proceeds to close the physical channel
if requested.

The response must be sent to the server in a message of type
"[Transmit Card Request (Response)](#transmit-card-request-resp)".

{{% callout warning %}}
The `MessageDto` is contained in a single-element array!
{{% /callout %}}

#### MessageDto {#messagedto-transmit-card-request-cmd}

|                    |                                                                                                                   |
|--------------------|-------------------------------------------------------------------------------------------------------------------|
| `action`           | **String**<br>Constant value: "**CMD**"                                                                           |
| `body`             | **String**<br>A JSON string containing a [TransmitCardRequestCmdBody](#transmitcardrequestcmdbody) JSON object.   |
| `sessionId`        | **String**<br>The current transaction identifier as provided by the initial "**Execute Remote Service**" message. |
| `clientNodeId`     | **String**<br>The terminal identifier as provided by the initial "**Execute Remote Service**" message.            |
| `localReaderName`  | **String**<br>The identifier of the local reader as provided by the initial "**Execute Remote Service**" message. |
| `serverNodeId`     | **String**<br>The server identifier.                                                                              |
| `remoteReaderName` | **String**<br>The identifier of the virtual remote reader linked to the local reader.                             |

##### TransmitCardRequestCmdBody

|              |                                                                                                 |
|--------------|-------------------------------------------------------------------------------------------------|
| `service`    | **String**<br>Constant value: "**TRANSMIT_CARD_REQUEST**"                                       |
| `parameters` | [TransmitCardRequestParameters](#transmitcardrequestparameters)<br>The card request parameters. |

##### TransmitCardRequestParameters

|                  |                                                                                                                                                                             |
|------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `cardRequest`    | [CardRequest](#cardrequest-1)<br>An object containing the list of APDU requests to be sent.                                                                                 |
| `channelControl` | **String**<br>Can have one of the following values:<br>- "**KEEP_OPEN**": leaves the physical channel open.<br>- "**CLOSE_AFTER**": terminates communication with the card. |

##### CardRequest

|                                    |                                                                                                                                                                                                                        |
|------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `apduRequests`                     | [ApduRequest](#apdurequest-1) **[ ]**<br>A non-empty array of APDU requests.                                                                                                                                           |
| `isStatusCodesVerificationEnabled` | **Boolean**<br>Set to **true** if the transmission of the APDUs should be interrupted as soon as the status word of a response does not belong to the associated list of successful status words, **false** otherwise. |

##### ApduRequest

|                         |                                                                                                                           |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------|
| `apdu`                  | **String**<br>An hexadecimal string containing the APDU to transmit to the card.                                          |
| `successfulStatusWords` | **String [ ]**<br>A non-empty array of 2-byte hexadecimal strings containing the status word to be considered successful. |
| `info`                  | **String (optional)**<br>An optional textual information about the command.                                               |

##### Example

{{< code lang="json" >}}
[
    {
        "action": "CMD",
        "body": "{\"service\":\"TRANSMIT_CARD_REQUEST\",\"parameters\":{\"cardRequest\":{\"apduRequests\":[{\"apdu\":\"00B2014400\",\"successfulStatusWords\":[\"9000\"],\"info\":\"Read Records - SFI: 8h, REC: 1, READMODE: ONE_RECORD, EXPECTEDLENGTH: 0\"}],\"isStatusCodesVerificationEnabled\":true},\"channelControl\":\"CLOSE_AFTER\"}}",
        "clientNodeId": "ca21fd3c-a055-4be5-aad1-c61af3528371",
        "localReaderName": "READER_1",
        "remoteReaderName": "a65f4920-7e96-4082-986a-b58d85978c07",
        "serverNodeId": "4132f1ef-4386-49b0-acb6-cc16035c107a",
        "sessionId": "b1b8ed38-bae6-4b2e-a747-67d233652ea9"
    }
]
{{< /code >}}

---
## Response

This message, sent by the terminal to the server, is intended to transmit to the server the result of the specific 
service previously performed on the card or the terminal's reader.

Following the transmission of this message, the server will return a message of type 
"[Command](#command)", containing the next action to be performed, or of type 
"[End Remote Service](#end-remote-service)" to terminate the transaction.

The following UML class diagram illustrates the structure of this object and may help to implement it in the development
language of the target terminal.

{{< figure src="/media/learn/user-guide/distributed-json-api-1-0/distributedJsonApi_classDiagram_resp.svg" caption="Keyple Distributed JSON API - \"Response\" class diagram" numbered="true" >}}

---
### Is Contactless {#is-contactless-resp}

This message, sent by the terminal to the server in response to "[Is Contactless (Command)](#is-contactless-cmd)", is 
intended to indicate to the server if the reader is contactless.

#### MessageDto {#messagedto-is-contactless-resp}

|                    |                                                                                                                                     |
|--------------------|-------------------------------------------------------------------------------------------------------------------------------------|
| `action`           | **String**<br>Constant value: "**RESP**"                                                                                            |
| `body`             | **String**<br>A JSON string containing a [IsContactlessRespBody](#iscontactlessrespbody) JSON object.                               |
| `sessionId`        | **String**<br>The current transaction identifier as provided by the initial "**Execute Remote Service**" message.                   |
| `clientNodeId`     | **String**<br>The terminal identifier as provided by the initial "**Execute Remote Service**" message.                              |
| `localReaderName`  | **String**<br>The identifier of the local reader as provided by the initial "**Execute Remote Service**" message.                   |
| `serverNodeId`     | **String**<br>The server identifier as provided by the last "**Command**" message.                                                  |
| `remoteReaderName` | **String**<br>The identifier of the virtual remote reader linked to the local reader as provided by the last "**Command**" message. |

##### IsContactlessRespBody

|           |                                                                                                                        |
|-----------|------------------------------------------------------------------------------------------------------------------------|
| `service` | **String**<br>Constant value: "**IS_CONTACTLESS**"                                                                     |
| `result`  | **Boolean (optional)**<br>Set to **true** if the reader is contactless, **false** otherwise (absent in case of error). |
| `error`   | [Error](#is-contactless-resp_error) **(optional)**<br>The error description (absent in case of success).               |

##### Error {#is-contactless-resp_error}

|           |                                      |
|-----------|--------------------------------------|
| `code`    | **String**<br>Free value.            |
| `message` | **String**<br>The error description. |

#### Example

{{< code lang="json" >}}
{
    "action": "RESP",
    "body": "{\"service\":\"IS_CONTACTLESS\",\"result\":true}",
    "clientNodeId": "ca21fd3c-a055-4be5-aad1-c61af3528371",
    "localReaderName": "READER_1",
    "remoteReaderName": "a65f4920-7e96-4082-986a-b58d85978c07",
    "serverNodeId": "4132f1ef-4386-49b0-acb6-cc16035c107a",
    "sessionId": "b1b8ed38-bae6-4b2e-a747-67d233652ea9"
}
{{< /code >}}

---
### Is Card Present {#is-card-present-resp}

This message, sent by the terminal to the server in response to "[Is Card Present (Command)](#is-card-present-cmd)", 
is intended to indicate to the server if a card is present.

#### MessageDto {#messagedto-is-card-present-resp}

|                    |                                                                                                                                     |
|--------------------|-------------------------------------------------------------------------------------------------------------------------------------|
| `action`           | **String**<br>The value is "**RESP**".                                                                                              |
| `body`             | **String**<br>A JSON string containing a [IsCardPresentRespBody](#iscardpresentrespbody) JSON object.                               |
| `sessionId`        | **String**<br>The current transaction identifier as provided by the initial "**Execute Remote Service**" message.                   |
| `clientNodeId`     | **String**<br>The terminal identifier as provided by the initial "**Execute Remote Service**" message.                              |
| `localReaderName`  | **String**<br>The identifier of the local reader as provided by the initial "**Execute Remote Service**" message.                   |
| `serverNodeId`     | **String**<br>The server identifier as provided by the last "**Command**" message.                                                  |
| `remoteReaderName` | **String**<br>The identifier of the virtual remote reader linked to the local reader as provided by the last "**Command**" message. |

##### IsCardPresentRespBody

|           |                                                                                                           |
|-----------|-----------------------------------------------------------------------------------------------------------|
| `service` | **String**<br>Constant value: "**IS_CARD_PRESENT**"                                                       |
| `result`  | **Boolean**<br>Set to **true** if a card is present, **false** otherwise (absent in case of error).       |
| `error`   | [Error](#is-card-present-resp_error) **(optional)**<br>The error description (absent in case of success). |

##### Error {#is-card-present-resp_error}

|           |                                                                                                                                                                                                                                                   |
|-----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `code`    | **String**<br>Can have one of the following values:<br>- "**READER_COMMUNICATION_ERROR**": if the issue is related to the reader communication link,<br>- "**CARD_COMMUNICATION_ERROR**": if the issue is related to the card communication link. |
| `message` | **String**<br>The error description.                                                                                                                                                                                                              |

#### Example

{{< code lang="json" >}}
{
    "action": "RESP",
    "body": "{\"service\":\"IS_CARD_PRESENT\",\"result\":true}",
    "clientNodeId": "ca21fd3c-a055-4be5-aad1-c61af3528371",
    "localReaderName": "READER_1",
    "remoteReaderName": "a65f4920-7e96-4082-986a-b58d85978c07",
    "serverNodeId": "4132f1ef-4386-49b0-acb6-cc16035c107a",
    "sessionId": "b1b8ed38-bae6-4b2e-a747-67d233652ea9"
}
{{< /code >}}

---
### Transmit Card Selection Requests {#transmit-card-selection-requests-resp}

This message, sent by the terminal to the server in response to 
"[Transmit Card Selection Requests (Command)](#transmit-card-selection-requests-cmd)", 
is intended to transmit to the server the result of the execution of the selection scenario.

#### MessageDto {#messagedto-transmit-card-selection-requests-resp}

|                    |                                                                                                                                       |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------------|
| `action`           | **String**<br>Constant value: "**RESP**"                                                                                              |
| `body`             | **String**<br>A JSON string containing a [TransmitCardSelectionRequestsRespBody](#transmitcardselectionrequestsrespbody) JSON object. |
| `sessionId`        | **String**<br>The current transaction identifier as provided by the initial "**Execute Remote Service**" message.                     |
| `clientNodeId`     | **String**<br>The terminal identifier as provided by the initial "**Execute Remote Service**" message.                                |
| `localReaderName`  | **String**<br>The identifier of the local reader as provided by the initial "**Execute Remote Service**" message.                     |
| `serverNodeId`     | **String**<br>The server identifier as provided by the last "**Command**" message.                                                    |
| `remoteReaderName` | **String**<br>The identifier of the virtual remote reader linked to the local reader as provided by the last "**Command**" message.   |

##### TransmitCardSelectionRequestsRespBody

|           |                                                                                                                                                                                     |
|-----------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `service` | **String**<br>Constant value: "**TRANSMIT_CARD_SELECTION_REQUESTS**"                                                                                                                |
| `result`  | [CardSelectionResponse](#cardselectionresponse) **[ ] (optional)**<br>A non-empty list containing at most as many responses as there are selection cases (absent in case of error). |
| `error`   | [Error](#transmit-card-selection-requests-resp_error) **(optional)**<br>The error description (absent in case of success).                                                          |

##### CardSelectionResponse

|                             |                                                                                                                                                                                                                                                                                                                                                     |
|-----------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `hasMatched`                | **Boolean**<br>Set to **true** if the associated selection case has matched, **false** otherwise.                                                                                                                                                                                                                                                   |
| `powerOnData`               | **String (optional)**<br>Data from the initialization phase of the communication with the card. E.g. the Answer To Reset (ATR) in the case of a contact card or any other string informing about the low level communication. This string can be used for filtering by power-on data defined in the command (absent if the protocol filter failed). |
| `selectApplicationResponse` | [ApduResponse](#apduresponse) **(optional)**<br>Data received in response to the ISO7816-4 "Select Application" command (absent if no AID filtering).                                                                                                                                                                                               |
| `cardResponse`              | [CardResponse](#cardresponse) **(optional)**<br>Data received in response to additional commands (absent if no additional commands were provided).                                                                                                                                                                                                  |

##### CardResponse

|                        |                                                                                                                |
|------------------------|----------------------------------------------------------------------------------------------------------------|
| `isLogicalChannelOpen` | **Boolean**<br>Set to **true** if the logical channel is left open, **false** otherwise.                       |
| `apduResponses`        | [ApduResponse](#apduresponse) **[ ]**<br>A list containing the APDU responses for each request in the command. |

##### ApduResponse

|              |                                                                                                             |
|--------------|-------------------------------------------------------------------------------------------------------------|
| `apdu`       | **String**<br>An hexadecimal string containing the APDU received from the card (including the status word). |
| `statusWord` | **String**<br>A 2-byte hexadecimal string containing the status word of the received APDU.                  |

##### Error {#transmit-card-selection-requests-resp_error}

|           |                                                                                                                                                                                                                                                                                                                                    |
|-----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `code`    | **String**<br>Can have one of the following values:<br>- "**READER_COMMUNICATION_ERROR**": if the issue is related to the reader communication link,<br/>- "**CARD_COMMUNICATION_ERROR**": if the issue is related to the card communication link,<br/>- "**CARD_COMMAND_ERROR**": if the card returned an unexpected status word. |
| `message` | **String**<br>The error description.                                                                                                                                                                                                                                                                                               |

##### Example

{{< code lang="json" >}}
{
    "action": "RESP",
    "body": "{\"service\":\"TRANSMIT_CARD_SELECTION_REQUESTS\",\"result\":[{\"hasMatched\":true,\"powerOnData\":\"3B8880010000000000718100F9\",\"selectApplicationResponse\":{\"apdu\":\"6F238409315449432E49434131A516BF0C13C708000000001122334453070A3C23121410019000\",\"statusWord\":\"9000\"},\"cardResponse\":{\"apduResponses\":[{\"apdu\":\"24B92848080000131A50001200000000000000000000000000000000009000\",\"statusWord\":\"9000\"}],\"isLogicalChannelOpen\":true}}]}",
    "clientNodeId": "ca21fd3c-a055-4be5-aad1-c61af3528371",
    "localReaderName": "READER_1",
    "remoteReaderName": "a65f4920-7e96-4082-986a-b58d85978c07",
    "serverNodeId": "4132f1ef-4386-49b0-acb6-cc16035c107a",
    "sessionId": "b1b8ed38-bae6-4b2e-a747-67d233652ea9"
}
{{< /code >}}

### Transmit Card Request {#transmit-card-request-resp}

This message, sent by the terminal to the server in response to
"[Transmit Card Request (Command)](#transmit-card-request-cmd)",
is intended to transmit to the server the result of the execution of a card request.

#### MessageDto {#messagedto-transmit-card-request-resp}

|                    |                                                                                                                                     |
|--------------------|-------------------------------------------------------------------------------------------------------------------------------------|
| `action`           | **String**<br>Constant value: "**RESP**"                                                                                            |
| `body`             | **String**<br>A JSON string containing a [TransmitCardRequestRespBody](#transmitcardrequestrespbody) JSON object.                   |
| `sessionId`        | **String**<br>The current transaction identifier as provided by the initial "**Execute Remote Service**" message.                   |
| `clientNodeId`     | **String**<br>The terminal identifier as provided by the initial "**Execute Remote Service**" message.                              |
| `localReaderName`  | **String**<br>The identifier of the local reader as provided by the initial "**Execute Remote Service**" message.                   |
| `serverNodeId`     | **String**<br>The server identifier as provided by the last "**Command**" message.                                                  |
| `remoteReaderName` | **String**<br>The identifier of the virtual remote reader linked to the local reader as provided by the last "**Command**" message. |

##### TransmitCardRequestRespBody

|           |                                                                                                                            |
|-----------|----------------------------------------------------------------------------------------------------------------------------|
| `service` | **String**<br>Constant value: "**TRANSMIT_CARD_REQUEST**"                                                                  |
| `result`  | [CardResponse](#cardresponse-1) **(optional)**<br>Data received in response to the card request (absent in case of error). |
| `error`   | [Error](#transmit-card-request-resp_error) **(optional)**<br>The error description (absent in case of success).            |

##### CardResponse

|                        |                                                                                                                  |
|------------------------|------------------------------------------------------------------------------------------------------------------|
| `isLogicalChannelOpen` | **Boolean**<br>Set to **true** if the logical channel is left open, **false** otherwise.                         |
| `apduResponses`        | [ApduResponse](#apduresponse-1) **[ ]**<br>A list containing the APDU responses for each request in the command. |

##### ApduResponse

|              |                                                                                                             |
|--------------|-------------------------------------------------------------------------------------------------------------|
| `apdu`       | **String**<br>An hexadecimal string containing the APDU received from the card (including the status word). |
| `statusWord` | **String**<br>A 2-byte hexadecimal string containing the status word of the received APDU.                  |

##### Error {#transmit-card-request-resp_error}

|           |                                                                                                                                                                                                                                                                                                                                    |
|-----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `code`    | **String**<br>Can have one of the following values:<br>- "**READER_COMMUNICATION_ERROR**": if the issue is related to the reader communication link,<br/>- "**CARD_COMMUNICATION_ERROR**": if the issue is related to the card communication link,<br/>- "**CARD_COMMAND_ERROR**": if the card returned an unexpected status word. |
| `message` | **String**<br>The error description.                                                                                                                                                                                                                                                                                               |

##### Example

{{< code lang="json" >}}
{
    "action": "RESP",
    "body": "{\"service\":\"TRANSMIT_CARD_REQUEST\",\"result\":{\"apduResponses\":[{\"apdu\":\"00112233445566778899AABBCCDDEEFF00112233445566778899AABBCC9000\",\"statusWord\":\"9000\"}],\"isLogicalChannelOpen\":true}}",
    "clientNodeId": "ca21fd3c-a055-4be5-aad1-c61af3528371",
    "localReaderName": "READER_1",
    "remoteReaderName": "a65f4920-7e96-4082-986a-b58d85978c07",
    "serverNodeId": "4132f1ef-4386-49b0-acb6-cc16035c107a",
    "sessionId": "b1b8ed38-bae6-4b2e-a747-67d233652ea9"
}
{{< /code >}}

---
## End Remote Service

The purpose of this message, received from the server, is to inform the terminal that the transaction has been 
completed and, if necessary, to transmit the result. No follow-up is expected from the server.

The following UML class diagram illustrates the structure of this object and may help to implement it in the development
language of the target terminal.

{{< figure src="/media/learn/user-guide/distributed-json-api-1-0/distributedJsonApi_classDiagram_endRemoteService.svg" 
caption="Keyple Distributed JSON API - \"End Remote Service\" class diagram" numbered="true" >}}

{{% callout warning %}}
The `MessageDto` is contained in a single-element array!
{{% /callout %}}

#### MessageDto {#messagedto-endremoteservice}

|                    |                                                                                                                   |
|--------------------|-------------------------------------------------------------------------------------------------------------------|
| `action`           | **String**<br>Constant value: "**END_REMOTE_SERVICE**"                                                            |
| `body`             | **String**<br>A JSON string containing a [EndRemoteServiceBody](#endremoteservicebody) JSON object.               |
| `sessionId`        | **String**<br>The current transaction identifier as provided by the initial "**Execute Remote Service**" message. |
| `clientNodeId`     | **String**<br>The terminal identifier as provided by the initial "**Execute Remote Service**" message.            |
| `localReaderName`  | **String (optional)**<br>Null or absent.                                                                          |
| `serverNodeId`     | **String**<br>The server identifier.                                                                              |
| `remoteReaderName` | **String**<br>The identifier of the virtual remote reader linked to the local reader.                             |

#### EndRemoteServiceBody

|              |                                                                                                                                                                                |
|--------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `outputData` | **Object (optional)**<br>An optional object containing additional data provided by the remote business service. Its content is a convention between the client and the server. |

#### Example

{{< code lang="json" >}}
[
    {
        "action": "END_REMOTE_SERVICE",
        "body": "{\"outputData\":{\"isSuccessful\":true,\"userId\":\"test\"}}",
        "sessionId": "b1b8ed38-bae6-4b2e-a747-67d233652ea9",
        "clientNodeId": "ca21fd3c-a055-4be5-aad1-c61af3528371",
        "serverNodeId": "4132f1ef-4386-49b0-acb6-cc16035c107a",
        "remoteReaderName": "a65f4920-7e96-4082-986a-b58d85978c07"
    }
]
{{< /code >}}
