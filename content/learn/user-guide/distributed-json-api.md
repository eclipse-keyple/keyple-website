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
block exchanges.

This allows the development of a distributed solution in which the client reader terminal delegates the entire 
management of the card transaction to the server.

---
## Messaging flow

The diagram below shows the global flow of JSON objects exchanges between the terminal and the server:

{{< figure src="/media/learn/user-guide/distributed-json-api/distributedJsonApi_messagingFlow.svg" caption="Keyple Distributed JSON API - Messaging flow" numbered="true" >}}

On its own initiative (e.g. following the detection of a card), the terminal sends a JSON object of type 
`EXECUTE_REMOTE_SERVICE` to the server to ask it to start a card transaction.
At this step, the terminal has the ability to tell the server which business service to run and to provide additional 
custom data.

As long as the transaction is not completed, the terminal receives from the server JSON objects of type `CMD` containing 
the actions to be performed with the card or the terminal reader. 
The results are sent back to the server in JSON objects of type `RESP`.

When the transaction is finished, the terminal receives from the server a last JSON object of type `END_REMOTE_SERVICE` 
which may contain custom transaction output data.

---
## EXECUTE_REMOTE_SERVICE

{{< figure src="/media/learn/user-guide/distributed-json-api/distributedJsonApi_classDiagram_executeRemoteService.svg" caption="Keyple Distributed JSON API - EXECUTE_REMOTE_SERVICE class diagram" numbered="true" >}}

| NAME              |  TYPE  | DESCRIPTION                                                            |
|-------------------|:------:|------------------------------------------------------------------------|
| `action`          | string | `EXECUTE_REMOTE_SERVICE`                                               |
| `body`            | string | [ExecuteRemoteServiceData](#executeremoteservicedata) as a JSON string |
| `clientNodeId`    | string | The terminal identifier                                                |
| `localReaderName` | string | The name of the local reader                                           |
| `sessionId`       | string | The identifier to be used for the whole current transaction            |

##### ExecuteRemoteServiceData

| NAME         |  TYPE  | DESCRIPTION                                                                                     |
|--------------|:------:|-------------------------------------------------------------------------------------------------|
| `SERVICE_ID` | string | The identifier of the remote business service to be executed                                    |
| `INPUT_DATA` | object | (optional) - An object containing additional data to be provided to the remote business service |

##### Example

{{< code lang="json" >}}
{
  "action": "EXECUTE_REMOTE_SERVICE",
  "body": "{\"SERVICE_ID\":\"EXECUTE_CALYPSO_SESSION_FROM_REMOTE_SELECTION\",\"INPUT_DATA\":{\"userId\":\"test\"}}",
  "clientNodeId": "d4020f5a-b80c-42c7-b715-a222245e952a",
  "localReaderName": "stubReader",
  "sessionId": "bd2225d8-7838-410f-afa6-ec66dd0e497c"
}
{{< /code >}}

---
## CMD/RESP

{{< figure src="/media/learn/user-guide/distributed-json-api/distributedJsonApi_classDiagram_cmd.svg" caption="Keyple Distributed JSON API - CMD class diagram" numbered="true" >}}

{{< figure src="/media/learn/user-guide/distributed-json-api/distributedJsonApi_classDiagram_resp.svg" caption="Keyple Distributed JSON API - RESP class diagram" numbered="true" >}}

### TRANSMIT_CARD_SELECTION_REQUESTS

#### CMD

| NAME               |  TYPE  | DESCRIPTION                                                                                    |
|--------------------|:------:|------------------------------------------------------------------------------------------------|
| `action`           | string | `CMD`                                                                                          |
| `body`             | string | [TransmitCardSelectionRequestsDataCmd](#transmitcardselectionrequestsdatacmd) as a JSON string |
| `clientNodeId`     | string | The terminal identifier                                                                        |
| `localReaderName`  | string | The name of the local reader                                                                   |
| `remoteReaderName` | string | The name of the remote reader                                                                  |
| `serverNodeId`     | string | The server identifier                                                                          |
| `sessionId`        | string | The current transaction identifier                                                             |

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

#### RESP

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

### TRANSMIT_CARD_REQUEST
### IS_CONTACTLESS
### IS_CARD_PRESENT

---
## END_REMOTE_SERVICE

{{< figure src="/media/learn/user-guide/distributed-json-api/distributedJsonApi_classDiagram_endRemoteService.svg" caption="Keyple Distributed JSON API - END_REMOTE_SERVICE class diagram" numbered="true" >}}

---
## JSON inner objects

### ExecuteRemoteServiceBody
### ApduRequest
### CardRequest
### CardSelector