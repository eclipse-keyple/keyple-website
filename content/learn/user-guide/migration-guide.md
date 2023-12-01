---
title: Upgrade from an earlier version of Keyple
linktitle: Upgrade Keyple
summary: How to upgrade an existing Keyple application using an earlier version.
type: book
toc: true
weight: 7
---

---
This guide is intended to help a user of a previous version of Keyple Java to upgrade his application to a new version of the library.

Upgrade from:
* [2.+ to 3.0.0](#upgrade-from-2-to-300)
* [1.0.0 to 2.0.0](#upgrade-from-100-to-200)

---
## Upgrade from "2.+" to "3.0.0"

This major release follows the adoption of **Keypop APIs** in place of **CNA Terminal APIs**.

### Dependency management

Use first the [configuration wizard]({{< relref "/components/overview/configuration-wizard" >}}) to correctly import the new artifacts into your project.

### Renaming

Search and replace (in "**case-sensitive**" and "**whole-word**" mode) in the following order the following strings when present:
1. `org.calypsonet.terminal.calypso` => `org.eclipse.keypop.calypso.card`
2. `org.calypsonet.terminal` => `org.eclipse.keypop`
3. `card.sam` => `crypto.legacysam.sam`
4. `Reader` => `CardReader`
4. `ObservableReader` => `ObservableCardReader`
4. `ReaderEvent` => `CardCardReader`
4. `CalypsoSam` => `LegacySam`
5. `CardSelection` => `CardSelectionExtension`
6. `CalypsoApiProperties` => `CalypsoCardApiProperties`
7. `SamIOException` => `CryptoIOException`
8. `CalypsoCardSelection` => `CalypsoCardSelectionExtension`
9. `CardSecuritySetting` => `SymmetricCryptoSecuritySetting`
9. `createCardSecuritySetting` => `createSymmetricCryptoSecuritySetting`
10. `processCommands(true)` => `processCommands(ChannelControl.CLOSE_AFTER)`
11. `processCommands(false)` => `processCommands(ChannelControl.KEEP_OPEN)`
12. `createCardSelectionManager()` => `getReaderApiFactory().createCardSelectionManager()`
13. `createCardSelection()` => `getCalypsoCardApiFactory().createCalypsoCardSelectionExtension()`
13. `createCardTransactionWithoutSecurity` => `getCalypsoCardApiFactory().createFreeTransactionManager`
13. `createSearchCommandData` => `getCalypsoCardApiFactory().createSearchCommandData`
12. `prepareComputeSignature` => `getCryptoExtension(CardTransactionLegacySamExtension.class).prepareComputeSignature`
12. `prepareVerifySignature` => `getCryptoExtension(CardTransactionLegacySamExtension.class).prepareVerifySignature`

### Card selection

#### Prepare a Calypso Card selection case

- 2.+

{{< code lang="java" >}}
CalypsoCardSelection calypsoCardSelection = 
    CalypsoExtensionService.getInstance().createCardSelection()
        .filterByDfName(...)
        .setFileOccurrence(...)
        .setFileControlInformation(...)

cardSelectionManager.prepareSelection(calypsoCardSelection);
{{< /code >}}

- 3.0.0

{{< code lang="java" >}}
IsoCardSelector isoCardSelector =
    SmartCardServiceProvider.getService().getReaderApiFactory().createIsoCardSelector()
        .filterByDfName(...)
        .setFileOccurrence(...)
        .setFileControlInformation(...);

CalypsoCardSelectionExtension calypsoCardSelectionExtension =
    CalypsoExtensionService.getInstance().getCalypsoCardApiFactory().createCalypsoCardSelectionExtension();

cardSelectionManager.prepareSelection(isoCardSelector, calypsoCardSelectionExtension);
{{< /code >}}

#### Prepare a Calypso SAM selection case

- 2.+

{{< code lang="java" >}}
CalypsoSamSelection CalypsoSamSelection = 
    CalypsoExtensionService.getInstance().createSamSelection()
        .filterByProductType(productType)
        .filterBySerialNumber(serialNumber);

cardSelectionManager.prepareSelection(CalypsoSamSelection);
{{< /code >}}

- 3.0.0

{{< code lang="java" >}}
String powerOnDataFilter = LegacySamUtil.buildPowerOnDataFilter(productType, serialNumber);

BasicCardSelector basicCardSelector =
    SmartCardServiceProvider.getService().getReaderApiFactory().createBasicCardSelector()
        .filterByPowerOnData(powerOnDataFilter);

LegacySamSelectionExtension legacySamSelectionExtension =
    LegacySamExtensionService.getInstance().getLegacySamApiFactory().createLegacySamSelectionExtension();

cardSelectionManager.prepareSelection(basicCardSelector, legacySamSelectionExtension);
{{< /code >}}

#### Schedule a card selection scenario

- 2.+

{{< code lang="java" >}}
cardSelectionManager.scheduleCardSelectionScenario(
    observableCardReader,
    detectionMode,
    notificationMode);
{{< /code >}}

- 3.0.0

{{< code lang="java" >}}
cardSelectionManager.scheduleCardSelectionScenario(
    observableCardReader,
    notificationMode);
{{< /code >}}

### Card Transaction

#### Create a card transaction manager without security

- 2.+

{{< code lang="java" >}}
CardTransactionManager cardTransactionManager =
    CalypsoExtensionService.getInstance()
        .createCardTransactionWithoutSecurity(cardReader, card);
{{< /code >}}

- 3.0.0

{{< code lang="java" >}}
FreeTransactionManager cardTransactionManager =
    CalypsoExtensionService.getInstance()
        .getCalypsoCardApiFactory().createFreeTransactionManager(cardReader, card);
{{< /code >}}

#### Create a card transaction manager with security (regular mode)

- 2.+

{{< code lang="java" >}}
CardSecuritySetting securitySetting =
    CalypsoExtensionService.getInstance().createCardSecuritySetting()
        .setControlSamResource(samReader, sam);

CardTransactionManager cardTransactionManager =
    CalypsoExtensionService.getInstance()
        .createCardTransaction(cardReader, card, securitySetting)
{{< /code >}}

- 3.0.0

{{< code lang="java" >}}
SymmetricCryptoCardTransactionManagerFactory cryptoCardTransactionManagerFactory =
    LegacySamExtensionService.getInstance().getLegacySamApiFactory()
        .createSymmetricCryptoCardTransactionManagerFactory(samReader, sam);

SymmetricCryptoSecuritySetting securitySetting =
    CalypsoExtensionService.getInstance().getCalypsoCardApiFactory()
        .createSymmetricCryptoSecuritySetting(cryptoCardTransactionManagerFactory);

SecureRegularModeTransactionManager cardTransactionManager =
    CalypsoExtensionService.getInstance().getCalypsoCardApiFactory()
        .createSecureRegularModeTransactionManager(cardReader, card, securitySetting);
{{< /code >}}

#### Create a card transaction manager with security (extended mode)

- 2.+

{{< code lang="java" >}}
CardSecuritySetting securitySetting =
    CalypsoExtensionService.getInstance().createCardSecuritySetting()
        .setControlSamResource(samReader, sam);

CardTransactionManager cardTransactionManager =
    CalypsoExtensionService.getInstance()
        .createCardTransaction(cardReader, card, securitySetting)
{{< /code >}}

- 3.0.0

{{< code lang="java" >}}
SymmetricCryptoCardTransactionManagerFactory cryptoCardTransactionManagerFactory =
    LegacySamExtensionService.getInstance().getLegacySamApiFactory()
        .createSymmetricCryptoCardTransactionManagerFactory(samReader, sam);

SymmetricCryptoSecuritySetting securitySetting =
    CalypsoExtensionService.getInstance().getCalypsoCardApiFactory()
        .createSymmetricCryptoSecuritySetting(cryptoCardTransactionManagerFactory);

SecureExtendedModeTransactionManager cardTransactionManager =
    CalypsoExtensionService.getInstance().getCalypsoCardApiFactory()
        .createSecureExtendedModeTransactionManager(cardReader, card, securitySetting);
{{< /code >}}

### PSO signature manipulation (computation/verification)

- 2.+

{{< code lang="java" >}}
TraceableSignatureComputationData signatureComputationData =
    CalypsoExtensionService.getInstance()
        .createTraceableSignatureComputationData();

cardTransactionManager.prepareComputeSignature(signatureComputationData);
{{< /code >}}

- 3.0.0

{{< code lang="java" >}}
TraceableSignatureComputationData signatureComputationData =
    LegacySamExtensionService.getInstance()
        .getLegacySamApiFactory().createTraceableSignatureComputationData();

cardTransactionManager.getCryptoExtension(CardTransactionLegacySamExtension.class)
    .prepareComputeSignature(signatureComputationData);
{{< /code >}}

### Context setting

- 2.+

{{< code lang="java" >}}
ContextSetting contextSetting = CalypsoExtensionService.getInstance().getContextSetting();
{{< /code >}}

- 3.0.0

{{< code lang="java" >}}
ContextSetting contextSetting = LegacySamExtensionService.getInstance().getContextSetting();
{{< /code >}}


---
## Upgrade from "1.0.0" to "2.0.0"

Here is a comparative review of the main API changes between Keyple 1.0.0 and 2.0.0:

### Dependency management

Use the [configuration wizard]({{< relref "/components/overview/configuration-wizard" >}}) to correctly import the new artifacts into your project.

### Initial configuration

#### Use of a provider to access the smart card service

- 1.0.0

{{< code lang="java" >}}
SmartCardService smartCardService = SmartCardService.getInstance();
{{< /code >}}

- 2.0.0

{{< code lang="java" >}}
SmartCardService smartCardService = SmartCardServiceProvider.getService();
{{< /code >}}

#### Use of builders to instantiate plugin factories

- 1.0.0

{{< code lang="java" >}}
Plugin plugin = smartCardService.registerPlugin(new PcscPluginFactory(null, new ExceptionHandlerImpl()));
...
((ObservableReader) reader).addObserver(new CardReaderObserver());
{{< /code >}}

- 2.0.0

{{< code lang="java" >}}
Plugin plugin = smartCardService.registerPlugin(PcscPluginFactoryBuilder.builder().build());
...
((ObservableCardReader) reader).setReaderObservationExceptionHandler(new ExceptionHandlerImpl());
((ObservableCardReader) reader).addObserver(new CardReaderObserver());
{{< /code >}}

{{% callout note %}}
Exception handlers are no longer required when registering the plugin but only when starting the observation.
{{% /callout %}}

#### Use of a new interface dedicated to the management of protocols

- 1.0.0

{{< code lang="java" >}}
reader.activateProtocol(
    PcscSupportedContactlessProtocols.ISO_14443_4.name(), 
    ContactlessCardCommonProtocols.ISO_14443_4.name());
{{< /code >}}

- 2.0.0

{{< code lang="java" >}}
((ConfigurableCardReader) reader).activateProtocol(
    PcscSupportedContactlessProtocols.ISO_14443_4.name(), 
    CARD_ISO_14443_4);
{{< /code >}}

#### Use of plugin and reader extensions for specific configurations

{{% callout note %}}
The examples below show the evolutions for the configuration of a PC/SC reader but the principle is the same for all plugins and readers.
{{% /callout %}}

- 1.0.0

{{< code lang="java" >}}
reader
    .setContactless(true)
    .setIsoProtocol(PcscReader.IsoProtocol.T1);
{{< /code >}}

- 2.0.0

{{< code lang="java" >}}
plugin.getReaderExtension(PcscReader.class, reader.getName())
    .setContactless(true)
    .setIsoProtocol(PcscReader.IsoProtocol.T1);
{{< /code >}}

### Card selection

#### Use a manager instead of service for card selection

- 1.0.0

{{< code lang="java" >}}
CardSelectionsService cardSelectionsService = new CardSelectionsService();
{{< /code >}}

- 2.0.0

{{< code lang="java" >}}
CardSelectionManager cardSelectionManager = smartCardService.createCardSelectionManager();
{{< /code >}}

{{% callout note %}}
A new instance of the card selection manager is provided by the smart card service.
{{% /callout %}}

#### Use of a card extension to create a card selection

- 1.0.0

{{< code lang="java" >}}
GenericCardSelectionRequest genericCardSelectionRequest =
    new GenericCardSelectionRequest(
        CardSelector.builder()
            .aidSelector(CardSelector.AidSelector.builder().aidToSelect(cardAid).build())
            .build());
{{< /code >}}

- 2.0.0

{{< code lang="java" >}}
CardSelection cardSelection = GenericExtensionService.getInstance()
    .createCardSelection()
    .filterByDfName(cardAid);
{{< /code >}}

{{% callout note %}} 
- The `CardSelector` class does not exist anymore.
- A generic card extension is now available.
- The card extension service is used to configure the card selection.
{{% /callout %}}

#### Explicit card selection

- 1.0.0

{{< code lang="java" >}}
CardSelectionsResult selectionResult = cardSelectionsService.processExplicitSelections(reader);
{{< /code >}}

- 2.0.0

{{< code lang="java" >}}
CardSelectionResult selectionResult = cardSelectionManager.processCardSelectionScenario(reader);
{{< /code >}}

{{% callout note %}}
Note the removal of the "s" in `CardSelectionResult`.
{{% /callout %}}

#### Scheduled card selection

- 1.0.0

{{< code lang="java" >}}
((ObservableReader) reader)
    .setDefaultSelectionRequest(
        defaultSelectionsRequest,
        ObservableReader.NotificationMode.MATCHED_ONLY,
        ObservableReader.PollingMode.REPEATING);
((ObservableReader) reader).addObserver(new CardReaderObserver());
{{< /code >}}

- 2.0.0

{{< code lang="java" >}}
cardSelectionManager.scheduleCardSelectionScenario(
    (ObservableCardReader) reader,
    ObservableCardReader.DetectionMode.REPEATING,
    ObservableCardReader.NotificationMode.MATCHED_ONLY);
((ObservableCardReader) reader).setReaderObservationExceptionHandler(new ExceptionHandlerImpl());
((ObservableCardReader) reader).addObserver(new CardReaderObserver());
{{< /code >}}

{{% callout note %}}
The selection data is no longer provided to the observable reader but to the selection manager.
It is the observable reader that is provided to the selection manager.
{{% /callout %}}

#### The processing of the result of the selection response has changed

- 1.0.0

{{< code lang="java" >}}
AbstractSmartCard smartCard =
  defaultSelection
      .processDefaultSelectionsResponse(event.getDefaultSelectionsResponse())
      .getActiveSmartCard();
{{< /code >}}

- 2.0.0

{{< code lang="java" >}}
SmartCard smartCard =
    cardSelectionManager
        .parseScheduledCardSelectionsResponse(event.getScheduledCardSelectionsResponse())
        .getActiveSmartCard();
{{< /code >}}

{{% callout note %}}
`AbstractSmartCard` was changed to the `SmartCard` interface.
{{% /callout %}}

### Calypso Card Extension

#### Vocabulary
- `PO` has been replaced by `Card`.

#### SAM management

The SAM resource manager has been replaced by a generic [Card Resource Service]({{< relref "/components/core/keyple-service-resource-lib" >}}).

#### Card transaction

Access to the card transaction manager has changed. It is now done through the card extension service.

- 1.0.0

{{< code lang="java" >}}
PoTransaction poTransaction =
    new PoTransaction(
        new CardResource<CalypsoPo>(poReader, calypsoPo),
        CalypsoUtils.getSecuritySettings(samResource));
{{< /code >}}

- 2.0.0

{{< code lang="java" >}}
CardTransactionManager transactionManager = CalypsoExtensionService.getInstance()
    .createCardTransaction(cardReader, calypsoCard, cardSecuritySetting);
{{< /code >}}

### Distributed systems

#### Remote plugin registration

- 1.0.0

{{< code lang="java" >}}
// Init the remote plugin factory.
RemotePluginServerFactory factory =
    RemotePluginServerFactory.builder()
        .withDefaultPluginName()
        .withSyncNode()
        .withPluginObserver(new RemotePluginServerObserver())
        .usingEventNotificationPool(
            Executors.newCachedThreadPool(r -> new Thread(r, "server-pool")))
        .build();

// Register the remote plugin to the smart card service using the factory.
SmartCardService.getInstance().registerPlugin(factory);
{{< /code >}}

- 2.0.0

{{< code lang="java" >}}
RemotePluginServerFactory factory =
    RemotePluginServerFactoryBuilder.builder(REMOTE_PLUGIN_NAME)
        .withSyncNode()
        .build();

// Register the remote plugin to the smart card service using the factory.
ObservablePlugin plugin =
    (ObservablePlugin) SmartCardServiceProvider.getService().registerPlugin(factory);

// Init the remote plugin observer.
plugin.setPluginObservationExceptionHandler(new ExceptionHandlerImpl());
plugin.addObserver(new RemotePluginServerObserver());
{{< /code >}}

{{% callout note %}}
- You have to specify the name of the plugin.
- It is no longer necessary to provide a thread pool.
- The exception handler must be provided as for any observable plugin before adding an observer.
{{% /callout %}}

#### Local service registration

- 1.0.0

{{< code lang="java" >}}
// Init the local service using the associated factory.
LocalServiceClientFactory.builder()
    .withDefaultServiceName()
    .withSyncNode(endpointClient)
    .withoutReaderObservation()
    .getService();
{{< /code >}}

- 2.0.0

{{< code lang="java" >}}
// Init the local service factory.
LocalServiceClientFactory factory =
    LocalServiceClientFactoryBuilder.builder(LOCAL_SERVICE_NAME)
        .withSyncNode(endpointClient)
        .build();

// Init the local service using the associated factory.
SmartCardServiceProvider.getService().registerDistributedLocalService(factory);
{{< /code >}}

{{% callout note %}}
- You have to specify the name of the local service.
- The local service must be registered with the smart card service.
- It behaves like a plugin or reader and also provides an extension to access specific settings.
{{% /callout %}}