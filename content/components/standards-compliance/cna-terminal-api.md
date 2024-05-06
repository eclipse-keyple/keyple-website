---
title: CNA Terminal API
linktitle: CNA Terminal API
summary: Keyple is compliant with the Terminal API specifications provided by the Calypso Networks Association that standardize how to manage cards, readers, reader events and card selection.
type: book
weight: 10
toc: true
---

<br>

Keyple is compliant with the **Terminal API** specifications provided by the [Calypso Networks Association](https://calypsonet.org) that standardize how to manage cards, readers, reader events and card selection.

This compliance allows Keyple to obtain certifications from the Calypso Networks Association.
It is a guarantee of reliability and reproducibility of the processes implemented on a variety of devices.

The open source [Eclipse Keypop](https://keypop.org) project exposes the **Terminal API** specifications in the form of 
**Java** and **C++** interfaces,
and Keyple is based on these interfaces.

<br>

## Reader & Card APIs

These two APIs standardize the way that a reader and a card interact.
They are generic and apply to all card and reader technologies.

The **Reader API** must be used by developers of applications and card extensions, while the **Card API** must be used **only** by developers of card extensions.

* [Keypop Reader API](https://keypop.org/apis/reader-layer/reader-api/)
* [Keypop Card API](https://keypop.org/apis/reader-layer/card-api/)

<br>

## Calypso APIs

These high-level APIs standardizes the way to interact with a Calypso® product (card, NFC smartphone applet/application, SAM, etc...).

These APIs should be used by developers of Calypso applications.

* [Keypop Calypso Card API](https://keypop.org/apis/calypso-layer/calypso-card-api/)
* [Keypop Calypso Crypto Legacy SAM API](https://keypop.org/apis/calypso-layer/calypso-legacysam-api/)