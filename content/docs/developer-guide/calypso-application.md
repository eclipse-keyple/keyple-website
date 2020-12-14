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

## Before you start
1. In pre-requisite, have knowledge of the standard Calypso.
1. Read the [common concepts]({{< relref "common-concepts.md" >}}) page and become familiar with the basic concepts on which **Keyple** is based.
1. Any implementation of a Keyple application starts with the implementation of **Keyple Core**, please study the [workflow]({{< relref "local-application.md" >}}) proposed in Local application guide.
1. Read chapter [Concepts](#concepts) to understand the main terms and concepts of the  **Keyple Calypso Extension** API.
1. Explore the [Keyple Calypso API](#keyplecalypsoapi) to discover all the possibilities offered by **Keyple Calypso Extension**.
1. Take inspiration from the [examples](#examples).
1. Follow the explanations given in the [Build your first app]({{< relref "build-your-first-app" >}}) section to configure your environment.
1. Using the [component]({{< ref "components/index.md" >}}) page, import **Keyple Core** and **Keyple Calyspo Extension** into your project and start playing with **Keyple**.

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

Calypso PO fields are populated from a CardSelectionResponse obtained through the process of a PO selection.

#### ElementaryFile

Object containing the description of a Calypso Elementary File. Can be retrieved from Calypso PO using its SFI. 

#### Calypso SAM

Concentrates all the informations we know about the SAM currently selected. Accessible informations are:
 * The Sam Revision
 * The Serial number
 * The Platform identifier
 * The Application Type
 * The Application SubType
 * The Software Issuer identifier
 * The Software Version number
 * The Software Revision number

Calypso SAM fields are populated are extracted from an analysis of the ATR within a CardSelectionResponse obtained through 
the process of a SAM selection.


### PoTransaction

Service providing high-level API to manage transactions with a Calypso PO. The calypso PO Object tied is kept and updated at
each step of using this service. 

This service workflow is composed of two steps:
* Prepare the commands to be executed to the PO
* Process the prepared commands. Regarding of commands, the presence of SAM could be mandatory.



## API

## Workflow/Use Cases

## Examples