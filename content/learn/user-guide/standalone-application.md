---
title: Standalone Application User Guide
linktitle: Standalone application
summary: How to develop an end-user standalone application.
type: book
toc: true
draft: false
weight: 1
---

---
## Overview

A standalone application is an application that runs in a device in contact
with the end user.

It has at least one local smart card reader and manages itself the
interaction with the user.

The diagram below illustrates the organization of a standalone application based on Keyple: 
{{< figure src="/media/learn/user-guide/standalone-application/standalone_application_overview.svg" caption="" >}}

---
## Operating mode
{{% callout warning %}}
If you are new to Keyple, read the [key concepts]({{< relref "key-concepts.md" >}}) page and familiarize yourself with the fundamentals behind Keyple.
{{% /callout %}}

1. Access to the [smart card service](#the-smart-card-service)
2. [Set up a plugin](#set-up-a-plugin)
3. [Set up a reader](#set-up-a-reader)
4. [Select a card](#select-a-card)
5. [Perform a transaction](#perform-a-transaction)

## The smart card service

As part of Keyple Service component, the smart card service is the main service of Keyple. Its role is to centralize the add-on resources and to manage their
life cycle.

The service is accessible by invoking the `SmartCardServiceProvider.getService()` static method.

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
or one of our [partners reader plugins]({{< ref "external-resources/external-add-ons/" >}}).

{{% callout note %}}
A new plugin can also be [created]({{< relref "reader-plugin-add-on" >}}) if there is no plugin for the intended hardware.
{{% /callout %}}

### Access to a plugin
To access a plugin at the application level, it must first be registered with the smart card service via the `registerPlugin(...)` method.
It will be necessary to provide an implementation of the `KeyplePluginExtensionFactory` interface.
This factory is provided by the API of the used plugin.

Depending on the capabilities of the hardware, the plugin factory may or may not offer specific configuration options.
Please refer to the API of the plugin component you are considering to see what is appropriate for your application.

The registration provides in return an implementation of one of the `Plugin`, `ObservablePlugin` or `PoolPlugin` interfaces depending on the type of target plugin.

{{% callout note %}}
A plugin is identified by a unique name in the system so that it can be retrieved at any time from the smart card service.
{{% /callout %}}

{{< code lang="java" >}}
// Here is for example the registration of the PC/SC plugin
Plugin plugin = smartCardService.registerPlugin(PcscPluginFactoryBuilder.builder().build());
{{< /code >}}

### Configure a plugin
Some plugin types may offer specific options.

Static options are usually directly exposed by the plugin factory API while dynamic options are exposed by the plugin extension API.

To access the plugin extension it is necessary to invoke the `getExtension(...)` method on the registered `Plugin` by specifying the expected class of the extension which must extends the `KeyplePluginExtension` interface.
After that, the dedicated methods are available from the resulting object.

{{< code lang="java" >}}
// Here is a snippet showing the usage of the extension of the Stub plugin
plugin
    .getExtension(StubPlugin.class)
    .unplugReader("READER_1");
{{< /code >}}

### Monitor a plugin
{{% callout warning %}} The plugin monitoring only applies to hardware environments in which the readers are removable.
Moreover, only plugins of type `ObservablePlugin` can be monitored.
{{% /callout %}}

The observation of reader connections and disconnections is achieved
through a background task managed by Keyple Service.

To enable these observation mechanisms, it is imperative to provide:
- a plugin observer implementing the `PluginObserverSpi` interface to be notified of plugin events,
- an exception handler implementing the `PluginObservationExceptionHandlerSpi` interface to be notified of errors that may occur during the monitoring or events notifications.

These two interfaces are available in the `org.eclipse.keyple.core.service.spi` package of the Keyple Service component.

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
        // handle here the plugin exceptions raised while observing the readers
        ...
    }
}
{{< /code >}}

In order to access the dedicated setters, the plugin has to be cast to `ObservablePlugin`.

Since adding an observer will cause the Keyple Service to check for the presence of an exception handler,
the definition of the exception handler must be done first.

{{< code lang="java" >}}
PluginObserver pluginObserver = new PluginObserver();
((ObservablePlugin) plugin).setPluginObservationExceptionHandler(pluginObserver);
((ObservablePlugin) plugin).addObserver(pluginObserver);
{{< /code >}}

{{% callout note %}}
Note that the monitoring thread only works if there is at least one observer registered, and the notification process is sequential and synchronous.
{{% /callout %}}

---
## Set up a reader
The readers are provided by the plugins, that's why you have to [set up the plugin](#set-up-a-plugin) first.

### Access to a reader
The hardware readers already connected are referenced in the system during the registration of the plugin.
For observable plugins, the references of the connected readers are updated in real time.

Readers are accessible directly from the associated `Plugin` instance.

{{< code lang="java" >}}
// Here is an example to get the 1st available reader
String readerName = plugin.getReaderNames().get(0);
CardReader reader = plugin.getReader(readerName);
{{< /code >}}

{{% callout note %}}
Depending on the type of plugin, the reader names are
more or less dynamic (e.g. a PC/SC based system vs. an embedded
terminal), it is sometimes necessary to implement an identification
mechanism in order to assign the right reader to the right place in the
system (for example by using regular expressions).
{{% /callout %}}

### Configure a reader
There are two types of configuration. Their availability depends on the characteristics of the reader:

* The reader is an instance of `ConfigurableCardReader`:<br>
It is then possible to activate or deactivate the protocols supported by the reader.
  <div class="alert alert-note"><div>Use of these methods may be optional if the application does not intend to target products by protocol filtering.</div></div>

* The reader's extension API exposes specific options:<br>
To access the reader extension it is necessary to invoke the `getReaderExtension(...)` method on the `Plugin` instance by specifying the expected class of the extension (which must extends the `KeypleReaderExtension` interface) and the reader's name.
After that, the dedicated methods, if any, are available from the resulting object.
{{< code lang="java" >}}
// Here is a snippet showing how to get and use the extension of the Stub reader
plugin
    .getReaderExtension(StubReader.class, readerName)
    .removeCard();
{{< /code >}}

### Monitor a reader
{{% callout warning %}} The reader monitoring only applies to hardware environments in which the smart cards are removable.
Moreover, only readers of type `ObservableCardReader` can be monitored.
{{% /callout %}}

{{% callout note %}}
Observation of the readers is optional in Keyple. It facilitates an event-driven programming mode, but an application
developer can choose not to observe a reader, either because this reader is not designed to manage card insertions/withdrawals (for example an
Android OMAPI reader or a SAM reader), or because the application is designed to directly manage the presence of a card (see to `isCardPresent` method of the
`CardReader` interface).
{{% /callout %}}

The observation of card insertions and removals is achieved
through a background task managed by Keyple Service.

To enable these observation mechanisms, it is imperative to provide:
- a reader observer implementing the `CardReaderObserverSpi` interface to be notified of reader events,
- an exception handler implementing the `CardReaderObservationExceptionHandlerSpi` interface to be notified of errors that may occur during the monitoring or events notifications.

These two interfaces are available in the `org.calypsonet.terminal.reader.spi` package of the **Calypsonet Terminal Reader API** component.

Here is an example of a reader observer class including an exception handler:

{{< code lang="java" >}}
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
        // handle here the reader exceptions raised while observing the cards
        ...
    }
}
{{< /code >}}

In order to access the dedicated setters, the reader has to be cast to `ObservableCardReader`.

Since adding an observer will cause the Keyple Service to check for the presence of an exception handler,
the definition of the exception handler must be done first.

{{< code lang="java" >}}
ReaderObserver readerObserver = new ReaderObserver();
((ObservableCardReader) reader).setReaderObservationExceptionHandler(readerObserver);
((ObservableCardReader) reader).addObserver(readerObserver);
((ObservableCardReader) reader).startCardDetection(ObservableCardReader.DetectionMode.REPEATING);
{{< /code >}}

{{% callout note %}}
Note that the `startCardDetection(...)` and `stopCardDetection()` methods start and stop the monitoring thread.
The API offers different options to manage the needs around card detection.<br>
Moreover, the notification process is sequential and synchronous.
{{% /callout %}}

---
## Select a card

The starting point of any processing done with a card in the Keyple enrivonment, is to reference this card in the system. 
It is the role of the selection step to obtain this reference.

You have first to prepare a selection scenario defining the eligible cards for a transaction, then to execute the scenario when a card is present.

### Prepare a scenario

To prepare a scenario, you have to get a new instance of `CardSelectionManager` from the smart card service using the `createCardSelectionManager()` method,
then configure it with scenario cases using dedicated methods provided by one or more card extensions.

{{< code lang="java" >}}
CardSelectionManager cardSelectionManager = smartCardService.createCardSelectionManager();```
{{< /code >}}

The `prepareSelection(...)` method allows to add a selection case to the scenario by providing an implementation of the `CardSelection` interface and return the index of the added case in order to be able to identify later the case that matched.

Please note that the order of addition is important because it will impact the selection cycle and favor the performance of the first added cases. 

Providing one or more selection cases to the `CardSelectionManager` constitutes a selection scenario.
The scenario is run by Keyple Service when a card is detected, the different cases being evaluated
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

The same card could correspond to several cases of the same scenario, especially when filtering by AID.
By default, the selection process will stop at the first case that matches.
It is however possible to choose another strategy using the `setMultipleSelectionMode()` method.
In this case, the process will continue to the last selection case in the scenario and return all results, but only the last matching application will be selected.

When a card is selected, the `CardSelectionManager` will make available the result
as a `SmartCard` object containing all the information known about the card at that stage.

Depending on the card extension that is used, this `SmartCard` object can be cast to a more
comprehensive object with specific features defined by the extension.

In addition to the selection process itself, specific APDU commands may be sent to the card if the selection is successful.
The output of these commands is available in the instance of the `SmartCard` object.

The following snippet shows the preparation of two selection cases using the generic card extension:
{{< code lang="java" >}}
// prepare a selection for application 1
int firstCaseIndex = cardSelectionManager.prepareSelection(
    GenericExtensionService.getInstance()
        .createCardSelection()
        .filterByDfName(AID1));

// prepare a selection for application 2
int secondCaseIndex = cardSelectionManager.prepareSelection(
    GenericExtensionService.getInstance()
        .createCardSelection()
        .filterByDfName(AID2));
{{< /code >}}

### Run a scenario

If we know that the card is in the reader it is possible to run a selection scenario by invoking the `processCardSelectionScenario(...)` method on the corresponding reader.
The result of the selection is then directly returned.

{{< code lang="java" >}}
// Actual card communication: run the selection scenario.
CardSelectionResult selectionResult = cardSelectionManager.processCardSelectionScenario(reader);

// Get the SmartCard resulting of the selection.
SmartCard smartCard = selectionResult.getActiveSmartCard();

// Check the selection result.
if (smartCard == null) {
  throw new IllegalStateException("The selection of the card failed.");
}
{{< /code >}}

### Schedule a scenario

If the reader is of type `ObservableCardReader` then it is possible to schedule in advance the execution of a selection scenario as soon as a card is presented.

Invoke the `scheduleCardSelectionScenario(...)` to register the previously prepared scenario in the observable reader.

In this case, it is necessary to register a reader observer and to have started the card detection in order to be able to retrieve the result of the selection which will be contained in a `CardReaderEvent`.

Use the `parseScheduledCardSelectionsResponse(...)` method to extract the selection result from the event.

Note that the scheduling of the execution of a scenario includes two options:
* the `DetectionMode` defining the expected behavior regarding the card detection allowing to automatically restart it or not.
* the `NotificationMode` allowing to choose if only the cards matching the selection (successfully selected) should trigger an event.

{{< code lang="java" >}}
...
@Override
public void onReaderEvent(CardReaderEvent event) {
  try {
    switch (event.getType()) {
      case CardReaderEvent.Type.CARD_MATCHED:
        // Retrieve the selected smart card
        SmartCard smartCard =
            cardSelectionManager
                .parseScheduledCardSelectionsResponse(event.getScheduledCardSelectionsResponse())
                .getActiveSmartCard();
        // Perform the transaction
        ...
        break;
      default:
        break;
    }
  } finally {
    // Ensures that the communication channel is closed, regardless of the processing with the card.
    ((ObservableCardReader) (reader)).finalizeCardProcessing();
  }
}
...
{{< /code >}}

{{% callout note %}}
The `finalizeCardProcessing()` method must be invoked at the end of the transaction to ensure that the communication channel is closed.
This switches the underlying monitoring thread into a state of waiting for the card to be removed.

Not doing this can lead to blocking states of the card insertion/removal monitoring mechanism.
{{% /callout %}}

---
## Perform a transaction

Once the smart card is referenced in the system it is possible to perform the desired transaction using the appropriate card extension.

When the transaction is completed, if the reader is observed, it is imperative to invoke the `finalizeCardProcessing()` method on the observable reader (see the above note).

---
## Unregister a plugin
To shut down a Keyple application properly, it is necessary to free the resources and in particular to close opened card physical channels and stop the observation threads.

This is done by unregistering the plugins in the following way:

{{< code lang="java" >}}
smartCardService.unregisterPlugin(plugin.getName());
{{< /code >}}

---
## API

* [Calypsonet Terminal Reader API](https://terminal-api.calypsonet.org/apis/calypsonet-terminal-reader-api/)
* [Keyple Common API](https://eclipse.github.io/keyple-common-java-api)
* [Keyple Service API](https://eclipse.github.io/keyple-service-java-lib)

---
## Examples

* [Java examples](https://github.com/eclipse/keyple-java-example)

---
## Download

* [Java components]({{< ref "components-java/overview/configuration-wizard" >}})