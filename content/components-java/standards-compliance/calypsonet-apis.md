---
title: Calypsonet Terminal Java APIs
linktitle: Calypsonet Terminal APIs
summary: Keyple is compliant with the terminal APIs provided by Calypsonet that standardize how to manage cards, readers, reader events and card selection.
type: book
weight: 10
toc: true
---

---

**Keyple** is compliant with the terminal APIs provided by the [Calypso Networks Association](https://calypsonet.org) that standardize how to manage cards, readers, reader events and card selection.

This compliance allows **Keyple** to obtain certifications from the **Calypso Networks Association**.
It is a guarantee of reliability and reproducibility of the processes implemented on a variety of devices.

## Reader & Card APIs

These two APIs standardize the way that a reader and a card interact.
They are generic and apply to all card and reader technologies.

The **Reader API** must be used by developers of applications and card extensions, while the **Card API** must be used **only** by developers of card extensions.

* [{{< icon name="github" pack="fab" >}} Calypsonet Terminal Reader Java API](https://github.com/calypsonet/calypsonet-terminal-reader-java-api)
* [{{< icon name="github" pack="fab" >}} Calypsonet Terminal Card Java API](https://github.com/calypsonet/calypsonet-terminal-card-java-api)

## Calypso API

This high level API standardizes the way to interact with a **Calypso®** product (card, NFC smartphone applet/application, SAM, etc...).

This API should be used by developers of **Calypso** applications.

* [{{< icon name="github" pack="fab" >}} Calypsonet Terminal Calypso Java API](https://github.com/calypsonet/calypsonet-terminal-calypso-java-api)