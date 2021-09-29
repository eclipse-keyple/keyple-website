---
title: Standalone Application Developer Guide
linktitle: Standalone application
summary: How to develop an end-user standalone application.
type: book
toc: true
draft: false
weight: 10
---

---
## Overview

A standalone application is an application that runs in a device in contact
with the end user.

It has at least one local smart card reader and manages itself the
interaction with the user.

The diagram below illustrates the organization of a standalone application based on Keyple: {{< figure library="true"
src="uml/standalone-application/component/Local_Application_Components_Overview.svg"
title="" >}}

---
## Before you start

1. If you are new to Keyple, read the [key concepts]({{< relref
   "key-concepts.md" >}}) page and familiarize yourself with the fundamentals behind Keyple.
2. Any implementation of a Keyple application starts with the
   setting up of **Keyple Service**, please study the
   [workflow](#workflow) proposed in the following chapter.
3. Explore the [Keyple Service component page]({{< ref "components-java/core/keyple-service-java-lib.md" >}}) to discover the features and the
   possibilities offered by its API.
4. Take inspiration from the [examples](#examples).
5. Follow the explanations given in the [Build your first app]({{<
   ref "learn/build-your-first-app/java-app.md" >}}) section to configure your environment (Gradle / Maven).
6. Using the [Java components]({{< ref "components-java/_index.md" >}}) pages, import
   **Keyple Service** and the optional add-ons into your project and start playing with **Keyple**.
7. Don't forget to explore the potential of Keyple card-specific
   extensions such as [**Keyple Calypso**]({{< ref "components-java/card-extensions/keyple-card-calypso-java-lib.md" >}}).

---
## Operating mode

**Keyple Service** is built around the concepts described [here]({{< relref
"key-concepts.md" >}}) and sometimes proposes several ways to perform
an action or to achieve a result depending on the needs of the
application.

The purpose of this section is to guide you in its use.

## Access to the smart card service

Invoke the `SmartCardServiceProvider.getService()` static method to access the service.

Its main role is to centralize the Keyple add-on resources and to manage their
life cycle.

{{< code lang="java" >}}
SmartCardService smartCardService = SmartCardServiceProvider.getService();
{{< /code >}}

---
## Set up a plugin
The Keyple application developer will choose the reader plugins he needs
according to the equipment on which the Keyple application will run.

For example, if the environment is PC-based, the PC/SC plugin will probably, but not necessarily, be chosen.
For an Andoid terminal environment, the plugin could be the standard
Android NFC plugin or one of the plugins available from the industrial
partners of the project.

For a complete list of available plugins, please see
the [standard reader plugins]({{< ref "components-java/standard-reader-plugins/_index.md" >}}),
the [specific reader plugins]({{< ref "components-java/specific-reader-plugins/_index.md" >}})
or one of our [partners reader plugins]({{< ref "community/external-add-ons/_index.md" >}}).

{{% alert note %}}
A new plugin can also be [created]({{< relref "create-a-reader-plugin" >}}) if there is no plugin for the intended hardware.
{{% /alert %}}

### Access to a plugin
To access a plugin at the application level, it must first be registered with the smart card service via the `registerPlugin(...)` method.
It will be necessary to provide an implementation of the `KeyplePluginExtensionFactory` interface.
This factory is provided by the API of the used plugin.

Depending on the capabilities of the hardware, the plugin factory may or may not offer specific configuration options.
Please refer to the API of the plugin component you are considering to see what is appropriate for your application.

The registration provides in return an implementation of one of the `Plugin`, `ObservablePlugin` or `PoolPlugin` interfaces depending on the type of target plugin.

{{< code lang="java" >}}
// Here is for example the registration of the PC/SC plugin
Plugin plugin = smartCardService.registerPlugin(PcscPluginFactoryBuilder.builder().build());
{{< /code >}}

### Configure a plugin
Some plugin types may offer specific options.

Static options are usually directly exposed by the plugin factory API while dynamic options are exposed by the plugin extension API.

To access the plugin extension it is necessary to invoke the `getExtension(...)` method on the registered `Plugin` by specifying the expected class of the extension.
After that, the dedicated methods are available from the resulting object.

{{< code lang="java" >}}
// Here is a snippet showing the usage of the extension of the Stub plugin (the procedure would be similar for another plugin/reader)
plugin
    .getExtension(StubPlugin.class)
    .unplugReader("READER_1");
{{< /code >}}

### Monitor a plugin
{{% alert warning %}} The plugin monitoring only applies to hardware environments in which the readers are removable.
Moreover, only plugins of type `ObservablePlugin` can be monitored.
{{% /alert %}}



The observation of reader connections and disconnections is achieved
through a background task managed by **Keyple Service**.

To enable these observation mechanisms, it is imperative to provide:
- a plugin observer implementing the `PluginObserverSpi` interface to be notified of plugin events,
- an exception handler implementing the `PluginObservationExceptionHandlerSpi` interface to be notified of errors that may occur during the monitoring or events notifications.

These two interfaces are available in the `org.eclipse.keyple.core.service.spi` package of the **Keyple Service** component.

Here is an example of a plugin observer class including an exception handler:

{{< code lang="java" >}}
// ...
import org.eclipse.keyple.core.service.spi.PluginObserverSpi;
import org.eclipse.keyple.core.service.spi.PluginObservationExceptionHandlerSpi;
// ...

class PluginObserver implements PluginObserverSpi, PluginObservationExceptionHandlerSpi {

    @Override
    public void onPluginEvent(PluginEvent event) {
        switch (event.getEventType()) {
            case READER_CONNECTED:
                // here the processing to be done when a reader is connected
                ...
                break;
            case READER_DISCONNECTED:
                // here the processing to be done when a reader is disconnected
                ...
                break;
            default:
                break;
        }
    }
    
    @Override
    public void onPluginObservationError(String pluginName, Throwable e) {
        // handle here the plugin exceptions raised while observing the readers
        ...
    }
}
{{< /code >}}

In order to access the dedicated setters, the plugin has to be casted as an `ObservablePlugin`.

Since adding an observer will cause the **Keyple Service** to check for the presence of an exception handler,
the definition of the exception handler must be done first.

{{< code lang="java" >}}
PluginObserver pluginObserver = new PluginObserver();
((ObservablePlugin) plugin).setPluginObservationExceptionHandler(pluginObserver);
((ObservablePlugin) plugin).addObserver(pluginObserver);
{{< /code >}}

{{% alert note %}}
Note that the monitoring thread only works if there is at least one observer registered, and the notification process is sequential and synchronous.
{{% /alert %}}

---
## Set up a reader
### Access to a reader
### Configure a reader
### Monitor a reader

---
## Select a card
### Prepare a selection scenario
### Process a selection scenario
### Schedule a selection scenario

---
## Perform a transaction

---
## Unregister a plugin

---
## API

---
## Examples

---
## Download



## Observation of the plugin


## Readers retrieval

Readers are objects implementing the `Reader` interface and are
returned by the plugin's `getReader` method taking the name of the
reader as argument.

The names of the readers available from the plugin are returned as a
Set of strings by the `getReaderNames` method.

The `getReaders` method also allows you to get all the readers at once as a Set of `Reader` objects.

Here is an example to get the 1st PC/SC reader:

{{< code lang="java" >}}
String readerName = plugin.getReaderNames().get(0);
Reader reader = plugin.getReader(readerName);
{{< /code >}}

{{% alert note %}}
Depending on the type of plugin, the reader names are
more or less dynamic (e.g. a PC/SC based system vs. an embedded
terminal), it is sometimes necessary to implement an identification
mechanism in order to assign the right reader to the right place in the
system (for example by using regular expressions).
{{% /alert %}}

## Reader specific settings

Take a close look at the parameters proposed by the plugin and its readers.

Depending on the characteristics of the reader, it may be necessary to set some parameters in order to meet the application needs.

To access the reader's settings it is necessary to obtain its **specific extension** (this differs from one type of equipment to another).

To do this, we need to invoke the `getExtension` method by passing it the specific class in parameter.
After that, the dedicated methods are available from the resulting object.

Here is a snippet showing the procedure for a PC/SC reader (the procedure would be similar for another plugin/reader):
{{< code lang="java" >}}
Reader reader = plugin.getReader(readerName);
// Configure the reader with parameters suitable for contactless operations.
reader
    .getExtension(PcscReader.class)
    .setContactless(true)
    .setIsoProtocol(PcscReader.IsoProtocol.T1);
{{< /code >}}

{{% alert note %}}
Similarly, the plugin itself may or may not have parameters.<br>
When they exist, they are usually defined by a builder in its factory.<br>
Please refer to the documentation of the plugin you are using for more details on this topic.
{{% /alert %}}

## Protocol activation/deactivation

The `activateProtocol` and `deactivateProtocol` methods of the `ConfigurableReader` interface meet two needs:

- the use or not of a particular protocol at the lowest level of the RF layer of the reader.
  In other words, these methods define which protocols the reader will use to search for cards.

  This may be significant in terms of detection performance (latency) because when multiple protocols are implemented,
  the readers search for cards for each protocol sequentially, for example by alternating ISO14443-A and ISO14443-B RF requests.

  Note that some readers do not allow to select the types of protocols used, for example NFC smartphones. 
  It is nevertheless possible to invoke these methods for their second purpose described below.
- the naming of a reader protocol for the application.
  The idea is to associate a protocol name that will be referenced by the application independently of the reader type.
  This name can be used as parameter of the selection process in order to target a particular product.

Please refer to the API of these methods to learn more about them.

{{% alert note %}}
Use of these methods may be optional if the reader's protocols are not configurable
or if the application does not intend to target products by this criterion.
{{% /alert %}}

## Observation of the reader

{{% alert note %}}
Observation of the readers is optional in Keyple. It
facilitates an event-driven programming mode, but an application
developer can choose not to observe a reader, either because this reader
is not designed to manage card insertions/withdrawals (for example an
Android OMAPI reader or a SAM reader), or because the application is
designed to directly manage the presence of a card (see to `isCardPresent` method of the
`Reader` interface).
{{% /alert %}}

The observation of inserting and removing cards from readers is similar to the observation of plugins.

The observation of card insertion and removal is achieved through a background task managed by **Keyple Service**.

The reader observer must implement the `CardReaderObserverSpi` interface, 
the reader exception handler must implement the `CardReaderObservationExceptionHandlerSpi` interface.

These two interfaces are available in the spi package of the 
[**Calypsonet Terminal Reader Java API**]({{< relref "calypsonet-apis" >}}) 
to which **Keyple Service** conforms to perform these functions.

Here is an example of a reader observer class including an exception handler:
{{< code lang="java" >}}
// ...
import org.calypsonet.terminal.reader.spi.CardReaderObserverSpi;
import org.calypsonet.terminal.reader.spi.CardReaderObservationExceptionHandlerSpi;
// ...

class ReaderObserver implements CardReaderObserverSpi, CardReaderObservationExceptionHandlerSpi {

    @Override
    public void onReaderEvent(CardReaderEvent event) {
        switch (event.getType()) {
            case CardReaderEvent.Type.CARD_INSERTED:
                // here the processing to be done when a card is inserted
                ...
                break;
            case CardReaderEvent.Type.CARD_REMOVED:
                // here the processing to be done when a card is removed
                ...
                break;
            default:
                break;
        }
    }
    
    @Override
    public void onReaderObservationError(String pluginName, String readerName, Throwable e) {
        //
        // handle here the reader exceptions raised while observing the cards
        //
    }
}
{{< /code >}}

The observation of the events of the reader is done in a similar way to
that of the plugin, by adding an observer:
{{< code lang="java" >}}
ReaderObserver readerObserver = new ReaderObserver();
((ObservableReader) reader).setReaderObservationExceptionHandler(readerObserver);
((ObservableReader) reader).addObserver(readerObserver);
{{< /code >}}

## Card selection

The Keyple card selection process is generic, allowing the management of cards of different types 
or technologies within the same application. 

It is based on the universal selection interface defined by the
[**Calypsonet Terminal Reader Java API**]({{< relref "calypsonet-apis" >}}).

A `CardSelectionManager` is obtained from the Keyple `SmartCardService`
using the `createCardSelectionManager` method.

It allows the addition of "selection cases" corresponding to an expected target card.

These selection cases are represented by objects implementing the **Calypsonet Terminal Reader Java API** 
interface `CardSelection`; these objects should be provided by a Keyple Card Extension add-on.

Providing one or more selection cases to the `CardSelectionManager` constitutes a _selection scenario_.
The scenario is run by **Keyple Service** when a card is detected, the different cases being evaluated 
sequentially as long as the card does not match the criteria of the defined cases.

The selection process for a case offers several options for selecting a processing based on the type of card presented to the reader.

It is based on a filtering process according to three possible criteria,
each of which is optional:
* the communication protocol of the card (usually also identifying a
  card technology)
* the power-on data collected by the reader when the card is detected (e.g. the Answer To Reset)
* the ISO standard application identifier (AID) used to perform a Select Application command.

When a card is inserted, it is evaluated according to these criteria and
will be given the status "selected" or not.

When a card is not selected, no other operation will be possible with it.

Depending on the chosen setting (see `setMultipleSelectionMode`), the result of the selection will or will not 
be made available to the application. 
It is thus possible to directly ignore cards that do not correspond to the defined selection criteria.

When a card is selected, the `CardSelectionManager` will make available the result 
as a `SmartCard` object containing all the information known about the card at that stage.

Depending on the card extension that is used, this `SmartCard` object can be casted into a more 
comprehensive object with specific features defined by the extension.

In addition to the selection process itself, specific APDU commands may be sent to the card if the selection is successful. 
The output of these commands is available in the instance of the `SmartCard` object or its derivative.

## Card selection and reader observation

The `CardSelectionManager` performs card selection in two steps:
- a first step of preparing the selection scenario,
- a second step of running the prepared scenario.

The first step is done by invoking the `prepareSelection` method with a `CardSelection` object defining
a selection profile as argument. This is to be repeated as many times as there are selection cases.

The second step, the scenario execution, can be done in two ways:
- by directly executing the scenario with `processCardSelectionScenario` when the presence of the card is managed 
by the application, 
- by feeding the observation mechanism with the scenario by invoking the `scheduleCardSelectionScenario` when 
the reader is observed.

In the first case, the result obtained directly in `CardSelectionResult` in return of 
`processCardSelectionScenario`. 

In the latter case, the result is passed to the application in the `ScheduledCardSelectionsResponse` field of 
`ReaderEvent` and is to be retrieved using `parseScheduledCardSelectionsResponse`. 

Note that the scheduling of the execution of a scenario includes two options:
- the `DetectionMode` defining the expected behavior regarding the card detection allowing to automatically restart it or not.
- the `NotificationMode` allowing to choose if only the cards matching the selection (successfully selected) should trigger an event.

## Card selection in practice

In this chapter we will show step by step how to use the selection service with the generic card extension.

### Create the card selection manager

The card selection manager will be used all along the card selection process.

{{< code lang="java" >}}
// Get the core card selection manager.
CardSelectionManager cardSelectionManager = smartCardService.createCardSelectionManager();```
{{< /code >}}

### Prepare and add the selection cases

The application can create as many selection cases as the type of cards
expected. The order in which the selection cases are prepared is
important because it will favor the latency delay for the processing of
the cards corresponding to the first case. It is therefore recommended
to place the most common card profile in the application context first.

{{< code lang="java" >}}
// prepare a selection for application 1
cardSelectionManager.prepareSelection(
    GenericExtensionService.getInstance()
        .createCardSelection()
        .filterByDfName(AID1));

// prepare a selection for application 2
cardSelectionManager.prepareSelection(
    GenericExtensionService.getInstance()
        .createCardSelection()
        .filterByDfName(AID2));
{{< /code >}}

#### Proceed to the selection with a non-observable reader

The `processCardSelectionScenario` method of `CardSelectionManager` performs the actual
communication with the card.
{{< code lang="java" >}}
// Actual card communication: run the selection scenario.
CardSelectionResult selectionResult = cardSelectionManager.processCardSelectionScenario(reader);

// Check the selection result.
if (selectionResult.getActiveSmartCard() == null) {
  throw new IllegalStateException("The selection of the card failed.");
}

// Get the SmartCard resulting of the selection.
SmartCard smartCard = selectionResult.getActiveSmartCard();
{{< /code >}}

#### Proceed to the selection with an observable reader

In the case of an observable reader, the prepared request is provided
to the reader (it is then named Default Selection) and will be processed
automatically as soon as a card is presented. The application is then
notified of the event with the data resulting from the selection.
Depending on the selection settings, the application will be notified of
all card presentations (```CARD_INSERTED``` event) or only those
presentations that led to a successful selection (```CARD_MATCHED```
event).

##### Add a default selection

```java
// Provide the Reader with the selection operation to be processed when a card is inserted.
((ObservableReader) reader)
        .setDefaultSelectionRequest(
        cardSelectionService.getDefaultSelection().getDefaultSelectionsRequest(),
        ObservableReader.NotificationMode.MATCHED_ONLY,
        ObservableReader.PollingMode.REPEATING);
```

The `NotificationMode` allows you to specify whether all card
insertions should be reported to the application or only those that led
to a successful selection.

`PollingMode` indicates whether to go back to waiting for the card
after processing (`REPEATING`) or let the application decide when to
restart the search (`SINGLESHOT`) with `startCardDetection`.

Note: when the default selection is set with the `PollingMode`
parameter, the card detection is started automatically. However, it is
possible to set a default selection without automatic start and by
starting the detection independently with `startCardDetection`.

##### Receive the result as an event

```java
...
@Override
public void update(ReaderEvent event) {
        switch (event.getEventType()) {
        case CARD_MATCHED:
        AbstractSmartCard selectedCard = null;
        try {
        selectedCard =
        getDefaultSelection()
        .processDefaultSelectionsResponse(event.getDefaultSelectionsResponse())
        .getActiveSmartCard();
        } catch (KeypleException e) {
        logger.error("Exception: {}", e.getMessage());
        ((ObservableReader) (event.getReader())).finalizeCardProcessing();
        }

        if (selectedCard != null) {
        logger.info("Observer notification: the selection of the card has succeeded.");
        // insert the processing of the card here
        ...
        logger.info("= #### End of the card processing.");
        } else {
        logger.error(
        "The selection of the card has failed. Should not have occurred due to the MATCHED_ONLY selection mode.");
        }
        break;
        case CARD_INSERTED:
        logger.error(
        "CARD_INSERTED event: should not have occurred due to the MATCHED_ONLY selection mode.");
        break;
        case CARD_REMOVED:
        logger.trace("There is no PO inserted anymore. Return to the waiting state...");
        break;
default:
        break;
        }
        if (event.getEventType() == ReaderEvent.EventType.CARD_INSERTED
        || event.getEventType() == ReaderEvent.EventType.CARD_MATCHED) {
        // Informs the underlying layer of the end of the card processing, in order to manage the
        // removal sequence.
        ((ObservableReader) (event.getReader())).finalizeCardProcessing();
        }
        }
        ...
```

#### Get the selection result

The result of the selection is available in the `AbstractSmartCard`
object.

```java
...
        if (!cardSelectionsResult.hasActiveSelection()) {
        logger.warn("The selection of the application " + cardAid + " failed.");
        }
        AbstractSmartCard smartCard = cardSelectionsResult.getActiveSmartCard();
        logger.info("The selection of the card has succeeded.");

        if (smartCard.hasFci()) {
        String fci = ByteArrayUtil.toHex(smartCard.getFciBytes());
        logger.info("Application FCI = {}", fci);
        }
        if (smartCard.hasAtr()) {
        String atr = ByteArrayUtil.toHex(smartCard.getAtrBytes());
        logger.info("Card ATR = {}", atr);
        }
        ...
```

## Implementation of the application service

The applicative processing of the card that follows the selection of the
card is to be inserted in the processing of the ```CARD_INSERTED``` or
```CARD_MATCHED``` event.

It can be processed in the thread provided by the monitoring task or
detached in a separate thread. The application developer must pay
attention to the handling of exceptions in this part of the application.
Indeed, in case of a runtime exception, the information will be given to
the application via the exception handler configured beforehand.

## Stopping the application

The clean shutdown of a Keyple application requires the release of
resources and in particular the shutdown of the observation threads.

This is done by unregistering the plugins in the following way:

```java
smartCardService.unregisterPlugin(plugin.getName());
```

---
## Keyple Service API

To learn all the details of the **Keyple Service** API, please consult the
[Javadoc documentation]({{< ref "docs-1.0/api-reference" >}}).

However, here are two diagrams showing the main features of **Keyple Service**:

* The diagram below represents the main classes implemented around the
  **Smart Card Service** with in particular the observation mechanisms.
  {{< figure library="true"
  src="archive-1.0/architecture/KeypleCore_Reader_ClassDiag_PluginSettingAndReaderAccess_1_0_0.svg"
  title=""

>}}

* The diagram below represents the main classes used for selection
  operations. {{< figure library="true"
  src="archive-1.0/architecture/KeypleCore_CardSelection_ClassDiag_SelectorAndSelection_1_0_0.svg"
  title=""

>}}

---
## Examples

To help in the implementation of the different facilities offered by
Keyple to process smart cards, a set of examples is present in the
project repository
[{{< icon name="github" pack="fab" >}} examples](https://github.com/eclipse/keyple-java/tree/master/java/example/generic/standalone)

Nevertheless, you will find below a brief description of them:

## Explicit Selection

Shows the use of Keyple to make a card selection without observing the
reader, based on testing the presence of the card by the application.

[see the code](https://github.com/eclipse/keyple-java/blob/master/java/example/generic/standalone/src/main/java/org/eclipse/keyple/example/generic/centralized/UseCase1_ExplicitSelectionAid)

## Default Selection

Shows the use of Keyple to make a card selection with observation of the
reader. A default selection is prepared, the presentation of a card
triggers the notification of a reader event to the application.

[see the code](https://github.com/eclipse/keyple-java/tree/master/java/example/generic/standalone/src/main/java/org/eclipse/keyple/example/generic/centralized/UseCase2_DefaultSelectionNotification)

## Sequential Multiple Selection

Executes successively several independent selection operations with the
use of the ISO 'NEXT' navigation flag.

[see the code](https://github.com/eclipse/keyple-java/tree/master/java/example/generic/standalone/src/main/java/org/eclipse/keyple/example/generic/centralized/UseCase3_SequentialMultiSelection)

Illustrates the case of a card exploration with maintenance of the physical channel open.

## Grouped Multiple Selection

Executes a multiple selection with logical channel closure between each
selection.

Allows the exploration of the applications of a card in a single
operation but without selection at the end.

[see the code](https://github.com/eclipse/keyple-java/blob/master/java/example/generic/standalone/src/main/java/org/eclipse/keyple/example/generic/centralized/UseCase4_GroupedMultiSelection)

## Demo Card Protocol Detection

Demonstrates the use of Keyple in a context where several card
technologies are likely to be processed by the application.

[see the code](https://github.com/eclipse/keyple-java/tree/master/java/example/generic/standalone/src/main/java/org/eclipse/keyple/example/generic/centralized/Demo_CardProtocolDetection)

## Demo Observable Reader Notification

Demonstrates the use of Keyple to implement the observation of a plugin
and its readers. Readers are dynamically created and an observer is
assigned to them.

[see the code](https://github.com/eclipse/keyple-java/tree/master/java/example/generic/standalone/src/main/java/org/eclipse/keyple/example/generic/centralized/Demo_ObservableReaderNotification)

---
## Download
