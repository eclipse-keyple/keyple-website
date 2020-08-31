---
title: Get Started with Keyple-Java
linktitle: (WIP) Android
toc: true
type: docs
date: "2020-02-24T00:00:00+01:00"
draft: false
menu:
  docs:
    parent: Build your first app
    weight: 110

reading_time: true  # Show estimated reading time?
share: true  # Show social sharing links?
profile: true  # Show author profile?
comments: true  # Show comments?

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 100
---
# Introduction 
## Overview

Keyple SDK is supported by the Operating System Android. As Keyple request low level reader access, the key features of 
the SDK relies on components called 'Plugins'.

Keyple Android Plugins are low level implementation of Keyple contracts described in the section 'Develop a plugin' in Developer 
guide. Once a plugin is provided, any classic Android application can use Keyple to provide ticketing features. 

This Guide will describe how to start a ticketing application using Keyple SDK.

## Compatibility

* Android OS 19+

# Integration

## SDK Integration

### Keyple Core 

This high-level API is convenient for developers implementing smart card processing application for terminal interfaced 
with smart card readers. Access to the readers is provided by the plugins. 

To use Keyple core API (and in fact, anything keyple's related) import the jar within the gradle dependencies of your 
Android application.

```gradle
implementation "org.eclipse.keyple:keyple-java-core:$keyple_version"
```

Please refer to Architecture/Keyle Core

### Keyple Plugins

There are many Keyple plugins available, the one to use depends on the device and ticketing tools you are aiming to 
use.

For a standard device the keyple-android-plugin-nfc and keyple-android-plugin-omapi should be be used. They will allow keyple to 
connect to, respectively, a smart card in the NFC field of the device or, a smart card inserted in a SIM like port. The 
plugins for Android are Android Libraries (AAR).

To use the plugins simply import it within the gradle dependencies of your Android application.

```gradle
implementation "org.eclipse.keyple:keyple-android-plugin-omapi:$keyple_version"
```

### Keyple Calypso

The Keyple Calypso User API is an extension of the Keyple Core User API to manage Calypso Portable Object securely using 
Calypso SAM.

Please refer to Architecture/Keyle Calypso

To use Keyple Calypso User API simply import the jar within the gradle dependencies of your Android application.

```gradle
implementation "org.eclipse.keyple:keyple-android-plugin-omapi:$keyple_version"
```

## Initializing the SDK

## Register a plugin

The Singleton SeProxyService is the entry point of the SE Proxy Service, its instance has to be called by a 
ticketing application in order to establish a link with a SE’s application.

In order to access to SE we have to register at least one plugin.

```kotlin
override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    /* register Omapi Plugin to the SeProxyService */
    try {
        SeProxyService.getInstance().registerPlugin(AndroidOmapiPluginFactory(this))
    } catch (e: KeyplePluginInstantiationException) {
    /* do something with it */
    }
}
```

Then readers of the plugin can be retrieved.

```kotlin
val readers = SeProxyService.getInstance().getPlugin(PLUGIN_NAME).readers
```

Using this readers it is possible to select a smart card application using its AID.

```kotlin
//Configure the selector with protocol and Aid
val seSelector = SeSelector.builder()
        .seProtocol(SeCommonProtocols.PROTOCOL_ISO7816_3)
        .aidSelector(AidSelector.builder().aidToSelect(poAid).build())
        .build()
//build the request by passing the seSelector. 
//As second parameter of the SeRequest consctructor, an APDU can be added to be executed
//right after the selection.
val seRequest = SeRequest(seSelector, null)

//A proxy reader is a physical reader, it allows to send and receive synchronised APDUS
val seResponse = (it.value as ProxyReader).transmitSeRequest(seRequest, ChannelControl.KEEP_OPEN)

//Check is selection is successful
if (seResponse?.selectionStatus?.hasMatched() == true) {
 //Selection is done
} else {
 //Selection failed
}
```