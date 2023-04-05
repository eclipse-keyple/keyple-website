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
span.text-secondary {
    padding-left: 0.8rem;
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

---
## Data flow

The diagram below shows the global flow of JSON data exchanges between the terminal and the server:

{{< figure src="/media/learn/user-guide/distributed-json-api-1-0/distributedJsonApi_messagingFlow.svg" caption="Keyple Distributed JSON API - Messaging flow" numbered="true" >}}

{{% callout warning %}}
For each terminal-server data exchange, the terminal sends to the server **a JSON object** and receives back **a JSON array
containing a single JSON object**.
{{% /callout %}}

On its own initiative (e.g. following the detection of a card), the terminal sends a `EXECUTE_REMOTE_SERVICE` JSON 
object to the server to ask it to start a card transaction.
At this step, the terminal has the ability to tell the server which business service to run and also to provide 
additional custom input data.

As long as the transaction is not completed, the terminal receives from the server `CMD` JSON objects containing 
the actions to be performed with the card or the terminal's reader. 
The results are sent back to the server in `RESP` JSON objects.

When the transaction is complete, instead of receiving a `CMD` JSON object, the terminal receives a final 
`END_REMOTE_SERVICE` JSON object from the server which optionally contains custom transaction output data.

---
## Data format
The Keyple transaction API uses 4 primary JSON object types, which are explained in detail in the sections below. 

The `action` field is present in all JSON objects and allows to determine the type of the object and especially the 
format of the `body` field content.

It can have the following values: 
- [`EXECUTE_REMOTE_SERVICE`](#execute_remote_service) 
- [`CMD`](#cmd)
- [`RESP`](#resp) 
- [`END_REMOTE_SERVICE`](#end_remote_service)

### EXECUTE_REMOTE_SERVICE

The purpose of this JSON object, sent to the server, is to initiate the server-controlled card 
transaction. 

By using the identification fields provided by the terminal in its subsequent responses, the server ensures 
consistent and accurate data flow management throughout the entire system.

Following the transmission of the `EXECUTE_REMOTE_SERVICE` request, the server will return a JSON object of type 
[`CMD`](#cmd), containing the first action to be performed with the card or the terminal's reader, or 
[`END_REMOTE_SERVICE`](#end_remote_service) to terminate the transaction.

The following UML class diagram illustrates the structure of this object and may help to implement it in the development 
language of the target terminal.

{{< figure src="/media/learn/user-guide/distributed-json-api-1-0/distributedJsonApi_classDiagram_executeRemoteService.svg" 
caption="Keyple Distributed JSON API - EXECUTE_REMOTE_SERVICE class diagram" numbered="true" >}}

#### ExecuteRemoteServiceData
- `action` <span class="text-secondary">**string**</span><br>Always set to "**EXECUTE_REMOTE_SERVICE**".
- `body` <span class="text-secondary">**string**</span><br>A JSON string containing a [ExecuteRemoteServiceBody](#executeremoteservicebody).
- `clientNodeId` <span class="text-secondary">**string**</span><br>The terminal identifier. It shall be unique per server.
- `localReaderName` <span class="text-secondary">**string**</span><br>The identifier of the local reader used to perform the card transaction. It shall be unique per terminal.
- `sessionId` <span class="text-secondary">**string**</span><br>The session identifier. It shall be unique per card transaction.

#### ExecuteRemoteServiceBody
- `serviceId` <span class="text-secondary">**string**</span><br>The identifier of the business service to be executed by the server. It's a naming convention between the client and the server.
- `inputData` <span class="text-secondary">**object (optional)**</span><br>An optional object containing additional data to be provided to the remote business service. Its content is a convention between the client and the server.

#### Example

{{< code lang="json" >}}
{
    "action": "EXECUTE_REMOTE_SERVICE",
    "body": "{\"serviceId\":\"AUTHENTICATE_CARD\",\"inputData\":{\"userId\":\"7b13592c-0d21-429b-80d2-3dc565338ea3\"}}",
    "clientNodeId": "ca21fd3c-a055-4be5-aad1-c61af3528371",
    "localReaderName": "READER_1",
    "sessionId": "b1b8ed38-bae6-4b2e-a747-67d233652ea9"
}
{{< /code >}}

---
### CMD

The purpose of this JSON object, received from the server, is to ask the terminal to perform a specific service with the
card or the terminal's reader.

The service input data is defined in the `body` field as a string containing a JSON object.

The terminal must therefore first parse this string to extract the corresponding JSON object.

The `service` field identifies the service to be executed and can take one of the following values:
- [`IS_CONTACTLESS`](#is_contactless_cmd)
- [`IS_CARD_PRESENT`](#is_card_present_cmd)
- [`TRANSMIT_CARD_SELECTION_REQUESTS`](#transmit_card_selection_requests_cmd)
- [`TRANSMIT_CARD_REQUEST`](#transmit_card_request_cmd)

The `parameters` field is an optional JSON object and is specific to each service (see below for details).

After receiving a `CMD` JSON object, the terminal will return to the server a `RESP` JSON object containing the result 
of the operation.

The following UML class diagram illustrates the structure of this object and may help to implement it in the development 
language of the target terminal.

{{< figure src="/media/learn/user-guide/distributed-json-api-1-0/distributedJsonApi_classDiagram_cmd.svg" 
caption="Keyple Distributed JSON API - CMD class diagram" numbered="true" >}}

---
### &nbsp;&nbsp;&nbsp;&nbsp;IS_CONTACTLESS {#is_contactless_cmd}

This service allows the server to know if the reader is in contact or contactless mode.

There are no parameters for this service.

Upon receiving this request, the terminal must return a `RESP` [IS_CONTACTLESS](#is_contactless_resp) JSON object 
containing a boolean set to true if the reader is a contactless type.

#### JSON structure
- `action` <span class="text-secondary">**string**</span><br>Always set to "**CMD**".
- `body` <span class="text-secondary">**string**</span><br>A JSON string containing a [IsContactlessCmdBody](#iscontactlesscmdbody).
- `clientNodeId` <span class="text-secondary">**string**</span><br>The terminal identifier as provided by `EXECUTE_REMOTE_SERVICE`.
- `localReaderName` <span class="text-secondary">**string**</span><br>The identifier of the local reader as provided by `EXECUTE_REMOTE_SERVICE`.
- `remoteReaderName` <span class="text-secondary">**string**</span><br>The identifier of the virtual remote reader linked to the local reader.
- `serverNodeId` <span class="text-secondary">**string**</span><br>The server identifier.
- `sessionId` <span class="text-secondary">**string**</span><br>The current transaction identifier as provided by `EXECUTE_REMOTE_SERVICE`.

##### IsContactlessCmdBody
- `service` <span class="text-secondary">**string**</span><br>Always set to "**IS_CONTACTLESS**".

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
### &nbsp;&nbsp;&nbsp;&nbsp;IS_CARD_PRESENT {#is_card_present_cmd}

This service allows the server to know if a card is inserted in the reader.

There are no parameters for this service.

Upon receiving this request, the terminal must return a `RESP` [IS_CARD_PRESENT](#is_card_present_resp) JSON object 
containing a boolean set to true if a card is present.

#### JSON structure
- `action` <span class="text-secondary">**string**</span><br>Always set to "**CMD**".
- `body` <span class="text-secondary">**string**</span><br>A JSON string containing a [IsCardPresentCmdBody](#iscardpresentcmdbody).
- `clientNodeId` <span class="text-secondary">**string**</span><br>The terminal identifier as provided by `EXECUTE_REMOTE_SERVICE`.
- `localReaderName` <span class="text-secondary">**string**</span><br>The identifier of the local reader as provided by `EXECUTE_REMOTE_SERVICE`.
- `remoteReaderName` <span class="text-secondary">**string**</span><br>The identifier of the virtual remote reader linked to the local reader.
- `serverNodeId` <span class="text-secondary">**string**</span><br>The server identifier.
- `sessionId` <span class="text-secondary">**string**</span><br>The current transaction identifier as provided by `EXECUTE_REMOTE_SERVICE`.

##### IsCardPresentCmdBody
- `service` <span class="text-secondary">**string**</span><br>Always set to "**IS_CARD_PRESENT**".

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
### &nbsp;&nbsp;&nbsp;&nbsp;TRANSMIT_CARD_SELECTION_REQUESTS {#transmit_card_selection_requests_cmd}

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

The terminal must then send the response to the server in a `RESP` 
[TRANSMIT_CARD_SELECTION_REQUESTS](#transmit_card_selection_requests_resp) JSON object.

#### JSON structure
- `action` <span class="text-secondary">**string**</span><br>Always set to "**CMD**".
- `body` <span class="text-secondary">**string**</span><br>A JSON string containing a [TransmitCardSelectionRequestsCmdBody](#transmitcardselectionrequestscmdbody).
- `clientNodeId` <span class="text-secondary">**string**</span><br>The terminal identifier as provided by `EXECUTE_REMOTE_SERVICE`.
- `localReaderName` <span class="text-secondary">**string**</span><br>The identifier of the local reader as provided by `EXECUTE_REMOTE_SERVICE`.
- `remoteReaderName` <span class="text-secondary">**string**</span><br>The identifier of the virtual remote reader linked to the local reader.
- `serverNodeId` <span class="text-secondary">**string**</span><br>The server identifier.
- `sessionId` <span class="text-secondary">**string**</span><br>The current transaction identifier as provided by `EXECUTE_REMOTE_SERVICE`.

##### TransmitCardSelectionRequestsCmdBody
- `service` <span class="text-secondary">**string**</span><br>Always set to "**TRANSMIT_CARD_SELECTION_REQUESTS**".
- `parameters` <span class="text-secondary">[TransmitCardSelectionRequestsParameters](#transmitcardselectionrequestsparameters)</span><br>The card selection parameters.

##### TransmitCardSelectionRequestsParameters
- `cardSelectionRequests` <span class="text-secondary">[CardSelectionRequest](#cardselectionrequest) **[&nbsp;]**</span><br>A non-empty array.
- `multiSelectionProcessing` <span class="text-secondary">**string**</span><br>- "**FIRST_MATCH**": the selection process stops as soon as a selection case is successful.<br>- "**PROCESS_ALL**": the selection process performs all the selection cases provided (the logical channel is closed at the end of the selection case).
- `channelControl` <span class="text-secondary">**string**</span><br>- "**KEEP_OPEN**": leaves the physical channel open.<br>- "**CLOSE_AFTER**": terminates communication with the card.

##### CardSelectionRequest
- `cardSelector` <span class="text-secondary">[CardSelector](#cardselector)</span><br>The card selection criteria.
- `cardRequest` <span class="text-secondary">[CardRequest](#cardrequest) **(optional)**</span><br>An optional object containing a list of APDU requests to be sent after a successful card selection.

##### CardSelector
- `cardProtocol` <span class="text-secondary">**string (optional)**</span><br>An optional name of the targeted card protocol.
- `powerOnDataRegex` <span class="text-secondary">**string (optional)**</span><br>An optional regex to use to filter the power-on data.
- `aid` <span class="text-secondary">**string (optional)**</span><br>An optional Application Identifier (AID) as an hexadecimal string to be sent with ISO7816-4 "Select Application".
- `fileOccurrence` <span class="text-secondary">**string**</span><br>"**FIRST**", "**LAST**", "**NEXT**" or "**PREVIOUS**" according to the ISO7816-4 standard (only relevant when AID is set).
- `fileControlInformation` <span class="text-secondary">**string**</span><br>"**FCI**", "**FCP**", "**FMD**" or "**NO_RESPONSE**" according to the ISO7816-4 standard (only relevant when AID is set).
- `successfulSelectionStatusWords` <span class="text-secondary">**string** [&nbsp;]<br>A non-empty array of 2-byte hexadecimal strings containing the status word of the "Select Application" APDU command to be considered successful (only relevant when AID is set).

##### CardRequest
- `apduRequests` <span class="text-secondary">[ApduRequest](#apdurequest) **[&nbsp;]**</span><br>A non-empty array of APDU requests.
- `isStatusCodesVerificationEnabled` <span class="text-secondary">**boolean**</span><br>`true` if the transmission of the APDUs should be interrupted as soon as the status word of a response does not belong to the associated list of successful status words.

##### ApduRequest
- `apdu` <span class="text-secondary">**string**</span><br>An hexadecimal string containing the APDU to transmit to the card.
- `successfulStatusWords` <span class="text-secondary">**string** [&nbsp;]<br>A non-empty array of 2-byte hexadecimal strings containing the status word to be considered successful.
- `info` <span class="text-secondary">**string (optional)**</span><br>An optional textual information about the command.

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



### &nbsp;&nbsp;&nbsp;&nbsp;TRANSMIT_CARD_REQUEST {#transmit_card_request_cmd}

The role of this service is to perform APDU exchanges with the card. The received answers are sent back to the 
server in a `RESP` [TRANSMIT_CARD_REQUEST](#transmit_card_request_resp) JSON object.

The terminal must iterate over the list of APDUs present in the card request and proceeds to close the physical channel 
if requested.

#### JSON structure
- `action` <span class="text-secondary">**string**</span><br>Always set to "**CMD**".
- `body` <span class="text-secondary">**string**</span><br>A JSON string containing a [TransmitCardRequestCmdBody](#transmitcardrequestcmdbody).
- `clientNodeId` <span class="text-secondary">**string**</span><br>The terminal identifier as provided by `EXECUTE_REMOTE_SERVICE`.
- `localReaderName` <span class="text-secondary">**string**</span><br>The identifier of the local reader as provided by `EXECUTE_REMOTE_SERVICE`.
- `remoteReaderName` <span class="text-secondary">**string**</span><br>The identifier of the virtual remote reader linked to the local reader.
- `serverNodeId` <span class="text-secondary">**string**</span><br>The server identifier.
- `sessionId` <span class="text-secondary">**string**</span><br>The current transaction identifier as provided by `EXECUTE_REMOTE_SERVICE`.


##### TransmitCardRequestCmdBody
- `service` <span class="text-secondary">**string**</span><br>Always set to "**TRANSMIT_CARD_REQUEST**".
- `parameters` <span class="text-secondary">[TransmitCardRequestParameters](#transmitcardrequestparameters)</span><br>The card request parameters.


##### TransmitCardRequestParameters
- `cardRequest` <span class="text-secondary">[CardRequest](#cardrequest-1)</span><br>An object containing the list of APDU requests to be sent.
- `channelControl` <span class="text-secondary">**string**</span><br>- "**KEEP_OPEN**": leaves the physical channel open.<br/>- "**CLOSE_AFTER**": terminates communication with the card.

##### CardRequest
- `apduRequests` <span class="text-secondary">[ApduRequest](#apdurequest-1) **[&nbsp;]**</span><br>A non-empty array of APDU requests.
- `isStatusCodesVerificationEnabled` <span class="text-secondary">**boolean**</span><br>`true` if the transmission of the APDUs should be interrupted as soon as the status word of a response does not belong to the associated list of successful status words.

##### ApduRequest
- `apdu` <span class="text-secondary">**string**</span><br>An hexadecimal string containing the APDU to transmit to the card.
- `successfulStatusWords` <span class="text-secondary">**string** [&nbsp;]<br>A non-empty array of 2-byte hexadecimal strings containing the status word to be considered successful.
- `info` <span class="text-secondary">**string (optional)**</span><br>An optional textual information about the command.

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
### RESP
This JSON object, sent by the terminal to the server, is intended to transmit to the server the result of the specific 
service previously performed on the card or the terminal's reader.

The service output data must be formatted in the `body` field as a string containing a JSON object.

The `service` field identifies the service that was executed and takes one of the following values:
- [`IS_CONTACTLESS`](#is_contactless_resp)
- [`IS_CARD_PRESENT`](#is_card_present_resp)
- [`TRANSMIT_CARD_SELECTION_REQUESTS`](#transmit_card_selection_requests_resp)
- [`TRANSMIT_CARD_REQUEST`](#transmit_card_request_resp)

The `result` field is a JSON object that is present if the service was successful and its type is specific to each 
service (see below for more details).

The `error` field is a JSON object that is present if an error occurred during the execution of the service (see below 
for more details).

Following the transmission of the `RESP` request, the server will return a JSON object of type [`CMD`](#cmd),
containing the next action to be performed, or [`END_REMOTE_SERVICE`](#end_remote_service) to terminate the transaction.

The following UML class diagram illustrates the structure of this object and may help to implement it in the development
language of the target terminal.

{{< figure src="/media/learn/user-guide/distributed-json-api-1-0/distributedJsonApi_classDiagram_resp.svg" caption="Keyple Distributed JSON API - RESP class diagram" numbered="true" >}}

---
### &nbsp;&nbsp;&nbsp;&nbsp;IS_CONTACTLESS {#is_contactless_resp}

This JSON object, sent by the terminal to the server in response to `CMD` [`IS_CONTACTLESS`](#is_contactless_cmd), is 
intended to indicate to the server if the reader is contactless.

#### JSON structure
- `action` <span class="text-secondary">**string**</span><br>Always set to "**RESP**".
- `body` <span class="text-secondary">**string**</span><br>A JSON string containing a [IsContactlessRespBody](#iscontactlessrespbody).
- `clientNodeId` <span class="text-secondary">**string**</span><br>The terminal identifier as provided by `EXECUTE_REMOTE_SERVICE`.
- `localReaderName` <span class="text-secondary">**string**</span><br>The identifier of the local reader as provided by `EXECUTE_REMOTE_SERVICE`.
- `remoteReaderName` <span class="text-secondary">**string**</span><br>The identifier of the virtual remote reader linked to the local reader as provided by `CMD`.
- `serverNodeId` <span class="text-secondary">**string**</span><br>The server identifier as provided by `CMD`.
- `sessionId` <span class="text-secondary">**string**</span><br>The current transaction identifier as provided by `EXECUTE_REMOTE_SERVICE`.

##### IsContactlessRespBody
- `service` <span class="text-secondary">**string**</span><br>Always set to "**IS_CONTACTLESS**".
- `result` <span class="text-secondary">**boolean (optional)**</span><br>`true` if the reader is contactless (absent in case of error).
- `error` <span class="text-secondary">[Error](#is_contactless_resp_error) **(optional)**</span><br>The error description (absent in case of success).


##### Error {#is_contactless_resp_error}
- `code` <span class="text-secondary">**string**</span><br>Free value.
- `message` <span class="text-secondary">**string**</span><br>The error description.

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
### &nbsp;&nbsp;&nbsp;&nbsp;IS_CARD_PRESENT {#is_card_present_resp}

This JSON object, sent by the terminal to the server, is intended to indicate to the server if a card is present.

#### JSON structure
- `action` <span class="text-secondary">**string**</span><br>The value is "**RESP**".
- `body` <span class="text-secondary">**string**</span><br>A JSON string containing a [IsCardPresentRespBody](#iscardpresentrespbody).
- `clientNodeId` <span class="text-secondary">**string**</span><br>The terminal identifier as provided by `EXECUTE_REMOTE_SERVICE`.
- `localReaderName` <span class="text-secondary">**string**</span><br>The identifier of the local reader as provided by `EXECUTE_REMOTE_SERVICE`.
- `remoteReaderName` <span class="text-secondary">**string**</span><br>The identifier of the virtual remote reader linked to the local reader as provided by `CMD`.
- `serverNodeId` <span class="text-secondary">**string**</span><br>The server identifier as provided by `CMD`.
- `sessionId` <span class="text-secondary">**string**</span><br>The current transaction identifier as provided by `EXECUTE_REMOTE_SERVICE`.

##### IsCardPresentRespBody
- `service` <span class="text-secondary">**string**</span><br>Always set to "**IS_CARD_PRESENT**".
- `result` <span class="text-secondary">**boolean**</span><br>true if a card is present.
- `error` <span class="text-secondary">[Error](#is_card_present_resp_error) **(optional)**</span><br>The error description (absent in case of success).

##### Error {#is_card_present_resp_error}
- `code` <span class="text-secondary">**string**</span><br>- "**READER_COMMUNICATION_ERROR**": if the issue is related to the reader communication link,<br/>- "**CARD_COMMUNICATION_ERROR**": if the issue is related to the card communication link.
- `message` <span class="text-secondary">**string**</span><br>The error description.                                                                                                                                                                  |


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
### &nbsp;&nbsp;&nbsp;&nbsp;TRANSMIT_CARD_SELECTION_REQUESTS {#transmit_card_selection_requests_resp}
This JSON object, sent by the terminal to the server, is intended to transmit to the server the result of the execution 
of the selection scenario.

#### JSON structure
- `action` <span class="text-secondary">**string**</span><br>Always set to "**RESP**".
- `body` <span class="text-secondary">**string**</span><br>A JSON string containing a [TransmitCardSelectionRequestsRespBody](#transmitcardselectionrequestsrespbody).
- `clientNodeId` <span class="text-secondary">**string**</span><br>The terminal identifier as provided by `EXECUTE_REMOTE_SERVICE`.
- `localReaderName` <span class="text-secondary">**string**</span><br>The identifier of the local reader as provided by `EXECUTE_REMOTE_SERVICE`.
- `remoteReaderName` <span class="text-secondary">**string**</span><br>The identifier of the virtual remote reader linked to the local reader as provided by `CMD`.
- `serverNodeId` <span class="text-secondary">**string**</span><br>The server identifier as provided by `CMD`.
- `sessionId` <span class="text-secondary">**string**</span><br>The current transaction identifier as provided by `EXECUTE_REMOTE_SERVICE`.

##### TransmitCardSelectionRequestsRespBody
- `service` <span class="text-secondary">**string**</span><br>Always set to "**TRANSMIT_CARD_SELECTION_REQUESTS**".
- `result` <span class="text-secondary">[CardSelectionResponse](#cardselectionresponse) **[&nbsp;] (optional)**</span><br>A non-empty list containing at most as many responses as there are selection cases (absent in case of error).
- `error` <span class="text-secondary">[Error](#transmit_card_selection_requests_resp_error) **(optional)**</span><br>The error description (absent in case of success).

##### CardSelectionResponse
- `hasMatched` <span class="text-secondary">**boolean**</span><br>`true` if the associated selection case has matched.                                                                                                                                                                                                                                                                       
- `powerOnData` <span class="text-secondary">**string (optional)**</span><br>Data from the initialization phase of the communication with the card. E.g. the Answer To Reset (ATR) in the case of a contact card or any other string informing about the low level communication. This string can be used for filtering by power-on data defined in the command (absent if the protocol filter failed). 
- `selectApplicationResponse` <span class="text-secondary">[`ApduResponse`](#apduresponse) **(optional)**</span><br>Data received in response to the ISO7816-4 "Select Application" command (absent if no AID filtering).                                                                                                                                                                                                                      
- `cardResponse` <span class="text-secondary">[`CardResponse`](#cardresponse) **(optional)**</span><br>Data received in response to additional commands (absent if no additional commands were provided).                                                                                                                                                                                                                         

##### CardResponse
- `isLogicalChannelOpen` <span class="text-secondary">**boolean**</span><br>`true` if the logical channel is left open.                           
- `apduResponses` <span class="text-secondary">[`ApduResponse`](#apduresponse) **[&nbsp;]**</span><br>A list containing the APDU responses for each request in the command. 

##### ApduResponse
- `apdu` <span class="text-secondary">**string**</span><br>An hexadecimal string containing the APDU received from the card (including the status word). 
- `statusWord` <span class="text-secondary">**string**</span><br>A 2-byte hexadecimal string containing the status word of the received APDU.                  

##### Error {#transmit_card_selection_requests_resp_error}
- `code` <span class="text-secondary">**string**</span><br>- "**READER_COMMUNICATION_ERROR**": if the issue is related to the reader communication link,<br/>- "**CARD_COMMUNICATION_ERROR**": if the issue is related to the card communication link,<br/>- "**CARD_COMMAND_ERROR**": if the card returned a unexpected status word. 
- `message` <span class="text-secondary">**string**</span><br>The error description.                                                                                                                                                                                                                                             

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

### &nbsp;&nbsp;&nbsp;&nbsp;TRANSMIT_CARD_REQUEST {#transmit_card_request_resp}
This JSON object, sent by the terminal to the server, is intended to transmit to the server the result of the execution
of a card request.

#### JSON structure
- `action` <span class="text-secondary">**string**</span><br>Always set to "**RESP**".
- `body` <span class="text-secondary">**string**</span><br>A JSON string containing a [TransmitCardRequestRespBody](#transmitcardrequestrespbody).
- `clientNodeId` <span class="text-secondary">**string**</span><br>The terminal identifier as provided by `EXECUTE_REMOTE_SERVICE`.
- `localReaderName` <span class="text-secondary">**string**</span><br>The identifier of the local reader as provided by `EXECUTE_REMOTE_SERVICE`.
- `remoteReaderName` <span class="text-secondary">**string**</span><br>The identifier of the virtual remote reader linked to the local reader as provided by `CMD`.
- `serverNodeId` <span class="text-secondary">**string**</span><br>The server identifier as provided by `CMD`.
- `sessionId` <span class="text-secondary">**string**</span><br>The current transaction identifier as provided by `EXECUTE_REMOTE_SERVICE`.

##### TransmitCardRequestRespBody
- `service` <span class="text-secondary">**string**</span><br>Always set to "**TRANSMIT_CARD_REQUEST**".
- `result` <span class="text-secondary">[CardResponse](#cardresponse-1) **[&nbsp;] (optional)**</span><br>A non-empty list containing at most as many responses as there are selection cases (absent in case of error).
- `error` <span class="text-secondary">[Error](#transmit_card_request_resp_error) **(optional)**</span><br>The error description (absent in case of success).

##### CardResponse
- `isLogicalChannelOpen` <span class="text-secondary">**boolean**</span><br>`true` if the logical channel is left open.
- `apduResponses` <span class="text-secondary">[`ApduResponse`](#apduresponse-1) **[&nbsp;]**</span><br>A list containing the APDU responses for each request in the command.

##### ApduResponse
- `apdu` <span class="text-secondary">**string**</span><br>An hexadecimal string containing the APDU received from the card (including the status word).
- `statusWord` <span class="text-secondary">**string**</span><br>A 2-byte hexadecimal string containing the status word of the received APDU.

##### Error {#transmit_card_request_resp_error}
- `code` <span class="text-secondary">**string**</span><br>- "**READER_COMMUNICATION_ERROR**": if the issue is related to the reader communication link,<br/>- "**CARD_COMMUNICATION_ERROR**": if the issue is related to the card communication link,<br/>- "**CARD_COMMAND_ERROR**": if the card returned a unexpected status word.
- `message` <span class="text-secondary">**string**</span><br>The error description.

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
### END_REMOTE_SERVICE
The purpose of this JSON object, received from the server, is to inform the terminal that the transaction has been 
completed and, if necessary, to transmit the result. No follow-up is expected from the server.

The following UML class diagram illustrates the structure of this object and may help to implement it in the development
language of the target terminal.

{{< figure src="/media/learn/user-guide/distributed-json-api-1-0/distributedJsonApi_classDiagram_endRemoteService.svg" 
caption="Keyple Distributed JSON API - END_REMOTE_SERVICE class diagram" numbered="true" >}}

#### EndRemoteServiceData
- `action` <span class="text-secondary">**string**</span><br>Always set to "**END_REMOTE_SERVICE**".
- `body` <span class="text-secondary">**string**</span><br>A JSON string containing a [EndRemoteServiceBody](#endremoteservicebody).
- `clientNodeId` <span class="text-secondary">**string**</span><br>The terminal identifier as provided by `EXECUTE_REMOTE_SERVICE`.
- `remoteReaderName` <span class="text-secondary">**string**</span><br>The identifier of the virtual remote reader linked to the local reader.
- `serverNodeId` <span class="text-secondary">**string**</span><br>The server identifier.
- `sessionId` <span class="text-secondary">**string**</span><br>The current transaction identifier as provided by `EXECUTE_REMOTE_SERVICE`.

#### EndRemoteServiceBody
- `outputData` <span class="text-secondary">**object (optional)**</span><br>An optional object containing additional data provided by the remote business 
service. Its content is a convention between the client and the server.

#### Example

{{< code lang="json" >}}
[
    {
        "action": "END_REMOTE_SERVICE",
        "body": "{\"outputData\":{\"isSuccessful\":true,\"userId\":\"test\"}}",
        "clientNodeId": "ca21fd3c-a055-4be5-aad1-c61af3528371",
        "remoteReaderName": "a65f4920-7e96-4082-986a-b58d85978c07",
        "serverNodeId": "4132f1ef-4386-49b0-acb6-cc16035c107a",
        "sessionId": "b1b8ed38-bae6-4b2e-a747-67d233652ea9"
    }
]
{{< /code >}}
