---
title: Build your first Java application
linktitle: Java
summary: This quick start describes how to create a ready-to-execute Java command-line application that runs a simple transaction based on a Calypso portable object involving two smart card readers.
type: book
toc: true
draft: false
weight: 1
---

---
## Overview

This quick start describes how to create a ready-to-execute Java command-line application that runs a simple transaction based on
a Calypso Card involving two smart card readers.

{{% callout warning %}}  
The demonstration application created for this quick start requires:
* a Calypso Card (contactless smart card, NFC mobile phone with a Calypso applet or application),
* a Calypso SAM (Secure Access Module).
{{% /callout %}}


We will use three main components of Keyple:
* [Keyple Service Java Library]({{< relref "/components-java/core/" >}})
  which is the base component to which all the others refer,
* [Keyple Card Calypso]({{< relref "/components-java/card-extensions/keyple-card-calypso-java-lib" >}}) 
  add-on to handle the commands sent to the Calypso card and the Calypso SAM,
* [Keyple Plugin PC/SC]({{< relref "/components-java/standard-reader-plugins/keyple-plugin-pcsc-java-lib" >}})
  add-on to provide the ability to manage PC/SC readers.

In this guide [Gradle](https://gradle.org/) is used as build automation
tool, but it is easy to transpose these explanations to another tool
such as Maven for example. 

See [here]({{< relref "/components-java/overview/configuration-wizard" >}}) for the configuration of the dependencies.

The example can run on any machine: Linux, Windows and macOS. If not
installed in your machine, you will need to download :

- Java 1.6+
- [Gradle](https://gradle.org/install/)

We recommend that you use a Java IDE like
[Eclipse](https://www.eclipse.org/ide/) or
[Intellij IDEA](https://www.jetbrains.com/idea/) to create your new
Gradle project.

---
## Create a Gradle-based empty project

Create a new Java project and add the following statements to your
```build.gradle``` file to import the Keyple components into your
project:

{{< code lang="gradle" >}}
plugins {
    id 'java'
}

repositories {
    mavenCentral()
}

dependencies {
    // Import CNA APIs
    implementation 'org.calypsonet.terminal:calypsonet-terminal-reader-java-api:1.2.0'
    implementation 'org.calypsonet.terminal:calypsonet-terminal-calypso-java-api:1.8.0'
    // Import Keyple components
    implementation 'org.eclipse.keyple:keyple-common-java-api:2.0.0'
    implementation 'org.eclipse.keyple:keyple-util-java-lib:2.3.0'
    implementation 'org.eclipse.keyple:keyple-service-java-lib:2.2.1'
    implementation 'org.eclipse.keyple:keyple-card-calypso-java-lib:2.3.5'
    implementation 'org.eclipse.keyple:keyple-plugin-pcsc-java-lib:2.1.2'
}
{{< /code >}}

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
DemoCardAuthentication.

{{< code lang="java" >}}
import org.calypsonet.terminal.calypso.WriteAccessLevel;
import org.calypsonet.terminal.calypso.card.CalypsoCard;
import org.calypsonet.terminal.calypso.sam.CalypsoSam;
import org.calypsonet.terminal.calypso.transaction.CardSecuritySetting;
import org.calypsonet.terminal.calypso.transaction.CardTransactionManager;
import org.calypsonet.terminal.reader.CardReader;
import org.calypsonet.terminal.reader.selection.CardSelectionManager;
import org.calypsonet.terminal.reader.selection.CardSelectionResult;
import org.eclipse.keyple.card.calypso.CalypsoExtensionService;
import org.eclipse.keyple.core.service.Plugin;
import org.eclipse.keyple.core.service.SmartCardService;
import org.eclipse.keyple.core.service.SmartCardServiceProvider;
import org.eclipse.keyple.plugin.pcsc.PcscPluginFactoryBuilder;
import org.eclipse.keyple.plugin.pcsc.PcscReader;

public class DemoCardAuthentication {

  // The names of the readers must be adapted to the actual configuration.
  private static final String CARD_READER_NAME = "ASK LoGO 0";
  private static final String SAM_READER_NAME = "Identive CLOUD 2700 R Smart Card Reader 0";
  private static final String AID = "315449432E49434131"; // Keyple test kit profile 1, Application 2
  private static final int RECORD_NUMBER_1 = 1;
  private static final byte SFI_ENVIRONMENT_AND_HOLDER = (byte) 0x07;

  public static void main(String[] args) {
    // ... 
  }
}
{{< /code >}}

### Set up the PC/SC plugin

The first step to use Keyple is to initialize the plugin and smart card readers.

In this snippet the PC/SC plugin is registered to the SmartCardService.

Two readers needs to be connected to the local machine. Change
"CARD_READER_NAME" and "SAM_READER_NAME" with the name of your USB readers.

If you don't know the names of the readers, read how to find them in the [FAQ](#faq).

{{< code lang="java" >}}
    // Get the instance of the SmartCardService
    SmartCardService smartCardService = SmartCardServiceProvider.getService();

    // Register the PcscPlugin with the SmartCardService, get a generic plugin instance in return
    Plugin plugin = smartCardService.registerPlugin(PcscPluginFactoryBuilder.builder().build());

    // Get and set up the card reader
    CardReader cardReader = plugin.getReader(CARD_READER_NAME);
    if (cardReader == null) {
      throw new IllegalStateException("Card reader " + CARD_READER_NAME + " not found.");
    }
    // Set the card reader type (for ratification management purpose)
    plugin.getReaderExtension(PcscReader.class, CARD_READER_NAME).setContactless(true);
    if (!cardReader.isCardPresent()) {
      throw new IllegalStateException("No card is present in the reader " + cardReader.getName());
    }

    // Get and set up the SAM reader
    CardReader samReader = plugin.getReader(SAM_READER_NAME);
    if (samReader == null) {
      throw new IllegalStateException("SAM reader " + SAM_READER_NAME + " not found.");
    }
    if (!samReader.isCardPresent()) {
      throw new IllegalStateException("No SAM is present in the reader " + samReader.getName());
    }
{{< /code >}}

### Set up the Calypso card extension
The Calypso card extension service will provide means to handle cards, SAMs and to manage card transactions.
{{< code lang="java" >}}
    // Get the Calypso card extension service
    CalypsoExtensionService calypsoExtensionService = CalypsoExtensionService.getInstance();
    // Verify that the extension's API level is consistent with the current service.
    smartCardService.checkCardExtension(calypsoExtensionService);
{{< /code >}}

### Select the Calypso SAM

Before executing a transaction each smart card should be selected. The
next step is the selection of the Calypso SAM resulting in a
CalypsoSam object.

It is then combined with the SAM reader to form the SAM resource needed
later within the transaction service.

{{< code lang="java" >}}
    // Select the SAM
    CardSelectionManager samSelectionManager = smartCardService.createCardSelectionManager();
    samSelectionManager.prepareSelection(calypsoExtensionService.createSamSelection());
    CardSelectionResult samSelectionResult =
        samSelectionManager.processCardSelectionScenario(samReader);
    CalypsoSam calypsoSam = (CalypsoSam) samSelectionResult.getActiveSmartCard();
    if (calypsoSam == null) {
      throw new IllegalStateException("The SAM selection failed.");
    }
{{< /code >}}

### Select the Calypso card

1st card exchange:

The Calypso card selection is made using the card application's AID 
and results in a CalypsoCard object that will contain all the information extracted 
from the Calypso card all along the transaction.

{{< code lang="java" >}}
    // Select the card
    CardSelectionManager cardSelectionManager = smartCardService.createCardSelectionManager();
    cardSelectionManager.prepareSelection(
        calypsoExtensionService.createCardSelection().filterByDfName(AID));
    CardSelectionResult cardSelectionResult =
        cardSelectionManager.processCardSelectionScenario(cardReader);
    CalypsoCard calypsoCard = (CalypsoCard) cardSelectionResult.getActiveSmartCard();
    if (calypsoCard == null) {
      throw new IllegalStateException("The card selection failed.");
    }
{{< /code >}}

### Open the Calypso secure session

2nd card exchange :

The secure session opening operated by the CardTransaction service is
combined with the reading of the environment file (SFI=07h).

The mutual authentication process between Calypso card and Calypso SAM is initiated transparently.

{{< code lang="java" >}}
    // Prepare the security settings used during the Calypso transaction
    CardSecuritySetting cardSecuritySetting =
        calypsoExtensionService
            .createCardSecuritySetting()
            .setControlSamResource(samReader, calypsoSam);

    // Performs file reads using the card transaction manager in a secure session.
    CardTransactionManager cardTransactionManager =
        calypsoExtensionService
            .createCardTransaction(cardReader, calypsoCard, cardSecuritySetting)
            .prepareOpenSecureSession(WriteAccessLevel.DEBIT)
            .prepareReadRecord(SFI_ENVIRONMENT_AND_HOLDER, RECORD_NUMBER_1)
            .processCommands(false);
{{< /code >}}

### Close the Calypso secure session

3rd card exchange:

Simply close the Calypso secure session

The mutual authentication is finalized, it includes the authentication
of the data in the read file.

Note: any technical, cryptographic or content-related incident in the Calypso card
would be signalled by an exception and would interrupt the thread of
execution.

{{< code lang="java" >}}
    // Close the secure session, free the communication channel at the same time
    cardTransactionManager.prepareCloseSecureSession().processCommands(true);

    System.out.println(
        "= #### The Secure Session ended successfully, the card is authenticated and the data read are certified.");
    System.out.println(
        "= #### FILE CONTENT = " + calypsoCard.getFileBySfi(SFI_ENVIRONMENT_AND_HOLDER).toString());

    System.out.println("= #### End of the Calypso card processing.");
{{< /code >}}

### Unregister the plugin 

Finally unregister the plugin before shutting down the application

{{< code lang="java" >}}
    // Unregister the plugin before leaving the application
    smartCardService.unregisterPlugin(plugin.getName());

    System.exit(0);
{{< /code >}}

Find the complete code source [below](#full-code).

---
## Run

1) Connect two USB PC/SC Readers.
2) Insert the Calypso SAM in the SAM reader.
3) Insert the Calypso card in the card reader.
4) Run the application.

{{% callout note %}} All project dependencies, including Keyple
components, are downloaded during the first run, which can take some
time. {{% /callout %}}


---
## FAQ

#### How do I find out the names of the readers?

To find out the names of the readers connected to your computer, we will
use Keyple with the following class which prints in the console the
number and names of the readers present:

{{< code lang="java" >}}
import org.eclipse.keyple.core.service.Plugin;
import org.eclipse.keyple.core.service.SmartCardService;
import org.eclipse.keyple.plugin.pcsc.PcscPluginFactoryBuilder;

import java.util.Set;

public class ReaderDiscovery {
  public static void main(String[] args) {
    SmartCardService smartCardService = SmartCardServiceProvider.getService();
    Plugin plugin = smartCardService.registerPlugin(PcscPluginFactoryBuilder.builder().build());
    Set<String> names = plugin.getReaderNames();
    System.out.println(names.size() + " readers found.");
    for (String name : names) {
      System.out.println('"' + name + '"');
    }
  }
} 
{{< /code >}}

The console output should look something like:

```
2 readers found.
"ASK LoGO 0"
"Identive CLOUD 2700 R Smart Card Reader 0"
```

Identify which reader will be the card (contactless) reader and the SAM
(contact) reader and replace ```CARD_READER_NAME``` and
```SAM_READER_NAME``` with their values.

#### How to activate the Keyple's logs?

As soon as the `slf4j` library is imported into the project, Keyple
modules are able to produce logs.
{{< code lang="gradle">}}
    // Import logger libs
    implementation 'org.slf4j:slf4j-api:1.7.32'
    implementation 'org.slf4j:slf4j-simple:1.7.32'
{{< /code >}}

However, to take full advantage of the possibilities of this library, it
is necessary to create a ```simplelogger.properties``` file in the
```/src/main/resources``` folder of the project.

The self-documented content of this file may be:

{{< code lang="ini">}}
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
{{< /code >}}

#### Why do I see a warning in the console about illegal reflexive access
when running the application?

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

{{< code lang="java" >}}
import org.calypsonet.terminal.calypso.WriteAccessLevel;
import org.calypsonet.terminal.calypso.card.CalypsoCard;
import org.calypsonet.terminal.calypso.sam.CalypsoSam;
import org.calypsonet.terminal.calypso.transaction.CardSecuritySetting;
import org.calypsonet.terminal.calypso.transaction.CardTransactionManager;
import org.calypsonet.terminal.reader.CardReader;
import org.calypsonet.terminal.reader.selection.CardSelectionManager;
import org.calypsonet.terminal.reader.selection.CardSelectionResult;
import org.eclipse.keyple.card.calypso.CalypsoExtensionService;
import org.eclipse.keyple.core.service.Plugin;
import org.eclipse.keyple.core.service.SmartCardService;
import org.eclipse.keyple.core.service.SmartCardServiceProvider;
import org.eclipse.keyple.plugin.pcsc.PcscPluginFactoryBuilder;
import org.eclipse.keyple.plugin.pcsc.PcscReader;

public class DemoCardAuthentication {

  // The names of the readers must be adapted to the actual configuration.
  private static final String CARD_READER_NAME = "ASK LoGO 0";
  private static final String SAM_READER_NAME = "Identive CLOUD 2700 R Smart Card Reader 0";
  private static final String AID = "315449432E49434131"; // Keyple test kit profile 1, Application 2
  private static final int RECORD_NUMBER_1 = 1;
  private static final byte SFI_ENVIRONMENT_AND_HOLDER = (byte) 0x07;

  public static void main(String[] args) {

    // Get the instance of the SmartCardService
    SmartCardService smartCardService = SmartCardServiceProvider.getService();

    // Register the PcscPlugin with the SmartCardService, get a generic plugin instance in return
    Plugin plugin = smartCardService.registerPlugin(PcscPluginFactoryBuilder.builder().build());

    // Get and set up the card reader
    CardReader cardReader = plugin.getReader(CARD_READER_NAME);
    if (cardReader == null) {
      throw new IllegalStateException("Card reader " + CARD_READER_NAME + " not found.");
    }
    // Set the card reader type (for ratification management purpose)
    plugin.getReaderExtension(PcscReader.class, CARD_READER_NAME).setContactless(true);
    if (!cardReader.isCardPresent()) {
      throw new IllegalStateException("No card is present in the reader " + cardReader.getName());
    }

    // Get and set up the SAM reader
    CardReader samReader = plugin.getReader(SAM_READER_NAME);
    if (samReader == null) {
      throw new IllegalStateException("SAM reader " + SAM_READER_NAME + " not found.");
    }
    if (!samReader.isCardPresent()) {
      throw new IllegalStateException("No SAM is present in the reader " + samReader.getName());
    }

    // Get the Calypso card extension service
    CalypsoExtensionService calypsoExtensionService = CalypsoExtensionService.getInstance();
    // Verify that the extension's API level is consistent with the current service.
    smartCardService.checkCardExtension(calypsoExtensionService);

    // Select the SAM
    CardSelectionManager samSelectionManager = smartCardService.createCardSelectionManager();
    samSelectionManager.prepareSelection(calypsoExtensionService.createSamSelection());
    CardSelectionResult samSelectionResult =
        samSelectionManager.processCardSelectionScenario(samReader);
    CalypsoSam calypsoSam = (CalypsoSam) samSelectionResult.getActiveSmartCard();
    if (calypsoSam == null) {
      throw new IllegalStateException("The SAM selection failed.");
    }

    // Select the card
    CardSelectionManager cardSelectionManager = smartCardService.createCardSelectionManager();
    cardSelectionManager.prepareSelection(
        calypsoExtensionService.createCardSelection().filterByDfName(AID));
    CardSelectionResult cardSelectionResult =
        cardSelectionManager.processCardSelectionScenario(cardReader);
    CalypsoCard calypsoCard = (CalypsoCard) cardSelectionResult.getActiveSmartCard();
    if (calypsoCard == null) {
      throw new IllegalStateException("The card selection failed.");
    }

    // Prepare the security settings used during the Calypso transaction
    CardSecuritySetting cardSecuritySetting =
        calypsoExtensionService
            .createCardSecuritySetting()
            .setControlSamResource(samReader, calypsoSam);

    // Performs file reads using the card transaction manager in a secure session.
    // Close the secure session, free the communication channel at the same time.
    CardTransactionManager cardTransactionManager =
        calypsoExtensionService
            .createCardTransaction(cardReader, calypsoCard, cardSecuritySetting)
            .prepareOpenSecureSession(WriteAccessLevel.DEBIT)
            .prepareReadRecord(SFI_ENVIRONMENT_AND_HOLDER, RECORD_NUMBER_1)
            .prepareCloseSecureSession()
            .processCommands(true);

    System.out.println(
        "= #### The Secure Session ended successfully, the card is authenticated and the data read are certified.");
    System.out.println(
        "= #### FILE CONTENT = " + calypsoCard.getFileBySfi(SFI_ENVIRONMENT_AND_HOLDER).toString());

    System.out.println("= #### End of the Calypso card processing.");

    // Unregister the plugin before leaving the application
    smartCardService.unregisterPlugin(plugin.getName());

    System.exit(0);
  }
}
{{< /code >}}