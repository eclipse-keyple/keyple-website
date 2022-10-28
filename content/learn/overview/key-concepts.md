---
title: The Keyple key concepts
linkTitle: Key concepts
summary: Understand the concepts behind Keyple.
type: book
toc: true
draft: false
weight: 1
---

---
## Overview

This page describes the core elements of Keyple, i.e. the concepts and APIs that are used to build any application implementing Keyple.
 
It is essential for the future user of Keyple to be familiar with what is said in this chapter.

---
## Reader

Keyple's primary goal being to interact with smart cards (or smartphones) held by individuals, it is logical to put the Reader at the top of Keyple's concepts.

Indeed, it is through the reader interfaces that all interactions with the smart cards will take place, either directly via the Keyple Service or using a card extension (such as Keyple Calypso card extension add-on for example).

These interfaces provide the means to
* identify the underlying physical reader,
* manage communication protocols,
* detect the presence and communicate with smart cards.

The reader concept also applies to the hardware interfaces used to communicate with security elements such as SAMs (Secure Access Modules),
which are sometimes integrated into devices and the virtual interfaces represented by the remote implementations.

To define the interface between an application and a reader,
Keyple relies on the [standard Terminal Reader API](https://terminal-api.calypsonet.org/apis/calypsonet-terminal-reader-api/) proposed by Calypso Networks Association and thus inherits an existing modeling effort.

Another benefit of using this terminal API is the ability to certify the functioning of a Keyple terminal via the associated certification process.

This certification provides a guarantee that the terminal will function as expected.

---
## Plugin

In Keyple terminology, a plugin is an add-on that allows the management of readers of a certain type.
The plugin is responsible for informing the application about the availability of readers.
The readers of the same plugin are usually hardware linked to the same physical interface.

Depending on its profile, an application may use different types of plugins to communicate with the different elements it needs (card, SAM).

---
## Card extension

A card extension is an add-on that provides high-level access to the features of a particular card technology.

Two card extensions are provided natively by the Keyple project:
- a generic card extension providing basic means to communicate with a card,
- a Calypso card extension providing high-level access to Calypso card features. It includes a Secure Session based transaction manager involving Calypso cards and SAMs.

---
## Smart card service

This is the main service of Keyple that concentrates the knowledge of active plugins and readers and provides card selection managers.

At startup, a Keyple application must register the add-ons (plugins and card extensions) it uses.

---
## Observation

The concept of observation applies to certain types of readers and plugins.

It consists in monitoring changes such as reader connection/disconnection or card insertion/removal and informing the observing application through a dedicated interface.

Not all plugins and readers are observable and for those which are, the observation is optional.

---
## Selection

The Keyple **selection** concept is derived from the application selection defined by the ISO7816-4 standard.

It supplements it by managing cards that do not have the standard command using identification mechanisms based on power-on data and communication protocol,
and also by allowing the execution of commands immediately following application selection or detection.

This principle optimizes the processing by allowing the application to elaborate advanced card discovery requests.

Several targets can be defined by the application according to the different customer cards expected within a selection scenario.

The **selection scenario** principle consists in providing a set of selection cases corresponding to the expected cards and receiving a selection result containing not only the card identification but also the result of all additional commands that the application will have attached.

The Keyple card selection process is generic, allowing the management of cards of different types or technologies within the same application.

---
## Smart card

The Keyple **smart card** is an object representation of the physical card.

It is built by the specific card extension used (e.g. Keyple Calypso) and is provided to the user by the card selection service.

---
## Protocol

At the time of selection, Keyple offers the possibility to distinguish cards by their communication **protocol**.

In order to associate a type of **protocol** (or card technology), Keyple proposes the concept of configurable reader with a method allowing to associate a **protocol** identifier known by the reader (name of the physical **protocol**) and another one known by the application (name of the logical **protocol**).

A configurable reader plugin is responsible for providing a means of identifying the **protocol** and names each **protocol** it supports.


