---
title: API Reference

language_tabs:
  - json

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>

includes:
  - errors

search: true

code_clipboard: true

meta:
  - name: description
    content: Documentation for the Kittn API
---

# Introduction

The Forrest EDI solution is a comprehensive platform for managing all EDI transaction sets across all industries. It supports interchange segments that are delimited by asterisks (*) and conclude with a tilde (~). 

Here you can access a growing collection of API and SFTP integration options. Our platform enables validation and transformation of EDI data. 

Integration teams can define their own set requirements for each trading partner of each transaction set to minimize errors, enhance decision-making, and streamline processes across all stakeholders in a transaction.

The Forrest EDI solution optimizes operations and collaboration with trading partners, ultimately leading to enhanced productivity and growth.

# Features

- **Comprehensive EDI Support**: Accepts all EDI transaction sets across all industries.
- **Data Conversion**: Converts EDI to JSON or XML and JSON or XML to EDI.
- **Real-Time Notifications**: Utilizes webhooks for instant notifications to stakeholders while transactions process.

# Authorization

API requests require a token in the header that looks like the following:

`Authorization: Bearer <Your Access Token>`

Access tokens can be refreshed and accessed in our customer web portal. 

# Setup Postman
Download our Postman collection to get started [here](https://www.postman.com/downloads/).

### Steps for Setup
Please follow the steps below to setup our API's in Postman.

### Step 1: Get Postman
[Download](https://www.postman.com/downloads/) and install Postman.

### Step 2: Download The Postman Collection
[Download](https://www.postman.com/downloads/) the EDI API collection. Postman collections give you sets of pre-built requests to test with. 

### Step 3: Configure Authentication

`Authorization Type: Bearer Token`

`Token: bhl5rbY8O4fHx748p1DIIgQlykduOWiQVHB1D`

Collect your token from our customer EDI portal.

# EDI

## Create EDI
> Request:

```json
[
    {
        "type": "ISA",
        "body": [
            "00",
            "ABCD1234",
            "00",
            "XYZ",
            "02",
            "RANDOM1",
            "ZZ",
            "PLACEHOLDER1",
            "123456",
            "9876",
            "X",
            "99999",
            "123456789",
            "0",
            "P",
            ":"
        ]
    },
    {
        "type": "GS",
        "body": [
            "GF",
            "RANDOM2",
            "PLACEHOLDER2",
            "20250101",
            "9876",
            "1",
            "Y",
            "654321"
        ]
    },
    {
        "type": "ST",
        "body": [
            "990",
            "0002"
        ]
    },
    {
        "type": "B1",
        "body": [
            "RANDOM3",
            "CMDUCBCXYZ1234",
            "20250101",
            "B"
        ]
    },
    {
        "type": "N9",
        "body": [
            "WO",
            "RANDOM-XYZ9876-1--TEST"
        ]
    },
    {
        "type": "SE",
        "body": [
            "5",
            "0002"
        ]
    },
    {
        "type": "GE",
        "body": [
            "2",
            "2"
        ]
    },
    {
        "type": "IEA",
        "body": [
            "1",
            "987654321"
        ]
    }
]
```

> OK Response:

```json
{
  "id": "6B29FC40-CA47-1067-B31D-00DD010662DA",
  "status": "success",
  "reason": "queued"
}
```

> Bad Response

```json
{
  "id": "",
  "status": "error",
  "reason": "timed out"
}
```

Submit a new EDI transaction. 
### HTTP Request
`POST http://example.com/v1/EDI`

### Request Body
Parameter|Type |Description
---------|-----|-----------
type| string | segment type
body | array | segment elements

In Electronic Data Interchange (EDI), a **segment type** refers to a specific category of data within an EDI message. Each segment type consists of a defined structure and purpose, allowing for the organization and interpretation of information.

Segments are typically composed of:

- **Segment Type**: A unique code that specifies the segment type (e.g., ISA, GS, ST, B1).
- **Segment Elements**: Individual pieces of information contained within the segment, often separated by delimiters. These elements provide specific details relevant to the segment type.

For example:
- The ISA segment type contains information about the interchange sender and receiver.
- The B1 segment type may include details about a specific transaction or order.

<aside class="notice">
Segment types and segment elements are ordinal.
</aside>

### Response Body
Parameter|Type |Description
---------|-----|-----------
id| string | unique identifier associated with the EDI transaction.
status | string | state or condition of the request.
reason | string | description of the state or condition of the request.

## Get EDI
> OK Response:

```json
{
  "edi": [
    {
        "type": "ISA",
        "body": [
            "00",
            "ABCD1234",
            "00",
            "XYZ",
            "02",
            "RANDOM1",
            "ZZ",
            "PLACEHOLDER1",
            "123456",
            "9876",
            "X",
            "99999",
            "123456789",
            "0",
            "P",
            ":"
        ]
    },
    {
        "type": "GS",
        "body": [
            "GF",
            "RANDOM2",
            "PLACEHOLDER2",
            "20250101",
            "9876",
            "1",
            "Y",
            "654321"
        ]
    },
    {
        "type": "ST",
        "body": [
            "990",
            "0002"
        ]
    },
    {
        "type": "B1",
        "body": [
            "RANDOM3",
            "CMDUCBCXYZ1234",
            "20250101",
            "B"
        ]
    },
    {
        "type": "N9",
        "body": [
            "WO",
            "RANDOM-XYZ9876-1--TEST"
        ]
    },
    {
        "type": "SE",
        "body": [
            "5",
            "0002"
        ]
    },
    {
        "type": "GE",
        "body": [
            "2",
            "2"
        ]
    },
    {
        "type": "IEA",
        "body": [
            "1",
            "987654321"
        ]
    }
  ],
  "status": "success",
  "reason": "match found"
}
```

> Bad Response:

```json
{
  "edi": [],
  "status": "error",
  "reason": "match not found"
}
```

Retrieve a specific EDI transaction by its ID.
### HTTP Request
`GET http://example.com/api/v1/EDI`


### Query Parameters

Parameter|Type |Description
---------|-----|-----------
id| string | unique identifier associated with the EDI transaction.
type | string | the data type to return.

<aside class="notice">
EDI transaction ID's are generated on creation of an EDI transaction.
</aside>

<aside class="notice">
Supported types are EDI, JSON, and XML.
</aside>

### Response Body
Parameter|Type |Description
---------|-----|-----------
edi | array | an EDI transaction.
status | string | state or condition of the request.
reason | string | description of the state or condition of the request.

## Get EDIs
> OK Response:

```json
{
  "edis": [
      "550e8400-e29b-41d4-a716-446655440000",
      "f47ac10b-58cc-4372-a567-0e02b2c3d479",
      "b2a4e3d2-e5b0-4bcf-8f34-2c17d4746b29",
      "4b1aef76-d6f8-4b16-92f8-f3a7c5d4d2c3",
      "d19d1cb4-1df0-4bb1-8f26-8972f06c4d3c",
      "cfa3e8bb-8b74-49cf-9e6f-f01a05b09f9e",
      "8d19e6e7-154c-41c1-bc05-45e0c7f3e8d0",
      "e2b1c062-27e3-4f7c-b5b1-e30a6f6f4e60",
      "1f8a59dc-fc65-43ff-a203-b0f8e73a63a4",
      "72b7e1a3-2345-40d8-b82b-9e3a4b45265a"
  ],
  "status": "success",
  "reason": "match found"
}
```

> Bad Response:

```json
{
  "edis": [],
  "status": "error",
  "reason": "match not found"
}
```
Fetch a list of all EDI transaction IDs.
### HTTP Request
`GET http://example.com/api/v1/EDI`

### Query Parameters

Parameter|Type |Description
---------|-----|-----------
page | integer | the current page number in a paginated data set
size | integer | the number of items to be included on each page

### Response Body
Parameter|Type |Description
---------|-----|-----------
edis | array | EDI transaction IDs.
status | string | state or condition of the request.
reason | string | description of the state or condition of the request.

<aside class="notice">
Size limitations prevent a full EDI for each transaction to appear. The ID associated with the EDI transaction appears instead and the <code>GET EDI</code> endpoint can be used to view the details of each transaction.
</aside>

## Update EDI
> Request:

```json
{
  "id": "72b7e1a3-2345-40d8-b82b-9e3a4b45265a",
  "edi": [
    {
        "type": "ISA",
        "body": [
            "00",
            "ABCD1234",
            "00",
            "XYZ",
            "02",
            "RANDOM1",
            "ZZ",
            "PLACEHOLDER1",
            "123456",
            "9876",
            "X",
            "99999",
            "123456789",
            "0",
            "P",
            ":"
        ]
    },
    {
        "type": "GS",
        "body": [
            "GF",
            "RANDOM2",
            "PLACEHOLDER2",
            "20250101",
            "9876",
            "1",
            "Y",
            "654321"
        ]
    },
    {
        "type": "ST",
        "body": [
            "990",
            "0002"
        ]
    },
    {
        "type": "B1",
        "body": [
            "RANDOM3",
            "CMDUCBCXYZ1234",
            "20250101",
            "B"
        ]
    },
    {
        "type": "N9",
        "body": [
            "WO",
            "RANDOM-XYZ9876-1--TEST"
        ]
    },
    {
        "type": "SE",
        "body": [
            "5",
            "0002"
        ]
    },
    {
        "type": "GE",
        "body": [
            "2",
            "2"
        ]
    },
    {
        "type": "IEA",
        "body": [
            "1",
            "987654321"
        ]
    }
  ]
}
```

> OK Response:

```json
{
  "status": "success",
  "reason": "match found"
}
```

> Bad Response:

```json
{
  "status": "error",
  "reason": "match not found"
}
```

Modify an existing EDI transaction set.
### HTTP Request
`PUT http://example.com/v1/EDI`

### Request Body

Parameter|Type |Description
---------|-----|-----------
id| string | unique identifier associated with the EDI transaction.
edi | array | an EDI transaction.

### Response Body
Parameter|Type |Description
---------|-----|-----------
status | string | state or condition of the request.
reason | string | description of the state or condition of the request.

## Delete EDI
> OK Response:

```json
{
  "status": "success",
  "reason": "match found"
}
```

> Bad Response:

```json
{
  "status": "error",
  "reason": "match not found"
}
```

Remove a specific EDI transaction from the system.
### HTTP Request
`DELETE http://example.com/v1/EDI`

### Query Parameters

Parameter|Type |Description
---------|-----|-----------
id| string | unique identifier associated with the EDI transaction.

### Response Body
Parameter|Type |Description
---------|-----|-----------
status | string | state or condition of the request.
reason | string | description of the state or condition of the request.

<aside class="warning">
Deleting the EDI transaction will remove it from the system, but it will not prevent any existing processes from completing their current operations on that transaction.
</aside>

# Interchange Rules

## Create Interchange Rule

> Request Body:

```json
{
    "set": 850,
    "segments": [
        {
            "segment": "ST",
            "segment rule": "a3d8d2b4-1a5c-4d2e-8e76-f6c9bc2041ae",
            "optional": false
        },
        {
            "segment": "BEG",
            "segment rule": "f9e65d0c-f5b5-44a0-8971-1c5a55cdd5c9",
            "optional": false
        },
        {
            "segment": "CUR",
            "segment rule": "0ab7c1f0-6db5-4e5c-b1c0-d1357d3b4e37",
            "optional": true
        },
        {
            "segment": "REF",
            "segment rule": "b1c7d776-1e0c-4f76-853e-63bc25618d54",
            "optional": true
        },
        {
            "segment": "PER",
            "segment rule": "0e6c1459-dcb6-4180-8c8c-b58e25be21b9",
            "optional": true
        },
        {
            "segment": "TAX",
            "segment rule": "d1c9d7ab-3b8f-4b57-8124-4749f85873c8",
            "optional": true
        },
        {
            "segment": "FOB",
            "segment rule": "7caa2ec8-9c2a-45c6-9b4a-e0a9f2500f57",
            "optional": true
        },
        {
            "segment": "CTP",
            "segment rule": "5f7635a4-e1d2-4f00-8c28-7b8f3c5c79f6",
            "optional": true
        },
                {
            "segment": "PAM",
            "segment rule": "b60f7f59-63e1-45e6-92e3-4d1b46c8c0da",
            "optional": true
        },
        {
            "segment": "CSH",
            "segment rule": "f7c6c7a0-0f9e-41c3-8596-b78b054f2f8c",
            "optional": true
        },
        {
            "segment": "TC2",
            "segment rule": "71b3cc8b-b48a-4650-8059-3b6456c0ef7a",
            "optional": true
        },
        {
            "loop": "SAC",
            "loop rule": "c567cb8e-e2c5-42ed-9a24-f2e3c2c0a8ed",
            "optional": true
        },
        {
            "segment": "ITD",
            "segment rule": "e9f4b1e6-d44f-4c4d-b76e-91d0db9e2d6f",
            "optional": true
        },
        {
            "segment": "DIS",
            "segment rule": "1f81e2b3-9264-4e58-b5aa-3d65b76334c4",
            "optional": true
        },
        {
            "segment": "INC",
            "segment rule": "f31f4e36-47b3-42ed-8514-982cde58b7c5",
            "optional": true
        },
        {
            "segment": "DTM",
            "segment rule": "2549f3e8-2f2b-41d1-a2c5-b60cdb65e7c8",
            "optional": true
        },
        {
            "segment": "LIN",
            "segment rule": "2e9731a5-33e8-44b7-975b-21ff634594e7",
            "optional": true
        },
        {
            "segment": "SI",
            "segment rule": "7cf2cbd8-2aa6-403b-a7f4-6f097d49e320",
            "optional": true
        },
        {
            "segment": "PID",
            "segment rule": "7d3f1210-5aef-453f-abc1-e8d74a536a9c",
            "optional": true
        },
        {
            "segment": "MEA",
            "segment rule": "4b99c5e5-b379-45aa-80ed-703a58a895e8",
            "optional": true
        },
        {
            "segment": "PWK",
            "segment rule": "8bb03304-3c66-467f-80b7-fc3e8cda00f8",
            "optional": true
        },
        {
            "segment": "PKG",
            "segment rule": "a3d8d2b4-1a5c-4d2e-8e76-f6c9bc2041ae",
            "optional": true
        },
        {
            "segment": "TD1",
            "segment rule": "f9e65d0c-f5b5-44a0-8971-1c5a55cdd5c9",
            "optional": true
        },
        {
            "segment": "TD5",
            "segment rule": "0ab7c1f0-6db5-4e5c-b1c0-d1357d3b4e37",
            "optional": true
        },
        {
            "segment": "TD3",
            "segment rule": "b1c7d776-1e0c-4f76-853e-63bc25618d54",
            "optional": true
        },
        {
            "segment": "TD4",
            "segment rule": "0e6c1459-dcb6-4180-8c8c-b58e25be21b9",
            "optional": true
        },
        {
            "segment": "MAN",
            "segment rule": "d1c9d7ab-3b8f-4b57-8124-4749f85873c8",
            "optional": true
        },
        {
            "segment": "PCT",
            "segment rule": "7caa2ec8-9c2a-45c6-9b4a-e0a9f2500f57",
            "optional": true
        },
        {
            "segment": "CTB",
            "segment rule": "5f7635a4-e1d2-4f00-8c28-7b8f3c5c79f6",
            "optional": true
        },
        {
            "segment": "TXI",
            "segment rule": "b60f7f59-63e1-45e6-92e3-4d1b46c8c0da",
            "optional": true
        },
        {
            "loop": "LDT",
            "loop rule": "f7c6c7a0-0f9e-41c3-8596-b78b054f2f8c",
            "optional": true
        },
        {
            "loop": "AMT",
            "loop rule": "71b3cc8b-b48a-4650-8059-3b6456c0ef7a",
            "optional": true
        },
        {
            "loop": "FA1",
            "loop rule": "c567cb8e-e2c5-42ed-9a24-f2e3c2c0a8ed",
            "optional": true
        },
        {
            "loop": "N9",
            "loop rule": "e9f4b1e6-d44f-4c4d-b76e-91d0db9e2d6f",
            "optional": true
        },
        {
            "loop": "N1",
            "loop rule": "1f81e2b3-9264-4e58-b5aa-3d65b76334c4",
            "optional": true
        },
        {
            "loop": "LM",
            "loop rule": "f31f4e36-47b3-42ed-8514-982cde58b7c5",
            "optional": true
        },
        {
            "loop": "SPI",
            "loop rule": "2549f3e8-2f2b-41d1-a2c5-b60cdb65e7c8",
            "optional": true
        },
        {
            "loop": "N1",
            "loop rule": "2e9731a5-33e8-44b7-975b-21ff634594e7",
            "optional": true
        },
        {
            "loop": "CB1",
            "loop rule": "7cf2cbd8-2aa6-403b-a7f4-6f097d49e320",
            "optional": true
        },
        {
            "loop": "ADV",
            "loop rule": "7d3f1210-5aef-453f-abc1-e8d74a536a9c",
            "optional": true
        },
        {
            "loop": "PO1",
            "loop rule": "4b99c5e5-b379-45aa-80ed-703a58a895e8",
            "optional": true
        },
        {
            "loop": "CTP",
            "loop rule": "8bb03304-3c66-467f-80b7-fc3e8cda00f8",
            "optional": true
        },
        {
            "loop": "PID",
            "loop rule": "a3d8d2b4-1a5c-4d2e-8e76-f6c9bc2041ae",
            "optional": true
        },
        {
            "loop": "SAC",
            "loop rule": "f9e65d0c-f5b5-44a0-8971-1c5a55cdd5c9",
            "optional": true
        },
        {
            "loop": "QTY",
            "loop rule": "0ab7c1f0-6db5-4e5c-b1c0-d1357d3b4e37",
            "optional": true
        },
        {
            "loop": "SCH",
            "loop rule": "b1c7d776-1e0c-4f76-853e-63bc25618d54",
            "optional": true
        },
        {
            "loop": "PKG",
            "loop rule": "0e6c1459-dcb6-4180-8c8c-b58e25be21b9",
            "optional": true
        },
        {
            "loop": "LDT",
            "loop rule": "d1c9d7ab-3b8f-4b57-8124-4749f85873c8",
            "optional": true
        },
        {
            "loop": "LM",
            "loop rule": "7caa2ec8-9c2a-45c6-9b4a-e0a9f2500f57",
            "optional": true
        },
        {
            "loop": "N9",
            "loop rule": "5f7635a4-e1d2-4f00-8c28-7b8f3c5c79f6",
            "optional": true
        },
        {
            "loop": "N1",
            "loop rule": "b60f7f59-63e1-45e6-92e3-4d1b46c8c0da",
            "optional": true
        },
        {
            "loop": "LDT",
            "loop rule": "f7c6c7a0-0f9e-41c3-8596-b78b054f2f8c",
            "optional": true
        },
        {
            "loop": "SLN",
            "loop rule": "71b3cc8b-b48a-4650-8059-3b6456c0ef7a",
            "optional": true
        },
        {
            "loop": "N9",
            "loop rule": "c567cb8e-e2c5-42ed-9a24-f2e3c2c0a8ed",
            "optional": true
        },
        {
            "loop": "SAC",
            "loop rule": "e9f4b1e6-d44f-4c4d-b76e-91d0db9e2d6f",
            "optional": true
        },
        {
            "loop": "QTY",
            "loop rule": "1f81e2b3-9264-4e58-b5aa-3d65b76334c4",
            "optional": true
        },
        {
            "loop": "N1",
            "loop rule": "f31f4e36-47b3-42ed-8514-982cde58b7c5",
            "optional": true
        },
        {
            "loop": "AMT",
            "loop rule": "2549f3e8-2f2b-41d1-a2c5-b60cdb65e7c8",
            "optional": true
        },
        {
            "loop": "LM",
            "loop rule": "2e9731a5-33e8-44b7-975b-21ff634594e7",
            "optional": true
        },
        {
            "loop": "CTT",
            "loop rule": "7cf2cbd8-2aa6-403b-a7f4-6f097d49e320",
            "optional": true
        },
        {
            "segment": "SE",
            "segment rule": "7d3f1210-5aef-453f-abc1-e8d74a536a9c",
            "optional": false
        }
    ]
}
```

> OK Response:

```json
{
  "id": "6B29FC40-CA47-1067-B31D-00DD010662DA",
  "status": "success",
  "reason": "queued"
}
```

> Bad Response

```json
{
  "id": "",
  "status": "error",
  "reason": "timed out"
}
```

Submit a new Interchange requirement.
### HTTP Request
`POST http://example.com/v1/Interchange`

### Request Body
Parameter|Type |Description
---------|-----|-----------
set | integer | transaction set number.
segments | array | segments or loops associated with the interchange.

In Electronic Data Interchange (EDI), a **set** represents a particular type of transaction or interchange, such as an order, invoice, or shipment notice. For example, the ANSI X12 standard includes transaction sets like 850 (Purchase Order) and 810 (Invoice).

transaction sets are composed of:

- **Segments**: consists of a unique identifier (segment type) and a series of data elements that provide specific information related to that segment.
- **Loops**:  groups of segments that are repeated based on specific conditions within an EDI.

<aside class="notice">
Segments and loops are ordinal.
</aside>

### Response Body
Parameter|Type |Description
---------|-----|-----------
id| string | unique identifier associated with the EDI transaction.
status | string | state or condition of the request.
reason | string | description of the state or condition of the request.


## Get Interchange Rule
> OK Response:

```json
{
  "set": "850",
  "segments": [
    {
        "segment": "ST",
        "segment rule": "a3d8d2b4-1a5c-4d2e-8e76-f6c9bc2041ae",
        "optional": false
    },
    {
        "segment": "BEG",
        "segment rule": "f9e65d0c-f5b5-44a0-8971-1c5a55cdd5c9",
        "optional": false
    },
    {
        "segment": "CUR",
        "segment rule": "0ab7c1f0-6db5-4e5c-b1c0-d1357d3b4e37",
        "optional": true
    },
    {
        "segment": "REF",
        "segment rule": "b1c7d776-1e0c-4f76-853e-63bc25618d54",
        "optional": true
    },
    {
        "segment": "PER",
        "segment rule": "0e6c1459-dcb6-4180-8c8c-b58e25be21b9",
        "optional": true
    },
    {
        "segment": "TAX",
        "segment rule": "d1c9d7ab-3b8f-4b57-8124-4749f85873c8",
        "optional": true
    },
    {
        "segment": "FOB",
        "segment rule": "7caa2ec8-9c2a-45c6-9b4a-e0a9f2500f57",
        "optional": true
    },
    {
        "segment": "CTP",
        "segment rule": "5f7635a4-e1d2-4f00-8c28-7b8f3c5c79f6",
        "optional": true
    },
            {
        "segment": "PAM",
        "segment rule": "b60f7f59-63e1-45e6-92e3-4d1b46c8c0da",
        "optional": true
    },
    {
        "segment": "CSH",
        "segment rule": "f7c6c7a0-0f9e-41c3-8596-b78b054f2f8c",
        "optional": true
    },
    {
        "segment": "TC2",
        "segment rule": "71b3cc8b-b48a-4650-8059-3b6456c0ef7a",
        "optional": true
    },
    {
        "loop": "SAC",
        "loop rule": "c567cb8e-e2c5-42ed-9a24-f2e3c2c0a8ed",
        "optional": true
    },
    {
        "segment": "ITD",
        "segment rule": "e9f4b1e6-d44f-4c4d-b76e-91d0db9e2d6f",
        "optional": true
    },
    {
        "segment": "DIS",
        "segment rule": "1f81e2b3-9264-4e58-b5aa-3d65b76334c4",
        "optional": true
    },
    {
        "segment": "INC",
        "segment rule": "f31f4e36-47b3-42ed-8514-982cde58b7c5",
        "optional": true
    },
    {
        "segment": "DTM",
        "segment rule": "2549f3e8-2f2b-41d1-a2c5-b60cdb65e7c8",
        "optional": true
    },
    {
        "segment": "LIN",
        "segment rule": "2e9731a5-33e8-44b7-975b-21ff634594e7",
        "optional": true
    },
    {
        "segment": "SI",
        "segment rule": "7cf2cbd8-2aa6-403b-a7f4-6f097d49e320",
        "optional": true
    },
    {
        "segment": "PID",
        "segment rule": "7d3f1210-5aef-453f-abc1-e8d74a536a9c",
        "optional": true
    },
    {
        "segment": "MEA",
        "segment rule": "4b99c5e5-b379-45aa-80ed-703a58a895e8",
        "optional": true
    },
    {
        "segment": "PWK",
        "segment rule": "8bb03304-3c66-467f-80b7-fc3e8cda00f8",
        "optional": true
    },
    {
        "segment": "PKG",
        "segment rule": "a3d8d2b4-1a5c-4d2e-8e76-f6c9bc2041ae",
        "optional": true
    },
    {
        "segment": "TD1",
        "segment rule": "f9e65d0c-f5b5-44a0-8971-1c5a55cdd5c9",
        "optional": true
    },
    {
        "segment": "TD5",
        "segment rule": "0ab7c1f0-6db5-4e5c-b1c0-d1357d3b4e37",
        "optional": true
    },
    {
        "segment": "TD3",
        "segment rule": "b1c7d776-1e0c-4f76-853e-63bc25618d54",
        "optional": true
    },
    {
        "segment": "TD4",
        "segment rule": "0e6c1459-dcb6-4180-8c8c-b58e25be21b9",
        "optional": true
    },
    {
        "segment": "MAN",
        "segment rule": "d1c9d7ab-3b8f-4b57-8124-4749f85873c8",
        "optional": true
    },
    {
        "segment": "PCT",
        "segment rule": "7caa2ec8-9c2a-45c6-9b4a-e0a9f2500f57",
        "optional": true
    },
    {
        "segment": "CTB",
        "segment rule": "5f7635a4-e1d2-4f00-8c28-7b8f3c5c79f6",
        "optional": true
    },
    {
        "segment": "TXI",
        "segment rule": "b60f7f59-63e1-45e6-92e3-4d1b46c8c0da",
        "optional": true
    },
    {
        "loop": "LDT",
        "loop rule": "f7c6c7a0-0f9e-41c3-8596-b78b054f2f8c",
        "optional": true
    },
    {
        "loop": "AMT",
        "loop rule": "71b3cc8b-b48a-4650-8059-3b6456c0ef7a",
        "optional": true
    },
    {
        "loop": "FA1",
        "loop rule": "c567cb8e-e2c5-42ed-9a24-f2e3c2c0a8ed",
        "optional": true
    },
    {
        "loop": "N9",
        "loop rule": "e9f4b1e6-d44f-4c4d-b76e-91d0db9e2d6f",
        "optional": true
    },
    {
        "loop": "N1",
        "loop rule": "1f81e2b3-9264-4e58-b5aa-3d65b76334c4",
        "optional": true
    },
    {
        "loop": "LM",
        "loop rule": "f31f4e36-47b3-42ed-8514-982cde58b7c5",
        "optional": true
    },
    {
        "loop": "SPI",
        "loop rule": "2549f3e8-2f2b-41d1-a2c5-b60cdb65e7c8",
        "optional": true
    },
    {
        "loop": "N1",
        "loop rule": "2e9731a5-33e8-44b7-975b-21ff634594e7",
        "optional": true
    },
    {
        "loop": "CB1",
        "loop rule": "7cf2cbd8-2aa6-403b-a7f4-6f097d49e320",
        "optional": true
    },
    {
        "loop": "ADV",
        "loop rule": "7d3f1210-5aef-453f-abc1-e8d74a536a9c",
        "optional": true
    },
    {
        "loop": "PO1",
        "loop rule": "4b99c5e5-b379-45aa-80ed-703a58a895e8",
        "optional": true
    },
    {
        "loop": "CTP",
        "loop rule": "8bb03304-3c66-467f-80b7-fc3e8cda00f8",
        "optional": true
    },
    {
        "loop": "PID",
        "loop rule": "a3d8d2b4-1a5c-4d2e-8e76-f6c9bc2041ae",
        "optional": true
    },
    {
        "loop": "SAC",
        "loop rule": "f9e65d0c-f5b5-44a0-8971-1c5a55cdd5c9",
        "optional": true
    },
    {
        "loop": "QTY",
        "loop rule": "0ab7c1f0-6db5-4e5c-b1c0-d1357d3b4e37",
        "optional": true
    },
    {
        "loop": "SCH",
        "loop rule": "b1c7d776-1e0c-4f76-853e-63bc25618d54",
        "optional": true
    },
    {
        "loop": "PKG",
        "loop rule": "0e6c1459-dcb6-4180-8c8c-b58e25be21b9",
        "optional": true
    },
    {
        "loop": "LDT",
        "loop rule": "d1c9d7ab-3b8f-4b57-8124-4749f85873c8",
        "optional": true
    },
    {
        "loop": "LM",
        "loop rule": "7caa2ec8-9c2a-45c6-9b4a-e0a9f2500f57",
        "optional": true
    },
    {
        "loop": "N9",
        "loop rule": "5f7635a4-e1d2-4f00-8c28-7b8f3c5c79f6",
        "optional": true
    },
    {
        "loop": "N1",
        "loop rule": "b60f7f59-63e1-45e6-92e3-4d1b46c8c0da",
        "optional": true
    },
    {
        "loop": "LDT",
        "loop rule": "f7c6c7a0-0f9e-41c3-8596-b78b054f2f8c",
        "optional": true
    },
    {
        "loop": "SLN",
        "loop rule": "71b3cc8b-b48a-4650-8059-3b6456c0ef7a",
        "optional": true
    },
    {
        "loop": "N9",
        "loop rule": "c567cb8e-e2c5-42ed-9a24-f2e3c2c0a8ed",
        "optional": true
    },
    {
        "loop": "SAC",
        "loop rule": "e9f4b1e6-d44f-4c4d-b76e-91d0db9e2d6f",
        "optional": true
    },
    {
        "loop": "QTY",
        "loop rule": "1f81e2b3-9264-4e58-b5aa-3d65b76334c4",
        "optional": true
    },
    {
        "loop": "N1",
        "loop rule": "f31f4e36-47b3-42ed-8514-982cde58b7c5",
        "optional": true
    },
    {
        "loop": "AMT",
        "loop rule": "2549f3e8-2f2b-41d1-a2c5-b60cdb65e7c8",
        "optional": true
    },
    {
        "loop": "LM",
        "loop rule": "2e9731a5-33e8-44b7-975b-21ff634594e7",
        "optional": true
    },
    {
        "loop": "CTT",
        "loop rule": "7cf2cbd8-2aa6-403b-a7f4-6f097d49e320",
        "optional": true
    },
    {
        "segment": "SE",
        "segment rule": "7d3f1210-5aef-453f-abc1-e8d74a536a9c",
        "optional": false
    }
  ],
  "status": "success",
  "reason": "match found"
}
```

> Bad Response:

```json
{
  "set": "",
  "segments": [],
  "status": "error",
  "reason": "match not found"
}
```

Retrieve a specific Interchange requirement by the Interchange Rule ID.
### HTTP Request
`GET http://example.com/api/v1/Interchange`


### Query Parameters

Parameter|Type |Description
---------|-----|-----------
id| string | unique identifier associated with the Interchange Rule.
type | string | the data type to return.

<aside class="notice">
Interchange Rule ID's are generated on creation of an Interchange Rule.
</aside>

<aside class="notice">
Supported types are EDI, JSON, and XML.
</aside>

### Response Body
Parameter|Type |Description
---------|-----|-----------
set | integer | transaction set number.
segments | array | segments or loops associated with the transaction set.
status | string | state or condition of the request.
reason | string | description of the state or condition of the request.

## Get Interchange Rules
> OK Response:

```json
{
  "rules": [
      "550e8400-e29b-41d4-a716-446655440000",
      "f47ac10b-58cc-4372-a567-0e02b2c3d479",
      "b2a4e3d2-e5b0-4bcf-8f34-2c17d4746b29",
      "4b1aef76-d6f8-4b16-92f8-f3a7c5d4d2c3",
      "d19d1cb4-1df0-4bb1-8f26-8972f06c4d3c",
      "cfa3e8bb-8b74-49cf-9e6f-f01a05b09f9e",
      "8d19e6e7-154c-41c1-bc05-45e0c7f3e8d0",
      "e2b1c062-27e3-4f7c-b5b1-e30a6f6f4e60",
      "1f8a59dc-fc65-43ff-a203-b0f8e73a63a4",
      "72b7e1a3-2345-40d8-b82b-9e3a4b45265a"
  ],
  "status": "success",
  "reason": "match found"
}
```

> Bad Response:

```json
{
  "rules": [],
  "status": "error",
  "reason": "match not found"
}
```
Fetch a list of all Intechange requirement IDs.
### HTTP Request
`GET http://example.com/api/v1/Interchange`

### Query Parameters

Parameter|Type |Description
---------|-----|-----------
page | integer | the current page number in a paginated data set.
size | integer | the number of items to be included on each page.

### Response Body
Parameter|Type |Description
---------|-----|-----------
rules | array | Interchange Rule IDs.
status | string | state or condition of the request.
reason | string | description of the state or condition of the request.

<aside class="notice">
Size limitations prevent all rules from appearing. The ID associated with the rule appears instead and the <code>GET Interchange</code> endpoint can be used to view the details of each ruleset.
</aside>

## Update Interchange Rule
> Request:

```json
{
  "id": "72b7e1a3-2345-40d8-b82b-9e3a4b45265a",
  "set": 850,
  "segments": [
    {
        "segment": "ST",
        "segment rule": "a3d8d2b4-1a5c-4d2e-8e76-f6c9bc2041ae",
        "optional": false
    },
    {
        "segment": "BEG",
        "segment rule": "f9e65d0c-f5b5-44a0-8971-1c5a55cdd5c9",
        "optional": false
    },
    {
        "segment": "CUR",
        "segment rule": "0ab7c1f0-6db5-4e5c-b1c0-d1357d3b4e37",
        "optional": true
    },
    {
        "segment": "REF",
        "segment rule": "b1c7d776-1e0c-4f76-853e-63bc25618d54",
        "optional": true
    },
    {
        "segment": "PER",
        "segment rule": "0e6c1459-dcb6-4180-8c8c-b58e25be21b9",
        "optional": true
    },
    {
        "segment": "TAX",
        "segment rule": "d1c9d7ab-3b8f-4b57-8124-4749f85873c8",
        "optional": true
    },
    {
        "segment": "FOB",
        "segment rule": "7caa2ec8-9c2a-45c6-9b4a-e0a9f2500f57",
        "optional": true
    },
    {
        "segment": "CTP",
        "segment rule": "5f7635a4-e1d2-4f00-8c28-7b8f3c5c79f6",
        "optional": true
    },
            {
        "segment": "PAM",
        "segment rule": "b60f7f59-63e1-45e6-92e3-4d1b46c8c0da",
        "optional": true
    },
    {
        "segment": "CSH",
        "segment rule": "f7c6c7a0-0f9e-41c3-8596-b78b054f2f8c",
        "optional": true
    },
    {
        "segment": "TC2",
        "segment rule": "71b3cc8b-b48a-4650-8059-3b6456c0ef7a",
        "optional": true
    },
    {
        "loop": "SAC",
        "loop rule": "c567cb8e-e2c5-42ed-9a24-f2e3c2c0a8ed",
        "optional": true
    },
    {
        "segment": "ITD",
        "segment rule": "e9f4b1e6-d44f-4c4d-b76e-91d0db9e2d6f",
        "optional": true
    },
    {
        "segment": "DIS",
        "segment rule": "1f81e2b3-9264-4e58-b5aa-3d65b76334c4",
        "optional": true
    },
    {
        "segment": "INC",
        "segment rule": "f31f4e36-47b3-42ed-8514-982cde58b7c5",
        "optional": true
    },
    {
        "segment": "DTM",
        "segment rule": "2549f3e8-2f2b-41d1-a2c5-b60cdb65e7c8",
        "optional": true
    },
    {
        "segment": "LIN",
        "segment rule": "2e9731a5-33e8-44b7-975b-21ff634594e7",
        "optional": true
    },
    {
        "segment": "SI",
        "segment rule": "7cf2cbd8-2aa6-403b-a7f4-6f097d49e320",
        "optional": true
    },
    {
        "segment": "PID",
        "segment rule": "7d3f1210-5aef-453f-abc1-e8d74a536a9c",
        "optional": true
    },
    {
        "segment": "MEA",
        "segment rule": "4b99c5e5-b379-45aa-80ed-703a58a895e8",
        "optional": true
    },
    {
        "segment": "PWK",
        "segment rule": "8bb03304-3c66-467f-80b7-fc3e8cda00f8",
        "optional": true
    },
    {
        "segment": "PKG",
        "segment rule": "a3d8d2b4-1a5c-4d2e-8e76-f6c9bc2041ae",
        "optional": true
    },
    {
        "segment": "TD1",
        "segment rule": "f9e65d0c-f5b5-44a0-8971-1c5a55cdd5c9",
        "optional": true
    },
    {
        "segment": "TD5",
        "segment rule": "0ab7c1f0-6db5-4e5c-b1c0-d1357d3b4e37",
        "optional": true
    },
    {
        "segment": "TD3",
        "segment rule": "b1c7d776-1e0c-4f76-853e-63bc25618d54",
        "optional": true
    },
    {
        "segment": "TD4",
        "segment rule": "0e6c1459-dcb6-4180-8c8c-b58e25be21b9",
        "optional": true
    },
    {
        "segment": "MAN",
        "segment rule": "d1c9d7ab-3b8f-4b57-8124-4749f85873c8",
        "optional": true
    },
    {
        "segment": "PCT",
        "segment rule": "7caa2ec8-9c2a-45c6-9b4a-e0a9f2500f57",
        "optional": true
    },
    {
        "segment": "CTB",
        "segment rule": "5f7635a4-e1d2-4f00-8c28-7b8f3c5c79f6",
        "optional": true
    },
    {
        "segment": "TXI",
        "segment rule": "b60f7f59-63e1-45e6-92e3-4d1b46c8c0da",
        "optional": true
    },
    {
        "loop": "LDT",
        "loop rule": "f7c6c7a0-0f9e-41c3-8596-b78b054f2f8c",
        "optional": true
    },
    {
        "loop": "AMT",
        "loop rule": "71b3cc8b-b48a-4650-8059-3b6456c0ef7a",
        "optional": true
    },
    {
        "loop": "FA1",
        "loop rule": "c567cb8e-e2c5-42ed-9a24-f2e3c2c0a8ed",
        "optional": true
    },
    {
        "loop": "N9",
        "loop rule": "e9f4b1e6-d44f-4c4d-b76e-91d0db9e2d6f",
        "optional": true
    },
    {
        "loop": "N1",
        "loop rule": "1f81e2b3-9264-4e58-b5aa-3d65b76334c4",
        "optional": true
    },
    {
        "loop": "LM",
        "loop rule": "f31f4e36-47b3-42ed-8514-982cde58b7c5",
        "optional": true
    },
    {
        "loop": "SPI",
        "loop rule": "2549f3e8-2f2b-41d1-a2c5-b60cdb65e7c8",
        "optional": true
    },
    {
        "loop": "N1",
        "loop rule": "2e9731a5-33e8-44b7-975b-21ff634594e7",
        "optional": true
    },
    {
        "loop": "CB1",
        "loop rule": "7cf2cbd8-2aa6-403b-a7f4-6f097d49e320",
        "optional": true
    },
    {
        "loop": "ADV",
        "loop rule": "7d3f1210-5aef-453f-abc1-e8d74a536a9c",
        "optional": true
    },
    {
        "loop": "PO1",
        "loop rule": "4b99c5e5-b379-45aa-80ed-703a58a895e8",
        "optional": true
    },
    {
        "loop": "CTP",
        "loop rule": "8bb03304-3c66-467f-80b7-fc3e8cda00f8",
        "optional": true
    },
    {
        "loop": "PID",
        "loop rule": "a3d8d2b4-1a5c-4d2e-8e76-f6c9bc2041ae",
        "optional": true
    },
    {
        "loop": "SAC",
        "loop rule": "f9e65d0c-f5b5-44a0-8971-1c5a55cdd5c9",
        "optional": true
    },
    {
        "loop": "QTY",
        "loop rule": "0ab7c1f0-6db5-4e5c-b1c0-d1357d3b4e37",
        "optional": true
    },
    {
        "loop": "SCH",
        "loop rule": "b1c7d776-1e0c-4f76-853e-63bc25618d54",
        "optional": true
    },
    {
        "loop": "PKG",
        "loop rule": "0e6c1459-dcb6-4180-8c8c-b58e25be21b9",
        "optional": true
    },
    {
        "loop": "LDT",
        "loop rule": "d1c9d7ab-3b8f-4b57-8124-4749f85873c8",
        "optional": true
    },
    {
        "loop": "LM",
        "loop rule": "7caa2ec8-9c2a-45c6-9b4a-e0a9f2500f57",
        "optional": true
    },
    {
        "loop": "N9",
        "loop rule": "5f7635a4-e1d2-4f00-8c28-7b8f3c5c79f6",
        "optional": true
    },
    {
        "loop": "N1",
        "loop rule": "b60f7f59-63e1-45e6-92e3-4d1b46c8c0da",
        "optional": true
    },
    {
        "loop": "LDT",
        "loop rule": "f7c6c7a0-0f9e-41c3-8596-b78b054f2f8c",
        "optional": true
    },
    {
        "loop": "SLN",
        "loop rule": "71b3cc8b-b48a-4650-8059-3b6456c0ef7a",
        "optional": true
    },
    {
        "loop": "N9",
        "loop rule": "c567cb8e-e2c5-42ed-9a24-f2e3c2c0a8ed",
        "optional": true
    },
    {
        "loop": "SAC",
        "loop rule": "e9f4b1e6-d44f-4c4d-b76e-91d0db9e2d6f",
        "optional": true
    },
    {
        "loop": "QTY",
        "loop rule": "1f81e2b3-9264-4e58-b5aa-3d65b76334c4",
        "optional": true
    },
    {
        "loop": "N1",
        "loop rule": "f31f4e36-47b3-42ed-8514-982cde58b7c5",
        "optional": true
    },
    {
        "loop": "AMT",
        "loop rule": "2549f3e8-2f2b-41d1-a2c5-b60cdb65e7c8",
        "optional": true
    },
    {
        "loop": "LM",
        "loop rule": "2e9731a5-33e8-44b7-975b-21ff634594e7",
        "optional": true
    },
    {
        "loop": "CTT",
        "loop rule": "7cf2cbd8-2aa6-403b-a7f4-6f097d49e320",
        "optional": true
    },
    {
        "segment": "SE",
        "segment rule": "7d3f1210-5aef-453f-abc1-e8d74a536a9c",
        "optional": false
    }
  ]
}
```

> OK Response:

```json
{
  "status": "success",
  "reason": "match found"
}
```

> Bad Response:

```json
{
  "status": "error",
  "reason": "match not found"
}
```

Modify an existing Interchange requirement.
### HTTP Request
`PUT http://example.com/v1/Interchange`

### Request Body

Parameter|Type |Description
---------|-----|-----------
id| string | unique identifier associated with the Interchange Rule.
set | integer | transaction set number.
segments | array | segments or loops associated with the transaction set.

### Response Body
Parameter|Type |Description
---------|-----|-----------
status | string | state or condition of the request.
reason | string | description of the state or condition of the request.

## Delete Interchange Rule
> OK Response:

```json
{
  "status": "success",
  "reason": "match found"
}
```

> Bad Response:

```json
{
  "status": "error",
  "reason": "match not found"
}
```

Remove a specific Interchange requirement from the system.
### HTTP Request
`DELETE http://example.com/v1/Interchange`

### Query Parameters

Parameter|Type |Description
---------|-----|-----------
id| string | unique identifier associated with the Interchange Rule.

### Response Body
Parameter|Type |Description
---------|-----|-----------
status | string | state or condition of the request.
reason | string | description of the state or condition of the request.

<aside class="warning">
Deleting the Interchange Rule will remove it from the system, but it will not prevent any existing processes from completing their current operations on that transaction.
</aside>

# Loop Rules

## Create Loop Rule
> Request:

```json
{
    "loop": "LM",
    "max": "1",
    "segments": [
        {
            "segment": "CTT",
            "segment rule": "a3d8d2b4-1a5c-4d2e-8e76-f6c9bc2041ae",
            "optional": false
        },
        {
            "segment": "AMT",
            "segment rule": "b4d8d2b4-1a5c-3d2e-9d76-a6c9ad4441ae",
            "optional": true
        }
    ]
}
```

> OK Response:

```json
{
  "id": "6B29FC40-CA47-1067-B31D-00DD010662DA",
  "status": "success",
  "reason": "queued"
}
```

> Bad Response

```json
{
  "id": "",
  "status": "error",
  "reason": "timed out"
}
```

Submit a new Loop requirement. 
### HTTP Request
`POST http://example.com/v1/Loop`

### Request Body
Parameter|Type |Description
---------|-----|-----------
loop | string | name of loop.
max | string | amount of repetitions.
segments | array | segments associated with the loop.

<aside class="notice">
Max defaults to infinite if no max is declared.
</aside>

In Electronic Data Interchange (EDI), a **loop**  refers to a group of related segments that can repeat within a transaction set, allowing for the organization and representation of hierarchical data, such as multiple line items or detailed information pertaining to a specific aspect of the transaction.

loops are typically composed of:

- **Segments**: Unit of data within an EDI message that conveys a particular piece of information related to a transaction.

<aside class="notice">
Segments are ordinal.
</aside>

### Response Body
Parameter|Type |Description
---------|-----|-----------
id| string | unique identifier associated with the EDI transaction.
status | string | state or condition of the request.
reason | string | description of the state or condition of the request.

## Get Loop Rule
> OK Response:

```json
{
  "rule": {
    "loop": "LM",
    "max": "1",
    "segments": [
        {
            "segment": "CTT",
            "segment rule": "a3d8d2b4-1a5c-4d2e-8e76-f6c9bc2041ae",
            "optional": false
        },
        {
            "segment": "AMT",
            "segment rule": "b4d8d2b4-1a5c-3d2e-9d76-a6c9ad4441ae",
            "optional": true
        }
    ]
  },
  "status": "success",
  "reason": "match found"
}
```

> Bad Response:

```json
{
  "rule": "",
  "status": "error",
  "reason": "match not found"
}
```

Retrieve a specific Loop requirement by the Loop Rule ID.
### HTTP Request
`GET http://example.com/api/v1/Loop`


### Query Parameters

Parameter|Type |Description
---------|-----|-----------
id| string | unique identifier associated with the Loop Rule.
type | string | the data type to return.

<aside class="notice">
Loop Rule ID's are generated on creation of a Loop Rule.
</aside>

<aside class="notice">
Supported types are EDI, JSON, and XML.
</aside>

### Response Body
Parameter|Type |Description
---------|-----|-----------
rule | array | loop requirements.
status | string | state or condition of the request.
reason | string | description of the state or condition of the request.

## Get Loop Rules
> OK Response:

```json
{
  "rules": [
      "550e8400-e29b-41d4-a716-446655440000",
      "f47ac10b-58cc-4372-a567-0e02b2c3d479",
      "b2a4e3d2-e5b0-4bcf-8f34-2c17d4746b29",
      "4b1aef76-d6f8-4b16-92f8-f3a7c5d4d2c3",
      "d19d1cb4-1df0-4bb1-8f26-8972f06c4d3c",
      "cfa3e8bb-8b74-49cf-9e6f-f01a05b09f9e",
      "8d19e6e7-154c-41c1-bc05-45e0c7f3e8d0",
      "e2b1c062-27e3-4f7c-b5b1-e30a6f6f4e60",
      "1f8a59dc-fc65-43ff-a203-b0f8e73a63a4",
      "72b7e1a3-2345-40d8-b82b-9e3a4b45265a"
  ],
  "status": "success",
  "reason": "match found"
}
```

> Bad Response:

```json
{
  "rules": [],
  "status": "error",
  "reason": "match not found"
}
```
Fetch a list of all Loop requirement IDs of an Interchange by the Interchange ID.
### HTTP Request
`GET http://example.com/api/v1/Loop`

### Query Parameters

Parameter|Type |Description
---------|-----|-----------
id | string | the Interchange ID
page | integer | the current page number in a paginated data set.
size | integer | the number of items to be included on each page.

### Response Body
Parameter|Type |Description
---------|-----|-----------
rules | array | Loop Rule IDs.
status | string | state or condition of the request.
reason | string | description of the state or condition of the request.

<aside class="notice">
Size limitations prevent all rules from appearing. The ID associated with the rule appears instead and the <code>GET Loop</code> endpoint can be used to view the details of each ruleset.
</aside>

## Update Loop Rule
> Request:

```json
{
  "id": "72b7e1a3-2345-40d8-b82b-9e3a4b45265a",
  "loop": "LM",
  "max": "1",
  "segments": [
      {
          "segment": "CTT",
          "segment rule": "a3d8d2b4-1a5c-4d2e-8e76-f6c9bc2041ae",
          "optional": false
      },
      {
          "segment": "AMT",
          "segment rule": "b4d8d2b4-1a5c-3d2e-9d76-a6c9ad4441ae",
          "optional": true
      }
  ]
}
```

> OK Response:

```json
{
  "status": "success",
  "reason": "match found"
}
```

> Bad Response:

```json
{
  "status": "error",
  "reason": "match not found"
}
```

Modify an existing Loop requirement.
### HTTP Request
`PUT http://example.com/v1/Loop`

### Request Body

Parameter|Type |Description
---------|-----|-----------
id| string | unique identifier associated with the Loop Rule.
loop | string | name of loop.
max | string | amount of repetitions.
segments | array | segments associated with the loop.

### Response Body
Parameter|Type |Description
---------|-----|-----------
status | string | state or condition of the request.
reason | string | description of the state or condition of the request.

## Delete Loop Rule
> OK Response:

```json
{
  "status": "success",
  "reason": "match found"
}
```

> Bad Response:

```json
{
  "status": "error",
  "reason": "match not found"
}
```

Remove a specific Loop requirement from the system. 
### HTTP Request
`DELETE http://example.com/v1/Loop`

### Query Parameters

Parameter|Type |Description
---------|-----|-----------
id | string | unique identifier associated with the Loop Rule.

### Response Body
Parameter|Type |Description
---------|-----|-----------
status | string | state or condition of the request.
reason | string | description of the state or condition of the request.

<aside class="warning">
Deleting the Loop Rule will remove it from the system, but it will not prevent any existing processes from completing their current operations on that transaction.
</aside>

# Segment Rules

## Create Segment Rule
Submit a new Segment requirement

## Get Segment Rule
Retreive a specific Segment requirement by the Segment Rule ID.

## Get Segment Rules
Retreive all Segment requirements of an Interchange by the Interchange ID.

## Update Segment Rule
Modify an existing Segment requirement.

## Delete Segment Rule
Remove a specific Segment requirement from the system. 

<aside class="warning">
Deleting the Segment Rule will remove it from the system, but it will not prevent any existing processes from completing their current operations on that transaction.
</aside>

# Webhooks

## Create Webhook
Submit a new Webhook endpoint.

## Get Webhook
Retreive a specific Webhook endpoint by the Webhook ID.

## Get Webhooks
Retreive all Webhook endpoints.

## Get Interchange Webhooks
Retreive all Webhook endpoints in an Interchange by the Interchange ID.

## Delete Webhook
Remove a specific Webhook endpoint. 

<aside class="warning">
Deleting the Webhook will remove it from the system, but it will not prevent any existing processes from completing their current operations on that transaction.
</aside>