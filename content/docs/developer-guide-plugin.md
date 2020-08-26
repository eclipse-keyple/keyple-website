---
title: (WIP)Developer guide - Develop a Plugin
linktitle: (WIP)Develop a plugin
toc: true
type: docs
date: "2020-02-24T00:00:00+01:00"
draft: false
menu:
  docs:
    parent: Developer Guide
    weight: 210

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 210
---
This guide will provide nescessary steps to develop a Keyple plugin for a device. In order to flatten the learning curve, we'll 
illustrate the creation processus using the implementation of the Android NFC Plugin and OMAPI plugins.
This plugins can be consulted with the keyple-java/android repository.

## Imports 

Your plugin will use be based upon Keyple Core libraries:

```gradle
implementation "org.eclipse.keyple:keyple-java-core:$keyple_version"
```

## Implement Keyple Reader

The basis component of a Keyple plugin is the implementation of an AbstractLocalReader. The AbstractLocalReader implementation will map the native reader's
features of the device to Keyple Reader component allowing to be used within the Keyple suite.

The 'local' in AbstractLocalReader is used to specify devices physicaly connected to the device.

Relying on  native libraries capacities of the device, implementations to be done are:
* checkSePresence()
* getATR()
* openPhysicalChannel()
* closePhysicalChannel()
* isPhysicalChannelOpen()
* ProtocolFlagMatches()
* TransmitApdu

###Examples
#### checkSePresence()
Allow Keyple to check if the secure elements is inserted or in the NFC field of the device.

OMAPI Exemple
```kotlin
//nativeReader is an instance of android.se.omapi.Reader
override fun checkSePresence(): Boolean {
    return nativeReader.isSecureElementPresent
}
```

Android NFC Example
```kotlin
//When a SE is presented in the NFC field, we can get a tagproxy object. When the SE is removed, 
//this value is reinited. So when it is not null, we can assume the SE is currently in the field.
public override fun checkSePresence(): Boolean {
    return tagProxy != null
}
```

#### getAtr()
OMAPI Exemple
```kotlin
//Session is a native object of android.se.omapi package
override fun getATR(): ByteArray? {
    return session?.let {
        it.atr
    }
}
```

Android NFC Example
```kotlin
//TagProxy is an object mapping android.nfc.tech.TagTechnology. Atr is obtained from data of this object (epending of protocol)
public override fun getATR(): ByteArray? {
    val atr = tagProxy?.atr
    return if (atr?.isNotEmpty() == true) atr else null
}
```

#### openPhysicalChannel()
OMAPI Exemple
```kotlin
@Throws(KeypleReaderIOException::class)
override fun openPhysicalChannel() {
    try {
        session = nativeReader.openSession()
    } catch (e: IOException) {
        throw KeypleReaderIOException("IOException while opening physical channel.", e)
    }
}
```

Android NFC Example
```kotlin
@Throws(KeypleReaderIOException::class)
public override fun openPhysicalChannel() {
    if (tagProxy?.isConnected != true) {
        try {
            tagProxy?.connect()
        } catch (e: IOException) {
            throw KeypleReaderIOException("Error while opening physical channel", e)
        }
    }
}
```



Also, this implementation could be done extending AbstractObservableLocalReader. It provides :
* State machine regarding SE event: 'WAIT_FOR_START_DETECTION', 'WAIT_FOR_SE_INSERTION'...
* Extended readers features
    + Smart Insertion Reader: Allow to detect SE insertion
    + Smart Removal Reader: Allow to detect SE Removal
    + Smart Selection Reader: Allow to use native SE selection process

