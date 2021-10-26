---
title: Build your first C++ application
linktitle: C++
summary: This quick start describes how to create a ready-to-execute C++ command-line application that runs a simple transaction based on a Calypso portable object involving two smart card readers.
type: book
toc: true
draft: false
weight: 230
---
{{% callout warning %}}
Version 1.0 of the documentation is no longer actively maintained. The site that you are currently viewing is an archived snapshot. For up-to-date documentation, see the latest version.
{{% /callout %}}

This quick start describes how to create a ready-to-execute C++
command-line application that runs a simple transaction based on
a Calypso portable object (PO) involving two smart card readers.

{{% callout note %}}
The demonstration application created for this quick start requires a
Calypso PO (contactless smart card, mobile phone with contactless
communication) and a Calypso Secure Access Module (SAM). {{% /callout %}}

We will use three main components of Keyple:
* [Keyple Core]({{< ref "/components-cpp-0.9/core/" >}})
  which is the base component to which all the others refer,
* [Keyple PC/SC plugin]({{< ref "/components-cpp-0.9/plugins/pcsc" >}})
  to provide the ability to manage PC/SC readers,
* [Keyple Calypso extension]({{< ref "/components-cpp-0.9/extensions/calypso" >}})
  to handle the commands sent to the Calypso PO and the Calypso SAM.

In this guide CMake is used as build automation tool.

The example can run on any machine: Linux, Windows and macOS. If not installed in your machine, you
will need to download :

- CMake 2.8 or newer [(download)](https://cmake.org/install/)
- GCC / CLang / MSVC compiler

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

Copy the source code below in a new C++ Class named
DemoPoAuthentication.

```cpp
/* Common */
#include "IllegalStateException.h"
#include "LoggerFactory.h"

/* Core */
#include "ByteArrayUtil.h"
#include "SeCommonProtocols.h"
#include "SeSelector.h"
#include "SeSelection.h"
#include "SeProxyService.h"

/* PCSC */
#include "PcscPluginFactory.h"
#include "PcscProtocolSetting.h"
#include "PcscReader.h"

/* Calypso */
#include "CalypsoPo.h"
#include "CalypsoSam.h"
#include "ElementaryFile.h"
#include "PoSecuritySettings.h"
#include "PoSelectionRequest.h"
#include "PoSelector.h"
#include "PoTransaction.h"
#include "SamRevision.h"
#include "SamSelector.h"
#include "SamSelectionRequest.h"

using namespace keyple::calypso::command::po;
using namespace keyple::calypso::command::po::builder;
using namespace keyple::calypso::command::po::parser;
using namespace keyple::calypso::command::sam;
using namespace keyple::calypso::transaction;
using namespace keyple::common;
using namespace keyple::common::exception;
using namespace keyple::core::command::exception;
using namespace keyple::core::selection;
using namespace keyple::core::seproxy;
using namespace keyple::core::seproxy::event;
using namespace keyple::core::seproxy::exception;
using namespace keyple::core::seproxy::message;
using namespace keyple::core::seproxy::protocol;
using namespace keyple::core::util;
using namespace keyple::plugin::pcsc;

int main(int argv, char **args)
{
    // ...

    return 0;
}
```

### Configure the PC/SC plugin and the readers

The first step to use Keyple is to initialize the plugin and smart card readers.

In this snippet the PC/SC plugin is registered to the SmartCardService.

Two readers needs to be connected to the local machine. Replace
"PO_READER_NAME" and "SAM_READER_NAME" with the name of the USB readers.

If you don't know the names of the readers, read how to find them in the [FAQ](#faq).

```cpp
/* ... */
/* PO Reader name */
const std::string PO_READER_NAME = "XXX";

/* SAM Reader name */
const std::string SAM_READER_NAME = "XXX";

/* Get the instance of the SeProxyService (Singleton pattern) */
SeProxyService& seProxyService = SeProxyService::getInstance();

/* Register the PcscPlugin with SeProxyService, get the corresponding generic ReaderPlugin */
auto pluginFactory = std::make_shared<PcscPluginFactory>();
std::shared_ptr<ReaderPlugin> readerPlugin = seProxyService.registerPlugin(pluginFactory);

/* Get the PO reader */
std::shared_ptr<SeReader> poReader = readerPlugin->getReader(PO_READER_NAME);

/* Configure the PO reader parameters */
poReader->setParameter(PcscReader::SETTING_KEY_PROTOCOL, PcscReader::SETTING_PROTOCOL_T1);

/* Get a SAM reader */
std::shared_ptr<SeReader> samReader = readerPlugin->getReader(SAM_READER_NAME);

/* Configure the SAM reader parameters */
samReader->setParameter(PcscReader::SETTING_KEY_PROTOCOL, PcscReader::SETTING_PROTOCOL_T0);

/*
 * PC/SC card access mode:
 *
 * The SAM is left in the SHARED mode (by default) to avoid automatic resets due to the limited
 * time between two consecutive exchanges granted by Windows.
 *
 * This point will be addressed in a coming release of the Keyple PcSc reader plugin.
 *
 * The PO reader is set to EXCLUSIVE mode to avoid side effects (on OS Windows 8+) during the
 * selection step that may result in session failures.
 *
 * See KEYPLE-CORE.PC.md file to learn more about this point.
 *
 */
samReader->setParameter(PcscReader::SETTING_KEY_MODE, PcscReader::SETTING_MODE_SHARED);
poReader->setParameter(PcscReader::SETTING_KEY_MODE, PcscReader::SETTING_MODE_SHARED);

/* Set the PO reader protocol flag */
poReader->addSeProtocolSetting(
    SeCommonProtocols::PROTOCOL_ISO14443_4,
    PcscProtocolSetting::PCSC_PROTOCOL_SETTING[SeCommonProtocols::PROTOCOL_ISO14443_4]);
poReader->addSeProtocolSetting(
    SeCommonProtocols::PROTOCOL_B_PRIME,
    PcscProtocolSetting::PCSC_PROTOCOL_SETTING[SeCommonProtocols::PROTOCOL_B_PRIME]);
samReader->addSeProtocolSetting(
    SeCommonProtocols::PROTOCOL_ISO7816_3,
    PcscProtocolSetting::PCSC_PROTOCOL_SETTING[SeCommonProtocols::PROTOCOL_ISO7816_3]);

/* ... */
```

### Select the Calypso SAM

Before executing a transaction each smart card should be selected. The
next step is the selection of the Calypso SAM resulting in a
CalypsoSam object.

It is then combined with the SAM reader to form the SAM resource needed
later within the transaction service.

```cpp
/* ... */

/* Prepare the selector to ensure the correct SAM is used */
auto selector = SamSelector::builder()->samRevision(SamRevision::AUTO).build();
auto samSelector = std::dynamic_pointer_cast<SamSelector>(selector);

/* Make the SAM selection */
SeSelection samSelection;
auto samSelectionRequest = std::make_shared<SamSelectionRequest>(samSelector);
auto abstractSamSelectionRequest =
    std::reinterpret_pointer_cast<AbstractSeSelectionRequest<AbstractApduCommandBuilder>>(samSelectionRequest);
samSelection.prepareSelection(abstractSamSelectionRequest);
std::shared_ptr<CalypsoSam> calypsoSam;

if (samReader->isSePresent()) {
    std::shared_ptr<SelectionsResult> selectionsResult = samSelection.processExplicitSelection(samReader);
    if (selectionsResult->hasActiveSelection()) {
        calypsoSam = std::dynamic_pointer_cast<CalypsoSam>(selectionsResult->getActiveMatchingSe());
    } else {
        throw IllegalStateException("SAM matching failed!");
    }
} else {
    throw IllegalStateException("No SAM is present in the reader " + samReader->getName());
}

/* Associate the calypsoSam and the samReader to create the samResource */
auto samResource = std::make_shared<SeResource<CalypsoSam>>(samReader, calypsoSam);

/* ... */
```

### Select the Calypso PO

1st PO exchange:

The Calypso PO selection is made using the portable object application's AID
and results in a CalypsoPo object that will contain all the information extracted
from the Calypso PO all along the transaction.

```cpp
/* Prepare a Calypso PO selection */
SeSelection seSelection;

/* Keyple test kit profile 1, Application 2 */
const std::string AID = "315449432E49434131";

/*
 * Setting of an AID based selection of a Calypso Revision 3.1 PO
 *
 * Select the first application matching the selection AID whatever the card communication
 * protocol
 * Keep the logical channel open after the selection
 *
 * Calypso selection: configures a PoSelectionRequest with all the desired attributes to
 * make the selection and read additional information afterwards
 */
 auto aidSelector = SeSelector::AidSelector::builder()->aidToSelect(AID).build();
auto seSelector = PoSelector::builder()->aidSelector(aidSelector) /* The application identifier
                                         to indicate if an invalidated PO should be accepted
                                         or not */
                                        .invalidatedPo(PoSelector::InvalidatedPo::REJECT)
                                        .build();
auto poSelector = std::dynamic_pointer_cast<PoSelector>(seSelector);
auto poSelectionRequest = std::make_shared<PoSelectionRequest>(poSelector);


/* Add the selection case to the current selection (we could have added other cases) */
auto abstractPoSelectionRequest =
    std::reinterpret_pointer_cast<AbstractSeSelectionRequest<AbstractApduCommandBuilder>>(poSelectionRequest);
seSelection.prepareSelection(abstractPoSelectionRequest);

if (poReader->isSePresent()) {
    try {
        // Actual PO communication: operate through a single request the Calypso PO selection
        std::shared_ptr<CalypsoPo> calypsoPo =
            std::dynamic_pointer_cast<CalypsoPo>(
                seSelection.processExplicitSelection(poReader)->getActiveMatchingSe());
        /* ... */
    } catch (const Exception& e) {
    }
/* ... */
```

### Open the Calypso secure session

2nd PO exchange :

The secure session opening operated by the PoTransaction service is
combined with the reading of the environment file (SFI=07h).

The mutual authentication process between Calypso PO and Calypso SAM is initiated transparently.

```cpp
/* Prepare the security settings used during the Calypso transaction */
auto poSecuritySettings = std::make_shared<PoSecuritySettings::PoSecuritySettingsBuilder>(samResource)->build();

/* Create a PoTransaction object to manage the Calypso transaction */
auto poTransaction = std::make_shared<PoTransaction>(
                            std::make_shared<SeResource<CalypsoPo>>(poReader, calypsoPo),
                            poSecuritySettings);

const uint8_t RECORD_NUMBER_1 = 1;
const uint8_t SFI_Environment = 0x07;

/* Read the Environment file at the Session Opening (we could have added other commands) */
poTransaction->prepareReadRecordFile(
        SFI_Environment, /* The sfi to select */
        RECORD_NUMBER_1);

/* Open Session with the debit key */
poTransaction->processOpening(PoTransaction::SessionSetting::AccessLevel::SESSION_LVL_DEBIT);

/* Get the Environment data */
std::shared_ptr<ElementaryFile> efEnvironment = calypsoPo->getFileBySfi(SFI_Environment);
const std::string environmentLog = ByteArrayUtil::toHex(efEnvironment->getData()->getContent());

/* ... */
```

### Close the Calypso secure session

3rd PO exchange:

Simply close the Calypso secure session

The mutual authentication is finalized, it includes the authentication
of the data in the read file.

Note: any technical, crytographic or content-related incident in the Calypso PO
would be signalled by an exception and would interrupt the thread of
execution.

```cpp
/* Schedule the closure of the channel with the PO after the closing of the secure session */
poTransaction->prepareReleasePoChannel();

/* Perform the closing of the Calypso Secure Session */
poTransaction->processClosing();

/* ... */
```

Find the complete code source [below](#full-code).

---
## CMake build

Create a CMakeLists.txt file as follows:

```cpp
#
# Copyright (c) 2020 Calypso Networks Association https://www.calypsonet-asso.org/
#
# All rights reserved. This program and the accompanying materials are made available under the
# terms of the Eclipse Public License version 2.0 which accompanies this distribution, and is
# available at https://www.eclipse.org/org/documents/epl-2.0/EPL-2.0.html
#

CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

SET(CMAKE_LEGACY_CYGWIN_WIN32 0)
SET(CMAKE_MACOSX_RPATH 1)
SET(CMAKE_CXX_STANDARD 11)

SET(CMAKE_C_COMPILER_WORKS 1)
SET(CMAKE_CXX_COMPILER_WORKS 1)

PROJECT(KeypleDemo)

SET(KEYPLE_SOURCE_DIR "<path_to_keyple_repos>")

INCLUDE_DIRECTORIES(
        ${CMAKE_CURRENT_SOURCE_DIR}

        # Core
        ${KEYPLE_SOURCE_DIR}/component/keyple-core/src/main/command
        ${KEYPLE_SOURCE_DIR}/component/keyple-core/src/main/command/exception
        ${KEYPLE_SOURCE_DIR}/component/keyple-core/src/main/selection
        ${KEYPLE_SOURCE_DIR}/component/keyple-core/src/main/seproxy
        ${KEYPLE_SOURCE_DIR}/component/keyple-core/src/main/seproxy/event
        ${KEYPLE_SOURCE_DIR}/component/keyple-core/src/main/seproxy/exception
        ${KEYPLE_SOURCE_DIR}/component/keyple-core/src/main/seproxy/message
        ${KEYPLE_SOURCE_DIR}/component/keyple-core/src/main/seproxy/protocol
        ${KEYPLE_SOURCE_DIR}/component/keyple-core/src/main/util
        ${KEYPLE_SOURCE_DIR}/component/keyple-core/src/main/util/bertlv

        # Plugin
        ${KEYPLE_SOURCE_DIR}/component/keyple-plugin/pcsc/src/main

        # Common
        ${KEYPLE_SOURCE_DIR}/component/keyple-common/src/main
        ${KEYPLE_SOURCE_DIR}/component/keyple-common/src/main/exception

        # Calypso
        ${KEYPLE_SOURCE_DIR}/component/keyple-calypso/src/main
        ${KEYPLE_SOURCE_DIR}/component/keyple-calypso/src/main/command
        ${KEYPLE_SOURCE_DIR}/component/keyple-calypso/src/main/command/po
        ${KEYPLE_SOURCE_DIR}/component/keyple-calypso/src/main/command/po/builder
        ${KEYPLE_SOURCE_DIR}/component/keyple-calypso/src/main/command/po/parser
        ${KEYPLE_SOURCE_DIR}/component/keyple-calypso/src/main/command/sam
        ${KEYPLE_SOURCE_DIR}/component/keyple-calypso/src/main/transaction

        # pcsc (Linux / macOS)
        /usr/include/PCSC
)

IF(WIN32)
        SET(CMAKE_FIND_LIBRARY_PREFIXES "")
        SET(CMAKE_FIND_LIBRARY_SUFFIXES ".dll")
        SET(CMAKE_BUILD_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")
        SET(WINSCARD winscard.lib)
ENDIF(WIN32)

IF(APPLE)
        SET(CMAKE_FIND_LIBRARY_PREFIXES "lib")
        SET(CMAKE_FIND_LIBRARY_SUFFIXES ".dylib")
        SET(CMAKE_BUILD_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")
        SET(WINSCARD "-framework PCSC")
ENDIF(APPLE)

IF(UNIX)
        SET(SPEC_LIBS pthread pcsclite rt)
ENDIF(UNIX)

IF(APPLE)
        SET(SPEC_LIBS pthread)
ENDIF(APPLE)

ADD_EXECUTABLE(
        demo_po_authentication

        ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
)

TARGET_LINK_DIRECTORIES(demo_po_authentication PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/build)
TARGET_LINK_LIBRARIES(demo_po_authentication keyplecommon keyplepluginpcsc keyplecore keyplecalypso ${SPEC_LIBS})
```

Now build the demo code:

```bash
mkdir build
cd build
cmake ..
make
```

---
## Run

1) Connect two USB PC/SC Readers.
2) Insert the Calypso SAM in the SAM reader.
3) Insert the Calypso PO in the PO reader.
4) Run the application.

---
## FAQ

**How do I find out the names of the readers?**

If you don’t know the reader name, several options:
* run the application in debug mode and get the reader name in plugin variable
* run 'pcsctest' (macOS)
* run 'pcsc_scan' (Linux)

Identify which reader will be the PO (contactless) reader and the SAM
(contact) reader and replace ```PO_READER_NAME``` and
```SAM_READER_NAME``` with their values.

**How to activate the Keyple's logs?**

Logs are automatically activated but log level can be dynamically changed by a simple call to the
Logger::setLevel() function. Default value is Logger::Level::logDebug.

```cpp
class DemoPoAuthentication final {};
const std::shared_ptr<Logger> logger = LoggerFactory::getLogger(typeid(DemoPoAuthentication));
logger->setLoggerLevel(Logger::Level::logError);
```

#### Full code

Here is the complete code of this quick start in one single block.

```cpp
/**************************************************************************************************
 * Copyright (c) 2020 Calypso Networks Association                                                *
 * https://www.calypsonet-asso.org/                                                               *
 *                                                                                                *
 * See the NOTICE file(s) distributed with this work for additional information regarding         *
 * copyright ownership.                                                                           *
 *                                                                                                *
 * This program and the accompanying materials are made available under the terms of the Eclipse  *
 * Public License 2.0 which is available at http://www.eclipse.org/legal/epl-2.0                  *
 *                                                                                                *
 * SPDX-License-Identifier: EPL-2.0                                                               *
 **************************************************************************************************/

/* Common */
#include "IllegalStateException.h"
#include "LoggerFactory.h"

/* Core */
#include "ByteArrayUtil.h"
#include "SeCommonProtocols.h"
#include "SeSelector.h"
#include "SeSelection.h"
#include "SeProxyService.h"

/* PCSC */
#include "PcscPluginFactory.h"
#include "PcscProtocolSetting.h"
#include "PcscReader.h"

/* Calypso */
#include "CalypsoPo.h"
#include "CalypsoSam.h"
#include "ElementaryFile.h"
#include "PoSecuritySettings.h"
#include "PoSelectionRequest.h"
#include "PoSelector.h"
#include "PoTransaction.h"
#include "SamRevision.h"
#include "SamSelector.h"
#include "SamSelectionRequest.h"

using namespace keyple::calypso::command::po;
using namespace keyple::calypso::command::po::builder;
using namespace keyple::calypso::command::po::parser;
using namespace keyple::calypso::command::sam;
using namespace keyple::calypso::transaction;
using namespace keyple::common;
using namespace keyple::common::exception;
using namespace keyple::core::command::exception;
using namespace keyple::core::selection;
using namespace keyple::core::seproxy;
using namespace keyple::core::seproxy::event;
using namespace keyple::core::seproxy::exception;
using namespace keyple::core::seproxy::message;
using namespace keyple::core::seproxy::protocol;
using namespace keyple::core::util;
using namespace keyple::plugin::pcsc;

class DemoPoAuthentication final {};
const std::shared_ptr<Logger> logger = LoggerFactory::getLogger(typeid(DemoPoAuthentication));

// PO Reader name
const std::string PO_READER_NAME = "XXX";

// SAM Reader name
const std::string SAM_READER_NAME = "XXX";

// Keyple test kit profile 1, Application 2
const std::string AID = "315449432E49434131";
const uint8_t RECORD_NUMBER_1 = 1;
const uint8_t SFI_Environment = 0x07;

int main(int argv, char **args)
{
    // Get the instance of the SeProxyService (Singleton pattern)
    SeProxyService& seProxyService = SeProxyService::getInstance();

    logger->info("============================================================================\n");
    logger->info("=                  Get and Configure the PO & SAM Readers                  =\n");
    logger->info("============================================================================\n");

    // Register the PcscPlugin with SeProxyService, get the corresponding generic ReaderPlugin
    auto pluginFactory = std::make_shared<PcscPluginFactory>();
    std::shared_ptr<ReaderPlugin> readerPlugin = seProxyService.registerPlugin(pluginFactory);

    // Get the PO reader
    std::shared_ptr<SeReader> poReader = readerPlugin->getReader(PO_READER_NAME);

    // Get a SAM reader
    std::shared_ptr<SeReader> samReader = readerPlugin->getReader(SAM_READER_NAME);

    // Eventually, configure the SAM reader parameters
    // ...

    /* Set Pcsc settings per reader */
    poReader->setParameter(PcscReader::SETTING_KEY_PROTOCOL, PcscReader::SETTING_PROTOCOL_T1);
    samReader->setParameter(PcscReader::SETTING_KEY_PROTOCOL, PcscReader::SETTING_PROTOCOL_T0);

    /*
     * PC/SC card access mode:
     *
     * The SAM is left in the SHARED mode (by default) to avoid automatic resets due to the limited
     * time between two consecutive exchanges granted by Windows.
     *
     * This point will be addressed in a coming release of the Keyple PcSc reader plugin.
     *
     * The PO reader is set to EXCLUSIVE mode to avoid side effects (on OS Windows 8+) during the
     * selection step that may result in session failures.
     *
     * See KEYPLE-CORE.PC.md file to learn more about this point.
     *
     */
    samReader->setParameter(PcscReader::SETTING_KEY_MODE, PcscReader::SETTING_MODE_SHARED);
    poReader->setParameter(PcscReader::SETTING_KEY_MODE, PcscReader::SETTING_MODE_SHARED);

    /* Set the PO reader protocol flag */
    poReader->addSeProtocolSetting(
        SeCommonProtocols::PROTOCOL_ISO14443_4,
        PcscProtocolSetting::PCSC_PROTOCOL_SETTING[SeCommonProtocols::PROTOCOL_ISO14443_4]);
    poReader->addSeProtocolSetting(
        SeCommonProtocols::PROTOCOL_B_PRIME,
        PcscProtocolSetting::PCSC_PROTOCOL_SETTING[SeCommonProtocols::PROTOCOL_B_PRIME]);
    samReader->addSeProtocolSetting(
        SeCommonProtocols::PROTOCOL_ISO7816_3,
        PcscProtocolSetting::PCSC_PROTOCOL_SETTING[SeCommonProtocols::PROTOCOL_ISO7816_3]);

    logger->info("============================================================================\n");
    logger->info("=              Create a SAM resource after selecting the SAM               =\n");
    logger->info("============================================================================\n");

    // Prepare the selector to ensure the correct SAM is used
    auto selector = SamSelector::builder()->samRevision(SamRevision::AUTO).build();
    auto samSelector = std::dynamic_pointer_cast<SamSelector>(selector);

    // Make the SAM selection
    SeSelection samSelection;
    auto samSelectionRequest = std::make_shared<SamSelectionRequest>(samSelector);
    auto abstractSamSelectionRequest =
        std::reinterpret_pointer_cast<AbstractSeSelectionRequest<AbstractApduCommandBuilder>>(
            samSelectionRequest);
    samSelection.prepareSelection(abstractSamSelectionRequest);
    std::shared_ptr<CalypsoSam> calypsoSam;
    if (samReader->isSePresent()) {
        std::shared_ptr<SelectionsResult> selectionsResult =
            samSelection.processExplicitSelection(samReader);
        if (selectionsResult->hasActiveSelection()) {
            calypsoSam = std::dynamic_pointer_cast<CalypsoSam>(
                selectionsResult->getActiveMatchingSe());
        } else {
            throw IllegalStateException("SAM matching failed!");
        }
    } else {
        throw IllegalStateException("No SAM is present in the reader " + samReader->getName());
    }

    // Associate the calypsoSam and the samReader to create the samResource
    auto samResource = std::make_shared<SeResource<CalypsoSam>>(samReader, calypsoSam);

    // Prepare the security settings used during the Calypso transaction
    auto poSecuritySettings =
        std::make_shared<PoSecuritySettings::PoSecuritySettingsBuilder>(samResource)->build();

    logger->info("============================================================================\n");
    logger->info("=           Display basic information about the readers and SAM            =\n");
    logger->info("============================================================================\n");

    logger->info("= PO Reader Name = %\n", poReader->getName());
    const std::string samSerialNumber =
        ByteArrayUtil::toHex(samResource->getMatchingSe()->getSerialNumber());
    logger->info("= SAM Reader Name = %, Serial Number = %\n",
                 samResource->getSeReader()->getName(),
                 samSerialNumber);

    logger->info("============================================================================\n");
    logger->info("=                     Prepare the Calypso PO selection                     =\n");
    logger->info("============================================================================\n");

    // Prepare a Calypso PO selection
    SeSelection seSelection;

    // Setting of an AID based selection of a Calypso Revision 3.1 PO
    //
    // Select the first application matching the selection AID whatever the card communication
    // protocol
    // Keep the logical channel open after the selection
    //
    // Calypso selection: configures a PoSelectionRequest with all the desired attributes to
    // make the selection and read additional information afterwards
    auto aidSelector = SeSelector::AidSelector::builder()->aidToSelect(AID).build();
    auto seSelector = PoSelector::builder()->aidSelector(aidSelector) // the application identifier
                                            // to indicate if an invalidated PO should be accepted
                                            // or not
                                            .invalidatedPo(PoSelector::InvalidatedPo::REJECT)
                                            .build();
    auto poSelector = std::dynamic_pointer_cast<PoSelector>(seSelector);
    auto poSelectionRequest = std::make_shared<PoSelectionRequest>(poSelector);


    // Add the selection case to the current selection
    // (we could have added other cases)
    auto abstractPoSelectionRequest =
        std::reinterpret_pointer_cast<AbstractSeSelectionRequest<AbstractApduCommandBuilder>>(
            poSelectionRequest);
    seSelection.prepareSelection(abstractPoSelectionRequest);

    logger->info("============================================================================\n");
    logger->info("=                  Check if a PO is present in the reader                  =\n");
    logger->info("============================================================================\n");

    if (poReader->isSePresent()) {
        logger->info("============================================================================\n");
        logger->info("=                    Start of the Calypso PO processing                    =\n");
        logger->info("============================================================================\n");
        logger->info("=                             1st PO exchange                              =\n");
        logger->info("=                           AID based selection                            =\n");
        logger->info("============================================================================\n");

        try {
            // Actual PO communication: operate through a single request the Calypso PO selection
            std::shared_ptr<CalypsoPo> calypsoPo =
                std::dynamic_pointer_cast<CalypsoPo>(
                    seSelection.processExplicitSelection(poReader)->getActiveMatchingSe());

            logger->info("The selection of the PO has succeeded\n");

            logger->info("============================================================================\n");
            logger->info("=                            2nd PO exchange                               =\n");
            logger->info("=                     Open a Calypso secure session                        =\n");
            logger->info("=                  Reading of Environment file (SFI=07h)                   =\n");
            logger->info("============================================================================\n");

            // Create a PoTransaction object to manage the Calypso transaction
            auto poTransaction = std::make_shared<PoTransaction>(
                                     std::make_shared<SeResource<CalypsoPo>>(poReader, calypsoPo),
                                     poSecuritySettings);

            // Read the Environment file at the Session Opening
            // (we could have added other commands)
            poTransaction->prepareReadRecordFile(
                    SFI_Environment, // the sfi to select
                    RECORD_NUMBER_1);

            // Open Session with the debit key
            poTransaction->processOpening(
                PoTransaction::SessionSetting::AccessLevel::SESSION_LVL_DEBIT);

            // Get the Environment data
            std::shared_ptr<ElementaryFile> efEnvironment =
                calypsoPo->getFileBySfi(SFI_Environment);

            const std::string environmentLog =
                ByteArrayUtil::toHex(efEnvironment->getData()->getContent());
            logger->info("File Environment log: %\n", environmentLog);

            if (!calypsoPo->isDfRatified()) {
                logger->info("============= Previous Calypso Secure Session was not ratified =============\n");
            }

            logger->info("============================================================================\n");
            logger->info("=                            3th PO exchange                               =\n");
            logger->info("=                     Close the Calypso secure session                     =\n");
            logger->info("============================================================================\n");

            // To close the channel with the PO after the closing
            poTransaction->prepareReleasePoChannel();

            // Close the Calypso Secure Session
            // A ratification command will be sent (CONTACTLESS_MODE)
            poTransaction->processClosing();

            logger->info("============================================================================\n");
            logger->info("=              The Calypso secure session ended successfully               =\n");
            logger->info("=                   (Successful mutual authentication)                     =\n");
            logger->info("=                    End of the Calypso PO processing                      =\n");
            logger->info("============================================================================\n");
        } catch (const Exception& e) {
            logger->error("Exception: %\n", e.getMessage());
        }
    } else {
        logger->error("The selection of the PO has failed\n");
    }

    return 0;
}
```

#### Sample trace

```bash
============================================================================
=                  Get and Configure the PO & SAM Readers                  =
============================================================================
initNativeReaders - getting card terminals
run - starting executor monitoring thread
[PcscReaderImpl] constructor => using terminal OMNIKEY CardMan (076B:5421) 5421(1)
[OMNIKEY CardMan (076B:5421) 5421(1)] setParameter => PCSC: Set a parameter. NAME =transmission_mode, VALUE =
[OMNIKEY CardMan (076B:5421) 5421(1)] setParameter => PCSC: Set a parameter. NAME = protocol, VALUE =
[OMNIKEY CardMan (076B:5421) 5421(1)] setParameter => PCSC: Set a parameter. NAME = mode, VALUE =
[OMNIKEY CardMan (076B:5421) 5421(1)] setParameter => PCSC: Set a parameter. NAME = disconnect, VALUE =
run - starting executor monitoring thread
constructor => using terminal OMNIKEY CardMan (076B:5421) 5421(2)
[OMNIKEY CardMan (076B:5421) 5421(2)] setParameter => PCSC: Set a parameter. NAME = transmission_mode, VALUE =
[OMNIKEY CardMan (076B:5421) 5421(2)] setParameter => PCSC: Set a parameter. NAME = protocol, VALUE =
[OMNIKEY CardMan (076B:5421) 5421(2)] setParameter => PCSC: Set a parameter. NAME = mode, VALUE =
[OMNIKEY CardMan (076B:5421) 5421(2)] setParameter => PCSC: Set a parameter. NAME = disconnect, VALUE =
Registering a new Plugin to the platform : PcscPlugin
[OMNIKEY CardMan (076B:5421) 5421(2)] setParameter => PCSC: Set a parameter. NAME = protocol, VALUE = T1
[OMNIKEY CardMan (076B:5421) 5421(1)] setParameter => PCSC: Set a parameter. NAME = protocol, VALUE = T0
[OMNIKEY CardMan (076B:5421) 5421(1)] setParameter => PCSC: Set a parameter. NAME = mode, VALUE = shared
[OMNIKEY CardMan (076B:5421) 5421(2)] setParameter => PCSC: Set a parameter. NAME = mode, VALUE = shared
============================================================================
=              Create a SAM resource after selecting the SAM               =
============================================================================
protocolFlagMatches - physical channel not open, opening it
[OMNIKEY CardMan (076B:5421) 5421(1)] openAndConnect - protocol: T=0
openAndConnect - connecting tp OMNIKEY CardMan (076B:5421) 5421(1) with protocol: T=0, connectProtocol: 1
    and sharingMode: 2
openAndConnect - card state: 84
[OMNIKEY CardMan (076B:5421) 5421(1)] Opening of a physical SE channel in shared mode
[OMNIKEY CardMan (076B:5421) 5421(1)] protocolFlagMatches => matching SE. PROTOCOLFLAG = SEPROTOCOL:
    {NAME = ISO 7816-3, TRANMISSIONMODE = CONTACTS}
processSeRequestSet - processing requests set
[OMNIKEY CardMan (076B:5421) 5421(1)] processSeRequests => transmit SEREQUEST: {REQUESTS = ApduRequests: {},
    SELECTOR = SESELECTOR: {SEPROTOCOL: {NAME = ISO 7816-3, TRANMISSIONMODE = CONTACTS}AIDSELECTOR = null,
    ATRFILTER: {REGEX = .*}}}
[OMNIKEY CardMan (076B:5421) 5421(1)] processSeRequest => Logical channel open = 0
[OMNIKEY CardMan (076B:5421) 5421(1)] processSeRequests => receive SERESPONSE: {RESPONSES = APDURESPONSES: {},
     SELECTIONSTATUS = SELECTIONSTATUS: {ATR = ATR = 3b3f9600805a4880c1205017aec11a36829000, FCI = R-APDU:
     {STATUS = FAILURE, BYTES (0) = }, HASMATCHED = 1}, CHANNELWASOPEN = 0}
============================================================================
=           Display basic information about the readers and SAM            =
============================================================================
= PO Reader Name = OMNIKEY CardMan (076B:5421) 5421(2)
= SAM Reader Name = OMNIKEY CardMan (076B:5421) 5421(1), Serial Number = AEC11A36
============================================================================
=                     Prepare the Calypso PO selection                     =
============================================================================
============================================================================
=                  Check if a PO is present in the reader                  =
============================================================================
============================================================================
=                    Start of the Calypso PO processing                    =
============================================================================
=                             1st PO exchange                              =
=                           AID based selection                            =
============================================================================
protocolFlagMatches - physical channel not open, opening it
[OMNIKEY CardMan (076B:5421) 5421(2)] openAndConnect - protocol: T=1
openAndConnect - connecting tp OMNIKEY CardMan (076B:5421) 5421(2) with protocol: T=1, connectProtocol: 2
    and sharingMode: 2
openAndConnect - card state: 84
[OMNIKEY CardMan (076B:5421) 5421(2)] Opening of a physical SE channel in shared mode
[OMNIKEY CardMan (076B:5421) 5421(2)] protocolFlagMatches => matching SE. PROTOCOLFLAG = SEPROTOCOL:
    {NAME = ISO 14443-4, TRANMISSIONMODE = CONTACTLESS}
processSeRequestSet - processing requests set
[OMNIKEY CardMan (076B:5421) 5421(2)] processSeRequests => transmit SEREQUEST: {REQUESTS = ApduRequests:
    {}, SELECTOR = SESELECTOR: {SEPROTOCOL: {NAME = ISO 14443-4, TRANMISSIONMODE = CONTACTLESS}AIDSELECTOR:
    {AIDTOSELECT = 315449432e49434131FILEOCCURRENCE: {ISOBITMASK = 0(0x00)}FILECONTROLINFORMATION:
    {ISOBITMASK = 0(0x00)}0x0}, ATRFILTER = null}}
[OMNIKEY CardMan (076B:5421) 5421(2)] processSeRequest => Logical channel open = 0
[OMNIKEY CardMan (076B:5421) 5421(2)] openLogicalChannel => Select Application with AID = 315449432e49434131
[OMNIKEY CardMan (076B:5421) 5421(2)] processApduRequest => APDUREQUEST: {NAME = Internal Select Application,
    RAWDATA = 00a4040009315449432e4943413100, CASE4 = 1}, elapsed 13c ms
[OMNIKEY CardMan (076B:5421) 5421(2)] transmitApdu - c-apdu >> 00a4040009315449432e4943413100
[OMNIKEY CardMan (076B:5421) 5421(2)] transmitApdu - r-apdu <<
    6f238409315449432e49434131a516bf0c13c70800000000c17be1f653070a3c23051410019000
[OMNIKEY CardMan (076B:5421) 5421(2)] processApduRequest => R-APDU: {STATUS = SUCCESS, BYTES (39) = 6f238409315449432e49434131a516bf0c13c70800000000c17be1f653070a3c23051410019000}, elapsed c ms
[OMNIKEY CardMan (076B:5421) 5421(2)] processSeRequests => receive SERESPONSE: {RESPONSES = APDURESPONSES: {},
    SELECTIONSTATUS = SELECTIONSTATUS: {ATR = ATR = 3b888001000000009171710098, FCI = R-APDU: {STATUS = SUCCESS,
    BYTES (27) = 6f238409315449432e49434131a516bf0c13c70800000000c17be1f653070a3c23051410019000}, HASMATCHED = 1},
    CHANNELWASOPEN = 0}
Application Serial Number = 00000000C17BE1F6
Discretionary Data = 0a3c2305141001
The selection of the PO has succeeded
============================================================================
=                            2nd PO exchange                               =
=                     Open a Calypso secure session                        =
=                  Reading of Environment file (SFI=07h)                   =
============================================================================
[OMNIKEY CardMan (076B:5421) 5421(1)] processSeRequest => Logical channel open = 1
[OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => APDUREQUEST: {NAME = Select Diversifier,
    RAWDATA = 801400000800000000c17be1f6, CASE4 = 0}, elapsed 208 ms
[OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - c-apdu >> 801400000800000000c17be1f6
[OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - r-apdu << 9000
[OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => R-APDU: {STATUS = SUCCESS, BYTES (2) =
    9000}, elapsed 37 ms
[OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => APDUREQUEST: {NAME = Get Challenge,
    RAWDATA =  8084000004, CASE4 = 0}, elapsed 0 ms
[OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - c-apdu >> 8084000004
[OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - r-apdu << ef48651d9000
[OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => R-APDU: {STATUS = SUCCESS, BYTES (6) =
    ef48651d9000}, elapsed 3 ms
identification: TERMINALCHALLENGE = ef48651d
[OMNIKEY CardMan (076B:5421) 5421(2)] processSeRequest => Logical channel open = 1
[OMNIKEY CardMan (076B:5421) 5421(2)] processApduRequest => APDUREQUEST: {NAME = Open Secure Session
    V3.1 -  KEYINDEX=3, SFI=07, REC=1, RAWDATA = 008a0b3904ef48651d00, CASE4 = 1}, elapsed c7 ms
[OMNIKEY CardMan (076B:5421) 5421(2)] transmitApdu - c-apdu >> 008a0b3904ef48651d00
[OMNIKEY CardMan (076B:5421) 5421(2)] transmitApdu - r-apdu <<
    030ab2cf0030791d00000000000000000000000000000000000000000000000000000000009000
[OMNIKEY CardMan (076B:5421) 5421(2)] processApduRequest => R-APDU: {STATUS = SUCCESS, BYTES (39) = 030ab2cf0030791d00000000000000000000000000000000000000000000000000000000009000}, elapsed e ms
processAtomicOpening => opening: CARDCHALLENGE = CF, POKIF = 30, POKVC = 79
initialize: POREVISION = REV3_1, SAMREVISION = C1, SESSIONENCRYPTION = 0, VERIFICATIONMODE = 0
initialize: VERIFICATIONMODE = 0, REV32MODE = 0, KEYRECNUMBER = 0(0x00)
initialize: KIF = 48(0x30), KVC = 79(0x79), DIGESTDATA =
    030ab2cf0030791d0000000000000000000000000000000000000000000000000000000000
File Environment log: 0000000000000000000000000000000000000000000000000000000000
============================================================================
=                            3th PO exchange                               =
=                     Close the Calypso secure session                     =
============================================================================
[OMNIKEY CardMan (076B:5421) 5421(1)] processSeRequest => Logical channel open = 1
[OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => APDUREQUEST: {NAME = Digest Init, RAWDATA = 808a00ff273079030ab2cf0030791d0000000000000000000000000000000000000000000000000000000000, CASE4 = 0},
    elapsed 2f ms
[OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - c-apdu >>
    808a00ff273079030ab2cf0030791d0000000000000000000000000000000000000000000000000000000000
[OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - r-apdu << 9000
[OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => R-APDU: {STATUS = SUCCESS, BYTES (2) = 9000},
    elapsed 6 ms
[OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => APDUREQUEST: {NAME = Digest Close,
    RAWDATA = 808e000004, CASE4 = 0}, elapsed 0 ms
[OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - c-apdu >> 808e000004
[OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - r-apdu << 819e515d9000
[OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => R-APDU: {STATUS = SUCCESS, BYTES (6) =
    819e515d9000}, elapsed 9 ms
SIGNATURE = 819e515d
[OMNIKEY CardMan (076B:5421) 5421(2)] processSeRequest => Logical channel open = 1
[OMNIKEY CardMan (076B:5421) 5421(2)] processApduRequest => APDUREQUEST: {NAME = Close Secure Session,
    RAWDATA = 008e800004819e515d00, CASE4 = 1}, elapsed 31 ms
[OMNIKEY CardMan (076B:5421) 5421(2)] transmitApdu - c-apdu >> 008e800004819e515d00
[OMNIKEY CardMan (076B:5421) 5421(2)] transmitApdu - r-apdu << 08d222e99000
[OMNIKEY CardMan (076B:5421) 5421(2)] processApduRequest => R-APDU: {STATUS = SUCCESS, BYTES (6) =
    08d222e99000}, elapsed 34 ms
[OMNIKEY CardMan (076B:5421) 5421(2)] processApduRequest => APDUREQUEST: {NAME = , RAWDATA = 00b2000000,
    CASE4 = 0}, elapsed 0 ms
[OMNIKEY CardMan (076B:5421) 5421(2)] transmitApdu - c-apdu >> 00b2000000
[OMNIKEY CardMan (076B:5421) 5421(2)] transmitApdu - r-apdu << 6b00
[OMNIKEY CardMan (076B:5421) 5421(2)] processApduRequest => R-APDU: {STATUS = FAILURE, BYTES (2) = 6b00},
    elapsed 2a ms
[OMNIKEY CardMan (076B:5421) 5421(2)] closePhysicalChannel
[OMNIKEY CardMan (076B:5421) 5421(2)] closeAndDisconnect - reset: y
[OMNIKEY CardMan (076B:5421) 5421(2)] Ignore =>  Event SE_PROCESSED received in currentState
    WAIT_FOR_START_DETECTION
[OMNIKEY CardMan (076B:5421) 5421(1)] processSeRequest => Logical channel open = 1
[OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => APDUREQUEST: {NAME = Digest Authenticate,
    RAWDATA = 808200000408d222e9, CASE4 = 0}, elapsed 61 ms
[OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - c-apdu >> 808200000408d222e9
[OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - r-apdu << 9000
[OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => R-APDU: {STATUS = SUCCESS, BYTES (2) = 9000},
    elapsed 5e ms
============================================================================
=              The Calypso secure session ended successfully               =
=                   (Successful mutual authentication)                     =
=                    End of the Calypso PO processing                      =
============================================================================
```
