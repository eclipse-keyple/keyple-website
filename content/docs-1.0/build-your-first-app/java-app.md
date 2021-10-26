---
title: Build your first Java application
linktitle: Java
summary: This quick start describes how to create a ready-to-execute Java command-line application that runs a simple transaction based on a Calypso portable object involving two smart card readers.
type: book
toc: true
draft: false
weight: 210
---
{{% callout warning %}}
Version 1.0 of the documentation is no longer actively maintained. The site that you are currently viewing is an archived snapshot. For up-to-date documentation, see the latest version.
{{% /callout %}}

This quick start describes how to create a ready-to-execute Java
command-line application that runs a simple transaction based on
a Calypso portable object (PO) involving two smart card readers.

{{% callout note %}}  
The demonstration application created for this quick start requires a
Calypso PO (contactless smart card, mobile phone with contactless 
communication) and a Calypso Secure Access Module (SAM). {{% /callout %}}


We will use three main components of Keyple:
* [Keyple Core]({{< ref "components-java-1.0/core/" >}})
  which is the base component to which all the others refer,
* [Keyple PC/SC plugin]({{< ref "components-java-1.0/plugins/pcsc" >}}) 
  to provide the ability to manage PC/SC readers,
* [Keyple Calypso extension]({{< ref "components-java-1.0/extensions/calypso" >}}) 
  to handle the commands sent to the Calypso PO and the Calypso SAM.

In this guide [Gradle](https://gradle.org/) is used as build automation
tool, but it is easy to transpose these explanations to another tool
such as Maven for example.

The example can run on any machine: Linux, Windows and macOS. If not
installed in your machine, you will need to download :

- Java 1.6 or newer
- [Gradle (any version)](https://gradle.org/install/)

We recommend that you use a Java IDE like
[Eclipse](https://www.eclipse.org/ide/) or
[Intellij IDEA](https://www.jetbrains.com/idea/) to create your new
Gradle project.

---
## Create a Gradle-based empty project

Create a new Java project and add the following statements to your
```build.gradle``` file to import the Keyple components into your
project:

```gradle
apply plugin: 'java'

repositories {
    mavenCentral()
}

dependencies {
    //Keyple core is a mandatory library for using Keyple, in this case import the last version of keyple-java-core
    implementation 'org.eclipse.keyple:keyple-java-core:1.0.0'

    //Import Calypso library to support Calypso Portable Object, in this case import the last version of keyple-java-calypso
    implementation 'org.eclipse.keyple:keyple-java-calypso:1.0.0'

    //Import PC/SC library to use a Pcsc reader, in this case import the last version of keyple-java-plugin-pcsc
    implementation 'org.eclipse.keyple:keyple-java-plugin-pcsc:1.0.0'

    //Import logger lib
    implementation 'org.slf4j:slf4j-api:1.7.25'
    implementation "org.slf4j:slf4j-simple:1.7.25"
}
```

If necessary, also create the usual tree in which the Java code of this
guide will be placed, namely the folders: ```\src\main\java```

---
## Let's code

Now let's see step by step how to create in one single class the
elements that allow a certified reading of data through a Calypso secure
session.

In a real ticketing application, the organization of the code would
probably be different, but the point here is to show how Keyple makes it
possible to perform very simply operations that normally require a
quantity of code and knowledge that far exceeds what is implemented
here.

You can either progressively copy each of the small portions of code
that follow or copy the whole class at the bottom of this page.

### Create the class skeleton

Copy the source code below in a new Java Class named
DemoPoAuthentication.

```java
import org.eclipse.keyple.calypso.command.sam.SamRevision;
import org.eclipse.keyple.calypso.transaction.*;
import org.eclipse.keyple.core.card.selection.*;
import org.eclipse.keyple.core.service.*;
import org.eclipse.keyple.core.util.ByteArrayUtil;
import org.eclipse.keyple.plugin.pcsc.*;

public class DemoPoAuthentication  {
    public static void main(String[] args) {
        // ...
    }
} 
```

### Configure the PC/SC plugin and the readers

The first step to use Keyple is to initialize the plugin and smart card readers.

In this snippet the PC/SC plugin is registered to the SmartCardService.

Two readers needs to be connected to the local machine. Replace
"PO_READER_NAME" and "SAM_READER_NAME" with the name of the USB readers.

If you don't know the names of the readers, read how to find them in the [FAQ](#faq).

```java
//...
// Get the instance of the SmartCardService : main service of Keyple SDK
SmartCardService smartCardService = SmartCardService.getInstance();

// Register the PcscPlugin within the SmartCardService to use PC/SC readers
Plugin plugin = smartCardService.registerPlugin(new PcscPluginFactory());

// Get the PO reader
PcscReader poReader = (PcscReader) plugin.getReader("PO_READER_NAME");

// Configure the PO reader parameters
poReader.setContactless(true);

// Get the SAM reader
PcscReader samReader = (PcscReader) plugin.getReader("SAM_READER_NAME");
// ...
```

### Select the Calypso SAM

Before executing a transaction each smart card should be selected. The
next step is the selection of the Calypso SAM resulting in a
CalypsoSam object.

It is then combined with the SAM reader to form the SAM resource needed
later within the transaction service.

```java
//...

// Prepare a SamSelector that identifies the Calypso SAM
SamSelector samSelector = SamSelector.builder().samRevision(SamRevision.AUTO).build();

// Perform the SAM selection
CardSelectionService samSelection = new CardSelectionService();
samSelection.prepareSelection(new SamSelection(samSelector));

if (!samReader.isCardPresent()) {
    throw new IllegalStateException("No SAM is present in the reader " + samReader.getName());
}

CardSelectionsResult cardSelectionsResult = samSelection.processExplicitSelections(samReader);

if (!cardSelectionsResult.hasActiveSelection()) {
    throw new IllegalStateException("SAM matching failed!");
}

CalypsoSam calypsoSam = (CalypsoSam) cardSelectionsResult.getActiveSmartCard();

// Associate the calypsoSam and the samReader to create a samResource
CardResource<CalypsoSam> samResource = new CardResource<CalypsoSam>(samReader, calypsoSam);

//...
```

### Select the Calypso PO

1st PO exchange:

The Calypso PO selection is made using the portable object application's AID 
and results in a CalypsoPo object that will contain all the information extracted 
from the Calypso PO all along the transaction.

```java
// Prepare a Calypso PO selection
final String AID = "315449432E49434131"; /* AID: Keyple test kit profile 1, Application 2 */

CardSelectionService cardSelectionService = new CardSelectionService();

// Setting up a selection based on the AID of a Calypso Revision 3.1 PO
//
// Select the first application matching the selection AID whatever the card communication protocol
PoSelection poSelection = new PoSelection(
        PoSelector.builder()
                .aidSelector(CardSelector.AidSelector.builder().aidToSelect(AID).build()) // the application identifier
                .invalidatedPo(PoSelector.InvalidatedPo.REJECT) // to indicate if an invalidated PO should be accepted or not
                .build());

// Add the selection case to the current selection
// (we could have added other cases)
cardSelectionService.prepareSelection(poSelection);

if (!poReader.isCardPresent()) {
    throw new IllegalStateException("The selection of the PO has failed.");
}

// Perform the PO selection and get a CalypsoPo container in return
CalypsoPo calypsoPo = (CalypsoPo) cardSelectionService.processExplicitSelections(poReader).getActiveSmartCard();
//...
```

### Open the Calypso secure session

2nd PO exchange :

The secure session opening operated by the PoTransaction service is
combined with the reading of the environment file (SFI=07h).

The mutual authentication process between Calypso PO and Calypso SAM is initiated transparently.

```java
// Prepare the security settings used during the Calypso transaction
PoSecuritySettings poSecuritySettings = new PoSecuritySettings.PoSecuritySettingsBuilder(samResource).build();

// Create a PoTransaction service to manage the Calypso transaction
PoTransaction poTransaction = new PoTransaction(
        new CardResource<CalypsoPo(poReader, calypsoPo),
        poSecuritySettings);

final byte RECORD_NUMBER_1 = 1;
final byte SFI_Environment = (byte) 0x07;

// Schedule the reading of the Environment file after the secure session is opened
// (we could have added other commands)
poTransaction.prepareReadRecordFile(
        SFI_Environment, // the sfi to select
        RECORD_NUMBER_1);

// Perform the session opening with the debit key
poTransaction.processOpening(PoTransaction.SessionSetting.AccessLevel.SESSION_LVL_DEBIT);

// Get and display the Environment data from the card image CalypsoPo
ElementaryFile efEnvironment = calypsoPo.getFileBySfi(SFI_Environment);
String environmentLog = ByteArrayUtil.toHex(efEnvironment.getData().getContent());
System.out.println("Environment file content: "+ environmentLog);
//...
```

### Close the Calypso secure session

3rd PO exchange:

Simply close the Calypso secure session

The mutual authentication is finalized, it includes the authentication
of the data in the read file.

Note: any technical, crytographic or content-related incident in the Calypso PO
would be signalled by an exception and would interrupt the thread of
execution.

```java
// Schedule the closure of the channel with the PO after the closing of the secure session
poTransaction.prepareReleasePoChannel();

// Perform the closing of the Calypso Secure Session
poTransaction.processClosing();

System.out.println("The data read in session have been certified by the successful closing.");
//...       
```

### Unregister the plugin 

Finally unregister the plugin before shutting down the application

```java
// Shutdown the application
smartCardService.unregisterPlugin(plugin.getName());

System.exit(0);
```

Find the complete code source [below](#full-code).

---
## Run

1) Connect two USB PC/SC Readers.
2) Insert the Calypso SAM in the SAM reader.
3) Insert the Calypso PO in the PO reader.
4) Run the application.

{{% callout note %}} All project dependencies, including Keyple
components, are downloaded during the first run, which can take some
time. {{% /callout %}}


---
## FAQ

**How do I find out the names of the readers?**

To find out the names of the readers connected to your computer, we will
use Keyple with the following class which prints in the console the
number and names of the readers present:

```java
import org.eclipse.keyple.core.service.Plugin;
import org.eclipse.keyple.core.service.SmartCardService;
import org.eclipse.keyple.plugin.pcsc.PcscPluginFactory;

import java.util.Set;

public class ReaderDiscovery {

    public static void main(String[] args) {

        SmartCardService smartCardService = SmartCardService.getInstance();

        Plugin plugin = smartCardService.registerPlugin(new PcscPluginFactory());

        Set<String> names = plugin.getReaderNames();

        System.out.println(names.size() + " readers found.");

        for (String name : names) {
            System.out.println('"' + name + '"');
        }
    }
} 
```

The console output should look something like:

```
2 readers found.
"ASK LoGO 0"
"Identive CLOUD 2700 R Smart Card Reader 0"
```

Identify which reader will be the PO (contactless) reader and the SAM
(contact) reader and replace ```PO_READER_NAME``` and
```SAM_READER_NAME``` with their values.

**How to activate the Keyple's logs?**

As soon as the `slf4j` library is imported into the project, Keyple
modules are able to produce logs.

However, to take full advantage of the possibilities of this library, it
is necessary to create a ```simplelogger.properties``` file in the
```/src/main/resources``` folder of the project.

The self-documented content of this file may be:

```
# SLF4J's SimpleLogger configuration file
# Simple implementation of Logger that sends all enabled log messages, for all defined loggers, to System.err.

# Default logging detail level for all instances of SimpleLogger.
# Must be one of ("trace", "debug", "info", "warn", or "error").
# If not specified, defaults to "info".
org.slf4j.simpleLogger.defaultLogLevel=debug

# Logging detail level for a SimpleLogger instance named "xxxxx".
# Must be one of ("trace", "debug", "info", "warn", or "error").
# If not specified, the default logging detail level is used.
#org.slf4j.simpleLogger.log.xxxxx=

# Set to true if you want the current date and time to be included in output messages.
# Default is false, and will output the number of milliseconds elapsed since startup.
org.slf4j.simpleLogger.showDateTime=true

# The date and time format to be used in the output messages.
# The pattern describing the date and time format is the same that is used in java.text.SimpleDateFormat.
# If the format is not specified or is invalid, the default format is used.
# The default format is yyyy-MM-dd HH:mm:ss:SSS Z.
org.slf4j.simpleLogger.dateTimeFormat=[HH:mm:ss:SSS]

# Set to true if you want to output the current thread name.
# Defaults to true.
org.slf4j.simpleLogger.showThreadName=true

# Set to true if you want the Logger instance name to be included in output messages.
# Defaults to true.
org.slf4j.simpleLogger.showLogName=false

# Set to true if you want the last component of the name to be included in output messages.
# Defaults to false.
org.slf4j.simpleLogger.showShortLogName=true

org.slf4j.simpleLogger.levelInBrackets=true
```

**Why do I see a warning in the console about illegal reflexive access
when running the application?**

A known problem on Windows 8/10 platforms causes the smartcard service
to stop when the last reader is removed. This problem prevents a
"classic" monitoring of connections and disconnections of readers with
the smartcard.io library (Java PC/SC). So for the moment we are using a
workaround based on reflexivity to overcome this problem and allow a
correct monitoring of the readers in the PC/SC plugin. This has the
disadvantage of generating a warning message with recent versions of the
JVM. However, we have not found any problems with this implementation of
the PC/SC plugin so far.

#### Full code

Here is the complete code of this quick start in one single block.

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

        // Register a PcscPlugin within the SmartCardService to use PC/SC USB Readers
        Plugin plugin = smartCardService.registerPlugin(new PcscPluginFactory(null, null));

        // Get the PO reader
        PcscReader poReader = (PcscReader) plugin.getReader("ASK LoGO 0");

        // Configure the PO reader parameters
        poReader.setContactless(true);

        // Get a SAM reader
        PcscReader samReader = (PcscReader) plugin.getReader("Identive CLOUD 2700 R Smart Card Reader 0");

        // Prepare a SamSelector that identifies the Calypso SAM
        SamSelector samSelector = SamSelector.builder().samRevision(SamRevision.AUTO).build();

        // Perform the SAM selection
        CardSelectionsService samSelection = new CardSelectionsService();
        samSelection.prepareSelection(new SamSelection(samSelector));

        if (!samReader.isCardPresent()) {
            throw new IllegalStateException("No SAM is present in the reader " + samReader.getName());
        }

        CardSelectionsResult cardSelectionsResult = samSelection.processExplicitSelections(samReader);

        if (!cardSelectionsResult.hasActiveSelection()) {
            throw new IllegalStateException("SAM matching failed!");
        }

        CalypsoSam calypsoSam = (CalypsoSam) cardSelectionsResult.getActiveSmartCard();

        // Associate the calypsoSam and the samReader to create a samResource
        CardResource<CalypsoSam> samResource = new CardResource<CalypsoSam>(samReader, calypsoSam);

        // Prepare a Calypso PO selection
        final String AID = "315449432E49434131"; /* AID: Keyple test kit profile 1, Application 2 */
        final byte RECORD_NUMBER_1 = 1;
        final byte SFI_Environment = (byte) 0x07;

        CardSelectionsService cardSelectionService = new CardSelectionsService();

        // Setting up a selection based on the AID of a Calypso Revision 3.1 PO
        //
        // Select the first application matching the selection AID whatever the card communication protocol
        PoSelection poSelection = new PoSelection(
                PoSelector.builder()
                        .aidSelector(CardSelector.AidSelector.builder().aidToSelect(AID).build()) // the application identifier
                        .invalidatedPo(PoSelector.InvalidatedPo.REJECT) // to indicate if an invalidated PO should be accepted or not
                        .build());

        // Add the selection case to the current selection
        // (we could have added other cases)
        cardSelectionService.prepareSelection(poSelection);

        if (!poReader.isCardPresent()) {
            throw new IllegalStateException("The selection of the PO has failed.");
        }

        // Perform the PO selection and get a CalypsoPo container in return
        CalypsoPo calypsoPo = (CalypsoPo) cardSelectionService.processExplicitSelections(poReader).getActiveSmartCard();

        // Prepare the security settings used during the Calypso transaction
        PoSecuritySettings poSecuritySettings = new PoSecuritySettings.PoSecuritySettingsBuilder(samResource).build();

        // Create a PoTransaction service to manage the Calypso transaction
        PoTransaction poTransaction = new PoTransaction(
                new CardResource<CalypsoPo>(poReader, calypsoPo),
                poSecuritySettings);

        // Schedule the reading of the Environment file after the secure session is opened
        // (we could have added other commands)
        poTransaction.prepareReadRecordFile(
                SFI_Environment, // the sfi to select
                RECORD_NUMBER_1);

        // Perform the session opening with the debit key
        poTransaction.processOpening(PoTransaction.SessionSetting.AccessLevel.SESSION_LVL_DEBIT);

        // Get and display the Environment data from the card image CalypsoPo
        ElementaryFile efEnvironment = calypsoPo.getFileBySfi(SFI_Environment);
        String environmentLog = ByteArrayUtil.toHex(efEnvironment.getData().getContent());
        System.out.println("Environment file content: "+ environmentLog);

        // Schedule the closure of the channel with the PO after the closing of the secure session
        poTransaction.prepareReleasePoChannel();

        // Perform the closing of the Calypso Secure Session
        poTransaction.processClosing();

        System.out.println("The data read in session have been certified by the successful closing.");

        // Shutdown the application
        smartCardService.unregisterPlugin(plugin.getName());

        System.exit(0);
    }
} 
```

