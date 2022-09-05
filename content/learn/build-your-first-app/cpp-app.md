---
title: Build your first C++ application
linktitle: C++
summary: This quick start describes how to create a ready-to-execute C++ command-line application that runs a simple transaction based on a Calypso portable object involving two smart card readers.
type: book
toc: true
draft: false
weight: 3
---

---
{{% callout warning %}}  
This page is still under construction and may contain inaccurate information.
{{% /callout %}}
## Overview

This quick start describes how to create a ready-to-execute command-line application that runs a simple transaction based on
a Calypso Card involving two smart card readers.

{{% callout warning %}}  
The demonstration application created for this quick start requires:
* a Calypso Card (contactless smart card, NFC mobile phone with a Calypso applet or application),
* a Calypso SAM (Secure Access Module). 
{{% /callout %}}


We will use three main components of Keyple:
* **Keyple Service C++ Library**
  which is the base component to which all the others refer,
* **Keyple Card Calypso C++ Library**
  add-on to handle the commands sent to the Calypso card and the Calypso SAM,
* **Keyple Plugin PC/SC C++ Library**
  add-on to provide the ability to manage PC/SC readers.

{{% callout info %}}  
Prerequisites

Here are the prerequisites to build the keyple components (dynamic libraries):
* G++ 6 and higher, MSVC++ 14 (other compilers untested)
* [CMake](https://cmake.org/)
* libpcsclite1 and libpcsclite-dev packages installed (Linux) to build the PC/SC plugin
{{% /callout %}}

In this guide, the Keyple components and application are build under Linux using CMake as build automation tool.

---
## Create the build environment

The building of all the necessary components is facilitated by a dedicated "meta-project" allowing to get all the 
components and dependencies in a single step. 

Git checkout the [meta project](https://github.com/eclipse/keyple-cpp-meta) into a directory of you local disk, then 
enter the created directory and execute the following commands:

{{< code lang="bash" >}}
mkdir build
cd build
cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain/gcc-linux.cmake ..
make
{{< /code >}}

{{% callout note %}}  
```gcc-linux``` may be replaced by one of the build configurations available [here](https://github.com/eclipse/keyple-cpp-meta/tree/master/toolchain).
{{% /callout %}}

---
## Let's code

Now let's see step by step how to create in one single class the elements that allow a certified reading of data through 
a Calypso secure session.

In a real ticketing application, the organization of the code would probably be different, but the point here is to show 
how Keyple makes it possible to perform very simply operations that normally require a quantity of code and knowledge 
that far exceeds what is implemented here.

You can either progressively copy each of the small portions of code
that follow or copy the whole class at the bottom of this page.

### Create a directory dedicated to the application

{{< code lang="bash" >}}
cd ..
mkdir app
cd app
{{< /code >}}
We assume here that the current directory was the previously created  ```build``` directory.

Create a file named ```CMakeLists.txt``` with the following content:
{{< code lang="make" >}}
SET(CALYPSONET_CALYPSO_DIR "../../calypsonet-terminal-calypso-cpp-api")
SET(CALYPSONET_CARD_DIR    "../../calypsonet-terminal-card-cpp-api")
SET(CALYPSONET_READER_DIR  "../../calypsonet-terminal-reader-cpp-api")
SET(KEYPLE_CALYPSO_DIR     "../../keyple-card-calypso-cpp-lib")
SET(KEYPLE_COMMON_DIR      "../../keyple-common-cpp-api")
SET(KEYPLE_PLUGIN_DIR      "../../keyple-plugin-cpp-api")
SET(KEYPLE_PCSC_DIR        "../../keyple-plugin-pcsc-cpp-lib")
SET(KEYPLE_SERVICE_DIR     "../../keyple-service-cpp-lib")
SET(KEYPLE_UTIL_DIR        "../../keyple-util-cpp-lib")

SET(KEYPLE_CALYPSO_LIB     "keyplecardcalypsocpplib")
SET(KEYPLE_PCSC_LIB        "keyplepluginpcsccpplib")
SET(KEYPLE_SERVICE_LIB     "keypleservicecpplib")
SET(KEYPLE_UTIL_LIB        "keypleutilcpplib")

INCLUDE_DIRECTORIES(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/src/main/common
  ${CMAKE_CURRENT_SOURCE_DIR}/src/main/spi
  
  ${CALYPSONET_CALYPSO_DIR}/src/main
  ${CALYPSONET_CALYPSO_DIR}/src/main/card
  ${CALYPSONET_CALYPSO_DIR}/src/main/sam
  ${CALYPSONET_CALYPSO_DIR}/src/main/transaction
  
  ${CALYPSONET_CARD_DIR}/src/main
  ${CALYPSONET_CARD_DIR}/src/main/spi
  
  ${CALYPSONET_READER_DIR}/src/main
  ${CALYPSONET_READER_DIR}/src/main/selection
  ${CALYPSONET_READER_DIR}/src/main/selection/spi
  ${CALYPSONET_READER_DIR}/src/main/spi
  
  ${KEYPLE_CALYPSO_DIR}/src/main
  
  ${KEYPLE_CARD_DIR}/src/main
  
  ${KEYPLE_COMMON_DIR}/src/main
  
  ${KEYPLE_PCSC_DIR}/src/main
  
  ${KEYPLE_PLUGIN_DIR}/src/main
  ${KEYPLE_PLUGIN_DIR}/src/main/spi
  ${KEYPLE_PLUGIN_DIR}/src/main/spi/reader
  ${KEYPLE_PLUGIN_DIR}/src/main/spi/reader/observable/
  ${KEYPLE_PLUGIN_DIR}/src/main/spi/reader/observable/state/insertion
  ${KEYPLE_PLUGIN_DIR}/src/main/spi/reader/observable/state/processing
  ${KEYPLE_PLUGIN_DIR}/src/main/spi/reader/observable/state/removal
  
  ${KEYPLE_RESOURCE_DIR}/src/main
  ${KEYPLE_RESOURCE_DIR}/src/main/spi
  
  ${KEYPLE_SERVICE_DIR}/src/main
  ${KEYPLE_SERVICE_DIR}/src/main/cpp
  ${KEYPLE_SERVICE_DIR}/src/main/spi
  
  ${KEYPLE_STUB_DIR}/src/main
  
  ${KEYPLE_UTIL_DIR}/src/main
  ${KEYPLE_UTIL_DIR}/src/main/cpp
  ${KEYPLE_UTIL_DIR}/src/main/cpp/exception
  ${KEYPLE_UTIL_DIR}/src/main/protocol
)

IF(APPLE OR UNIX)
SET(THREAD_LIB pthread)
ELSE()
ENDIF(APPLE OR UNIX)

SET(USECASE1 UseCase1_ExplicitSelectionAid)
SET(USECASE1_STUB ${USECASE1}_Stub)
ADD_EXECUTABLE(${USECASE1_STUB}
${CMAKE_CURRENT_SOURCE_DIR}/src/main/common/CalypsoConstants.cpp
${CMAKE_CURRENT_SOURCE_DIR}/src/main/common/StubSmartCardFactory.cpp
${CMAKE_CURRENT_SOURCE_DIR}/src/main/${USECASE1}/Main_ExplicitSelectionAid_Stub.cpp)
TARGET_LINK_LIBRARIES(${USECASE1_STUB} ${KEYPLE_CARD_LIB} ${KEYPLE_STUB_LIB} ${KEYPLE_SERVICE_LIB} ${KEYPLE_UTIL_LIB} ${KEYPLE_CALYPSO_LIB} ${THREAD_LIB})
{{< /code >}}

### Create a directory for the source code

{{< code lang="bash" >}}
mkdir src
cd src
{{< /code >}}

### Create the class skeleton

Copy the source code below in a new C++ file named ```DemoCardAuthentication.cpp```

{{< code lang="cpp" >}}
#include "CalypsoExtensionService.h"

#include "ConfigurableReader.h"
#include "SmartCardService.h"
#include "SmartCardServiceProvider.h"

#include "ByteArrayUtil.h"
#include "ContactCardCommonProtocol.h"
#include "ContactlessCardCommonProtocol.h"
#include "IllegalStateException.h"
#include "LoggerFactory.h"
#include "StringUtils.h"

#include "PcscPlugin.h"
#include "PcscPluginFactory.h"
#include "PcscPluginFactoryBuilder.h"
#include "PcscReader.h"
#include "PcscSupportedContactlessProtocol.h"

#include "CardResource.h"
#include "CardResourceServiceProvider.h"

#include "CalypsoConstants.h"
#include "ConfigurationUtil.h"

using namespace keyple::card::calypso;
using namespace keyple::core::service;
using namespace keyple::core::service::resource;
using namespace keyple::core::util;
using namespace keyple::core::util::cpp;
using namespace keyple::core::util::cpp::exception;
using namespace keyple::core::util::protocol;
using namespace keyple::plugin::pcsc;

class Main_CardAuthentication_Pcsc {};
static const std::unique_ptr<Logger> logger = LoggerFactory::getLogger(typeid(Main_CardAuthentication_Pcsc));

int main()
{
  // ...
}
{{< /code >}}

### Set up the PC/SC plugin

The first step to use Keyple is to initialize the plugin and smart card readers.

In this snippet the PC/SC plugin is registered to the SmartCardService.

Two readers needs to be connected to the local machine. Change
"CARD_READER_NAME" and "SAM_READER_NAME" with the name of your USB readers.

If you don't know the names of the readers, read how to find them in the [FAQ](#faq).

{{< code lang="cpp" >}}
// Get the instance of the SmartCardService
std::shared_ptr<SmartCardService> smartCardService = SmartCardServiceProvider::getService();

// Register the PcscPlugin with the SmartCardService, retrieve anc configure the readers
std::shared_ptr<Plugin> plugin = smartCardService->registerPlugin(PcscPluginFactoryBuilder::builder()->build());

std::shared_ptr<Reader> cardReader = std::dynamic_pointer_cast<ConfigurableReader>(plugin->getReader("CARD_READER_NAME"));

std::shared_ptr<Reader> samReader = std::dynamic_pointer_cast<ConfigurableReader>(plugin->getReader("SAM_READER_NAME"));
{{< /code >}}

### Set up the Calypso card extension
The Calypso card extension service will provide means to handle cards, SAMs and to manage card transactions.
{{< code lang="cpp" >}}
// Get the Calypso card extension service
std::shared_ptr<CalypsoExtensionService> cardExtension = CalypsoExtensionService::getInstance();

// Verify that the extension's API level is consistent with the current service
smartCardService->checkCardExtension(cardExtension);
{{< /code >}}

### Select the Calypso SAM

Before executing a transaction each smart card should be selected. The
next step is the selection of the Calypso SAM resulting in a
CalypsoSam object.

It is then combined with the SAM reader to form the SAM resource needed
later within the transaction service.

{{< code lang="cpp" >}}
// Select the SAM
std::shared_ptr<CardSelectionManager> samSelectionManager = smartCardService.createCardSelectionManager();
samSelectionManager.prepareSelection(calypsoExtensionService.createSamSelection());
std::shared_ptr<CardSelectionResult> samSelectionResult = samSelectionManager.processCardSelectionScenario(samReader);
std::shared_ptr<CalypsoSam> calypsoSam = std::dynamic_pointer_cast<CalypsoSam> samSelectionResult.getActiveSmartCard();
if (calypsoSam == nullptr) {
  throw IllegalStateException("The SAM selection failed.");
}
{{< /code >}}

### Select the Calypso card

1st card exchange:

The Calypso card selection is made using the card application's AID
and results in a CalypsoCard object that will contain all the information extracted
from the Calypso card all along the transaction.

{{< code lang="cpp" >}}
// Select the card
std::shared_ptr<CardSelectionManager> cardSelectionManager = smartCardService.createCardSelectionManager();
cardSelectionManager.prepareSelection(
calypsoExtensionService.createCardSelection().filterByDfName(AID));
std::shared_ptr<CardSelectionResult> cardSelectionResult =
cardSelectionManager.processCardSelectionScenario(cardReader);
std::shared_ptr<CalypsoCard> calypsoCard = std::dynamic_pointer_cast<CalypsoCard> cardSelectionResult.getActiveSmartCard();
if (calypsoCard == nullptr) {
  throw IllegalStateException("The card selection failed.");
}
{{< /code >}}

### Open the Calypso secure session

2nd card exchange :

The secure session opening operated by the CardTransaction service is
combined with the reading of the environment file (SFI=07h).

The mutual authentication process between Calypso card and Calypso SAM is initiated transparently.

{{< code lang="cpp" >}}
// Prepare the security settings used during the Calypso transaction
std::shared_ptr<CardSecuritySetting> cardSecuritySetting =
        calypsoExtensionService
          .createCardSecuritySetting()
          .setControlSamResource(samReader, calypsoSam);

// Performs file reads using the card transaction manager in a secure session.
std::shared_ptr<CardTransactionManager> cardTransactionManager =
    calypsoExtensionService
        .createCardTransaction(cardReader, calypsoCard, cardSecuritySetting)
        .prepareReadRecord(SFI_ENVIRONMENT_AND_HOLDER, RECORD_NUMBER_1)
        .processOpening(WriteAccessLevel.DEBIT);
{{< /code >}}

### Close the Calypso secure session

3rd card exchange:

Simply close the Calypso secure session

The mutual authentication is finalized, it includes the authentication
of the data in the read file.

Note: any technical, cryptographic or content-related incident in the Calypso card
would be signalled by an exception and would interrupt the thread of
execution.

{{< code lang="cpp" >}}
// Close the secure session, free the communication channel at the same time
cardTransactionManager.prepareReleaseCardChannel().processClosing();

printf(
    "= #### The Secure Session ended successfully, the card is authenticated and the data read are certified.");
System.out.println(
    "\n= #### FILE CONTENT = " + calypsoCard.getFileBySfi(SFI_ENVIRONMENT_AND_HOLDER));

printf("\n= #### End of the Calypso card processing.");
{{< /code >}}

### Unregister the plugin

Finally unregister the plugin before shutting down the application

{{< code lang="cpp" >}}
// Unregister the plugin before leaving the application
smartCardService.unregisterPlugin(plugin.getName());
exit(0);
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

{{< code lang="cpp" >}}
#include "SmartCardService.h"
#include "SmartCardServiceProvider.h"

#include "PcscPlugin.h"
#include "PcscPluginFactory.h"
#include "PcscPluginFactoryBuilder.h"
#include "PcscReader.h"

using namespace keyple::core::service;
using namespace keyple::plugin::pcsc;

class ReaderDiscovery {};

int main()
{
    std::shared_ptr<SmartCardService> smartCardService = SmartCardServiceProvider::getService();
    std::shared_ptr<Plugin> plugin = smartCardService->registerPlugin(PcscPluginFactoryBuilder::builder()->build());
    std::cout << plugin->getReaderNames().size() << " reader(s) found." << std::endl;
    for (const auto& readerName : plugin->getReaderNames()) {
        std::cout << "\"" << readerName << "\"" << std::endl;
    }
}
{{< /code >}}

The console output should look something like:

```
2 reader(s) found.
"ASK LoGO 0"
"Identive CLOUD 2700 R Smart Card Reader 0"
```

Identify which reader will be the card (contactless) reader and the SAM
(contact) reader and replace ```CARD_READER_NAME``` and
```SAM_READER_NAME``` with their values.

#### The program is terminated with 'The SAM/card selection failed'

Check the presence of the SAM and/or the card. The expected SAM is a Calypso S1 SAM and the expected card must have an 
application identifier (DFNAME) corresponding to the AID used.

#### The program is terminated with an exception

The cause is probably an error in the name of one of the two readers or the absence of a card on the contactless reader.

To better identify the origin of the problem, it is always possible to surround the code with try/catch and display the cause.

#### Full code

Here is the complete code of this quick start in one single block.

{{< code lang="cpp" >}}
#include "CalypsoExtensionService.h"

#include "ConfigurableReader.h"
#include "SmartCardService.h"
#include "SmartCardServiceProvider.h"

#include "ByteArrayUtil.h"
#include "ContactCardCommonProtocol.h"
#include "ContactlessCardCommonProtocol.h"
#include "IllegalStateException.h"
#include "LoggerFactory.h"
#include "StringUtils.h"

#include "PcscPlugin.h"
#include "PcscPluginFactory.h"
#include "PcscPluginFactoryBuilder.h"
#include "PcscReader.h"
#include "PcscSupportedContactlessProtocol.h"

using namespace keyple::card::calypso;
using namespace keyple::core::service;
using namespace keyple::core::service::resource;
using namespace keyple::core::util;
using namespace keyple::core::util::cpp;
using namespace keyple::core::util::cpp::exception;
using namespace keyple::core::util::protocol;
using namespace keyple::plugin::pcsc;

const std::string AID                    = "315449432E49434131";
const uint8_t SFI_ENVIRONMENT_AND_HOLDER = 0x07;
const uint8_t RECORD_NUMBER_1            = 1;

class Main_CardAuthentication_Pcsc {};

int main()
{
    // Get the instance of the SmartCardService
    std::shared_ptr<SmartCardService> smartCardService = SmartCardServiceProvider::getService();

    // Register the PcscPlugin with the SmartCardService, retrieve anc configure the readers
    std::shared_ptr<Plugin> plugin = smartCardService->registerPlugin(PcscPluginFactoryBuilder::builder()->build());

    std::shared_ptr<Reader> cardReader = std::dynamic_pointer_cast<ConfigurableReader>(plugin->getReader("CARD_READER_NAME"));

    std::shared_ptr<Reader> samReader = std::dynamic_pointer_cast<ConfigurableReader>(plugin->getReader("SAM_READER_NAME"));

    // Get the Calypso card extension service
    std::shared_ptr<CalypsoExtensionService> calypsoExtensionService = CalypsoExtensionService::getInstance();

    // Verify that the extension's API level is consistent with the current service
    smartCardService->checkCardExtension(calypsoExtensionService);

    // Select the SAM
    std::shared_ptr<CardSelectionManager> samSelectionManager = smartCardService->createCardSelectionManager();
    samSelectionManager->prepareSelection(calypsoExtensionService->createSamSelection());
    std::shared_ptr<CardSelectionResult> samSelectionResult = samSelectionManager->processCardSelectionScenario(samReader);
    std::shared_ptr<CalypsoSam> calypsoSam                  = std::dynamic_pointer_cast<CalypsoSam>(samSelectionResult->getActiveSmartCard());
    if (calypsoSam == nullptr)
    {
        throw IllegalStateException("The SAM selection failed.");
    }

    // Select the card
    std::shared_ptr<CardSelectionManager> cardSelectionManager = smartCardService->createCardSelectionManager();
    std::shared_ptr<CalypsoCardSelection> cardSelection        = calypsoExtensionService->createCardSelection();
    cardSelection->filterByDfName(AID);
    cardSelectionManager->prepareSelection(cardSelection);
    std::shared_ptr<CardSelectionResult> cardSelectionResult = cardSelectionManager->processCardSelectionScenario(cardReader);
    std::shared_ptr<CalypsoCard> calypsoCard                 = std::dynamic_pointer_cast<CalypsoCard>(cardSelectionResult->getActiveSmartCard());
    if (calypsoCard == nullptr)
    {
        throw IllegalStateException("The card selection failed.");
    }

    // Prepare the security settings used during the Calypso transaction
    std::shared_ptr<CardSecuritySetting> cardSecuritySetting = calypsoExtensionService->createCardSecuritySetting();
    cardSecuritySetting->setSamResource(samReader, calypsoSam);

    // Performs file reads using the card transaction manager in a secure session.
    std::shared_ptr<CardTransactionManager> cardTransactionManager = calypsoExtensionService->createCardTransaction(cardReader, calypsoCard, cardSecuritySetting);

    cardTransactionManager->prepareReadRecord(SFI_ENVIRONMENT_AND_HOLDER, RECORD_NUMBER_1).processOpening(WriteAccessLevel::DEBIT);

    // Close the secure session, free the communication channel at the same time
    cardTransactionManager->prepareReleaseCardChannel().processClosing();

    printf("= #### The Secure Session ended successfully, the card is "
           "authenticated and the data read are certified.");
    //  printf("\n= #### FILE CONTENT = " +
    //  calypsoCard->getFileBySfi(SFI_ENVIRONMENT_AND_HOLDER));

    printf("\n= #### End of the Calypso card processing.");
}
{{< /code >}}