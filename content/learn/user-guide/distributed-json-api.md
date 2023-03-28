---
title: Distributed JSON API
linktitle: Distributed JSON API
summary: How to connect a non-Keyple based client application to a Keyple based server using simple JSON block exchanges.
type: book
toc: true
draft: false
weight: 3
---

---
## Overview

This guide explains how to connect a non-Keyple based client application to a Keyple based server using simple JSON 
data exchanges. 
It details the JSON data exchange between the terminal and the server, but does not cover the transport of this data.

This allows the development of a distributed solution in which the client reader terminal delegates the entire 
management of the card transaction to the server.

---
## Data flow

The diagram below shows the global flow of JSON data exchanges between the terminal and the server:

{{< figure src="/media/learn/user-guide/distributed-json-api/distributedJsonApi_messagingFlow.svg" caption="Keyple Distributed JSON API - Messaging flow" numbered="true" >}}

On its own initiative (e.g. following the detection of a card), the terminal sends a `EXECUTE_REMOTE_SERVICE` JSON 
object to the server to ask it to start a card transaction.
At this step, the terminal has the ability to tell the server which business service to run and also to provide 
additional custom input data.

As long as the transaction is not completed, the terminal receives from the server `CMD` JSON objects containing 
the actions to be performed with the card or the terminal reader. 
The results are sent back to the server in `RESP` JSON objects.

When the transaction is complete, instead of receiving a `CMD` JSON object, the terminal receives a final 
`endremoteservice` JSON object from the server which optionally contains custom transaction output data.

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
[`CMD`](#cmd) or [`END_REMOTE_SERVICE`](#end_remote_service) containing the actions to be performed with the card or
the terminal reader.

The following UML class diagram illustrates the structure of this object and may help to implement it in the development 
language of the target terminal.

{{< figure src="/media/learn/user-guide/distributed-json-api/distributedJsonApi_classDiagram_executeRemoteService.svg" 
caption="Keyple Distributed JSON API - EXECUTE_REMOTE_SERVICE class diagram" numbered="true" >}}

#### ExecuteRemoteServiceData

| NAME              |  TYPE  | DESCRIPTION                                                                                               |
|-------------------|:------:|-----------------------------------------------------------------------------------------------------------|
| `action`          | String | `"EXECUTE_REMOTE_SERVICE"`                                                                                |
| `body`            | String | A JSON string containing a [ExecuteRemoteServiceBody](#executeremoteservicebody).                         |
| `clientNodeId`    | String | The terminal identifier. It shall be unique per server.                                                   |
| `localReaderName` | String | The identifier of the local reader used to perform the card transaction. It shall be unique per terminal. |
| `sessionId`       | String | The session identifier. It shall be unique per card transaction.                                          |

#### ExecuteRemoteServiceBody

| NAME        |  TYPE  | DESCRIPTION                                                                                                                                                       |
|-------------|:------:|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `serviceId` | String | The identifier of the business service to be executed by the server. It's a naming convention between the client and the server.                                  |
| `inputData` | Object | (optional) - An object containing additional data to be provided to the remote business service. It's content is a convention between the client and the server.  |

#### Example

{{< code lang="json" >}}
{
  "action": "EXECUTE_REMOTE_SERVICE",
  "body": "{\"serviceId\":\"EXECUTE_CALYPSO_SESSION_FROM_REMOTE_SELECTION\",\"inputData\":{\"userId\":\"test\"}}",
  "clientNodeId": "d4020f5a-b80c-42c7-b715-a222245e952a",
  "localReaderName": "stubReader",
  "sessionId": "bd2225d8-7838-410f-afa6-ec66dd0e497c"
}
{{< /code >}}

---
### CMD

The purpose of this JSON object, received from the server, is to ask the terminal to perform a specific service with the 
card or the terminal's reader.

The service is defined in the `body` field as a string containing a JSON object.

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

{{< figure src="/media/learn/user-guide/distributed-json-api/distributedJsonApi_classDiagram_cmd.svg" caption="Keyple Distributed JSON API - CMD class diagram" numbered="true" >}}

---
### &nbsp;&nbsp;&nbsp;&nbsp;IS_CONTACTLESS {#iscontactlesscmd}

This service allows the server to know if the reader is in contact or contactless mode.

There are no parameters for this service.

Upon receiving this request, the terminal must return a `RESP` [IS_CONTACTLESS](#is_contactless_resp) JSON object 
containing a boolean set to true if the reader is a contactless type.

#### JSON structure

| NAME               |  TYPE  | DESCRIPTION                                                                 |
|--------------------|:------:|-----------------------------------------------------------------------------|
| `action`           | String | `"CMD"`                                                                     |
| `body`             | String | A JSON string containing a [IsContactlessCmdBody](#iscontactlessbody).      |
| `clientNodeId`     | String | The terminal identifier as provided by `EXECUTE_REMOTE_SERVICE`.            |
| `localReaderName`  | String | The identifier of the local reader as provided by `EXECUTE_REMOTE_SERVICE`. |
| `remoteReaderName` | String | The identifier of the virtual remote reader linked to the local reader.     |
| `serverNodeId`     | String | The server identifier.                                                      |
| `sessionId`        | String | The current transaction identifier as provided by `EXECUTE_REMOTE_SERVICE`. |

##### IsContactlessCmdBody

| NAME      |  TYPE  | DESCRIPTION        |
|-----------|:------:|--------------------|
| `service` | String | `"IS_CONTACTLESS"` |

##### Example

{{< code lang="json" >}}
{
"action": "CMD",
"body": "{\"SERVICE\":\"IS_CONTACTLESS\"}",
"clientNodeId": "d4020f5a-b80c-42c7-b715-a222245e952a",
"localReaderName": "stubReader",
"remoteReaderName": "2c4065b1-79d1-4545-9caf-b9a8aa1f46b5",
"serverNodeId": "9fe9eab8-7a31-4098-820f-c7d4d4a5c902",
"sessionId": "bd2225d8-7838-410f-afa6-ec66dd0e497c"
}
{{< /code >}}

---
### &nbsp;&nbsp;&nbsp;&nbsp;IS_CARD_PRESENT {#is_card_present_cmd}

This service allows the server to know if a card is inserted in the reader.

There are no parameters for this service.

Upon receiving this request, the terminal must return a `RESP` [IS_CARD_PRESENT](#is_card_present_resp) JSON object 
containing a boolean set to true if a card is present.

#### JSON structure

| NAME               |  TYPE  | DESCRIPTION                                                                 |
|--------------------|:------:|-----------------------------------------------------------------------------|
| `action`           | String | `"CMD"`                                                                     |
| `body`             | String | A JSON string containing a [IsCardPresentCmdBody](#iscardpresentcmdbody).   |
| `clientNodeId`     | String | The terminal identifier as provided by `EXECUTE_REMOTE_SERVICE`.            |
| `localReaderName`  | String | The identifier of the local reader as provided by `EXECUTE_REMOTE_SERVICE`. |
| `remoteReaderName` | String | The identifier of the virtual remote reader linked to the local reader.     |
| `serverNodeId`     | String | The server identifier.                                                      |
| `sessionId`        | String | The current transaction identifier as provided by `EXECUTE_REMOTE_SERVICE`. |

##### IsContactlessCmdBody

| NAME      |  TYPE  | DESCRIPTION         |
|-----------|:------:|---------------------|
| `service` | String | `"IS_CARD_PRESENT"` |

##### Example

{{< code lang="json" >}}
{
"action": "CMD",
"body": "{\"SERVICE\":\"IS_CARD_PRESENT\"}",
"clientNodeId": "d4020f5a-b80c-42c7-b715-a222245e952a",
"localReaderName": "stubReader",
"remoteReaderName": "2c4065b1-79d1-4545-9caf-b9a8aa1f46b5",
"serverNodeId": "9fe9eab8-7a31-4098-820f-c7d4d4a5c902",
"sessionId": "bd2225d8-7838-410f-afa6-ec66dd0e497c"
}
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

| NAME               |  TYPE  | DESCRIPTION                                                                                               |
|--------------------|:------:|-----------------------------------------------------------------------------------------------------------|
| `action`           | String | `"CMD"`                                                                                                   |
| `body`             | String | A JSON string containing a [TransmitCardSelectionRequestsCmdBody](#transmitcardselectionrequestsCmdBody). |
| `clientNodeId`     | String | The terminal identifier as provided by `EXECUTE_REMOTE_SERVICE`.                                          |
| `localReaderName`  | String | The identifier of the local reader as provided by `EXECUTE_REMOTE_SERVICE`.                               |
| `remoteReaderName` | String | The identifier of the virtual remote reader linked to the local reader.                                   |
| `serverNodeId`     | String | The server identifier.                                                                                    |
| `sessionId`        | String | The current transaction identifier as provided by `EXECUTE_REMOTE_SERVICE`.                               |

##### TransmitCardSelectionRequestsCmdBody

| NAME         |                                        TYPE                                         | DESCRIPTION                          |
|--------------|:-----------------------------------------------------------------------------------:|--------------------------------------|
| `service`    |                                       String                                        | `"TRANSMIT_CARD_SELECTION_REQUESTS"` |
| `parameters` | [TransmitCardSelectionRequestsParameters](#transmitcardselectionrequestsparameters) | The card selection parameters.       |

##### TransmitCardSelectionRequestsParameters

| NAME                       |                      TYPE                       | DESCRIPTION                                                                                                                                                                   |
|----------------------------|:-----------------------------------------------:|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `cardSelectionRequests`    | [CardSelectionRequest](#cardselectionrequest)[] | A not empty array                                                                                                                                                             |
| `multiSelectionProcessing` |                     String                      | - `FIRST_MATCH`: the selection process stops as soon as a selection case is successful.<br/>- `PROCESS_ALL`: the selection process performs all the selection cases provided. |
| `channelControl`           |                     String                      | - `KEEP_OPEN`: leaves the physical channel open.<br/>- `CLOSE_AFTER`: terminates communication with the card.                                                                 |

##### CardSelectionRequest

| NAME           |             TYPE              | DESCRIPTION                                                                                         |
|----------------|:-----------------------------:|-----------------------------------------------------------------------------------------------------|
| `cardSelector` | [CardSelector](#cardselector) | The card selection criteria.                                                                        |
| `cardRequest`  | [CardRequest](#cardrequest)?  | An optional object containing a list of APDU requests to be sent after a successful card selection. |

##### CardSelector

| NAME                             |   TYPE   | DESCRIPTION                                                                                                                                                                      |
|----------------------------------|:--------:|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `cardProtocol`                   | String?  | An optional name of the targeted card protocol.                                                                                                                                  |
| `powerOnDataRegex`               | String?  | An optional regex to use to filter the power-on data.                                                                                                                            |
| `aid`                            | String?  | An optional Application Identifier (AID) as an hexadecimal string to be sent with ISO7816-4 "Select Application".                                                                |
| `fileOccurrence`                 |  String  | `FIRST`, `LAST`, `NEXT` or `PREVIOUS` according to the ISO7816-4 standard (only relevant when AID is set).                                                                       |
| `fileControlInformation`         |  String  | `FCI`, `FCP`, `FMD` or `NO_RESPONSE` according to the ISO7816-4 standard (only relevant when AID is set).                                                                        |
| `successfulSelectionStatusWords` | String[] | A not empty array of 2-byte hexadecimal strings containing the status word of the "Select Application" APDU command to be considered successful (only relevant when AID is set). |

##### CardRequest

| NAME                               |             TYPE              | DESCRIPTION                                                                                                                                                               |
|------------------------------------|:-----------------------------:|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `apduRequests`                     | [ApduRequest](#apdurequest)[] | A not empty array of APDU requests.                                                                                                                                       |
| `isStatusCodesVerificationEnabled` |            Boolean            | `true` if the transmission of the APDUs should be interrupted as soon as the status word of a response does not belong to the associated list of successful status words. |

##### ApduRequest

| NAME                    |   TYPE   | DESCRIPTION                                                                                             |
|-------------------------|:--------:|---------------------------------------------------------------------------------------------------------|
| `apdu`                  |  String  | An hexadecimal string containing the APDU to transmit to the card.                                      |
| `successfulStatusWords` | String[] | A not empty array of 2-byte hexadecimal strings containing the status word to be considered successful. |
| `info`                  | String?  | An optional textual information about the command.                                                      |

##### Example

{{< code lang="json" >}}
{
  "action": "CMD",
  "body": "{\"SERVICE\":\"TRANSMIT_CARD_SELECTION_REQUESTS\",\"CARD_SELECTION_REQUESTS\":[{\"cardSelector\":{\"cardProtocol\":\"ISO_14443_4_CARD\",\"aid\":\"315449432E49434131\",\"fileOccurrence\":\"FIRST\",\"fileControlInformation\":\"FCI\",\"successfulSelectionStatusWords\":[\"9000\"]},\"cardRequest\":{\"apduRequests\":[{\"apdu\":\"00B2013C00\",\"successfulStatusWords\":[\"9000\"],\"info\":\"Read Records - SFI: 7h, REC: 1, READMODE: ONE_RECORD, EXPECTEDLENGTH: 0\"}],\"isStatusCodesVerificationEnabled\":false}}],\"MULTI_SELECTION_PROCESSING\":\"FIRST_MATCH\",\"CHANNEL_CONTROL\":\"KEEP_OPEN\"}",
  "clientNodeId": "d4020f5a-b80c-42c7-b715-a222245e952a",
  "localReaderName": "stubReader",
  "remoteReaderName": "2c4065b1-79d1-4545-9caf-b9a8aa1f46b5",
  "serverNodeId": "9fe9eab8-7a31-4098-820f-c7d4d4a5c902",
  "sessionId": "bd2225d8-7838-410f-afa6-ec66dd0e497c"
}
{{< /code >}}

### &nbsp;&nbsp;&nbsp;&nbsp;TRANSMIT_CARD_REQUEST {#transmit_card_request_cmd}

The role of this service is to perform APDU exchanges with the card. The received answers are sent back to the 
server in a `RESP` [TRANSMIT_CARD_REQUEST](#transmit_card_request_resp) JSON object.

The terminal must iterate over the list of APDUs present in the card request and proceeds to close the physical channel 
if requested.

#### JSON structure

| NAME               |  TYPE  | DESCRIPTION                                                                           |
|--------------------|:------:|---------------------------------------------------------------------------------------|
| `action`           | String | `"CMD"`                                                                               |
| `body`             | String | A JSON string containing a [TransmitCardRequestCmdBody](#transmitcardrequestcmdbody). |
| `clientNodeId`     | String | The terminal identifier as provided by `EXECUTE_REMOTE_SERVICE`.                      |
| `localReaderName`  | String | The identifier of the local reader as provided by `EXECUTE_REMOTE_SERVICE`.           |
| `remoteReaderName` | String | The identifier of the virtual remote reader linked to the local reader.               |
| `serverNodeId`     | String | The server identifier.                                                                |
| `sessionId`        | String | The current transaction identifier as provided by `EXECUTE_REMOTE_SERVICE`.           |


##### TransmitCardRequestCmdBody

| NAME         |                              TYPE                               | DESCRIPTION                  |
|--------------|:---------------------------------------------------------------:|------------------------------|
| `service`    |                             String                              | `"TRANSMIT_CARD_REQUEST"`    |
| `parameters` | [TransmitCardRequestParameters](#transmitcardrequestparameters) | The card request parameters. |


##### TransmitCardRequestParameters

| NAME             |             TYPE              | DESCRIPTION                                                                                                   |
|------------------|:-----------------------------:|---------------------------------------------------------------------------------------------------------------|
| `cardRequest`    | [CardRequest](#cardrequest-1) | An object containing the list of APDU requests to be sent.                                                    |
| `channelControl` |            String             | - `KEEP_OPEN`: leaves the physical channel open.<br/>- `CLOSE_AFTER`: terminates communication with the card. |

##### CardRequest

| NAME                               |              TYPE               | DESCRIPTION                                                                                                                                                               |
|------------------------------------|:-------------------------------:|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `apduRequests`                     | [ApduRequest](#apdurequest-1)[] | A not empty array of APDU requests.                                                                                                                                       |
| `isStatusCodesVerificationEnabled` |             Boolean             | `true` if the transmission of the APDUs should be interrupted as soon as the status word of a response does not belong to the associated list of successful status words. |

##### ApduRequest

| NAME                    |   TYPE   | DESCRIPTION                                                                                             |
|-------------------------|:--------:|---------------------------------------------------------------------------------------------------------|
| `apdu`                  |  String  | An hexadecimal string containing the APDU to transmit to the card.                                      |
| `successfulStatusWords` | String[] | A not empty array of 2-byte hexadecimal strings containing the status word to be considered successful. |
| `info`                  | String?  | An optional textual information about the command.                                                      |

---
### RESP

{{< figure src="/media/learn/user-guide/distributed-json-api/distributedJsonApi_classDiagram_resp.svg" caption="Keyple Distributed JSON API - RESP class diagram" numbered="true" >}}

---
### &nbsp;&nbsp;&nbsp;&nbsp;IS_CONTACTLESS {#is_contactless_resp}
---
### &nbsp;&nbsp;&nbsp;&nbsp;IS_CARD_PRESENT {#is_card_present_resp}
---
### &nbsp;&nbsp;&nbsp;&nbsp;TRANSMIT_CARD_SELECTION_REQUESTS {#transmit_card_selection_requests_resp}
Après le traitement de l'étape de sélection avec les paramètres fournis par le serveur, le terminal envoie une réponse
dont le contenu dépend à la fois des 

#### JSON structure

| NAME               |  TYPE  | DESCRIPTION                                                                                      |
|--------------------|:------:|--------------------------------------------------------------------------------------------------|
| `action`           | string | `RESP`                                                                                           |
| `body`             | string | [TransmitCardSelectionRequestsDataResp](#transmitcardselectionrequestsdataresp) as a JSON string |
| `clientNodeId`     | string | The terminal identifier                                                                          |
| `localReaderName`  | string | The name of the local reader                                                                     |
| `remoteReaderName` | string | The name of the remote reader                                                                    |
| `serverNodeId`     | string | The server identifier                                                                            |
| `sessionId`        | string | The current transaction identifier                                                               |

##### TransmitCardSelectionRequestsDataResp

| NAME      |  TYPE  | DESCRIPTION                                                 |
|-----------|:------:|-------------------------------------------------------------|
| `SERVICE` | string | `TRANSMIT_CARD_SELECTION_REQUESTS`                          |
| `RESULT`  | array  | An array of [CardSelectionResponse](#cardselectionresponse) |

##### CardSelectionResponse

| NAME                        |  TYPE  | DESCRIPTION |
|-----------------------------|:------:|-------------|
| `powerOnData`               | string |             |
| `selectApplicationResponse` | object |             |

##### Example

{{< code lang="json" >}}
{
  "action": "RESP",
  "body": "{\"SERVICE\":\"TRANSMIT_CARD_SELECTION_REQUESTS\",\"RESULT\":[{\"powerOnData\":\"3B8880010000000000718100F9\",\"selectApplicationResponse\":{\"apdu\":\"6F238409315449432E49434131A516BF0C13C708000000001122334453070A3C23121410019000\",\"statusWord\":\"9000\"},\"hasMatched\":true,\"cardResponse\":{\"apduResponses\":[{\"apdu\":\"24B92848080000131A50001200000000000000000000000000000000009000\",\"statusWord\":\"9000\"}],\"isLogicalChannelOpen\":true}}]}",
  "clientNodeId": "d4020f5a-b80c-42c7-b715-a222245e952a",
  "localReaderName": "stubReader",
  "remoteReaderName": "2c4065b1-79d1-4545-9caf-b9a8aa1f46b5",
  "serverNodeId": "9fe9eab8-7a31-4098-820f-c7d4d4a5c902",
  "sessionId": "bd2225d8-7838-410f-afa6-ec66dd0e497c"
}
{{< /code >}}

### &nbsp;&nbsp;&nbsp;&nbsp;TRANSMIT_CARD_REQUEST {#transmit_card_request_resp}

---
### END_REMOTE_SERVICE

{{< figure src="/media/learn/user-guide/distributed-json-api/distributedJsonApi_classDiagram_endRemoteService.svg" caption="Keyple Distributed JSON API - endremoteservice class diagram" numbered="true" >}}
