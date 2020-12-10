---
title: Build your first Java application
linktitle: Java
type: book
toc: true
draft: false
weight: 210
---

This quick-start escribes how to create a ready-to-execute JAVA app that operate a simple Calypso transaction.

In order to communicate with the smart card we use [Keyple PCSC plugin](https://github.com/eclipse/keyple-java/tree/master/java/component/keyple-plugin/pcsc) and and the [Calypso extension](https://github.com/eclipse/keyple-java/tree/master/java/component/keyple-calypso) to communicate with the Calypso Portable Object (PO) and the Secure Access Module (SAM).

The example can run on any machine: Linux, Windows and MacOS. If not installed in your machine, you will need to download :

- Java 1.6 or newer
- [Gradle (any version)](https://gradle.org/install/)

We recommend that you use a Java IDE like Eclipse or Intellij to create your new Gradle project.

## Create the Gradle project

Create a gradle project and add the following statements to your build.gradle file to import Keyple components into your project:

```gradle
repositories {
    mavenCentral()
}

dependencies {
    //Keyple core is a mandatory library for using Keyple, in this case import the last version of keyple-java-core
    implementation group: 'org.eclipse.keyple', name: 'keyple-java-core', version: '+'

    //Import Calypso library to support Calypso Portable Object, in this case import the last version of keyple-java-calypso
    implementation group: 'org.eclipse.keyple', name: 'keyple-java-calypso', version: '+'

    //Import PCSC library to use a Pcsc reader, in this case import the last version of keyple-java-plugin-pcsc
    implementation group: 'org.eclipse.keyple', name: 'keyple-java-plugin-pcsc', version: '+'
}
```
## Let's code

### Configure PCSC plugin and readers

The first step to use Keyple SDK is to initialize the plugin and smartcard readers. In this snippet the PCSC plugin is registered to the SmartCardService. Two readers needs to be connected to the local machine. Replace "PO_READER_NAME" and "SAM_READER_NAME" with the name of the USB readers. If you don’t know the reader name, run the application in debug mode and get the reader names from the Plugin object.

Copy the source code below in a new Java Class named DemoPoAuthentication. 

```java
import org.eclipse.keyple.calypso.command.sam.SamRevision;
import org.eclipse.keyple.calypso.transaction.*;
import org.eclipse.keyple.core.card.selection.*;
import org.eclipse.keyple.core.service.*;
import org.eclipse.keyple.core.util.ByteArrayUtil;
import org.eclipse.keyple.plugin.pcsc.*;

public class DemoPoAuthentication  {

    public static void main(String[] args) {

        // Get the instance of the SmartCardService : main service of Keyple SDK
        SmartCardService smartCardService = SmartCardService.getInstance();

        // Register a PcscPlugin within the SmartCardService to use PCSC USB Readers
        Plugin plugin = smartCardService.registerPlugin(new PcscPluginFactory());

        // Get the PO reader
        PcscReader poReader = (PcscReader) plugin.getReader("PO_READER_NAME");

        // Configure the PO reader parameters
        poReader.setContactless(true);

        // Get a SAM reader
        PcscReader samReader = (PcscReader) plugin.getReader("SAM_READER_NAME");
        
//...

    }
} 
```

### Select SAM resource

Before executing a transaction each smart card should be selected. The next step is the selection of the SAM smart card, followed by the creation of the CalypsoSam resource which is necessary for the Calypso transaction.

```java
        
        // Prepare the selector to ensure the correct SAM is used
        SamSelector samSelector = SamSelector.builder().samRevision(SamRevision.AUTO).build();

        // Make the SAM selection
        CardSelection samSelection = new CardSelection();
        samSelection.prepareSelection(new SamSelectionRequest(samSelector));
        CalypsoSam calypsoSam;

        //check that a smartcard is present in the SAM reader
        if (!samReader.isCardPresent()) {
            throw new IllegalStateException("No SAM is present in the reader " + samReader.getName());
        }

        SelectionsResult selectionsResult = samSelection.processExplicitSelection(samReader);

        if (!selectionsResult.hasActiveSelection()) {
            throw new IllegalStateException("SAM matching failed!");
        }

        calypsoSam = (CalypsoSam) selectionsResult.getActiveSmartCard();

        // Associate the calypsoSam and the samReader to create the samResource
        CardResource<CalypsoSam> samResource = new CardResource<CalypsoSam>(samReader, calypsoSam);

        //...

```
### Select PO resource

Preparing the 1st PO exchange : after the selection of the SAM smartcard, we operate the AID based selection on the PO.

```java
        // Prepare a Calypso PO selection
        CardSelection seSelection = new CardSelection();

        // Setting of an AID based selection of a Calypso Revision 3.1 PO
        //
        // Select the first application matching the selection AID whatever the card communication protocol
        // Keep the logical channel open after the selection
        //
        // Calypso selection: configures a PoSelectionRequest with all the desired attributes to
        // make the selection and read additional information afterwards
        PoSelectionRequest poSelectionRequest = new PoSelectionRequest(
                PoSelector.builder()
                        .aidSelector(CardSelector.AidSelector.builder().aidToSelect(AID).build()) // the application identifier
                        .invalidatedPo(PoSelector.InvalidatedPo.REJECT) // to indicate if an invalidated PO should be accepted or not
                        .build());

        // Add the selection case to the current selection
        // (we could have added other cases)
        seSelection.prepareSelection(poSelectionRequest);
        
        if (!poReader.isCardPresent()) {
            throw new IllegalStateException("The selection of the PO has failed.");
        }
        
        // Actual PO communication: operate through a single request the Calypso PO selection
        CalypsoPo calypsoPo = (CalypsoPo) seSelection.processExplicitSelection(poReader).getActiveSmartCard();

  //...
```
### Transaction : open session

2nd PO exchange : prepare the PoTransaction object with the reading of the environment file (SFI=07h) .

```java
    // Prepare the security settings used during the Calypso transaction
    PoSecuritySettings poSecuritySettings = new PoSecuritySettings.PoSecuritySettingsBuilder(samResource).build();
   
    // Create a PoTransaction object to manage the Calypso transaction
    PoTransaction poTransaction = new PoTransaction(
                new CardResource<>(poReader, calypsoPo),
                poSecuritySettings);

    // Read the Environment file at the Session Opening
    // (we could have added other commands)
    poTransaction.prepareReadRecordFile(
            SFI_Environment, // the sfi to select
            RECORD_NUMBER_1);

    // Open Session with the debit key
    poTransaction.processOpening(PoTransaction.SessionSetting.AccessLevel.SESSION_LVL_DEBIT);

    // Get the Environment data
    ElementaryFile efEnvironment = calypsoPo.getFileBySfi(SFI_Environment);

    String environmentLog = ByteArrayUtil.toHex(efEnvironment.getData().getContent());
    System.out.println("File Environment log: "+ environmentLog);

    if (!calypsoPo.isDfRatified()) {
        System.out.println("============= Previous Calypso Secure Session was not ratified =============");
    }

  //...
```
### Transaction : close session

The 3th PO exchange : the Calypso secure session is closed 

```java
    // To close the channel with the PO after the closing
    poTransaction.prepareReleasePoChannel();

    // Close the Calypso Secure Session
    // A ratification command will be sent (CONTACTLESS_MODE)
    poTransaction.processClosing();

```

Unregister the plugin before shutting down the application

```java
    // To shutdown the application
    smartCardService.unregisterPlugin(plugin.getName());
    
    System.exit(0);
```

Find the complete code source in the [example project](https://github.com/eclipse/keyple-java/blob/develop/java/example/calypso/src/main/java/org/eclipse/keyple/example/calypso/UseCase1_ExplicitSelectionAid/Main_ExplicitSelectionAid_Pcsc.java) 

## Run

1) Connect two USB PCSC Readers.

2) Insert the SAM smart card in the SAM reader.

3) Insert the PO smart card in the PO reader.

4) Run the application.

{{% alert note %}}
All project dependencies, including Keyple components, are downloaded during the first run, which can take several minutes.
{{% /alert %}}

