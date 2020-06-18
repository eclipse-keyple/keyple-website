---
title: Get Started with Keyple-Java
linktitle: Java
toc: true
type: docs
date: "2020-02-24T00:00:00+01:00"
draft: false
menu:
  docs:
    parent: Get Started
    weight: 100

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 100
---

This getting stated contains one ready-to-execute JAVA example starting from a new Gradle project.

The example demonstrate Keyple capabilities with the Keyple PCSC plugin and PO/SAM provided in the Calypso Test Kit.

## Build

The example can run on any machine: Linux, Windows and MacOS. If not installed in your machine, you will need to download :

Java 1.6 or newer

Gradle (any version) download

We recommend that you use a Java IDE like Eclipse or Intellij to create your new Gradle project.

Create a new Gradle project.

Add the following statements to your build.gradle file to import Keyple components into your project:

```java
repositories {
    //to import snapshots
    maven {url 'https://oss.sonatype.org/content/repositories/snapshots' }
    //to import releases
    //maven { url 'https://oss.sonatype.org/content/repositories/releases' }
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
Copy the source code below in a new Java Class named Demo_CalypsoTestKit_App2_Pcsc:
```java
/********************************************************************************
 * Copyright (c) Calypso Networks Association 2020 https://www.calypsonet-asso.org/
 *
 * See the NOTICE file(s) distributed with this work for additional information regarding copyright
 * ownership.
 *
 * This program and the accompanying materials are made available under the terms of the Eclipse
 * Public License 2.0 which is available at http://www.eclipse.org/legal/epl-2.0
 *
 * SPDX-License-Identifier: EPL-2.0
 ********************************************************************************/

import org.eclipse.keyple.calypso.command.po.parser.ReadDataStructure;
import org.eclipse.keyple.calypso.command.po.parser.ReadRecordsRespPars;
import org.eclipse.keyple.calypso.command.sam.SamRevision;
import org.eclipse.keyple.calypso.transaction.*;
import org.eclipse.keyple.core.selection.*;
import org.eclipse.keyple.core.seproxy.*;
import org.eclipse.keyple.core.seproxy.exception.KeypleBaseException;
import org.eclipse.keyple.core.seproxy.exception.KeypleReaderException;
import org.eclipse.keyple.core.seproxy.exception.NoStackTraceThrowable;
import org.eclipse.keyple.core.seproxy.protocol.SeCommonProtocols;
import org.eclipse.keyple.core.util.ByteArrayUtil;
import org.eclipse.keyple.plugin.pcsc.PcscPlugin;
import org.eclipse.keyple.plugin.pcsc.PcscPluginFactory;
import org.eclipse.keyple.plugin.pcsc.PcscProtocolSetting;
import org.eclipse.keyple.plugin.pcsc.PcscReader;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Demo_CalypsoTestKit_App2_Pcsc  {

    private static final Logger logger =
            LoggerFactory.getLogger(Demo_CalypsoTestKit_App2_Pcsc.class);

    /* Plugin name */
    private final static String PLUGIN_NAME = "PcscPlugin";
    /* PO Reader name */
    private final static String PO_READER_NAME = "ASK LoGO 0";
    /* SAM Reader name */
    private final static String SAM_READER_NAME = "Identive CLOUD 2700 R Smart Card Reader 0";

    /* AID: Keyple test kit profile 1, Application 2 */
    private final static String AID = "315449432E49434131";


    private final static byte RECORD_NUMBER_1 = 1;

    private final static byte SFI_EnvironmentAndHolder = (byte) 0x07;


    public static void main(String[] args) throws KeypleBaseException, NoStackTraceThrowable {

        /* Get the instance of the SeProxyService (Singleton pattern) */
        SeProxyService seProxyService = SeProxyService.getInstance();

        logger.info(
                "=================================================================================");
        logger.info(
                "=                     Configuration of the PO & SAM Readers                     =");
        logger.info(
                "=================================================================================");

        /* Assign PcscPlugin to the SeProxyService */
        seProxyService.registerPlugin(new PcscPluginFactory());

        /* Get the PcscPlugin */
        ReaderPlugin plugin = seProxyService.getPlugin(PcscPlugin.PLUGIN_NAME);

        /* Get the PO reader */
        SeReader poReader = plugin.getReader(PO_READER_NAME);

        /* Sets the PO reader parameters for contactless secure elements */
        setContactlessSettings(poReader);

        /* Get a SAM reader */
        SeReader samReader = plugin.getReader(SAM_READER_NAME);

        /* Sets the reader parameters for contacts secure elements */
        setContactsSettings(samReader);

        logger.info(
                "=================================================================================");
        logger.info(
                "=                       Opening logical channel with the SAM                    =");
        logger.info(
                "=================================================================================");
        /*
         * Open logical channel for the SAM inserted in the reader
         * (We expect the right is inserted)
         */
        SamResource samResource = checkSamAndOpenChannel(samReader);

        /* Check if the readers exists */
        if (poReader == null || samResource == null) {
            throw new IllegalStateException("Bad PO or SAM reader setup");
        }

        logger.info("======= Secure reading of Environment and Holder file & Po Authentication =======");
        logger.info("= PO Reader  NAME = {}", poReader.getName());
        logger.info("= SAM Reader  NAME = {}", samResource.getSeReader().getName());

        /* Check if a PO is present in the reader */
        if (poReader.isSePresent()) {

            logger.info(
                    "=================================================================================");
            logger.info(
                    "=                       Start of the Calypso PO processing.                     =");
            logger.info(
                    "=================================================================================");
            logger.info(
                    "=                                1st PO exchange                                =");
            logger.info(
                    "=                              AID based selection                              =");
            logger.info(
                    "=================================================================================");

            /*
             * Prepare a Calypso PO selection
             */
            SeSelection seSelection = new SeSelection();

            /*
             * Setting of an AID based selection of a Calypso REV3 PO
             *
             * Select the first application matching the selection AID whatever the SE communication protocol
             * Keep the logical channel open after the selection
             *
             * Calypso PO selection: configures a PoSelectionRequest with all the desired attributes to
             * make the selection and read additional information afterwards
             */
            PoSelectionRequest poSelectionRequest = new PoSelectionRequest(
                    new PoSelector( //the selector to target a particular SE
                            SeCommonProtocols.PROTOCOL_ISO14443_4, // the SE communication protocol
                            null, // the ATR filter
                            new PoSelector.PoAidSelector( // the AID selection data
                                    new SeSelector.AidSelector.IsoAid(AID), // the application identifier
                                    PoSelector.InvalidatedPo.REJECT), // an enum value to indicate if an invalidated PO should be accepted or not
                            "AID: "+ AID), // information string (to be printed in logs)
                    ChannelState.KEEP_OPEN); // tell if the channel is to be closed or not after the command

            /*
             * Add the selection case to the current selection (we could have added other cases
             * here)
             */
            seSelection.prepareSelection(poSelectionRequest);

            /*
             * Actual PO communication: operate through a single request the Calypso PO selection
             * and the file read
             */
            SelectionsResult selectionsResult = seSelection.processExplicitSelection(poReader);

            if (selectionsResult.hasActiveSelection()) {
                MatchingSelection matchingSelection = selectionsResult.getActiveSelection();

                CalypsoPo calypsoPo = (CalypsoPo) matchingSelection.getMatchingSe();
                logger.info("The selection of the PO has succeeded.");

                logger.info(
                        "=================================================================================");
                logger.info(
                        "=                                2nd PO exchange                                =");
                logger.info(
                        "=                             Open a secure session                             =");
                logger.info(
                        "=                Reading of Environment and Holder file (SFI=07h)               =");
                logger.info(
                        "=================================================================================");

                PoTransaction poTransaction = new PoTransaction(new PoResource(poReader, calypsoPo),
                        samResource, new SecuritySettings());

                /*
                 * Prepare the reading order and keep the associated parser for later use once the
                 * transaction has been processed.
                 */
                int readEnvironmentAndHolderParserIndex = poTransaction.prepareReadRecordsCmd(
                        SFI_EnvironmentAndHolder, // the sfi top select
                        ReadDataStructure.SINGLE_RECORD_DATA, // read mode enum to indicate a SINGLE, MULTIPLE or COUNTER read
                        RECORD_NUMBER_1, // the record number to read (or first record to read in case of several records)
                        String.format( // extra information included in the logs (can be null or empty)
                                "EventLog (SFI=%02X, recnbr=%d))",
                                SFI_EnvironmentAndHolder,
                                RECORD_NUMBER_1));

                /*
                 * Open Session for the debit key
                 */
                boolean poProcessStatus = poTransaction.processOpening(
                        PoTransaction.ModificationMode.ATOMIC,
                        PoTransaction.SessionAccessLevel.SESSION_LVL_DEBIT, (byte) 0, (byte) 0);

                if (!poProcessStatus) {
                    throw new IllegalStateException("processingOpening failure.");
                }

                if (!poTransaction.wasRatified()) {
                    logger.info(
                            "=================== Previous Secure Session was not ratified ====================");
                }


                /*
                 * Retrieve the data read from the parser updated during the transaction process
                 */
                byte EnvironmentAndHolderLog[] = (((ReadRecordsRespPars) poTransaction
                        .getResponseParser(readEnvironmentAndHolderParserIndex)).getRecords())
                        .get((int) RECORD_NUMBER_1);

                /* Log the result */
                logger.info("Environment And Holder file data: {}", ByteArrayUtil.toHex(EnvironmentAndHolderLog));

                logger.info(
                        "=================================================================================");
                logger.info(
                        "=                                3th PO exchange                                =");
                logger.info(
                        "=                           Close the secure session                            =");
                logger.info(
                        "=================================================================================");
                /*
                 * Close the Secure Session.
                 * A ratification command will be sent (CONTACTLESS_MODE).
                 */
                poProcessStatus = poTransaction.processClosing(ChannelState.CLOSE_AFTER);

                if (!poProcessStatus) {
                    throw new IllegalStateException("processClosing failure.");
                }

                logger.info(
                        "=================================================================================");
                logger.info(
                        "=                       Successful mutual authentication                        =");
                logger.info(
                        "=                       End of the Calypso PO processing                        =");
                logger.info(
                        "=================================================================================");
            } else {
                logger.error("The selection of the PO has failed.");
            }
        } else {
            logger.error("No PO were detected.");
        }
        System.exit(0);
    }

    /**
     * Sets the reader parameters for contactless secure elements
     *
     * @param reader the reader to configure
     * @throws KeypleBaseException in case of an error while settings the parameters
     */
    private static void setContactlessSettings(SeReader reader) throws KeypleBaseException {
        /* Enable logging */
        reader.setParameter(PcscReader.SETTING_KEY_LOGGING, "true");

        /* Contactless SE works with T1 protocol */
        reader.setParameter(PcscReader.SETTING_KEY_PROTOCOL, PcscReader.SETTING_PROTOCOL_T1);

        /*
         * PC/SC card access mode:
         * The PO reader is set to EXCLUSIVE mode to avoid side effects during the selection step
         * that may result in session failures.
         */
        reader.setParameter(PcscReader.SETTING_KEY_MODE, PcscReader.SETTING_MODE_EXCLUSIVE);

        /* Set the PO reader protocol flag */
        reader.addSeProtocolSetting(
                SeCommonProtocols.PROTOCOL_ISO14443_4,
                PcscProtocolSetting.PCSC_PROTOCOL_SETTING.get(SeCommonProtocols.PROTOCOL_ISO14443_4));
    }

    /**
     * Sets the reader parameters for contacts secure elements
     *
     * @param reader the reader to configure
     * @throws KeypleBaseException in case of an error while settings the parameters
     */
    private static void setContactsSettings(SeReader reader) throws KeypleBaseException {
        /* Enable logging */
        reader.setParameter(PcscReader.SETTING_KEY_LOGGING, "true");

        /* Contactless SE works with T0 protocol */
        reader.setParameter(PcscReader.SETTING_KEY_PROTOCOL, PcscReader.SETTING_PROTOCOL_T0);

        /*
         * PC/SC card access mode:
         * The SAM is left in the SHARED mode (by default) to avoid automatic resets due to the
         * limited time between two consecutive exchanges granted by Windows.
         */
        reader.setParameter(PcscReader.SETTING_KEY_MODE, PcscReader.SETTING_MODE_SHARED);

        /* Set the SAM reader protocol flag */
        reader.addSeProtocolSetting(
                SeCommonProtocols.PROTOCOL_ISO7816_3,
                PcscProtocolSetting.PCSC_PROTOCOL_SETTING.get(SeCommonProtocols.PROTOCOL_ISO7816_3));
    }

    /**
     * Check SAM presence and consistency and return a SamResource when everything is correct.
     *
     * Throw an exception if the expected SAM is not available
     *
     * @param samReader the SAM reader
     */
    private static SamResource checkSamAndOpenChannel(SeReader samReader) {
        /*
         * Check the availability of the SAM doing a ATR based selection,
         * open its physical and logical channels,
         * keep it open
         */
        SeSelection samSelection = new SeSelection();

        SamSelector samSelector = new SamSelector(SamRevision.C1, ".*", "Selection SAM C1");

        /* Prepare selector, ignore AbstractMatchingSe here */
        samSelection.prepareSelection(new SamSelectionRequest(samSelector, ChannelState.KEEP_OPEN));
        CalypsoSam calypsoSam;

        try {
            calypsoSam = (CalypsoSam) samSelection.processExplicitSelection(samReader)
                    .getActiveSelection().getMatchingSe();
            if (!calypsoSam.isSelected()) {
                throw new IllegalStateException("Unable to open a logical channel for SAM!");
            }
        } catch (KeypleReaderException e) {
            throw new IllegalStateException("SAM Reader exception: " + e.getMessage());
        }
        return new SamResource(samReader, calypsoSam);
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
org.slf4j.simpleLogger.defaultLogLevel=trace

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
If you don’t know the reader name, run the application in debug mode and get the reader name in plugin variable returned by:
> seProxyService.getPlugin(PLUGIN_NAME) methode: plugin -> readers -> X -> terminal -> name .

Run the application.

Note: All project dependencies, including Keyple components, are downloaded during the first run, which can take several minutes.
