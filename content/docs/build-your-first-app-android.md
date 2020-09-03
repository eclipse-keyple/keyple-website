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

### Register a plugin

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

### Retrieve the readers

With the plugin registered we can retrieve all instance of the component mapping the smartcard readers provided by this 
plugins. For example, some plugins provide access to contact and contactless readers)

```kotlin
//PLUGIN_NAME is a constant provided by the keyple plugin 
val readers = SeProxyService.getInstance().getPlugin(PLUGIN_NAME).readers
```

### Retrieve one specific reader

It is also possible to retrieve a specific reader.

```kotlin
//PLUGIN_NAME and READER_NAME are constants provided by the used keyple plugin 
val reader = SeProxyService.getInstance().getPlugin(PLUGIN_NAME).getReader(READER_NAME)
```

## Select a PO

### SeProxy API

Using a reader, it is possible to select a PO using its AID. Here we use the low level SeProxy API of Keyple core to do so.

```kotlin
 /*
 * Configuration of the selector
 * Setting of an AID based selection of a Calypso REV3 PO
 */
val seSelector = SeSelector.builder()
        .seProtocol(SeCommonProtocols.PROTOCOL_ISO7816_3)
        .aidSelector(AidSelector.builder().aidToSelect(poAid).build())
        .build()
//build the request by passing the seSelector. 
//As second parameter of the SeRequest consctructor, an APDU can be added to be executed
//right after the selection.
val seRequest = SeRequest(seSelector, null)

//A ProxyReader is a physical reader, it allows to send and receive synchronised APDUS
val seResponse = (reader.value as ProxyReader).transmitSeRequest(seRequest, ChannelControl.KEEP_OPEN)

//Check is selection is successful
if (seResponse?.selectionStatus?.hasMatched() == true) {
    //Selection is done
} else {
    //Selection failed
}
```

### Selection API

The bellow example illustrates the same operation using the Selection API, an higher level API of Keyple Core. 
 
```kotlin
var seSelection = SeSelection()

/* 
 * Close the channel after the selection 
 */
seSelection.prepareReleaseSeChannel()

/*
 * AID based selection: get the first application occurrence matching the AID, keep the
 * physical channel open
 */
seSelection.prepareSelection(GenericSeSelectionRequest(
        SeSelector.builder()
                .seProtocol(SeCommonProtocols.PROTOCOL_ISO14443_4)
                .aidSelector(AidSelector.builder()
                        .aidToSelect(seAidPrefix)
                        .fileOccurrence(AidSelector.FileOccurrence.FIRST)
                        .fileControlInformation(AidSelector.FileControlInformation.FCI).build())
                .build()))
seSelection.prepareSelection(poSelectionRequest)

/*
 * Execution og the selection
 */
val selectionsResult = seSelection.processExplicitSelection(reader)

/**
 * Check if PO has been selected successfuly
 */
if (selectionsResult.hasActiveSelection()) {
    //Selection is done
    val matchedSe = selectionsResult.activeMatchingSe
    val fci = matchedSe.fciBytes
    val atr = matchedSe.atrBytes
} else {
    //Selection failed
}
```

## Reading and writing data

### Reading Environment and usage

Exemple of reading Environmement and usage data of an Hoplink application. As Hoplink is a calypso application, we can map 
cast the result of the selection with CalypsoPo. It will allow us to easily access calypso datas.

```kotlin
var poAid= "A000000291A000000191"
val sfiHoplinkEFEnvironment = 0x14.toByte()
val sfiHoplinkEFUsage = 0x1A.toByte()

/*
 * Prepare a Calypso PO selection
 */
val seSelection = SeSelection()

/*
 * Setting of an AID based selection of a Calypso REV3 PO
 *
 * Select the first application matching the selection AID whatever the SE
 * communication protocol keep the logical channel open after the selection
 */

/*
 * Calypso selection: configures a PoSelectionRequest with all the desired
 * attributes to make the selection and read additional information afterwards
 */
val poSelectionRequest = PoSelectionRequest(
        PoSelector.builder()
                .seProtocol(SeCommonProtocols.PROTOCOL_ISO7816_3)
                .aidSelector(AidSelector.builder().aidToSelect(poAid).build())
                .invalidatedPo(InvalidatedPo.REJECT).build())

/*
 * Prepare the reading order and keep the associated parser for later use once
 * the selection has been made.
 */
poSelectionRequest.prepareReadRecordFile(sfiHoplinkEFEnvironment, 1)

poSelectionRequest.prepareReadRecordFile(
        sfiHoplinkEFUsage, 1)

/*
 * Add the selection case to the current selection (we could have added other
 * cases here)
 *
 * Ignore the returned index since we have only one selection here.
 */
seSelection.prepareSelection(poSelectionRequest)

/*
 * Actual PO communication: operate through a single request the Calypso PO
 * selection and the file read
 */
try {
    val selectionsResult = seSelection.processExplicitSelection(seReader)

    if (selectionsResult.hasActiveSelection()) {
        val calypsoPo = selectionsResult.activeMatchingSe as CalypsoPo
        val environmentAndHolder = calypsoPo.getFileBySfi(sfiHoplinkEFEnvironment).data.content
        val usage = calypsoPo.getFileBySfi(sfiHoplinkEFUsage).data.content
    } else {
       //The selection of the PO Failed
    }
} catch (e: Exception) {
    //The selection of the PO Failed with an error
}

```

### Incrementing a counter

In this example, we'll increase Counter 1 by 10 on a contactless ticketing NFC PO. The counter will be increased
when the PO will enter NFC Field.

#### Setup to catch reader event
```kotlin
/*
 * In order to received readers events (Inserted, removed etc..), the interface ObservableReader.ReaderObserver must be 
 * implemented.
 *    
 */

import org.eclipse.keyple.core.seproxy.event.ObservableReader
import org.eclipse.keyple.core.seproxy.event.ReaderEvent

class MainActivity : ObservableReader.ReaderObserver{

    //Initialise Android NFC Reader
    override fun initReaders() {
      // Initialize SEProxy with Android Plugins
        val nfcPlugin = SeProxyService.getInstance().registerPlugin(AndroidNfcPluginFactory())
        //Example of plugin for device with a sam reader
        val samPlugin = SeProxyService.getInstance().registerPlugin(AndroidFamocoPluginFactory())

        // Configuration of AndroidNfc Reader
        poReader = nfcPlugin.getReader(AndroidNfcReader.READER_NAME) as AndroidNfcReader
        poReader.setParameter("FLAG_READER_RESET_STATE", "0")
        poReader.setParameter("FLAG_READER_PRESENCE_CHECK_DELAY", "100")
        poReader.setParameter("FLAG_READER_NO_PLATFORM_SOUNDS", "0")
        poReader.setParameter("FLAG_READER_SKIP_NDEF_CHECK", "0")
        
        (poReader as ObservableReader).addObserver(this)
        (poReader as ObservableReader).addSeProtocolSetting(SeCommonProtocols.PROTOCOL_ISO14443_4, 
                                            AndroidNfcProtocolSettings.getSetting(SeCommonProtocols.PROTOCOL_ISO14443_4))
    }

    // Reader event will be caught in this method
    override fun update(event: ReaderEvent?) {
        CoroutineScope(Dispatchers.Main).launch {
            when (event?.eventType) {
                ReaderEvent.EventType.SE_MATCHED -> {
                    //PO with set AID detected
                    samReader.setParameter(AndroidFamocoReader.FLAG_READER_RESET_STATE, "")
                    val samResource = checkSamAndOpenChannel(samReader)

                    val selectionsResult = seSelection.processDefaultSelection(event.defaultSelectionsResponse)
                    if (selectionsResult.hasActiveSelection()) {
                        val calypsoPo = selectionsResult.activeMatchingSe as CalypsoPo
                        val poTransaction = PoTransaction(SeResource(poReader, calypsoPo), getSecuritySettings(samResource))
                        when (transactionType) {
                            TransactionType.INCREASE -> {
                                /*
                                * Open Session for the debit key
                                */
                                poTransaction.processOpening(PoTransaction.SessionSetting.AccessLevel.SESSION_LVL_LOAD)

                                poTransaction.prepareReadRecordFile(CalypsoClassicInfo.SFI_Counter1, CalypsoClassicInfo.RECORD_NUMBER_1.toInt())
                                poTransaction.processPoCommandsInSession()
        
                                //Process PO increase counter by 10
                                poTransaction.prepareIncreaseCounter(CalypsoClassicInfo.SFI_Counter1, CalypsoClassicInfo.RECORD_NUMBER_1.toInt(), 10)
                                poTransaction.processClosing(ChannelControl.CLOSE_AFTER)
                                addResultEvent("Increase by 10: SUCCESS")
                            }
                        }
                    }
                    //Notifying Keyple that we handled event
                    (poReader as ObservableReader).notifySeProcessed()
                }

                ReaderEvent.EventType.SE_INSERTED -> {
                    //PO detected but AID didn't match with AID set

                    //Notifying Keyple that we handled event
                    (poReader as ObservableReader).notifySeProcessed()
                }

                ReaderEvent.EventType.SE_REMOVED -> {
                    //Action when SE is Removed
                }

                ReaderEvent.EventType.TIMEOUT_ERROR -> {
                    //Action when timeout with SE
                }
            }
        }
    }
}
```

#### Launch detection

```kotlin
   /* Prepare a Calypso PO selection */
   val seSelection = SeSelection(MultiSeRequestProcessing.FIRST_MATCH)
   
    /* Calypso selection: configures a PoSelector with all the desired attributes to make the selection and read additional information afterwards */
   val poSelectionRequest = PoSelectionRequest(PoSelector.builder()
        .seProtocol(SeCommonProtocols.PROTOCOL_ISO14443_4)
        .aidSelector(SeSelector.AidSelector.builder().aidToSelect(CalypsoClassicInfo.AID).build())
        .invalidatedPo(PoSelector.InvalidatedPo.REJECT).build())

    /* Prepare the reading order */
    poSelectionRequest.prepareReadRecordFile(CalypsoClassicInfo.SFI_EnvironmentAndHolder, CalypsoClassicInfo.RECORD_NUMBER_1.toInt())

    /*
     * Add the selection request to the current selection (we could have added other request
     * here)
     */
    seSelection.prepareSelection(poSelectionRequest)

    /*
    * Provide the SeReader with the selection operation to be processed when a PO is
    * inserted.
    */
    (poReader as ObservableReader).setDefaultSelectionRequest(seSelection.selectionOperation,
        ObservableReader.NotificationMode.MATCHED_ONLY)

    // notify reader that se detection has been launched
    poReader.startSeDetection(ObservableReader.PollingMode.REPEATING)
```



#FAQ:

When should I use the Selection API instead of SeProxy API?