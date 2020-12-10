---
title: Calypso application
type: book
toc: true
draft: false
weight: 330
---

## Overview

**Work in Progress**

Keyple API was designed to support an extension system. On top of **Keyple Core**, APIs can be developed to extend
Keyple features. For example, Calypso Network Association provides **Keyple Calypso Extension**. 

The use of **Keyple Calypso Extension** open the ability to operate commands with a calypso Portable Object and to manage a 
secure calypso transaction.

The diagram below shows the role of the **Keyple Calypso Extension** components in the software layers for a local application :

{{< figure library="true" src="calypso-app-development/component/Local_Component_Overview.svg" title="" >}}

## How to use it

1. In pre-requisite, read page [Develop a Local Application]({{< relref "local-application.md" >}}) to understand the main concepts of Keyple in a local application.
1. Read chapter [Concepts](#concepts) to understand the main terms and concepts of the  **Keyple Calypso Extension** API.

## Concepts

Here are the main concepts to keep in mind before continuing to read this developer guide :

#### Calypso PO

Concentrate all known informations about the Personal Object being processed. Accessible informations are
* The application identification fields (revision/version, class, DF name, serial number, ATR, issuer)
* The indication of the presence of optional features (Stored Value, PIN, Rev3.2 mode, ratification management)
* The management information of the modification buffer
* The invalidation status
* The files, counters, SV data read or modified during the execution of the processes defined  by PoTransaction

Calypso PO fields are populated from a CardSelectionResponse optained through the process of a card selection.

### PoTransaction

Service providing high-level API to manage transactions with a Calypso PO. 

#### ElementaryFile

Contains the description of a Calypso Elementary File.

### Card Selection Service

#### PO

#### SAM


## API

## Workflow/Use Cases

## Examples