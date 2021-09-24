---
title: Standalone Application Developer Guide
linktitle: Standalone Application
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
## Workflow

**Keyple Service** is built around the concepts described [here]({{< relref
"key-concepts.md" >}}) and sometimes proposes several ways to perform
an action or to achieve a result depending on the needs of the
application.

The purpose of this section is to guide you in its use.

### Start of the smart card service

This is the very first step in the realization of a Keyple application:

{{< code lang="java" >}}
// Get the instance of the SmartCardService (singleton pattern)
SmartCardService smartCardService = SmartCardServiceProvider.getService();
{{< /code >}}

The smart card service is based on the `SmartCardService` interface, of which
a singleton instance is provided by the `SmartCardServiceProvider` class.

Its main role is to centralize the Keyple add-on resources and to manage their
life cycle.


### Reader Plugin selection

The Keyple application developer will choose the reader plugins he needs
according to the equipment on which the Keyple application will run.

For example, if the environment is PC-based, the PC/SC plugin will probably, but not necessarily, be chosen.
For an Andoid terminal environment, the plugin could be the standard
Android NFC plugin or one of the plugins available from the industrial
partners of the project.

For a complete list of available plugins, please see 
the [standard reader plugins]({{< ref "components-java/standard-reader-plugins/_index.md" >}}), 
the [specific reader plugins]({{< ref "components-java/specific-reader-plugins/_index.md" >}}) 
or one of our [partners reader plugins]({{< ref "external-extensions-and-support/proprietary-add-ons/_index.md" >}}).

{{% alert note %}} A new plugin can also be [created]({{< relref
"create-a-reader-plugin" >}}) if there is no plugin for the intended hardware.{{% /alert %}}

### Register the plugin

All Keyple plugins implement the ````Plugin```` interface.

The plugin registration consists in submitting its factory to the Smart
Card Service.

Here is for example the registration of the PC/SC plugin:

{{< code lang="java" >}}
// Register the PcscPlugin to the `SmartCardService` */
Plugin plugin = smartCardService.registerPlugin(PcscPluginFactoryBuilder.builder().build());
{{< /code >}}

{{% alert note %}}

The plugin factories all implement the interface expected by
SmartCardService.

However, depending on the capabilities of the hardware, the plugin factory may or may not offer configuration options using a builder.

Please refer to the API of the plugin you are considering to see what is appropriate for your application.

{{% /alert %}}

### Observation of the plugin

{{% alert warning %}} The notion of plugin observation applies only to
hardware environments in which the readers are removable. {{% /alert %}}

The observation of reader connections and disconnections is achieved
through a background task managed by **Keyple Service**.

To implement these observation mechanisms, it is imperative to provide a plugin observer and an exception handler
to allow **Keyple Service** to notify the application of plugin events and runtime errors (that may occur during the monitoring or notification of events).

The plugin observer must implement the `PluginObserverSpi` interface, the plugin exception handler must implement the `PluginObservationExceptionHandlerSpi` interface.

These two interfaces are available in the _spi_ package of the **Keyple Service** component.

Here is an example of a plugin observer class including an exception handler:

{{< code lang="java" >}}
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
    //
    // handle here the plugin exceptions raised while observing the readers
    //
  }
}
{{< /code >}}

In order to access the dedicated setters, the plugin has to be casted as an ```ObservablePlugin```.

Since adding an observer will cause the **Keyple Service** to check for the presence of an exception handler, 
the definition of the exception handler must be done first.

{{< code lang="java" >}}
PluginObserver pluginObserver = new PluginObserver();
((ObservablePlugin) plugin).setPluginObservationExceptionHandler(pluginObserver);
((ObservablePlugin) plugin).addObserver(pluginObserver);
{{< /code >}}

### Retrieve the reader

Readers are objects implementing the ```Reader``` interface and are
returned by the plugin's ```getReader``` method taking the name of the
reader as argument.

The names of the readers available from the plugin are returned as a
list of strings by the ```getReaderNames``` method.

The ```getReaders``` method also allows to retrieve all readers in a Map
whose key is the name of the reader and the value the ```Reader```
object.

Here is an example to get the 1st PC/SC reader:

```java
String readerName = plugin.getReaderNames().get(0);
        Reader reader = plugin.getReader(readerName);
```

{{% alert note %}} Depending on the type of plugin, the reader names are
more or less dynamic (e.g. a PC/SC based system vs. an embedded
terminal), it is sometimes necessary to implement an identification
mechanism in order to assign the right reader to the right place in the
system (for example by using regular expressions). {{% /alert %}}

### Customize the reader settings

Take a close look at the parameters proposed by the plugin and its
readers.

In particular, it is necessary to configure the expected communication
protocols, but it is also possible that other settings exist depending
on the hardware context.

### Observation of the reader

The observation of inserting and removing cards from readers is similar
to the observation of plugins in that it requires the same operations,
i.e. the use of an exception handler and an object implementing a
dedicated interface.

```java
...
private static class ReaderExceptionHandlerImpl implements ReaderObservationExceptionHandler {
    @Override
    public void onReaderObservationError(String pluginName, String readerName, Throwable throwable) {
        logger.error("An unexpected reader error occurred: {}:{}", pluginName, readerName, throwable);
    }
}
}

        /* Create an exception handler for reader observation */
        ReaderExceptionHandlerImpl readerExceptionHandlerImpl = new ExceptionHandlerImpl();

        /* Assign the PcscPlugin to the SmartCardService */
        plugin = smartCardService.registerPlugin(new PcscPluginFactory(pluginExceptionHandlerImpl, readerExceptionHandlerImpl));
        ...
```


The observation of the events of the reader is done in a similar way to
that of the plugin, by adding an observer:

```java
((ObservableReader) reader).addObserver(new ReaderObserver());
```

and implementing the ReaderObserver interface:

```java
class ReaderObserver implements ObservableReader.ReaderObserver {

    @Override
    public void update(ReaderEvent event) {
        switch (event.getEventType()) {
            case CARD_INSERTED:
                // here the processing to be done when a card is inserted
          ...
                break;
            case CARD_MATCHED:
                // here the processing to be done when a card matched the selection
          ...
                break;
            case CARD_REMOVED:
                // here the processing to be done when a card is removed
          ...
                break;
            default:
                break;
        }
    }
}
}
```

{{% alert note %}} Observation of the readers is optional in Keyple. It
facilitates an event-driven programming mode, but an application
developer can choose not to observe a reader, either because this reader
is not designed to manage card insertions/withdrawals (for example an
Android OMAPI reader or a SAM reader), or because the application is
designed to directly manage the presence of a card (refer to the
```Reader``` interface). {{% /alert %}}

### Card selection

The card selection service offered by **Keyple Core** gives multiple
possibilities to choose the processing according to the type of card
presented to the reader.

It is based on a filtering process according to three possible criteria,
each of which is optional:
* the communication protocol of the card (usually also identifying a
  card technology)
* the answer to reset of the card (ATR)
* the ISO standardized application identifier (AID)

Each of these criteria can be defined in a ```CardSelector``` object.

When a card is inserted, it is evaluated according to these criteria and
will be given the status "selected" or not.

When a card is not selected, no other operation will be possible with
it. Depending on the chosen setting, the result of the selection will or
will not be made available to the application. It is thus possible to
directly ignore cards that do not correspond to the defined selection
criteria.

When a card is selected, the result is an object that extends the
AbstractSmartCard and contains all the information known about the card
at that stage.

In the case of a ISO standardized card, the application is selected with
the provided AID (additional settings are available to specify the
desired navigation within the card applications list).

In addition to the selection process itself, specific APDU commands can
be sent to the card if the selection is successful. The output data of
these commands are available in the instance of the object
```AbstractSmarCard```.

The ```CardSelector``` and the additional APDU commands are grouped in a
```CardSelectionRequest``` object.

One or more ```CardSelectionRequest``` can be set up to perform as many
selection cases, each targeting a particular card or application.

The final selection process takes as input a list of
```CardSelectionRequest``` and gets in return a list of
```CardSelectionResponse```.

#### Card selection steps

In this guide we will not show the addition of supplementary APDU
commands. Please refer to the Calypso guide for an implementation
example.

##### Create the card selection service

The card selection service will be used all along the card search
process.

```java
    cardSelectionService = new CardSelectionsService();
```

##### Create the selection cases

The application can create as many selection cases as the type of cards
expected. The order in which the selection cases are prepared is
important because it will favor the latency delay for the processing of
the cards corresponding to the first case. It is therefore recommended
to place the most common card profile in the application context first.

```java
/** Create a new class extending AbstractCardSelection */
public final class GenericCardSelection extends AbstractCardSelection {
    public GenericCardSelection(CardSelector cardSelector) {
        super(cardSelector);
    }

    @Override
    protected AbstractSmartCard parse(CardSelectionResponse cardSelectionResponse) {
        class GenericSmartCard extends AbstractSmartCard {
            public GenericSmartCard(CardSelectionResponse cardSelectionResponse) {
                super(cardSelectionResponse);
            }

            public String toJson() {
                return "{}";
            }
        }
        return new GenericSmartCard(cardSelectionResponse);
    }
}

    final String aid1 = "AABBCCDDEE";
    final String aid2 = "EEDDCCBBAA";

    // first selection case targeting cards with AID1
    GenericCardSelection cardSelector1 =
            new GenericCardSelection(
                    CardSelector.builder()
                            .cardProtocol(ContactlessCardCommonProtocols.ISO_14443_4.name())
                            .aidSelector(CardSelector.AidSelector.builder().aidToSelect(aid1).build())
                            .build());

// Add the selection case to the current selection
cardSelectionsService.prepareSelection(cardSelector1);

// first selection case targeting cards with AID1
        GenericCardSelection cardSelector2 =
        new GenericCardSelection(
        CardSelector.builder()
        .cardProtocol(ContactlessCardCommonProtocols.ISO_14443_4.name())
        .aidSelector(CardSelector.AidSelector.builder().aidToSelect(aid2).build())
        .build());

// Add the selection case to the current selection
        cardSelectionsService.prepareSelection(cardSelector2);
```

##### Proceed to the selection with a non-observable reader

The ```processExplicitSelections``` method of ```CardSelectionService```
performs the actual communication with the card.

```java
...
// Check if a card is present in the reader
        if (!reader.isCardPresent()) {
        logger.error("No Po Card is present in the reader.");
        return;
        }

// Actual card communication: operate through a single request the card selection
        CardSelectionsResult cardSelectionsResult =
        cardSelectionsService.processExplicitSelections(reader);
        ...
```

##### Proceed to the selection with an observable reader

In the case of an observable reader, the selection request is provided
to the reader (it is then named Default Selection) and will be processed
automatically as soon as a card is presented. The application is then
notified of the event with the data resulting from the selection.
Depending on the selection settings, the application will be notified of
all card presentations (```CARD_INSERTED``` event) or only those
presentations that led to a successful selection (```CARD_MATCHED```
event).

###### Add a default selection

```java
// Provide the Reader with the selection operation to be processed when a card is inserted.
((ObservableReader) reader)
        .setDefaultSelectionRequest(
        cardSelectionService.getDefaultSelection().getDefaultSelectionsRequest(),
        ObservableReader.NotificationMode.MATCHED_ONLY,
        ObservableReader.PollingMode.REPEATING);
```

The ```NotificationMode``` allows you to specify whether all card
insertions should be reported to the application or only those that led
to a successful selection.

```PollingMode``` indicates whether to go back to waiting for the card
after processing (```REPEATING```) or let the application decide when to
restart the search (```SINGLESHOT```) with ```startCardDetection```.

Note: when the default selection is set with the ```PollingMode```
parameter, the card detection is started automatically. However, it is
possible to set a default selection without automatic start and by
starting the detection independently with ```startCardDetection```.

###### Receive the result as an event

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

##### Get the selection result

The result of the selection is available in the ```AbstractSmartCard```
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

### Implementation of the application service

The applicative processing of the card that follows the selection of the
card is to be inserted in the processing of the ```CARD_INSERTED``` or
```CARD_MATCHED``` event.

It can be processed in the thread provided by the monitoring task or
detached in a separate thread. The application developer must pay
attention to the handling of exceptions in this part of the application.
Indeed, in case of a runtime exception, the information will be given to
the application via the exception handler configured beforehand.

### Stopping the application

The clean shutdown of a Keyple application requires the release of
resources and in particular the shutdown of the observation threads.

This is done by unregistering the plugins in the following way:

```java
smartCardService.unregisterPlugin(plugin.getName());
```

---
## Keyple Core API

To learn all the details of the **Keyple Core** API, please consult the
[Javadoc documentation]({{< ref "docs-1.0/api-reference" >}}).

However, here are two diagrams showing the main features of Keyple Core:

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

### Explicit Selection

Shows the use of Keyple to make a card selection without observing the
reader, based on testing the presence of the card by the application.

[see the code](https://github.com/eclipse/keyple-java/blob/master/java/example/generic/standalone/src/main/java/org/eclipse/keyple/example/generic/centralized/UseCase1_ExplicitSelectionAid)

### Default Selection

Shows the use of Keyple to make a card selection with observation of the
reader. A default selection is prepared, the presentation of a card
triggers the notification of a reader event to the application.

[see the code](https://github.com/eclipse/keyple-java/tree/master/java/example/generic/standalone/src/main/java/org/eclipse/keyple/example/generic/centralized/UseCase2_DefaultSelectionNotification)

### Sequential Multiple Selection

Executes successively several independent selection operations with the
use of the ISO 'NEXT' navigation flag.

[see the code](https://github.com/eclipse/keyple-java/tree/master/java/example/generic/standalone/src/main/java/org/eclipse/keyple/example/generic/centralized/UseCase3_SequentialMultiSelection)

Illustrates the case of a card exploration with maintenance of the physical channel open.

### Grouped Multiple Selection

Executes a multiple selection with logical channel closure between each
selection.

Allows the exploration of the applications of a card in a single
operation but without selection at the end.

[see the code](https://github.com/eclipse/keyple-java/blob/master/java/example/generic/standalone/src/main/java/org/eclipse/keyple/example/generic/centralized/UseCase4_GroupedMultiSelection)

### Demo Card Protocol Detection

Demonstrates the use of Keyple in a context where several card
technologies are likely to be processed by the application.

[see the code](https://github.com/eclipse/keyple-java/tree/master/java/example/generic/standalone/src/main/java/org/eclipse/keyple/example/generic/centralized/Demo_CardProtocolDetection)

### Demo Observable Reader Notification

Demonstrates the use of Keyple to implement the observation of a plugin
and its readers. Readers are dynamically created and an observer is
assigned to them.

[see the code](https://github.com/eclipse/keyple-java/tree/master/java/example/generic/standalone/src/main/java/org/eclipse/keyple/example/generic/centralized/Demo_ObservableReaderNotification)

---
## Download

The artifact **Keyple Core** and how to integrate it into your
application is available here:

* [Keyple Core Java component]({{< ref "/components-java-1.0/core" >}})
* [Keyple Core C++ component]({{< ref "/components-cpp-0.9/core" >}})
