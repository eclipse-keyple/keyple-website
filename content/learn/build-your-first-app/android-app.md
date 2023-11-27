---
title: Build your first Android application
linktitle: Android
summary: This guide describes how to start a ticketing application using Keyple and Android NFC plugin to read the content of a Calypso card.
type: book
toc: true
weight: 2
---

---
## Overview

The development of an Android application based on Keyple follows the same principles as those exposed in the Java part.

However, this guide points out the specificities of this environment based on the **Android NFC application** example provided in the [keyple-java-example](https://github.com/eclipse/keyple-java-example) repository.

We recommend that Android application developers clone this example to better understand how Keyple works on Android.

{{% callout warning %}}  
The application available in the example repository requires: 
* a retail Device with NFC powered by android.nfc library (integrated into standard Android SDK),
* Android OS 19+,
* a Calypso card (contactless smart card, NFC mobile phone with a Calypso applet or application).
{{% /callout %}}

It uses three main components of Keyple:
* [Keyple Service Java Library]({{< relref "/components/core/" >}})
  which is the base component to which all the others refer,
* [Keyple Card Generic]({{< relref "/components/card-extensions/keyple-card-generic-lib" >}})
  add-on to handle the commands sent to the Calypso card,
* [Keyple Plugin Android NFC]({{< relref "/components/standard-reader-plugins/keyple-plugin-android-nfc-lib" >}})
  add-on to provide the ability to drive the NFC reader.

[Gradle](https://gradle.org/) is used as build automation tool, but it is easy to transpose these explanations to another tool
such as Maven for example.

---
## Project setup

The dependencies to be imported into the project are accessible with the [configuration wizard]({{< relref "/components/overview/configuration-wizard" >}}).

Depending on the nature of the hardware resources required, it is necessary to declare certain permissions in the project manifest file.
In the case of the Android NFC example, access to NFC functions is declared as follows:
{{< code lang="xml" >}}
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    ...
    <uses-permission android:name="android.permission.NFC" />
    <uses-feature android:name="android.hardware.nfc" android:required="true" />
    ...
    <application ...>
        ...
        <activity ... >
            ...
            <intent-filter>
                <action android:name="android.nfc.action.TECH_DISCOVERED" />
            </intent-filter>
            <meta-data
                    android:name="android.nfc.action.TECH_DISCOVERED"
                    android:resource="@xml/tech_list" />
        </activity>
    </application>
</manifest>
{{< /code >}}

You will have to adapt this section according to the reader plugin used.

---
## Focus on Keyple specific code

{{< code lang="kotlin" >}}
...
class MainActivity : AppCompatActivity(), CardReaderObserverSpi, CardReaderObservationExceptionHandlerSpi {

  private lateinit var reader: ObservableCardReader
  private lateinit var cardSelectionManager: CardSelectionManager
  private val readerApiFactory: ReaderApiFactory =
      SmartCardServiceProvider.getService().readerApiFactory
  private var calypsoExtensionService = CalypsoExtensionService.getInstance()
  private val calypsoCardApiFactory: CalypsoCardApiFactory =
      calypsoExtensionService.getCalypsoCardApiFactory()

    override fun onCreate(savedInstanceState: Bundle?) {
        ...
        // Retrieve the NFC reader
        val plugin =
            SmartCardServiceProvider.getService()
                .registerPlugin(AndroidNfcPluginFactoryProvider(this).getFactory())
        reader = plugin.getReader(AndroidNfcReader.READER_NAME) as ObservableCardReader
        reader.setReaderObservationExceptionHandler(this)
        reader.addObserver(this)
        (reader as ConfigurableCardReader).activateProtocol(
            AndroidNfcSupportedProtocols.ISO_14443_4.name, "ISODEP")
        ...
        // Configure the card selection
        cardSelectionManager = readerApiFactory.createCardSelectionManager()
    
        // Create a generic ISO selector
        val cardSelector =
            readerApiFactory.createIsoCardSelector().filterByDfName(CalypsoConstants.KEYPLE_KIT_AID)
    
        // Create a specific Calypso card selection extension
        val calypsoCardSelectionExtension =
            calypsoCardApiFactory.createCalypsoCardSelectionExtension().acceptInvalidatedCard()
    
        cardSelectionManager.prepareSelection(cardSelector, calypsoCardSelectionExtension)
        ...
        // Start the card detection
        cardSelectionManager.scheduleCardSelectionScenario(
            reader, ObservableCardReader.NotificationMode.ALWAYS)
    
        reader.startCardDetection(ObservableCardReader.DetectionMode.REPEATING)
        ...
    }

    override fun onDestroy() {
        ...
        SmartCardServiceProvider.getService().unregisterPlugin(AndroidNfcPlugin.PLUGIN_NAME)
    }
    
    override fun onReaderEvent(readerEvent: CardReaderEvent?) {
        CoroutineScope(Dispatchers.Main).launch {
          readerEvent?.let { event ->
            when (event.type) {
              CardReaderEvent.Type.CARD_INSERTED -> {
                // handle card inserted event
                ...
                reader.finalizeCardProcessing()
              }
              CardReaderEvent.Type.CARD_MATCHED -> {
                // handle card matched event
                ...
                reader.finalizeCardProcessing()
              }
              CardReaderEvent.Type.CARD_REMOVED -> {
                // handle card removed event
                ...
              }
              else -> {
                // Handle other event types if necessary
              }
            }
          }
          ...
        }
    }

    override fun onReaderObservationError(contextInfo: String?, readerName: String?, e: Throwable?) {
        // Handle the error
        ...
    }
}
{{< /code >}}

---
## FAQ

#### How to fix "_More than one file was found with OS independent path 'META-INF/NOTICE.md'_".

Add lines below to your :app build.gradle file

{{< code lang="kotlin" >}}
android {
    packagingOptions {
        exclude 'META-INF/NOTICE.md'
    }
}
{{< /code >}}