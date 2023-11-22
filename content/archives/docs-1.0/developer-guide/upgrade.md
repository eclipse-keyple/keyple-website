---
title: Upgrade from an earlier version of Keyple
linktitle: Upgrade Keyple
type: book
toc: true
draft: false
weight: 350
---
{{% callout warning %}}
Version 1.0 of the documentation is no longer actively maintained. The site that you are currently viewing is an archived snapshot. For up-to-date documentation, see the latest version.
{{% /callout %}}

This guide is intended to help a user of a previous version of Keyple Java to upgrade his application to a new version of the library.

Upgrade from:
* [0.9.0 to 1.0.0](#upgrade-from-090-to-100)
* [0.8.1 to 0.9.0](#upgrade-from-081-to-090)

Note: here we describe the evolutions in broad outline, for the details of the APIs, the reader is invited to consult
the [API reference]({{< ref "../api-reference/_index.md" >}}) section.

---

## Upgrade from 0.9.0 to 1.0.0

### What's changed?
Compared to version 0.9, the goal of Keyple 1.0 is mainly to fix bugs,
add features to make Keyple more robust and rename/reorganize classes to make it easier to learn.

* [Renamings](#class-renaming)
* [Internal exception handling](#internal-exception-handling)
* [PC/SC plugin](#pcsc-plugin)
* [Keyple Distributed](#keyple-distributed)

#### Class renaming

| Module  | Old name (0.9.0) | New name (1.0.0)
|---------|---------|----------
| Keyple Core | SeProxyService | SmartCardService
| Keyple Core | ReaderPlugin | Plugin
| Keyple Core | SeReader | Reader
| Keyple Core | ReaderPoolPlugin | PoolPlugin
| Keyple Core | SeSelection | CardSelectionService
| Keyple Core | SeSelector | CardSelector
| Keyple Core | AbstractMatchingSe | AbstractSmartCard
| Keyple Calypso | PoSelectionRequest | PoSelection
| Keyple Calypso | SamSelectionRequest | SamSelection

#### Internal exception handling

New possibilities have been added in the management of observable objects (*Plugin* and *Reader*).

If the Plugin or Reader is observable, it is now necessary to define exception handlers that will be called by the internal layers of Keyple in the case of an exception raised by an observation process.

Two new interfaces have been added to the *event* package to allow applications via the factories of the concerned plugins to define the method that will be called when needed:
* ```PluginObservationExceptionHandler```
* ```ReaderObservationExceptionHandler```

These handlers are usually provided by the application via the constructor of the plugin's factory.

#### PC/SC plugin
The generic parameterization interface for plugins and readers has been removed in favor of methods specific to each plugin.

In the case of the PC/SC plugin, the following methods have appeared:


| |
|---------|---------
| PcscPlugin | ```setReaderNameFilter```
| PcscPlugin | ```setProtocolIdentificationRule```
| PcscReader | ```setSharingMode```
| PcscReader | ```setContactless```
| PcscReader | ```setIsoProtocol```
| PcscReader | ```setDisconnectionMode```

#### Keyple Distributed
The use of Keyple in a remote context has been extensively reviewed and its description is beyond the scope of this guide. Please refer to the [distributed application]({{< relref
"distributed-application.md" >}}) section.
  
---

## Upgrade from 0.8.1 to 0.9.0

### What's changed?
From a user API point of view, the changes relate to the following topics:
From a user API point of view, the changes relate to the following topics:

* [plugin registration in the SeProxyService](#plugin-registration-in-the-seproxyservice)
* [preparation of selection cases](#preparation-of-selection-cases)
* [retrieving selection results](#retrieving-selection-results)
* [definition of the security settings of the transaction](#definition-of-the-security-settings-of-the-transaction)
* [creation of the PoTransaction object](#creation-of-the-potransaction-object)
* [transaction commands preparation](#transaction-commands-preparation)
* [transaction commands processing](#transaction-commands-processing)
* [retrieving data read from POs](#retrieving-data-read-from-pos)
* [error handling](#error-handling)

### Plugin registration in the SeProxyService

The `registerPlugin` method of the `SeProxyService` class now returns the reference of the registered plugin.

This makes it possible, for example, to perform a reader setup in an application such as this one:

```java
   // Create a PcscPlugin and register it into the SeProxyService
   ReaderPlugin pcscPlugin = seProxyService.registerPlugin(new PcscPluginFactory());`

   // Get the PO reader from the plugin
   SeReader poReader = pcscPlugin.getReader("ASK LoGO 0");
```

### Preparation of selection cases

The `AidSelector`, `Selector` and `PoSelector` classes now follow the Fluent Builder pattern for better handling of optional parameters.

The construction of an `AidSelector` is as follows:

```java
AidSelector appAidSelector = AidSelector.builder()
                            .aidToSelect(AID)
                            .fileControlInformation(AidSelector.FileControlInformation.FCI)
                            .fileOccurrence(AidSelector.FileOccurrence.FIRST)
                            .build();
```

The `fileControlInformation` and `fileOccurrence` fields are optional (shown here with their default values), so a simple version can be :
```java
AidSelector aidSelector = AidSelector.builder().aidToSelect(CalypsoClassicInfo.AID).build();
```

The construction of a `SeSelector` is as follows:
```java
seSelector = SeSelector.builder()
                .seProtocol(SeCommonProtocols.PROTOCOL_ISO14443_4)
                .aidSelector(appAidSelector)
                .build();
```

The `PoSelector` adds the possibility to specify that an invalidated PO should be processed
```java
seSelector = SeSelector.builder()
                .seProtocol(SeCommonProtocols.PROTOCOL_ISO14443_4)
                .aidSelector(appAidSelector)
                .invalidatedPo(InvalidatedPo.ACCEPT)
                .build();
```

The management of PO commands to be performed after the selection step (when it has been successful) is handled by the methods of the `PoSelectionRequest` class:

* preparing to read files has been simplified and is done using the unique following method:
```java
public void prepareReadRecordFile(byte sfi, int recordNumber)
``` 

* preparing to select files is done using the following method:
```java
public void prepareSelectFile(byte[] lid)
public void prepareSelectFile(short lid)
``` 

Note that from now the "prepare" methods no longer return indexes, the data will be placed in the CalypsoPo object.

### Retrieving selection results

The `MatchingSelection` class no longer exists.
In the class `SelectionsResult` (see `processDefaultSelection/processExplicitSelection`):

* `getActiveSelection` is replaced by `getActiveMatchingSe` which returns an `AbstractMatchingSe` object (the still existing `hasActiveSelection` method must be used before)

* `getMatchingSelection` is replaced by `getMatchingSe` which returns an `AbstractMatchingSe` object (may be null if the index provided does not correspond to a successful selection case)

* `getMatchingSelections` now returns a Map containing a list of associated `AbstractMatchingSe` with the selection index that produced it (`Map<Integer, AbstractMatchingSe>`)

* a new `hasSelectionMatched` method indicates whether the selection index provided corresponds to a successful selection case

* a new `getActiveSelectionIndex` method returns the index of the active selection (the still existing `hasActiveSelection` method must be used before)

### Definition of the security settings of the transaction



These parameters are defined via the `PoSecuritySettings` class, whose construction now follows the Fluent Builder pattern.

All parameters are optional except the `SamResource`.

Here is an example of a complete `PoSecuritySettings` build:
```java
poSecuritySettings = new PoSecuritySettings.PoSecuritySettingsBuilder(samResource)
                            .sessionDefaultKif(AccessLevel.SESSION_LVL_PERSO, DEFAULT_KIF_PERSO)
                            .sessionDefaultKif(AccessLevel.SESSION_LVL_LOAD, DEFAULT_KIF_LOAD)
                            .sessionDefaultKif(AccessLevel.SESSION_LVL_DEBIT, DEFAULT_KIF_DEBIT)
                            .sessionDefaultKeyRecordNumber(AccessLevel.SESSION_LVL_PERSO, DEFAULT_KEY_RECORD_NUMBER_PERSO)
                            .sessionDefaultKeyRecordNumber(AccessLevel.SESSION_LVL_LOAD, DEFAULT_KEY_RECORD_NUMBER_LOAD)
                            .sessionDefaultKeyRecordNumber(AccessLevel.SESSION_LVL_DEBIT, DEFAULT_KEY_RECORD_NUMBER_DEBIT)
                            .sessionModificationMode(ModificationMode.ATOMIC)
                            .ratificationMode(RatificationMode.CLOSE_RATIFIED)
                            .sessionAuthorizedKvcList(authKvcs)
                            .build();
```

### Creation of the PoTransaction object

Since PoSecuritySettings now integrates SamResource, the construction of PoTransaction has evolved slightly.

Here is an example:

```java
PoTransaction poTransaction = new PoTransaction(new PoResource(poReader, calypsoPo), poSecuritySettings);
```

### Transaction commands preparation

Just as with the "prepare" commands used for selection, the "prepare" commands used for transactions no longer return indexes.

The available commands in version 0.9 are:

```java
public final void prepareSelectFile(SelectFileControl control)
public final void prepareSelectFile(short lid)
public final void prepareSelectFile(byte[] lid)
public final void prepareReadRecordFile(byte sfi, int recordNumber)
public final void prepareReadRecordFile(byte sfi, int firstRecordNumber, int numberOfRecords, int recordSize))
public final void prepareReadCounterFile(byte sfi, int countersNumber)
public final void prepareUpdateRecord(byte sfi, int recordNumber, byte[] recordData)
public final void prepareWriteRecord(byte sfi, int recordNumber, byte[] recordData)
public final void prepareAppendRecord(byte sfi, byte[] recordData)
public final void prepareIncreaseCounter(byte sfi, int counterNumber, int incValue)
public final void prepareDecreaseCounter(byte sfi, int counterNumber, int decValue)
```

### Transaction commands processing

The "process" commands have also been revised and simplified.

They all return ```void```.

In case of failure a exception is raised (see below).

```java
public final void processOpening(PoTransaction.SessionSetting.AccessLevel accessLevel)
```
The ```ModificationMode``` is no longer required since it is integrated in the ```PoSecuritySettings```.

Parameters previously used to specify that a file is read at login are removed.

Instead, the first prepareReadFile command will be automatically taken into account.

```java
public final void processPoCommands()
public final void processPoCommandsInSession()
public final void processCancel(ChannelControl channelControl)
public final void processClosing(ChannelControl channelControl)
```

### Retrieving data read from POs

This is a major evolution of the Keyple API. Previously, data read from Calyspo POs were retrieved by applications using "parser" methods.

With Keyple API 0.9, Calypso PO data is made available in the CalypsoPo object obtained during selection and enriched all along the operations performed with PoTransaction.

The public getter methods of CalypsoPo are:
```java
public final String getDfName()
public final byte[] getDfNameBytes()
public final String getApplicationSerialNumber()
public final byte[] getApplicationSerialNumberBytes()

public final String getAtr()
public final String getStartupInfo()
public final PoRevision getRevision()
public final byte getSessionModification()
public final byte getApplicationType()
public final byte getApplicationSubtype()
public final byte getPlatform()
public final byte getSoftwareIssuer()
public final byte getSoftwareVersion()
public final byte getSoftwareRevision()

public final boolean isDeselectRatificationSupported()
public final boolean isConfidentialSessionModeSupported()
public final boolean isPublicAuthenticationSupported()
public final boolean isPinFeatureAvailable()
public final boolean isSvFeatureAvailable()

public final boolean isDfInvalidated()
public final boolean isDfRatified()

public final DirectoryHeader getDirectoryHeader()
public final ElementaryFile getFileBySfi(byte sfi)
public final ElementaryFile getFileByLid(short lid)
public final Map<Byte, ElementaryFile> getAllFiles()
```

Four new classes ``DirectoryHeader``, ``ElementaryFile``, ``FileHeader`` and ``FileData`` have been added.

##### DirectoryHeader

The public getters for this class are:
```java
public short getLid()
public byte[] getAccessConditions()
public byte[] getKeyIndexes()

public byte getDfStatus()
public byte getKif(AccessLevel level)
public byte getKvc(AccessLevel level)

public String toString()
```

##### ElementaryFile

The public getters for this class are:
```java
public byte getSfi()
public FileHeader getHeader()
public FileData getData()

public String toString()
```

##### FileHeader

The public getters for this class are:
```java
public short getLid()
public int getRecordsNumber()
public int getRecordSize()
public FileType getType()
public byte getDfStatus()

public boolean isShared()
public Short getSharedReference()
public byte[] getAccessConditions()
public byte[] getKeyIndexes()

public String toString()
```

##### FileData

The public getters for this class are:
```java
public byte[] getContent()
public byte[] getContent(int numRecord)
public byte[] getContent(int numRecord, int dataOffset, int dataLength)
public SortedMap<Integer, byte[]> getAllRecordsContent()

public int getContentAsCounterValue(int numCounter)
public SortedMap<Integer, Integer> getAllCountersValue()

public String toString()
```

So, for example to extract the contents of contract files present in the PO, the code might look like this:
```java
[...]
    /* Read all 4 contracts command, record size set to 29 */
    poTransaction.prepareReadRecordFile(CalypsoClassicInfo.SFI_Contracts,
            CalypsoClassicInfo.RECORD_NUMBER_1, 4, 29);
    /* proceed with the sending of commands, don't close the channel */
    poTransaction.processPoCommandsInSession();

    ElementaryFile efContracts = calypsoPo.getFileBySfi(CalypsoClassicInfo.SFI_Contracts);

    SortedMap<Integer, byte[]> records = efContracts.getData().getAllRecordsContent();
    for (Map.Entry<Integer, byte[]> entry : records.entrySet()) {
        logger.info("Contract #{}: {}", entry.getKey(),
                ByteArrayUtil.toHex(entry.getValue()));
    }
[...]
```

## Error handling

Since version 0.9, all Keyple exceptions are of the RuntimeException type.

Catching exceptions is therefore now optional.

However, it is possible to selectively catch certain exceptions in order to deal with particular cases.

The new hierarchy of Keyple exceptions is shown [here](https://keyple.atlassian.net/projects/KEYP/issues/KEYP-154?filter=allissues&orderby=priority%20DESC&keyword=exceptions)

