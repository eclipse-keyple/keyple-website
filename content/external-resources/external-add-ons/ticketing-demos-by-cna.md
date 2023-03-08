---
title: Advanced ticketing demos by the Calypso Networks Association
linktitle: Ticketing demos by CNA
summary: Ticketing applications to emulate an autonomous validator, a hand-held inspection terminal, a distributed solution for remote ticket sales and loading
type: book
toc: false
weight: 2
---

---
The Calypso Networks Association has created several innovative demos to showcase the potential of Keyple 
Java-based ticketing terminals, which are representative of the use cases encountered in public transport ticketing.

- [Demo Reload Remote](https://github.com/calypsonet/keyple-java-demo-remote) (client/server environment):
  - On the client side, an Android application loaded in a standard NFC smartphone provides the means to a customer to 
    make the ticket purchase.
    The Android NFC plugin is used to communicate with the contactless card, and the Calypso card commands are fully 
    managed by the back-office ticketing server using the Keyple Distributed solution.
  - On the server side, the back-office includes a Java server application to process the ticketing sale and manage the 
    Calypso secure session to reload contracts in remote cards.
    The server manages a pool of Calypso SAM using the PC/SC plugin and the Calypso SAM resource manager.

- [Demo Validation](https://github.com/calypsonet/keyple-android-demo-validation):
  - An autonomous validator on Android-based ticketing terminal that seamlessly starts a secure session when a contactless card is detected.
  - The machine checks the last transport event and the available ticketing contracts.
  - If access is granted, a new event is written.

- [Demo Control](https://github.com/calypsonet/keyple-android-demo-control):
  - A hand-held inspection terminal on Android portable terminal that allows an operator to check the content of a card.
  - The application verifies the validity of the last transport event regarding the current time and location.
  - Finally, it displays the result.

The "Validation" and "Control" demos can be installed on various terminals such as
Coppernic, Famoco, Flowbird, and Bluebird, using the [dedicated plugins]({{< relref "terminal-plugins-by-cna" >}}) provided by CNA.

For further information and guides on these demos, please visit the [CNA website](https://calypsonet.org/keyple-resources/).