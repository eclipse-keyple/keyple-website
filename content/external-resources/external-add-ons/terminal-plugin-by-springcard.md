---
title: Android PC/SC plugin by SpringCard
linktitle: Terminal plugin by SpringCard
summary: Plugin to integrate SpringCard PC/SC readers on Android terminals
type: book
toc: false
weight: 1
---

---
SpringCard is happy to contribute to the Keyple project by providing a plugin that makes it possible to use SpringCard PC/SC couplers from a stock Android tablet or mobile phone.

The plugin works
 - with all SpringCard PC/SC over USB devices.

This includes all the SpringCard Puck family (for instance SpringCard Puck One, featuring contactless+SAM: https://www.springcard.com/en/products/puck-one), SpringCard Prox'N'Roll (https://www.springcard.com/en/products/proxnroll-pcsc-hsp) and virtually all PC/SC over USB (CCID) devices.

The Android host must be a complete USB host (https://developer.android.com/guide/topics/connectivity/usb/host). USB on-the-go (OTG) is not enough!
Pay attention that the Android host must also be able to provide enough power to the reader (more than 250mA), which is not the case for many tablets and mobile phones. Using a USB 3 hub with power delivery is generally the solution.
 - with SpringCard PC/SC over BLE (Bluetooth Low Energy) devices.

First BLE PC/SC reader in SpringCard's portfolio is SpringCard Puck Blue (https://www.springcard.com/en/products/puck-blue). Other devices will be introduced in the future. The Android host must support BLE (https://developer.android.com/guide/topics/connectivity/bluetooth/ble-overview).

The plugin is hosted on GitHub: https://github.com/springcard/android-keyple

It is based on SpringCard's PC/SC-Like for Android libraries (https://github.com/springcard/android-pcsclike) that connects to the reader in BLE or USB using only 'user-land' methods.
