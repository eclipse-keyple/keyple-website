---
title: Build your First Java Application
linktitle: Java App
type: book
toc: true
draft: false
weight: 210
---

This getting started contains one ready-to-execute JAVA example starting from a new Gradle project.

The example demonstrate Keyple capabilities with the Keyple PCSC plugin and PO/SAM provided in the Calypso Test Kit.

## Build

The example can run on any machine: Linux, Windows and MacOS. If not installed in your machine, you will need to download :

Java 1.6 or newer

[Gradle (any version)](https://gradle.org/install/)

We recommend that you use a Java IDE like Eclipse or Intellij to create your new Gradle project.

Create a new Gradle project.

Add the following statements to your build.gradle file to import Keyple components into your project:

```java
repositories {
    //to import snapshots
    //maven {url 'https://oss.sonatype.org/content/repositories/snapshots' }
    //to import releases
    maven { url 'https://oss.sonatype.org/content/repositories/releases' }
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
Add the following statements to your build.gradle file to import Logger components into your project:
```java
dependencies {
    implementation "org.slf4j:slf4j-simple:1.7.25"
    implementation "org.slf4j:slf4j-ext:1.7.25"
}
```
Copy the source code below in a new Java Class named DemoPoAuthentication:
```java
/* **************************************************************************************
 * Copyright (c) 2020 Calypso Networks Association https://www.calypsonet-asso.org/
 *
 * See the NOTICE file(s) distributed with this work for additional information
 * regarding copyright ownership.
 *
 * This program and the accompanying materials are made available under the terms of the
 * Eclipse Public License 2.0 which is available at http://www.eclipse.org/legal/epl-2.0
 *
 * SPDX-License-Identifier: EPL-2.0
 ************************************************************************************** */

import org.eclipse.keyple.calypso.transaction.*;
import org.eclipse.keyple.calypso.transaction.PoSelector.*;
import org.eclipse.keyple.calypso.command.sam.SamRevision;
import org.eclipse.keyple.core.selection.*;
import org.eclipse.keyple.core.seproxy.*;
import org.eclipse.keyple.core.seproxy.SeSelector.*;
import org.eclipse.keyple.core.util.ByteArrayUtil;
import org.eclipse.keyple.plugin.pcsc.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DemoPoAuthentication  {

    private static final Logger logger = LoggerFactory.getLogger(DemoPoAuthentication.class);

    // PO Reader name  
    private final static String PO_READER_NAME = "XXX";
    
    // SAM Reader name
    private final static String SAM_READER_NAME = "XXX";

    // Keyple test kit profile 1, Application 2
    private final static String AID = "315449432E49434131";
    private final static byte RECORD_NUMBER_1 = 1;
    private final static byte SFI_Environment = (byte) 0x07;

    public static void main(String[] args) {

        // Get the instance of the SeProxyService (Singleton pattern)
        SeProxyService seProxyService = SeProxyService.getInstance();

        logger.info("============================================================================");
        logger.info("=                  Get and Configure the PO & SAM Readers                  =");
        logger.info("============================================================================");
        
        // Register the PcscPlugin with SeProxyService, get the corresponding generic ReaderPlugin
        ReaderPlugin readerPlugin = seProxyService.registerPlugin(new PcscPluginFactory());

        // Get the PO reader 
        SeReader poReader = readerPlugin.getReader(PO_READER_NAME);

        // Configure the PO reader parameters
        ((PcscReader)poReader).setContactless(true);    

        // Get a SAM reader
        SeReader samReader = readerPlugin.getReader(SAM_READER_NAME);

        // Eventually, configure the SAM reader parameters
        // ...

        logger.info("============================================================================");
        logger.info("=              Create a SAM resource after selecting the SAM               =");
        logger.info("============================================================================");

        // Prepare the selector to ensure the correct SAM is used
        SamSelector samSelector = SamSelector.builder().samRevision(SamRevision.AUTO).build();

        // Make the SAM selection
        SeSelection samSelection = new SeSelection();
        samSelection.prepareSelection(new SamSelectionRequest(samSelector));
        CalypsoSam calypsoSam;
        if (samReader.isSePresent()) {
        	SelectionsResult selectionsResult = samSelection.processExplicitSelection(samReader);
        	if (selectionsResult.hasActiveSelection()) {
        		calypsoSam = (CalypsoSam) selectionsResult.getActiveMatchingSe();
        	} else {
        		throw new IllegalStateException("SAM matching failed!");
        	}
        } else {
        	throw new IllegalStateException("No SAM is present in the reader " + samReader.getName());
        }
        
        // Associate the calypsoSam and the samReader to create the samResource
        SeResource<CalypsoSam> samResource = new SeResource<CalypsoSam>(samReader, calypsoSam);
        
        // Prepare the security settings used during the Calypso transaction
        PoSecuritySettings poSecuritySettings = new PoSecuritySettings.PoSecuritySettingsBuilder(samResource).build();

        logger.info("============================================================================");
        logger.info("=           Display basic information about the readers and SAM            =");
        logger.info("============================================================================");

        logger.info(
        		"= PO Reader Name = {}", 
        		poReader.getName());
        String samSerialNumber = ByteArrayUtil.toHex(samResource.getMatchingSe().getSerialNumber());
        logger.info(
        		"= SAM Reader Name = {}, Serial Number = {}",
        		samResource.getSeReader().getName(),
                samSerialNumber);
        
        logger.info("============================================================================");
        logger.info("=                     Prepare the Calypso PO selection                     =");
        logger.info("============================================================================");

        // Prepare a Calypso PO selection
        SeSelection seSelection = new SeSelection();

        // Setting of an AID based selection of a Calypso Revision 3.1 PO
        //
        // Select the first application matching the selection AID whatever the card communication protocol
        // Keep the logical channel open after the selection
        //
        // Calypso selection: configures a PoSelectionRequest with all the desired attributes to
        // make the selection and read additional information afterwards
        PoSelectionRequest poSelectionRequest = new PoSelectionRequest(
                PoSelector.builder()
                        .aidSelector(AidSelector.builder().aidToSelect(AID).build()) // the application identifier
                        .invalidatedPo(InvalidatedPo.REJECT) // to indicate if an invalidated PO should be accepted or not
                        .build());

        // Add the selection case to the current selection 
        // (we could have added other cases)
        seSelection.prepareSelection(poSelectionRequest);

        logger.info("============================================================================");
        logger.info("=                  Check if a PO is present in the reader                  =");
        logger.info("============================================================================");
        
        if (poReader.isSePresent()) {
            logger.info("============================================================================");
            logger.info("=                    Start of the Calypso PO processing                    =");
            logger.info("============================================================================");
            logger.info("=                             1st PO exchange                              =");
            logger.info("=                           AID based selection                            =");
            logger.info("============================================================================");

            try {
            	// Actual PO communication: operate through a single request the Calypso PO selection
            	CalypsoPo calypsoPo =
                    (CalypsoPo) seSelection.processExplicitSelection(poReader).getActiveMatchingSe();

            	logger.info("The selection of the PO has succeeded.");

            	logger.info("============================================================================");
                logger.info("=                            2nd PO exchange                               =");
                logger.info("=                     Open a Calypso secure session                        =");
                logger.info("=                  Reading of Environment file (SFI=07h)                   =");
                logger.info("============================================================================");

                // Create a PoTransaction object to manage the Calypso transaction
                PoTransaction poTransaction = new PoTransaction(
                		new SeResource<CalypsoPo>(poReader, calypsoPo), 
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
                logger.info("File Environment log: {}", environmentLog);
                
                if (!calypsoPo.isDfRatified()) {
                	logger.info("============= Previous Calypso Secure Session was not ratified =============");
                }

                logger.info("============================================================================");
                logger.info("=                            3th PO exchange                               =");
                logger.info("=                     Close the Calypso secure session                     =");
                logger.info("============================================================================");
                
                // To close the channel with the PO after the closing
                poTransaction.prepareReleasePoChannel();
                
                // Close the Calypso Secure Session
                // A ratification command will be sent (CONTACTLESS_MODE)         
                poTransaction.processClosing();

                logger.info("============================================================================");
                logger.info("=              The Calypso secure session ended successfully               =");
                logger.info("=                   (Successful mutual authentication)                     =");
                logger.info("=                    End of the Calypso PO processing                      =");
                logger.info("============================================================================");
            } catch (Exception e) {
                logger.error("Exception: {}", e.getMessage());
            }
        } else {
            logger.error("The selection of the PO has failed.");
        }
        System.exit(0);
    }
}
```
Copy the properties file below in a new properties file named simplelogger.properties in resources. The application log output format is configurable in this properties files.

```properties
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
## Run

Connect your PO and SAM readers.

Put the SAM in the SAM reader.

Place the PO on the PO reader.

Configure the PO and SAM readers you use in the java file (you have to respect the case for the reader name) :
```java
    /* PO Reader name */
    private final static String PO_READER_NAME = "XXX";
    /* SAM Reader name */
    private final static String SAM_READER_NAME = "XXX";
```
If you don’t know the reader name, run the application in debug mode and get the reader name in plugin variable

Run the application.

Note: All project dependencies, including Keyple components, are downloaded during the first run, which can take several minutes.
