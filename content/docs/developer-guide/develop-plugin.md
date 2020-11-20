---
title: Develop a Plugin
type: book
toc: true
draft: false
weight: 330
---

## Overview
In order to provide an easy way to port a Keyple applications from a device with a specific card reader to another, a plugin system
as been developed. When a developer wants to include Keyple features within his project, he has to initialize the SmartCardService by providing a
plugin Factory available with in the plugin library. The plugin to use depends on the targeted device and running environment.

For example, for an android device with native NFC we'll use KeypleAndroidNfcPlugin.

```gradle
implementation 'org.eclipse.keyple:keyple-android-plugin-nfc:$keyple_version'
```

```kotlin
SmartCardService.getInstance().registerPlugin(AndroidNfcPluginFactory())
```

Keyple is already provided with various plug-ins ready to use. For example Android NFC or PC/SC reader plugins.

But users of the Keyple API may need to use it on new hardware not covered with existing plugins. In this case, a new 
one must be developed. 

The purpose of this guide is to support developers in this process.

## Class diagram of plugin package

For the record, this is a wide view of classes implied in the plugin system. It is designed to natively handle as much 
use cas as possible while being easy to use. It results of several internal classes, however, plugin's developers will 
only have to use a few part of this elements.

{{< figure library="true" src="plugin-development/class/Plugin_Class_Full.png" title="" >}} 

## Steps
Plugin's development relies on 3 main steps, each one consists in implementing a few set of abstract classes and interfaces of
plugin package from Keyple Core API:
1. Import Keyple dependency
1. Implement a Keyple Reader
1. Implement a Keyple Plugin
1. Implement a Keyple Plugin Factory.


## Imports 
Your plugin will use be based upon Keyple Core libraries:

```gradle
implementation "org.eclipse.keyple:keyple-java-core:$keyple_version"
```

## Implement Keyple Reader
The first step of a Keyple plugin development is the implementation of Keyple Reader Interface (org.eclipse.keyple.core.Reader). 
This implementation should use device's native smartcard reader library (or sdk package) to map interfaces used by Keyple API. 

This implementation of a local reader must be done through the extension of one of three abstract classes provided within the Keyple API. The choice depends
on expected behaviour of the reader:
* **AbstractLocalReader**: Basic abstract class to use for local reader implementation.
* **AbstractObservableLocalReader**: extends AbstractLocalReader and is used to manage the matter of observing card events in the case of a local reader 
(ie: card insertion, card removal..).
* **AbstractObservableLocalAutonomousReader**: extends AbstractObservableLocalReader and is used to allow the reader implementation to 
call back the core when card insertion and removal events occurs.

{{< figure library="true" src="plugin-development/class/AbstractReaders_Class.png" title="" >}} 

Once chosen, the Abstract class must be extended by the new reader class and abstract methods must be implemented. Please refer to your native reader
documentation to implement this elements.

### Implementation of AbstractLocalReader's abstract classes 

Relying on the native smartcard reader of the device, implementations to be done are:

| Method to implement| Description                       
|---------------------------------|------------------------------------
|**boolean checkCardPresence()**|Verify the presence of the card
|**byte[] getATR()**|provides the information retrieved when powering up the card
|**openPhysicalChannel()**|Attempts to open the physical channel
|**closePhysicalChannel()**|Attempts to close the current physical channel
|**boolean isPhysicalChannelOpen()**|Tells if the physical channel is open or not
|**boolean isCurrentProtocol(String readerProtocolName)**|Tells if the current card communicates with the protocol provided as an argument
|**byte[] transmitApdu(byte[] apduIn)**|Transmits a single APDU and receives its response. Both are in the form of an array of bytes.
|**activateReaderProtocol(String readerProtocolName)**|Activates the protocol provided from the reader's implementation point of view.
|**deactivateReaderProtocol(String readerProtocolName)**|Deactivates the protocol provided from the reader's implementation point of view.
|**isContactless()**|Tells if the current card communication is contactless.

Example of implementations are provided [here](#abstractlocalreader).

### Implementation of AbstractObservableLocalReader's abstract classes 

In addition of AbstractLocalReader's methods, specific implementations to be done are:

#### Methods
| Method to implement| Description                       
|---------------------------------|------------------------------------
|**void onStartDetection()**|Called when the card detection is started by the Keyple Plugin
|**void onStopDetection()**|called when the card detection is stopped by the Keyple Plugin

Beside the implementation of this methods, this observable reader's notification behaviour must be set.

#### Observable reader's notification
Observable reader's notification behaviour is set up by implementing interfaces inheriting from ObservableReaderNotifiers. 
Developer has to choose how the reader should behave regarding its native abilities. It may involve a few more methods to implement. 

{{< figure library="true" src="plugin-development/class/ObservableReaderNotifiers_Interfaces.png" title="" >}} 

It is __mandatory__ to implement one, and only one, interface of each use case presented in the related columns in the below
table. 

| Card Insertion                  | Card Removal                       | Card Processing                             
|---------------------------------|------------------------------------|-------------------------------------
| WaitForCardInsertionAutonomous  | WaitForCardRemovalAutonomous       | WaitForCardRemovalDuringProcessing
| WaitForCardInsertionBlocking    | WaitForCardRemovalBlocking         | DontWaitForCardRemovalDuringProcessing
| WaitForCardInsertionNonBlocking | WaitForCardRemovalNonBlocking      | ---


Description of the Insertion/Removal behaviours:
|Type| Description                                                                                                                                                                         |
|----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **[*]Autonomous**     | Interface to be implemented by readers that have a fully integrated management of card  communications for card insertion/removal detection                                         |
| **[*]Blocking**      | Interface to be implemented by readers that are autonomous in the management of waiting for the  insertion/removal of a card and that provide a method to wait for it indefinitely. |
| **[*]Non Blocking**   | Interface to be implemented by readers that require an active process to detect the card insertion /removal.                                                                        |

Description of the processing behaviours:
|Type| Description                                                                                                                                                                         |
|----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **WaitForCardRemovalDuringProcessing** |  Interface to be implemented by readers __able__ to detect a card __removal__ during processing,  between two APDU commands.      
| **DontWaitForCardRemovalDuringProcessing** |  Interface to be implemented by readers __not able__ to detect a card __removal__ during processing,  between two APDU commands.      
                                                           |
Example of implementations are provided [here](#abstractobservablelocalreader).

### Implementation of AbstractObservableLocalAutonomousReader's abstract classes 

In addition of AbstractObservableLocalReader's methods and ObservableReaderNotifiers implementation, specific methods calls must be done:

| Method to call| Description                       
|---------------------------------|------------------------------------
|**void onCardInserted()**|This method must be called when a card is inserted to.
|**void onCardRemoved()**|This method must be called when a card is removed.

Example of implementations are provided [here](#abstractobservablelocalautonomousreader).

## Implement Keyple Plugin
The next step of Keyple plugin development is the implementation of Keyple Plugin Interface (org.eclipse.keyple.core.service.Plugin).
The plugin will provide access to the readers and handle their lifecycle.

As well as Reader's implementation, abstract classes to extend and interfaces to implement will depend on native abilities of the device.

This implementation of a plugin must be done through the extension of one of three abstract classes provided within the Keyple API. 
The choice depends on expected behaviour of the plugin:

* **AbstractPlugin**: Basic class for plugin implementation.
* **AbstractObservablePlugin**: This class provides the means to observe a plugin(insertion/removal of readers).
* **AbstractThreadedObservablePlugin**: This class provides the means to observe a plugin(insertion/removal of readers) using a monitoring thread.

{{< figure library="true" src="plugin-development/class/AbstractPlugins_Class.png" title="" >}} 

### Implementation of AbstractPlugin's abstract classes 
#### initNativeReaders()

| Method to implement| Description                       
|---------------------------------|------------------------------------
|**ConcurrentMap<String, Reader> initNativeReaders()**|This method is called when registering a plugin. It should be implemented to init readers map.

Example of implementations are provided [here](#initnativereaders-1).

### Implementation of AbstractObservablePlugin's abstract classes 
There is no additional methods to implement compared to AbstractPlugin

### Implementation of AbstractThreadedObservablePlugin's abstract classes 
In addition of AbstractObservablePlugin's methods and ObservableReaderNotifiers implementation, specific methods calls must be done:

| Method to implement| Description                       
|---------------------------------|------------------------------------
|**SortedSet<String> fetchNativeReadersNames()**|This method  Fetch the list of connected native reader (usually from third party library) and returns their names (or id)
|**Reader fetchNativeReader(String name)**|Fetch connected native reader (from third party library) by its name returns the current AbstractReader if it is already listed. Creates and returns a new AbstractReader if not.

Example of implementations are provided [here](#abstractthreadedobservableplugin).

### Implementation of AbstractPluginFactory's abstract classes 
The last step is to implement the Plugin factory which is going to be use by Keyple core to handle the plugin.

| Method to implement| Description                       
|---------------------------------|------------------------------------
|**String getPluginName()**|  Retrieve the name of the plugin that will be instantiated by this factory (can be static or dynamic)
|**Plugin getPlugin()**|Retrieve an instance of a plugin (can be a singleton)

Example of implementations are provided [here](#abstractthreadedobservableplugin).

## Examples of implementation
### AbstractLocalReader
#### checkCardPresence()
Allow Keyple to check if the secure elements is present within the reader (inserted, in NFC field...)

OMAPI Example
```kotlin
//nativeReader is an instance of android.se.omapi.Reader. It natively provides a method to check Card presence.
override fun checkCardPresence(): Boolean {
    return nativeReader.isSecureElementPresent
}
```

Android NFC Example
```kotlin
//When a SE is presented in the NFC field, we can get a tagproxy object. When the SE is removed, 
//this value is reinited. So when it is not null, we can assume the SE is currently in the field.
//The presence information is not directly available be we can find a way to implement checkCardPresence()
public override fun checkCardPresence(): Boolean {
    return tagProxy != null
}
```

PC/SC Example
```java
public override fun checkCardPresence(): Boolean {
    //Terminal is an instance of CardTerminal provided by javax.smartcardio
    return terminal.isCardPresent();
}
```

#### getAtr()
OMAPI Exemple
```kotlin
override fun getATR(): ByteArray? {
    //Session is a native object of android.se.omapi package
    return session?.let {
        it.atr
    }
}
```

Android NFC Example
```kotlin
public override fun getATR(): ByteArray? {
    //TagProxy is an object mapping android.nfc.tech.TagTechnology. Atr is obtained from data of this object (depending of protocol)
    val atr = tagProxy?.atr
    return if (atr?.isNotEmpty() == true) atr else null
}
```

PC/SC Example
```java
public override fun checkCardPresence(): Boolean {
    //Card is an instance of card provided by javax.smartcardio
    return return card.getATR().getBytes();;
}
```
#### openPhysicalChannel()
OMAPI Exemple
```kotlin
@Throws(KeypleReaderIOException::class)
override fun openPhysicalChannel() {
    try {
        //nativeReader is an instance of import android.se.omapi.Reader
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
    //TagProxy is a wrapper we created in the plugin
    //To handle android.nfc.Tag
    if (tagProxy?.isConnected != true) {
        try {
            tagProxy?.connect()
        } catch (e: IOException) {
            throw KeypleReaderIOException("Error while opening physical channel", e)
        }
    }
}
```

PC/SC Example
```java
public override fun checkCardPresence(): Boolean {
    //card is an instance of Card provided by javax.smartcardio
    if (card == null) {
        this.card = this.terminal.connect(parameterCardProtocol);
        } else {
          logger.debug("[{}] Opening of a card physical channel in shared mode.", this.getName());
        }
      }
    //CardChannel is an instance of card provided by javax.smartcardio
    this.channel = card.getBasicChannel();
}
```

#### closePhysicalChannel()
OMAPI Exemple
```kotlin
override fun closePhysicalChannel() {
    //openChannel is an instance of android.se.omapi.Channel
    openChannel?.let {
        it.session.close()
        openChannel = null
    }
}
```

Android NFC Example
```kotlin
@Throws(KeypleReaderIOException::class)
public override fun closePhysicalChannel() {
    try {
        //TagProxy is a wrapper we created in the plugin
        //To handle android.nfc.Tag
        tagProxy?.close()
    } catch (e: IOException) {
        throw KeypleReaderIOException("Error while closing physical channel", e)
    } finally {
        tagProxy = null
    }
}
```

PC/SC Example
```java
protected void closePhysicalChannel() {
    try {
     //card is an instance of Card provided by javax.smartcardio
      if (card != null) {
        channel = null;
        card.disconnect(true);
        card = null;
      }
    } catch (CardException e) {
      throw new KeypleReaderIOException("Error while closing physical channel", e);
    }
}
```

#### isPhysicalChannelOpen()
OMAPI Exemple
```kotlin
    override fun isPhysicalChannelOpen(): Boolean {
        //Session is an instance of android.se.omapi.Session
        return session?.isClosed == false
    }
```

Android NFC Example
```kotlin
    public override fun isPhysicalChannelOpen(): Boolean {
        //TagProxy is a wrapper we created in the plugin
        //To handle android.nfc.Tag
        return tagProxy?.isConnected == true
    }
```

PC/SC Example
```java
protected void closePhysicalChannel() {
    try {
     //card is an instance of Card provided by javax.smartcardio
      if (card != null) {
        channel = null;
        card.disconnect(true);
        card = null;
      }
    } catch (CardException e) {
      throw new KeypleReaderIOException("Error while closing physical channel", e);
    }
}
```

#### transmitApdu(byte[] apduIn)
OMAPI Exemple
```kotlin
    override fun transmitApdu(apduIn: ByteArray): ByteArray {
        // Initialization
        Timber.d("Data Length to be sent to tag : " + apduIn.size)
        Timber.d("Data in : " + ByteArrayUtil.toHex(apduIn))
        var dataOut = byteArrayOf(0)
        try {
            openChannel.let {
                dataOut = it?.transmit(apduIn) ?: throw IOException("Channel is not open")
            }
        } catch (e: IOException) {
            throw KeypleReaderIOException("Error while transmitting APDU", e)
        }

        Timber.d("Data out : " + ByteArrayUtil.toHex(dataOut))
        return dataOut
    }
```

Android NFC Example
```kotlin
    public override fun transmitApdu(apduIn: ByteArray): ByteArray {
        Timber.d("Send data to card : ${apduIn.size} bytes")
        return with(tagProxy) {
            if (this == null) {
                throw KeypleReaderIOException(
                        "Error while transmitting APDU, invalid out data buffer")
            } else {
                try {
                    val bytes = transceive(apduIn)
                    if (bytes.size <2) {
                        throw KeypleReaderIOException(
                                "Error while transmitting APDU, invalid out data buffer")
                    } else {
                        Timber.d("Receive data from card : ${ByteArrayUtil.toHex(bytes)}")
                        bytes
                    }
                } catch (e: IOException) {
                    throw KeypleReaderIOException(
                            "Error while transmitting APDU, invalid out data buffer", e)
                } catch (e: NoSuchElementException) {
                    throw KeypleReaderIOException("Error while transmitting APDU, no such Element", e)
                }
            }
        }
    }
```

PC/SC Example
```java
protected byte[] transmitApdu(byte[] apduIn) {
    ResponseAPDU apduResponseData;
    
    if (channel != null) {
      try {
        apduResponseData = channel.transmit(new CommandAPDU(apduIn));
      } catch (CardException e) {
        throw new KeypleReaderIOException(this.getName() + ":" + e.getMessage());
      } catch (IllegalArgumentException e) {
        // card could have been removed prematurely
        throw new KeypleReaderIOException(this.getName() + ":" + e.getMessage());
      }
    } else {
      // could occur if the card was removed
      throw new KeypleReaderIOException(this.getName() + ": null channel.");
    }

return apduResponseData.getBytes();
}
```

#### activateReaderProtocol(String readerProtocolName)
OMAPI Exemple
```kotlin
    override fun activateReaderProtocol(readerProtocolName: String?) {
        // do nothing as protocol ils not relevant for contact PO
    }
```

Android NFC Example
```kotlin
    override fun activateReaderProtocol(readerProtocolName: String?) {
    
        if (!protocolsMap.containsKey(readerProtocolName)) {
            //we map the requested protocol to a custom android protocol
            protocolsMap.put(readerProtocolName!!, AndroidNfcProtocolSettings.getSetting(readerProtocolName!!)!!)
        }
    }
```

PC/SC Example
```java
  protected void activateReaderProtocol(String readerProtocolName) {
    if (!PcscProtocolSetting.getSettings().containsKey(readerProtocolName)) {
      throw new KeypleReaderProtocolNotSupportedException(readerProtocolName);
    }
  }
```

#### deactivateReaderProtocol(String readerProtocolName)
OMAPI Exemple
```kotlin
    override fun deactivateReaderProtocol(readerProtocolName: String?) {
        // do nothing
    }
```

Android NFC Example
```kotlin
    override fun deactivateReaderProtocol(readerProtocolName: String?) {
        if (protocolsMap.containsKey(readerProtocolName)) {
            protocolsMap.remove(readerProtocolName)
        }
        Timber.d("${getName()}: Deactivate protocol $readerProtocolName.")
    }
```

PC/SC Example
```java
  protected void deactivateReaderProtocol(String readerProtocolName) {
    if (!PcscProtocolSetting.getSettings().containsKey(readerProtocolName)) {
      throw new KeypleReaderProtocolNotSupportedException(readerProtocolName);
    }

    if (logger.isDebugEnabled()) {
      logger.debug("{}: Deactivate protocol {}.", getName(), readerProtocolName);
    }
  }
```


#### isCurrentProtocol(String readerProtocolName)
OMAPI Exemple
```kotlin
    override fun isCurrentProtocol(readerProtocolName: String?): Boolean {
        return AndroidOmapiSupportedProtocols.ISO_7816_3.name == readerProtocolName
    }
```

Android NFC Example
```kotlin
    override fun isCurrentProtocol(readerProtocolName: String?): Boolean {
        return readerProtocolName == null || protocolsMap.containsKey(readerProtocolName) && protocolsMap[readerProtocolName] == tagProxy?.tech
    }
```

PC/SC Example
```java
  protected boolean isCurrentProtocol(String readerProtocolName) {
    String protocolRule = PcscProtocolSetting.getSettings().get(readerProtocolName);
    String atr = ByteArrayUtil.toHex(card.getATR().getBytes());
    return Pattern.compile(protocolRule).matcher(atr).matches();
  }
```

#### isContactless()
OMAPI Exemple
```kotlin
    override fun isContactless(): Boolean {
        //OMAPI is a contact Reader
        return false
    }
```

Android NFC Example
```kotlin
    override fun isContactless(): Boolean {
        //NFC is a contactless Reader
        return true
    }
```

PC/SC Example
```java
  public boolean isContactless() {
    //isContactless is a custom variable that can be set by the plugin 
    //as PC/SC can be a contactless or contact reade.
    if (isContactless == null) {
      /* First time initialisation, the transmission mode has not yet been determined or fixed explicitly, let's ask the plugin to determine it (only once) */
      isContactless =
          ((AbstractPcscPlugin) SmartCardService.getInstance().getPlugin(getPluginName()))
              .isContactless(getName());
    }
    return isContactless;
  }
```

### AbstractObservableLocalReader
#### onStartDetection()
Android NFC Example
```kotlin
    override fun onStartDetection() {
        // When Keyple Core starts detection, we have to use native Android NFC adapter to start nfc scanning
        if (contextWeakRef.get() == null) {
            throw IllegalStateException("onStartDetection() failed : no context available")
        }

        if (nfcAdapter == null) {
            nfcAdapter = NfcAdapter.getDefaultAdapter(contextWeakRef.get()!!)
        }
        val flags = flags
        val options = options
        nfcAdapter?.enableReaderMode(contextWeakRef.get(), this, flags, options)
    }
```

PC/SC Example
```java
  protected void onStartDetection() {
    //TODO: completion
  }
```

#### onStopDetection()
Android NFC Example
```kotlin    
    override fun onStopDetection() {
         /When keyple core stop detection, we call native adapter stop NFC scanning
         nfcAdapter?.let {
             if (contextWeakRef.get() != null) {
                 it.disableReaderMode(contextWeakRef.get())
             } else {
                 throw IllegalStateException("onStopDetection failed : no context available")
             }
         }
    }
```

PC/SC Example
```java
  protected void onStopDetection() {
    //TODO: completion
  }
```


### ObservableReaderNotifiers
Android NFC Example
```kotlin
    //Note simplified view of Android NFc implementation
    class AndroidNfcReader(activity: Activity) :
        //In android NFC, we want an easy way to callback Keyple Core when a card is inserted
        //because this event occurs through the native layer.
        AbstractObservableLocalAutonomousReader( 
            AndroidNfcReader.PLUGIN_NAME,
            AndroidNfcReader.READER_NAME
        ),
        //Our reader have an integrated management of card insertion detection
        WaitForCardInsertionAutonomous,
        //Our reader do not have an integrated management of card removal detection
        //but we can use it when the card is no longer in the field and trigger a removal event
        WaitForCardRemovalBlocking,
        //We do not want to catch card removal between exchanges with it
        DontWaitForCardRemovalDuringProcessing{}
```

PC/SC Example
```java
     //We want to observe card events like insertion, removal...
    class AbstractPcscReader extends bstractObservableLocalReader implements PcscReader, 
        //Our native reader do not have an integrated management of card insertion detection
        //but we can use it when the card is in the field and trigger an insertion event
        WaitForCardInsertionBlocking, 
        //We want to detect when card is removed while exchanging data with our reader
        WaitForCardRemovalDuringProcessing, 
        //Our native reader do not have an integrated management of card removal detection
        //but we can use it when the card is no longer in the field and trigger a removal event
        WaitForCardRemovalBlocking {}
```

### AbstractObservableLocalAutonomousReader
#### onCardInserted()
Android NFC Example
```kotlin
    //Note simplified view of Android NFc implementation
    override fun onTagDiscovered(tag: Tag?) {
        tag?.let {
            try {
                tagProxy = TagProxy.getTagProxy(tag)
                //onTagDiscovered is triggered natively
                //we use below code to forward the information to Keyple core
                onCardInserted()
            } catch (e: KeypleReaderException) {
                Timber.e(e)
            }
        }
    }
```
#### onCardRemoved()

### AbstractPlugin
#### initNativeReaders()
OMAPI Exemple
```kotlin
    override fun initNativeReaders(): ConcurrentSkipListMap<String, Reader> {
        val readers = ConcurrentSkipListMap<String, Reader>()
        //seService is an instance of android.se.omapi.SEService
        seService?.readers.forEach { nativeReader ->
            //mapToReader creates an instance of our Keyple reader from a native reader
            val reader = mapToReader(nativeReader)
            readers[reader.name] = reader
        }
        return readers
    }
```

Android NFC Example
```kotlin
    override fun initNativeReaders(): ConcurrentMap<String, Reader>? {
        val readers = ConcurrentHashMap<String, Reader>()
        //AndroidNfcReaderImpl is our implementation of Keyple reader
        readers[AndroidNfcReader.READER_NAME] = AndroidNfcReaderImpl(activity)
        return readers
    }
```

PC/SC Example
```java
  protected Map<String, Reader> initNativeReaders() {
    ConcurrentMap<String, Reader> nativeReaders = new ConcurrentHashMap<String, Reader>();
    //CardTerminal is a a class from javax.smartcardio
    CardTerminals terminals = getCardTerminals();
    try {
      for (CardTerminal terminal : terminals.list()) {
        final PcscReader pcscReader = createReader(this.getName(), terminal);
        nativeReaders.put(pcscReader.getName(), pcscReader);
      }
    } catch (CardException e) {
    }
    return nativeReaders;
  }
```

### AbstractThreadedObservablePlugin
#### fetchNativeReadersNames()
PC/SC Example
```kotlin
  public SortedSet<String> fetchNativeReadersNames() {

    SortedSet<String> nativeReadersNames = new ConcurrentSkipListSet<String>();
    CardTerminals terminals = getCardTerminals();
    try {
      for (CardTerminal terminal : terminals.list()) {
        nativeReadersNames.add(terminal.getName());
      }
    } catch (CardException e) {
    }
    return nativeReadersNames;
  }
```
#### fetchNativeReader()
PC/SC Example
```java
  protected Reader fetchNativeReader(String name) {

    // return the current reader if it is already listed
    Reader reader = readers.get(name);
    if (reader != null) {
      return reader;
    }
    /* parse the current PC/SC readers list to create the ProxyReader(s) associated with new reader(s) */
    CardTerminals terminals = getCardTerminals();
    try {
      for (CardTerminal terminal : terminals.list()) {
        if (terminal.getName().equals(name)) {
          reader = createReader(this.getName(), terminal);
        }
      }
    } catch (CardException e) {
      throw new KeypleReaderIOException("Could not access terminals list", e);
    }
    if (reader == null) {
      throw new KeypleReaderNotFoundException("Reader " + name + " not found!");
    }
    return reader;
  }
```

### PluginFactory
#### getPluginName()
Android NFC Example
```kotlin
    override fun getPluginName(): String {
        return AndroidNfcPlugin.PLUGIN_NAME
    }
```

PC/SC Example
```java
  public String getPluginName() {
    return PLUGIN_NAME;
  }
```

#### getPlugin()
Android NFC Example
```kotlin
    override fun getPlugin(): Plugin {
        return AndroidNfcPluginImpl(activity)
    }
```

PC/SC Example
```java
    public PcscPlugin getPlugin() {
    try {
      if (isOsWin) {
        return PcscPluginWinImpl.getInstance();
      } else {
        return PcscPluginImpl.getInstance();
      }
    } catch (Exception e) {
      throw new KeyplePluginInstantiationException("Can not access smartcard.io readers", e);
    }
    }
```