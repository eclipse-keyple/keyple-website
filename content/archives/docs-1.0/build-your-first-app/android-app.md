---
title: Build your first Android application
linktitle: Android
summary: This guide describes how to start a ticketing application using Keyple SDK and Android NFC plugin to read the content of a Calypso Portable Object.
type: book
toc: true
draft: false
weight: 220
---
{{% callout warning %}}
Version 1.0 of the documentation is no longer actively maintained. The site that you are currently viewing is an archived snapshot. For up-to-date documentation, see the latest version.
{{% /callout %}}

## Introduction 
### Overview
**Since Keyple is supported by the Android operating system, developers can take advantage of this quick and easy way to implement solution to provide SmartCard communication functionalities in their own mobile application.**
 
For example, Keyple could be used to facilitate the development of a ticketing application based on the use of conteners on a SIM card and relying on [Android SE OMAPI](https://developer.android.com/reference/android/se/omapi/package-summary). 
Keyple could also be used to develop an application reading SmartCard content through NFC using [Android NFC](https://developer.android.com/guide/topics/connectivity/nfc/advanced-nfc).

{{< figure src="/media/archive-1.0/android-app/component/Android_App_Overview.png" title="" >}} 
 
As Keyple request low-level reader access, the key features of Keyple SDK relies on components called **Plugins**. These are the plugins that allow access to the hardware functionality of the terminal by using the native Android SDK or the terminal manufacturer's own custom SDKs. 

This guide will describe how to start a ticketing application using Keyple SDK and Android NFC plugin to read the content of a Calypso SmartCard. As we want to focus on Keyple integration, the Android application architecture will remain the simplest as possible.

### What to we need for this guide?

* Retail Device with NFC powered by android.nfc library (integrated into standard Android SDK).
* Android OS 19+
* A NFC SmartCard with Calypso PO

---
## Integration
### Application setup

Like for any other Android NFC Application, we need to declare items in the application manifest. 
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    ...
    <uses-permission android:name="android.permission.NFC" />
    <uses-feature android:name="android.hardware.nfc" android:required="true" />
    ...
</manifest>
```

Also make sure your minSdkVersion is at least 19.

### SDK Integration
#### Keyple Core 

This high-level API is convenient for developers implementing smart card processing application for terminal interfaced 
with smart card readers. Access to the readers is provided by the plugins. 

To use Keyple core API (and in fact, anything keyple's related) import the jar within the gradle dependencies of your 
Android application.

```gradle
implementation "org.eclipse.keyple:keyple-java-core:$keyple_version"
```

Please refer to Architecture/Keyle Core

#### Keyple Plugins

There are many Keyple plugins available, the one to use depends on the device and ticketing tools you are aiming to 
use.

To use the NFC plugin simply import it within the gradle dependencies of your Android application.

```gradle
implementation "org.eclipse.keyple:keyple-android-plugin-nfc:$keyple_version"
```

#### Keyple Calypso

The Keyple Calypso User API is an extension of the Keyple Core User API to manage Calypso Portable Objects.

Please refer to Architecture/Keyle Calypso

To use Keyple Calypso User API simply import the jar within the gradle dependencies of your Android application.

```gradle
implementation "org.eclipse.keyple:keyple-java-calypso:$keyple_version"
```

---
## Let's code
### Initializing the SDK
#### Register a plugin

In order to setup Keyple, we need to register at least one plugin. Here we register our NFC plugin. To do so, we use the singleton SmartCardService and the plugin Factory. (See plugin development guide to know more about plugins)

```kotlin
override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    /* register Android NFC Plugin to the SmartCardService */
    try {
        val readerObservationExceptionHandler = ReaderObservationExceptionHandler { pluginName, readerName, e ->}
        SmartCardService.getInstance().registerPlugin(AndroidNfcPluginFactory(this, readerObservationExceptionHandler))
    }catch (e: KeypleException){
        /* do something with it */
    }
}
```

Note: Plugins Factory's initialisation could request more steps to execute before passing it to registerPlugin(). It depends on plugins, please check the documentation or usage example of desired plugin.

#### Unregister a plugin

Clean resources.

```kotlin
override fun onDestroy() {
    ...
    /* Unregister Android NFC Plugin to the SmartCardService */
    SmartCardService.getInstance().unregisterPlugin(AndroidNfcPlugin.PLUGIN_NAME)
    reader = null
    super.onDestroy()
}
```

### Retrieve a specific reader

With the plugin registered we can retrieve all instances of the component mapping the SmartCard readers. Here we want to retrieve the NFC reader.

```kotlin
//We keep a reference to the reader for later use
private lateinit var reader: AndroidNfcReader
...
//PLUGIN_NAME and READER_NAME are constants provided by the used Keyple plugin 
reader = plugin.readers[AndroidNfcReader.READER_NAME] as AndroidNfcReader
```

### Add observer to handle NFC events

When native NFC is activated on an Android device, the OS dispatches insertion events occurring in the NFC detection field. In our application, we need detect it in order to proceed to exchanges with the SmartCard.

```kotlin
//To keep it simple we choose to have our MainActivity implementing ObservableReader.ReaderObserver 
//interface. 
class MainActivity : AppCompatActivity(), ObservableReader.ReaderObserver {
    ...        
    reader.addObserver(this)
    ...
    //Belongs to ObservableReader.ReaderObserver
    //NFC Reader events will be received here.
    //this method is not triggered in UI thread
    override fun update(event: ReaderEvent) {
        if(event.eventType == ReaderEvent.EventType.CARD_INSERTED){
            //We'll select PO when SmartCard is presented in field
            //Method handlePo is described below
            handlePo()
        }
    }
}
```


### Activate a protocol

Before starting to read a NFC tag, you must activate the protocol in which you wish to detect it.
If you do not activate any protocol, no card will be detected by the Keyple library. 

```kotlin
class MainActivity : AppCompatActivity(), ObservableReader.ReaderObserver {
  
  override fun onCreate(savedInstanceState: Bundle?) {
      super.onCreate(savedInstanceState)
      ...
      // with this protocol settings we activate the nfc for ISO1443_4 protocol
      reader.activateProtocol(
            ContactlessCardCommonProtocols.ISO_14443_4.name,
            AndroidNfcProtocolSettings.getSetting(ContactlessCardCommonProtocols.ISO_14443_4.name)
        )
      ...
  }
}
```

### Deactivate a protocol

When your are done with your NFC operations, you can deactivate the NFC protocol :

```kotlin
class MainActivity : AppCompatActivity(), ObservableReader.ReaderObserver {
  
    override fun onDestroy() {
        ...
        //Deactivate nfc for ISO1443_4 protocol
        reader?.deactivateProtocol(ContactlessCardCommonProtocols.ISO_14443_4.name)
        ...
        super.onDestroy()
    }
}
```

Now we have an access to our NFC Reader, we can activate Card Detection.

### Activate Card detection

We will start detection as soon as our application comes in foreground and stop when application go background.

```kotlin
class MainActivity : AppCompatActivity(), ObservableReader.ReaderObserver {
    override fun onResume() {
        super.onResume()
        reader?.let {
            //We choose to continue waiting for a new card persentation
            it.startCardDetection(ObservableReader.PollingMode.REPEATING)
        }
    }
}
```

### Deactivate Card detection

```kotlin
class MainActivity : AppCompatActivity(), ObservableReader.ReaderObserver {
    override fun onPause() {
        reader?.let {
            it.stopCardDetection()
        }
        super.onPause()
    }
}
```

Now we can detect when a SmartCard is presented in the field, we can proceed to card application selection and data reading.

### Handling a Calypso PO

#### Calypso Selection API

With Keyple, PO selection and FCI retrieving can be done using only Keyple Core, but Keyple Calypso API provides specific tools to handle Calypso POs and make the process a bit more simple.

```kotlin
fun handlePo(){
    reader?.let {
        //check if card is in the NFC field
        if(it.isCardPresent){

            //Instanciate class handling card selection service 
            val cardSelectionsService = CardSelectionsService()
            //We only want to select the PO so we choose to close communication channel once 
            //selection is done
            cardSelectionsService.prepareReleaseChannel()

            //We build a selection request managing specific characteristics of Calypso POs
            val poSelection = PoSelection(
                PoSelector
                    .builder()
                    //Smarcard standard protocol
                    .cardProtocol(ContactlessCardCommonProtocols.ISO_14443_4.name)
                    .aidSelector(
                        CardSelector.AidSelector.builder()
                            .aidToSelect(YOUR_AID)  //Set the AID of your Calypso PO
                            //indicates how to carry out the file occurrence in accordance with 
                            //ISO7816-4
                            .fileOccurrence(CardSelector.AidSelector.FileOccurrence.FIRST)
                            //indicates which template is expected in accordance with ISO7816-4
                            .fileControlInformation(
                                CardSelector.AidSelector.FileControlInformation.FCI)
                            .build()
                    ).build())
            cardSelectionsService.prepareSelection(poSelection)

            //Proceed to selection using the reader
            val selectionResult = cardSelectionsService.processExplicitSelections(it)

            runOnUiThread {
                //We check the selection result and read the FCI
                if(selectionResult.hasActiveSelection()){
                    val matchedSmartCard = selectionResult.activeSmartCard
                    val fci = matchedSmartCard.fciBytes
                    Toast.makeText(this, String.format("Selected, Fci %s", 
                        ByteArrayUtil.toHex(fci)), Toast.LENGTH_LONG).show()
                }else {
                    Toast.makeText(this, 
                        String.format("Not selected"), Toast.LENGTH_SHORT).show()
                }
            }
        }
    }
}
```

Now we've seen we can select our PO we can retrieve more data from it.

#### Reading Environment and usage

In the below example we'll read Environment and Usage data of an Hoplink container.

```kotlin
    ...
    //Data related to Hoplink
    val poAid= "A000000291A000000191"
    val sfiHoplinkEFEnvironment = 0x14.toByte()
    val sfiHoplinkEFUsage = 0x1A.toByte()
    ...
    private fun handlePo(){
        ...
        //Prepare the reading order. We'll read the first record of the EF
        //specified by its SFI. This reading will be done within explicit selection.
        poSelection.prepareReadRecordFile(sfiHoplinkEFEnvironment, 1)
        poSelection.prepareReadRecordFile(sfiHoplinkEFUsage, 1)
        ...
        
        //Hoplink is a Calypso PO, we can cast the SmartCard
        //with CalypsoPo class, representing the PO content.
        val calypsoPO = selectionResult.activeSmartCard as CalypsoPo
        val environment = calypsoPO.getFileBySfi(sfiHoplinkEFEnvironment)
        val usage = calypsoPO.getFileBySfi(sfiHoplinkEFUsage)
        Toast.makeText(this, String.format("Environment %s",
            ByteArrayUtil.toHex(environment.data.content)), Toast.LENGTH_SHORT).show()
        Toast.makeText(this, String.format("Usage %s",
            ByteArrayUtil.toHex(usage.data.content)), Toast.LENGTH_SHORT).show()

    }
```

### Full code

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="org.eclipse.keyple.android.quickstart">

    <uses-permission android:name="android.permission.NFC" />

    <uses-feature
        android:name="android.hardware.nfc"
        android:required="true" />

    <application
        android:allowBackup="true"
        android:screenOrientation="portrait"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/AppTheme">
        <activity android:name=".MainActivity">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />

                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>
```

```kotlin
class MainActivity : AppCompatActivity(), ObservableReader.ReaderObserver {

    private var reader: AndroidNfcReader? = null
    val poAid= "A000000291A000000191"
    val sfiHoplinkEFEnvironment = 0x14.toByte()
    val sfiHoplinkEFUsage = 0x1A.toByte()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        try {
            val readerObservationExceptionHandler = ReaderObservationExceptionHandler { pluginName, readerName, e ->}
            val plugin = SmartCardService.getInstance().registerPlugin(AndroidNfcPluginFactory(this, readerObservationExceptionHandler))
            val reader = plugin.readers[AndroidNfcReader.READER_NAME] as AndroidNfcReader
            reader.addObserver(this)
            reader.activateProtocol(
                ContactlessCardCommonProtocols.ISO_14443_4.name,
                AndroidNfcProtocolSettings.getSetting(ContactlessCardCommonProtocols.ISO_14443_4.name)
            )
            this.reader = reader
        }catch (e: KeypleException){
            Timber.e(e)
            Toast.makeText(this, String.format("Error: %s", e.message), Toast.LENGTH_LONG).show()
        }
    }

    override fun onResume() {
        super.onResume()
        reader?.let {
            it.startCardDetection(ObservableReader.PollingMode.SINGLESHOT)
            Toast.makeText(this, String.format("Hunt enabled"), Toast.LENGTH_SHORT).show()
        }
    }

    override fun onPause() {
        reader?.let {
            it.stopCardDetection()
        }
        super.onPause()
    }

    override fun onDestroy() {
        /* Deactivate nfc for ISO1443_4 protocol */
        reader?.deactivateProtocol(ContactlessCardCommonProtocols.ISO_14443_4.name)
        
        /* Unregister Android NFC Plugin to the SmartCardService */
        SmartCardService.getInstance().unregisterPlugin(AndroidNfcPlugin.PLUGIN_NAME)
        reader = null
        super.onDestroy()
    }

    override fun update(event: ReaderEvent) {
        Timber.d("Event: %s", event.eventType.name)
        runOnUiThread {
            Toast.makeText(this, String.format("Event: %s", event.eventType.name),
                Toast.LENGTH_SHORT).show()
        }
        if(event.eventType == ReaderEvent.EventType.CARD_INSERTED){
            handlePo()
        }
    }

    //With Calypso API
    private fun handlePo(){
        reader?.let {
            if(it.isCardPresent){
                val cardSelectionsService = CardSelectionsService()
                cardSelectionsService.prepareReleaseChannel()
                val poSelection = PoSelection(
                        PoSelector
                                .builder()
                                .cardProtocol(ContactlessCardCommonProtocols.ISO_14443_4.name)
                                .aidSelector(
                                        CardSelector.AidSelector.builder()
                                                .aidToSelect(poAid)
                                                .fileOccurrence(
                                                    CardSelector.AidSelector.FileOccurrence.FIRST)
                                                .fileControlInformation(
                                                    CardSelector.AidSelector.FileControlInformation.FCI)
                                                .build()
                                ).build())

                cardSelectionsService.prepareSelection(poSelection)

                //Prepare the reading order. We'll read the first record of the EF
                //specified by his SFI. This reading will be done with selection.
                poSelection.prepareReadRecordFile(sfiHoplinkEFEnvironment, 1)
                poSelection.prepareReadRecordFile(sfiHoplinkEFUsage, 1)

                //Selection and file reading will be done here
                val selectionResult = cardSelectionsService.processExplicitSelections(it)

                runOnUiThread {
                    if(selectionResult.hasActiveSelection()){
                        val matchedSmartCard = selectionResult.activeSmartCard
                        val fci = matchedSmartCard.fciBytes
                        Toast.makeText(this, String.format("Selected, Fci %s",
                            ByteArrayUtil.toHex(fci)), Toast.LENGTH_SHORT).show()

                        //Hoplink is a Calypso PO, we can cast the SmartCard
                        //with CalypsoPo class, representing the PO content.
                        val calypsoPO = selectionResult.activeSmartCard as CalypsoPo
                        val environment = calypsoPO.getFileBySfi(sfiHoplinkEFEnvironment)
                        val usage = calypsoPO.getFileBySfi(sfiHoplinkEFUsage)
                        Toast.makeText(this, String.format("Environment %s",
                            ByteArrayUtil.toHex(environment.data.content)), Toast.LENGTH_SHORT).show()
                        Toast.makeText(this, String.format("Usage %s",
                            ByteArrayUtil.toHex(usage.data.content)), Toast.LENGTH_SHORT).show()
                    }else {
                        Toast.makeText(this, String.format("Not selected"), Toast.LENGTH_SHORT).show()
                    }
                }
            }
        }
    }
}
```

---
## FAQ

**How to fix "More than one file was found with OS independent path 'META-INF/NOTICE.md'."**

Add lines below to your :app build.gradle file 

```gradle
android{
    packagingOptions {
        exclude 'META-INF/NOTICE.md'
    }
}
```

**Where can I see more examples**

Android native plugins are provided with example applications. Check it to see more use cases: [Examples](https://github.com/eclipse/keyple-java/tree/master/java/example)

