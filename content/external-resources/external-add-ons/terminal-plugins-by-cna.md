---
title: Terminal plugins by the Calypso Networks Association
linktitle: Terminal plugins by CNA
summary: Plugins to integrate ticketing terminals from "Coppernic", "Famoco", "Flowbird", "Bluebird", and to interface the "Calypso HSM"
type: book
toc: false
weight: 1
---

---
The Calypso Networks Association has implemented several plugins to integrate Keyple Java on different ticketing terminals.

Some are fully provide as open source:
 - [Plugin Coppernic](https://github.com/calypsonet/keyple-plugin-cna-coppernic-cone2-java-lib) for the terminal "C-One v2"
 - [Plugin Famoco](https://github.com/calypsonet/keyple-plugin-cna-famoco-se-communication-java-lib) for the terminals 
   "FX100", "FX105", "FX200", "FX205", "FX300", "FX915", "FX920"

Others require proprietary libraries with restricted access in order to respect the intellectual property of the 
manufacturers (ask CNA on `keyple @ calypsonet.org`):
 - [Plugin Legacy HSM](https://github.com/calypsonet/keyple-plugin-cna-legacyhsm-java-lib) to interface the "Spirtech HSM"
 - [Plugin Flowbird](https://github.com/calypsonet/keyple-plugin-cna-flowbird-android-java-lib) to support all the Android 
   terminals proposed by Flowbird (Axio Touch Validator/ MTBorne validator, Magnetic Axio Touch Validator, 
   Axio 4 Validator, Infigo Driver Console, Voyager Embedded Ticketing Vending Machine, Coppernic C-One, 
   Coppernic C-One V2, Zebra TC77, ACTIA PSDT)
 - [Plugin Bluebird](https://github.com/calypsonet/keyple-plugin-cna-bluebird-specific-nfc-java-lib) for the terminal "EF501"
 
