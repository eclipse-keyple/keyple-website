---
title: Build your First C++ Application
linktitle: C++ App
type: book
toc: true
draft: false
weight: 210
---

This getting started contains one ready-to-execute C++ example starting from a new CMake project.

The example demonstrate Keyple capabilities with the Keyple PCSC plugin and PO/SAM provided in the
Calypso Test Kit.

## Requirements

The example can run on any machine: Linux, Windows and MacOS. If not installed in your machine, you
will need to download :
* CMake 2.8 or newer [(download)](https://cmake.org/install/)
* GCC / CLang / MSVC compiler

Keyple can be compiled through an IDE (Eclipe CDT, VSCode, Visual Studio...), simply make sure CMake
support plugins are installed if necessary.

## Keyple

### Checkout

Checkout the Keyple repository:

```bash
git clone https://github.com/eclipse/keyple-cpp.git
````

### Build

Navigate inside the repos and, create a 'build' directory (or a name of your choosing), then move
inside that directory:

```bash
cd keyple-cpp
mkdir build
cd build
```

Keyple comes with a set of predefined toolchain files for the main platforms/compiler combinations.
Call CMake with the appropriate toolchain file:

```bash
cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain/<compiler-os>.cmake ..
````

> Note: In Visual Studio, this can be done through the 'Manage Configurations...' action. See this
[link](https://docs.microsoft.com/en-us/cpp/build/customize-cmake-settings?view=msvc-160) for more
details.

Finally build the main libraries:

```bash
make keyplecommon keyplecore keyplepluginpcsc keyplecalypso
```

> Note: In Visual Sudio, click on 'Build All' or manually build each component one by one.

The compiled dynamic libraries can now be found in the 'build/bin' folder.

## Demo application

### Source code

Copy the source code below in a new file, say main.cpp:

```{cpp, class.output="scroll-100"}
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

### CMake build

Create a CMakeLists.txt file as follows:

```cmake
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

### Run

Connect your PO and SAM readers, put the SAM in the SAM reader, place the PO on the PO reader.

Configure the PO and SAM readers you use in the java file (you have to respect the case for the
reader name):

```cpp
// PO Reader name
const std::string PO_READER_NAME = "XXX";

// SAM Reader name
const std::string SAM_READER_NAME = "XXX";
```

If you don’t know the reader name, several options:
* run the application in debug mode and get the reader name in plugin variable
* run 'pcsctest' (macOS)
* run 'pcsc_scan' (Linux)

Run the application:

```bash
./demo_po_authentication
```

### Sample trace

```bash
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   ============================================================================
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   =                  Get and Configure the PO & SAM Readers                  =
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   ============================================================================
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscPlugin                                                                    ]   initNativeReaders - getting card terminals
[2020-12-09 00:01:22:482]   [ERROR]   [keyple::core::seproxy::plugin::ExecutorService                                                      ]   run - starting executor monitoring thread
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   [PcscReaderImpl] constructor => using terminal OMNIKEY CardMan (076B:5421) 5421(1)
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   [OMNIKEY CardMan (076B:5421) 5421(1)] setParameter => PCSC: Set a parameter. NAME = transmission_mode, VALUE =
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   [OMNIKEY CardMan (076B:5421) 5421(1)] setParameter => PCSC: Set a parameter. NAME = protocol, VALUE =
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   [OMNIKEY CardMan (076B:5421) 5421(1)] setParameter => PCSC: Set a parameter. NAME = mode, VALUE =
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   [OMNIKEY CardMan (076B:5421) 5421(1)] setParameter => PCSC: Set a parameter. NAME = disconnect, VALUE =
[2020-12-09 00:01:22:482]   [ERROR]   [keyple::core::seproxy::plugin::ExecutorService                                                      ]   run - starting executor monitoring thread
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   [PcscReaderImpl] constructor => using terminal OMNIKEY CardMan (076B:5421) 5421(2)
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   [OMNIKEY CardMan (076B:5421) 5421(2)] setParameter => PCSC: Set a parameter. NAME = transmission_mode, VALUE =
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   [OMNIKEY CardMan (076B:5421) 5421(2)] setParameter => PCSC: Set a parameter. NAME = protocol, VALUE =
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   [OMNIKEY CardMan (076B:5421) 5421(2)] setParameter => PCSC: Set a parameter. NAME = mode, VALUE =
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   [OMNIKEY CardMan (076B:5421) 5421(2)] setParameter => PCSC: Set a parameter. NAME = disconnect, VALUE =
[2020-12-09 00:01:22:482]   [ INFO]   [keyple::core::seproxy::SeProxyService                                                               ]   Registering a new Plugin to the platform : PcscPlugin
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   [OMNIKEY CardMan (076B:5421) 5421(2)] setParameter => PCSC: Set a parameter. NAME = protocol, VALUE = T1
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   [OMNIKEY CardMan (076B:5421) 5421(1)] setParameter => PCSC: Set a parameter. NAME = protocol, VALUE = T0
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   [OMNIKEY CardMan (076B:5421) 5421(1)] setParameter => PCSC: Set a parameter. NAME = mode, VALUE = shared
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   [OMNIKEY CardMan (076B:5421) 5421(2)] setParameter => PCSC: Set a parameter. NAME = mode, VALUE = shared
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   ============================================================================
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   =              Create a SAM resource after selecting the SAM               =
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   ============================================================================
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   protocolFlagMatches - physical channel not open, opening it
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] openAndConnect - protocol: T=0
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   openAndConnect - connecting tp OMNIKEY CardMan (076B:5421) 5421(1) with protocol: T=0, connectProtocol: 1 and sharingMode: 2
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   openAndConnect - card state: 84
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   [OMNIKEY CardMan (076B:5421) 5421(1)] Opening of a physical SE channel in shared mode
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   [OMNIKEY CardMan (076B:5421) 5421(1)] protocolFlagMatches => matching SE. PROTOCOLFLAG = SEPROTOCOL: {NAME = ISO 7816-3, TRANMISSIONMODE = CONTACTS}
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   processSeRequestSet - processing requests set
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] processSeRequests => transmit SEREQUEST: {REQUESTS = ApduRequests: {}, SELECTOR = SESELECTOR: {SEPROTOCOL: {NAME = ISO 7816-3, TRANMISSIONMODE = CONTACTS}AIDSELECTOR = null, ATRFILTER: {REGEX = .*}}}
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] processSeRequest => Logical channel open = 0
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] processSeRequests => receive SERESPONSE: {RESPONSES = APDURESPONSES: {}, SELECTIONSTATUS = SELECTIONSTATUS: {ATR = ATR = 3b3f9600805a4880c1205017aec11a36829000, FCI = R-APDU: {STATUS = FAILURE, BYTES (0) = }, HASMATCHED = 1}, CHANNELWASOPEN = 0}
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   ============================================================================
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   =           Display basic information about the readers and SAM            =
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   ============================================================================
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   = PO Reader Name = OMNIKEY CardMan (076B:5421) 5421(2)
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   = SAM Reader Name = OMNIKEY CardMan (076B:5421) 5421(1), Serial Number = AEC11A36
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   ============================================================================
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   =                     Prepare the Calypso PO selection                     =
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   ============================================================================
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   ============================================================================
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   =                  Check if a PO is present in the reader                  =
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   ============================================================================
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   ============================================================================
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   =                    Start of the Calypso PO processing                    =
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   ============================================================================
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   =                             1st PO exchange                              =
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   =                           AID based selection                            =
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   ============================================================================
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   protocolFlagMatches - physical channel not open, opening it
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] openAndConnect - protocol: T=1
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   openAndConnect - connecting tp OMNIKEY CardMan (076B:5421) 5421(2) with protocol: T=1, connectProtocol: 2 and sharingMode: 2
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   openAndConnect - card state: 84
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   [OMNIKEY CardMan (076B:5421) 5421(2)] Opening of a physical SE channel in shared mode
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   [OMNIKEY CardMan (076B:5421) 5421(2)] protocolFlagMatches => matching SE. PROTOCOLFLAG = SEPROTOCOL: {NAME = ISO 14443-4, TRANMISSIONMODE = CONTACTLESS}
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   processSeRequestSet - processing requests set
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] processSeRequests => transmit SEREQUEST: {REQUESTS = ApduRequests: {}, SELECTOR = SESELECTOR: {SEPROTOCOL: {NAME = ISO 14443-4, TRANMISSIONMODE = CONTACTLESS}AIDSELECTOR: {AIDTOSELECT = 315449432e49434131FILEOCCURRENCE: {ISOBITMASK = 0(0x00)}FILECONTROLINFORMATION: {ISOBITMASK = 0(0x00)}0x0}, ATRFILTER = null}}
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] processSeRequest => Logical channel open = 0
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] openLogicalChannel => Select Application with AID = 315449432e49434131
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] processApduRequest => APDUREQUEST: {NAME = Internal Select Application, RAWDATA = 00a4040009315449432e4943413100, CASE4 = 1}, elapsed 13c ms
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   transmitApdu
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] transmitApdu - c-apdu >> 00a4040009315449432e4943413100
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] transmitApdu - r-apdu << 6f238409315449432e49434131a516bf0c13c70800000000c17be1f653070a3c23051410019000
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] processApduRequest => R-APDU: {STATUS = SUCCESS, BYTES (39) = 6f238409315449432e49434131a516bf0c13c70800000000c17be1f653070a3c23051410019000}, elapsed c ms
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] processSeRequests => receive SERESPONSE: {RESPONSES = APDURESPONSES: {}, SELECTIONSTATUS = SELECTIONSTATUS: {ATR = ATR = 3b888001000000009171710098, FCI = R-APDU: {STATUS = SUCCESS, BYTES (27) = 6f238409315449432e49434131a516bf0c13c70800000000c17be1f653070a3c23051410019000}, HASMATCHED = 1}, CHANNELWASOPEN = 0}
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::calypso::command::po::parser::GetDataFciRespPars                                            ]   Application Serial Number = 00000000C17BE1F6
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::calypso::command::po::parser::GetDataFciRespPars                                            ]   Discretionary Data = 0a3c2305141001
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   The selection of the PO has succeeded
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   ============================================================================
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   =                            2nd PO exchange                               =
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   =                     Open a Calypso secure session                        =
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   =                  Reading of Environment file (SFI=07h)                   =
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   ============================================================================
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] processSeRequest => Logical channel open = 1
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => APDUREQUEST: {NAME = Select Diversifier, RAWDATA = 801400000800000000c17be1f6, CASE4 = 0}, elapsed 208 ms
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   transmitApdu
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - c-apdu >> 801400000800000000c17be1f6
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - r-apdu << 9000
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => R-APDU: {STATUS = SUCCESS, BYTES (2) = 9000}, elapsed 37 ms
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => APDUREQUEST: {NAME = Get Challenge, RAWDATA = 8084000004, CASE4 = 0}, elapsed 0 ms
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   transmitApdu
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - c-apdu >> 8084000004
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - r-apdu << ef48651d9000
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => R-APDU: {STATUS = SUCCESS, BYTES (6) = ef48651d9000}, elapsed 3 ms
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::calypso::transaction::SamCommandProcessor                                                   ]   identification: TERMINALCHALLENGE = ef48651d
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] processSeRequest => Logical channel open = 1
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] processApduRequest => APDUREQUEST: {NAME = Open Secure Session V3.1 - KEYINDEX=3, SFI=07, REC=1, RAWDATA = 008a0b3904ef48651d00, CASE4 = 1}, elapsed c7 ms
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   transmitApdu
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] transmitApdu - c-apdu >> 008a0b3904ef48651d00
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] transmitApdu - r-apdu << 030ab2cf0030791d00000000000000000000000000000000000000000000000000000000009000
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] processApduRequest => R-APDU: {STATUS = SUCCESS, BYTES (39) = 030ab2cf0030791d00000000000000000000000000000000000000000000000000000000009000}, elapsed e ms
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::calypso::transaction::PoTransaction                                                         ]   processAtomicOpening => opening: CARDCHALLENGE = CF, POKIF = 30, POKVC = 79
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::calypso::transaction::SamCommandProcessor                                                   ]   initialize: POREVISION = REV3_1, SAMREVISION = C1, SESSIONENCRYPTION = 0, VERIFICATIONMODE = 0
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::calypso::transaction::SamCommandProcessor                                                   ]   initialize: VERIFICATIONMODE = 0, REV32MODE = 0, KEYRECNUMBER = 0(0x00)
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::calypso::transaction::SamCommandProcessor                                                   ]   initialize: KIF = 48(0x30), KVC = 79(0x79), DIGESTDATA = 030ab2cf0030791d0000000000000000000000000000000000000000000000000000000000
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   File Environment log: 0000000000000000000000000000000000000000000000000000000000
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   ============================================================================
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   =                            3th PO exchange                               =
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   =                     Close the Calypso secure session                     =
[2020-12-09 00:01:22:482]   [ INFO]   [DemoPoAuthentication                                                                                ]   ============================================================================
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] processSeRequest => Logical channel open = 1
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => APDUREQUEST: {NAME = Digest Init, RAWDATA = 808a00ff273079030ab2cf0030791d0000000000000000000000000000000000000000000000000000000000, CASE4 = 0}, elapsed 2f ms
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   transmitApdu
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - c-apdu >> 808a00ff273079030ab2cf0030791d0000000000000000000000000000000000000000000000000000000000
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - r-apdu << 9000
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => R-APDU: {STATUS = SUCCESS, BYTES (2) = 9000}, elapsed 6 ms
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => APDUREQUEST: {NAME = Digest Close, RAWDATA = 808e000004, CASE4 = 0}, elapsed 0 ms
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   transmitApdu
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - c-apdu >> 808e000004
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - r-apdu << 819e515d9000
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => R-APDU: {STATUS = SUCCESS, BYTES (6) = 819e515d9000}, elapsed 9 ms
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::calypso::transaction::SamCommandProcessor                                                   ]   SIGNATURE = 819e515d
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] processSeRequest => Logical channel open = 1
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] processApduRequest => APDUREQUEST: {NAME = Close Secure Session, RAWDATA = 008e800004819e515d00, CASE4 = 1}, elapsed 31 ms
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   transmitApdu
[2020-12-09 00:01:22:482]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] transmitApdu - c-apdu >> 008e800004819e515d00
[2020-12-09 00:01:23:483]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] transmitApdu - r-apdu << 08d222e99000
[2020-12-09 00:01:23:483]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] processApduRequest => R-APDU: {STATUS = SUCCESS, BYTES (6) = 08d222e99000}, elapsed 34 ms
[2020-12-09 00:01:23:483]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] processApduRequest => APDUREQUEST: {NAME = , RAWDATA = 00b2000000, CASE4 = 0}, elapsed 0 ms
[2020-12-09 00:01:23:483]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   transmitApdu
[2020-12-09 00:01:23:483]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] transmitApdu - c-apdu >> 00b2000000
[2020-12-09 00:01:23:483]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] transmitApdu - r-apdu << 6b00
[2020-12-09 00:01:23:483]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] processApduRequest => R-APDU: {STATUS = FAILURE, BYTES (2) = 6b00}, elapsed 2a ms
[2020-12-09 00:01:23:483]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   [OMNIKEY CardMan (076B:5421) 5421(2)] closePhysicalChannel
[2020-12-09 00:01:23:483]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(2)] closeAndDisconnect - reset: y
[2020-12-09 00:01:23:483]   [ WARN]   [keyple::core::seproxy::plugin::WaitForStartDetect                                                   ]   [OMNIKEY CardMan (076B:5421) 5421(2)] Ignore =>  Event SE_PROCESSED received in currentState WAIT_FOR_START_DETECTION
[2020-12-09 00:01:23:483]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] processSeRequest => Logical channel open = 1
[2020-12-09 00:01:23:483]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => APDUREQUEST: {NAME = Digest Authenticate, RAWDATA = 808200000408d222e9, CASE4 = 0}, elapsed 61 ms
[2020-12-09 00:01:23:483]   [DEBUG]   [keyple::plugin::pcsc::PcscReaderImpl                                                                ]   transmitApdu
[2020-12-09 00:01:23:483]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - c-apdu >> 808200000408d222e9
[2020-12-09 00:01:23:483]   [DEBUG]   [keyple::plugin::pcsc::PcscTerminal                                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] transmitApdu - r-apdu << 9000
[2020-12-09 00:01:23:483]   [DEBUG]   [keyple::core::seproxy::plugin::AbstractLocalReader                                                  ]   [OMNIKEY CardMan (076B:5421) 5421(1)] processApduRequest => R-APDU: {STATUS = SUCCESS, BYTES (2) = 9000}, elapsed 5e ms
[2020-12-09 00:01:23:483]   [ INFO]   [DemoPoAuthentication                                                                                ]   ============================================================================
[2020-12-09 00:01:23:483]   [ INFO]   [DemoPoAuthentication                                                                                ]   =              The Calypso secure session ended successfully               =
[2020-12-09 00:01:23:483]   [ INFO]   [DemoPoAuthentication                                                                                ]   =                   (Successful mutual authentication)                     =
[2020-12-09 00:01:23:483]   [ INFO]   [DemoPoAuthentication                                                                                ]   =                    End of the Calypso PO processing                      =
[2020-12-09 00:01:23:483]   [ INFO]   [DemoPoAuthentication                                                                                ]   ============================================================================
```
