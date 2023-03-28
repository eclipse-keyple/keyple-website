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

Each service is defined as a JSON object (in string format) contained in the `body` field of the `CMD` JSON object.

For each service, this object contains a `service` field which identifies the requested service and also allows to 
properly interpret the other fields of the object.

The service field can take one of the following 4 values:
- [`IS_CONTACTLESS`](#nbspnbspnbspnbspis_contactless)
- [`IS_CARD_PRESENT`](#nbspnbspnbspnbspis_card_present)
- [`TRANSMIT_CARD_SELECTION_REQUESTS`](#nbspnbspnbspnbsptransmit_card_selection_requests)
- [`TRANSMIT_CARD_REQUEST`](#nbspnbspnbspnbsptransmit_card_request)

After receiving a `CMD` JSON object, the terminal will send a `RESP` JSON object containing the result of the operation.

The following UML class diagram illustrates the structure of this object and may help to implement it in the development language of the target terminal.

{{< figure src="/media/learn/user-guide/distributed-json-api/distributedJsonApi_classDiagram_cmd.svg" caption="Keyple Distributed JSON API - CMD class diagram" numbered="true" >}}

---
### &nbsp;&nbsp;&nbsp;&nbsp;IS_CONTACTLESS
---
### &nbsp;&nbsp;&nbsp;&nbsp;IS_CARD_PRESENT
---
### &nbsp;&nbsp;&nbsp;&nbsp;TRANSMIT_CARD_SELECTION_REQUESTS

The primary objective of this service is to establish a logical communication channel with a card.

The parameters coming from the server and the response to be provided by the terminal will be defined below.

To enable processing of different card profiles, it offers the creation of selection scenarios with integrated 
selection cases. The scenario is provided by the server after a card is detected, and it involves checking whether the card 
is compatible with at least one of the selection cases. The selection cases are played successively, in the order in 
which they are defined.

There are several options for executing the scenario:
- the process stops at the first selection case where the card is a match, or all scenarios are played systematically.
- the physical channel can be kept open or closed at the end of each selection case.

A card selection case incorporates various independent filters that can be applied individually or in combination 
to determine if a detected card is suitable for performing a transaction. While some cards can be selected based on 
communication protocol or response data from the power on operation, most of the cards require a selection through 
Application Identifier (AID) using the ISO7816-4 SELECT APPLICATION command. 

The structure outlined below allows for defining selection scenarios that combine these three types of filters:
- based on the communication protocol
- based on the response data from the power on stage
- based on the Application Identifier (AID)

When filtering by AID, the SELECT APPLICATION command is sent to the card in accordance with the ISO7816-4 standard.
Additional parameters, also defined by the standard, can be set to specify the type of operation (FileOccurrence) 
and the type of output (FileControlInformation).

Each filter is optional, and if none are defined, the selection is deemed successful as soon as the card is detected.
However, when a filter is specified, it becomes a prerequisite for the card selection.

Along with card selection, a selection scenario can comprise a list of APDUs (Application Protocol Data Units) that are 
to be transmitted to the card as soon as it becomes "selected". 
Such a list enables the definition of commands that can be executed during the selection stage, specifically to obtain 
contextual information from the card.

#### JSON structure

| NAME               |  TYPE  | DESCRIPTION                                                                                    |
|--------------------|:------:|------------------------------------------------------------------------------------------------|
| `action`           | string | `CMD`                                                                                          |
| `body`             | string | [TransmitCardSelectionRequestsDataCmd](#transmitcardselectionrequestsdatacmd) as a JSON string |
| `clientNodeId`     | string | The terminal identifier                                                                        |
| `localReaderName`  | string | The identifier of the local reader as provided by EXECUTE_REMOTE_SERVICE                       |
| `remoteReaderName` | string | The identifier of the virtual remote reader linked to the local reader                         |
| `serverNodeId`     | string | The server identifier                                                                          |
| `sessionId`        | string | The current transaction identifier as provided by EXECUTE_REMOTE_SERVICE                       |

##### TransmitCardSelectionRequestsDataCmd

| NAME                         |  TYPE  | DESCRIPTION                                                                                                                                                                 |
|------------------------------|:------:|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `SERVICE`                    | string | `TRANSMIT_CARD_SELECTION_REQUESTS`                                                                                                                                          |
| `CARD_SELECTION_REQUESTS`    | array  | A not empty array of [CardSelectionRequest](#cardselectionrequest)                                                                                                          |
| `MULTI_SELECTION_PROCESSING` | string | - `FIRST_MATCH`: the selection process stops as soon as a selection case is successful<br/>- `PROCESS_ALL`: the selection process performs all the selection cases provided |
| `CHANNEL_CONTROL`            | string | - `KEEP_OPEN`: leaves the physical channel open<br/>- `CLOSE_AFTER`: terminates communication with the card                                                                 |

##### CardSelectionRequest

| NAME           |  TYPE  | DESCRIPTION                                |
|----------------|:------:|--------------------------------------------|
| `cardSelector` | object | A [CardSelector](#cardselector)            |
| `cardRequest`  | object | (optional) - A [CardRequest](#cardrequest) |

##### CardSelector

| NAME                             |  TYPE  | DESCRIPTION                                                                                    |
|----------------------------------|:------:|------------------------------------------------------------------------------------------------|
| `cardProtocol`                   | string | (optional) - The name of the targeted card protocol                                            |
| `powerOnDataRegex`               | string | (optional) - The regex to use to filter the power-on data                                      |
| `aid`                            | string | (optional) - The AID as an hex-string                                                          |
| `fileOccurrence`                 | string | `FIRST` or `LAST` or `NEXT` or `PREVIOUS` according to the ISO-7816-4 standard                 |
| `fileControlInformation`         | string | `FCI` or `FCP` or `FMD` or `NO_RESPONSE` according to the ISO-7816-4 standard                  |
| `successfulSelectionStatusWords` | array  | A not empty array of 4-byte hex-strings containing the status word to be considered successful |

##### CardRequest

| NAME                               |  TYPE   | DESCRIPTION                                                                                                         |
|------------------------------------|:-------:|---------------------------------------------------------------------------------------------------------------------|
| `apduRequests`                     |  array  | A not empty array of [ApduRequest](#apdurequest)                                                                    |
| `isStatusCodesVerificationEnabled` | boolean | When true, the transmission of the APDUs must be interrupted as soon as the status code of a response is unexpected |

##### ApduRequest

| NAME                    |  TYPE  | DESCRIPTION                                                                                    |
|-------------------------|:------:|------------------------------------------------------------------------------------------------|
| `apdu`                  | string | An hex-string containing the APDU to transmit to the card                                      |
| `successfulStatusWords` | array  | A not empty array of 4-byte hex-strings containing the status word to be considered successful |
| `info`                  | string | (optional) - Textual information about the command                                             |
|
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

### &nbsp;&nbsp;&nbsp;&nbsp;TRANSMIT_CARD_REQUEST

### RESP

{{< figure src="/media/learn/user-guide/distributed-json-api/distributedJsonApi_classDiagram_resp.svg" caption="Keyple Distributed JSON API - RESP class diagram" numbered="true" >}}

### &nbsp;&nbsp;&nbsp;&nbsp;TRANSMIT_CARD_SELECTION_REQUESTS
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

| NAME                         |  TYPE  | DESCRIPTION                                                                                                                                                                 |
|------------------------------|:------:|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `SERVICE`                    | string | `TRANSMIT_CARD_SELECTION_REQUESTS`                                                                                                                                          |
| `RESULT`    | array  | An array of [CardSelectionResponse](#cardselectionresponse)                                                                                                                 |

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

### &nbsp;&nbsp;&nbsp;&nbsp;TRANSMIT_CARD_REQUEST
### &nbsp;&nbsp;&nbsp;&nbsp;IS_CONTACTLESS
### &nbsp;&nbsp;&nbsp;&nbsp;IS_CARD_PRESENT

---
### END_REMOTE_SERVICE

{{< figure src="/media/learn/user-guide/distributed-json-api/distributedJsonApi_classDiagram_endRemoteService.svg" caption="Keyple Distributed JSON API - END_REMOTE_SERVICE class diagram" numbered="true" >}}
