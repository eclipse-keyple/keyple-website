---
title: Advanced ticketing demos by the Calypso Networks Association
linktitle: Ticketing demos by CNA
summary: Ticketing applications to emulate an autonomous validator, a hand-held inspection terminal, a distributed solution for remote ticket sales and loading
type: book
toc: false
weight: 2
---

---
The Calypso Networks Association has implemented several advanced demos to show the possibilities of ticketing terminals based on Keyple Java.

Two Android applications to emulate:
- an [autonomous validator](https://github.com/calypsonet/keyple-android-demo-validation) on Android-based ticketing terminals: the machine automatically starts a secure session when a contactless card is detected, the last transport event et the available ticketing contracts are checked, and if the access is granted a new event is written.
- a [hand-held inspection terminal](https://github.com/calypsonet/keyple-android-demo-control) on Android portable terminals: an operator can check the content of a card.

Also proposed, the settings to integrate these two Android demos to terminals from Coppernic, Famoco, Flowbird, and Bluebird, using the [dedicated plugins]({{< relref "terminal-plugins-by-cna" >}}) provided by CNA.

The server and client applications to operate a [remote sale and ticketing reload service](https://github.com/calypsonet/keyple-java-demo-remote):
- in the back-office side, a Java server application to process the ticketing sale and to manage the Calypso secure session to reload contracts in remote cards. The server manages a pool of Calypso SAM using the PC/SC plugin and the Calypso SAM resource manager.
- on the customer side, an Android application loaded in a common NFC phone provides the graphic user interface to request the ticket purchase. The Android NFC plugin is used to communicate with the contactless card. The Calypso card commands are relayed from the ticketing server using the Keyple distributed module.

More guides on these demos on the [CNA website](https://calypsonet.org/keyple-resources/).
