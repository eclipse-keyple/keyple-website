---
title: Upgrade from an earlier version of Keyple
linktitle: How to upgrade Keyple
summary: How to upgrade an existing Keyple application using an earlier version.
type: book
toc: true
weight: 7
---

<br>

This guide is intended to help a user of a previous version of Keyple Java to upgrade his application to a new version of the library.

Upgrade from:
* [2.+ to 3.+](#upgrade-from-2-to-3)
* [1.+ to 2.+](#upgrade-from-1-to-2)

<br>

---
## Upgrade from "2.+" to "3.+"

This major release follows the adoption of **Keypop APIs** in place of **CNA Terminal APIs**.

We recommend that you follow the steps below in the order suggested:
1. Update the project [dependencies management](#dependencies-management)
2. Perform a global [text search & replace](#renaming) across the entire project
3. Apply the changes to the [card/SAM selection manager](#card-selection)
4. Apply the changes to the [card transaction manager](#card-transaction)
5. Apply the changes to the [signatures management (PSO or basic)](#pso-signature-management-computationverification) during card transactions
6. Apply the changes to the [SAM resource service](#sam-resource-service)

{{% callout note %}}
All deprecated methods have been removed. If your project contains such methods, please check the changelogs for
replacement methods.
{{% /callout %}}

### Dependencies management

Replace the legacy Keyple dependencies with the latest versions.
To do this, use the [configuration wizard]({{< relref "/components/overview/configuration-wizard" >}}) 
to correctly import the new artifacts into your project.

### Renaming

Search and replace (in "**case-sensitive**" and "**whole-word**" mode) in the following order the following strings when present:
1. `org.calypsonet.terminal.calypso` => `org.eclipse.keypop.calypso.card`
2. `org.calypsonet.terminal` => `org.eclipse.keypop`
3. `card.sam` => `crypto.legacysam.sam`
4. `Reader` => `CardReader`
5. `ObservableReader` => `ObservableCardReader`
6. `ReaderEvent` => `CardCardReader`
7. `CalypsoSam` => `LegacySam`
8. `CardSelection` => `CardSelectionExtension`
9. `CalypsoApiProperties` => `CalypsoCardApiProperties`
10. `SamIOException` => `CryptoIOException`
11. `CalypsoCardSelection` => `CalypsoCardSelectionExtension`
12. `GenericCardSelection` => `GenericCardSelectionExtension`
13. `CardSecuritySetting` => `SymmetricCryptoSecuritySetting`
14. `createCardSecuritySetting` => `createSymmetricCryptoSecuritySetting`
15. `processCommands(true)` => `processCommands(ChannelControl.CLOSE_AFTER)`
16. `processCommands(false)` => `processCommands(ChannelControl.KEEP_OPEN)`
17. `processApdusToByteArrays(true)` => `processApdusToByteArrays(ChannelControl.CLOSE_AFTER)`
18. `processApdusToByteArrays(false)` => `processApdusToByteArrays(ChannelControl.KEEP_OPEN)`
19. `processApdusToHexStrings(true)` => `processApdusToHexStrings(ChannelControl.CLOSE_AFTER)`
20. `processApdusToHexStrings(false)` => `processApdusToHexStrings(ChannelControl.KEEP_OPEN)`
21. `createCardSelectionManager()` => `getReaderApiFactory().createCardSelectionManager()`
22. `createCardSelection()` =>
    - **Calypso** card extension: `getCalypsoCardApiFactory().createCalypsoCardSelectionExtension()`
    - **Generic** card extension: `createGenericCardSelectionExtension()`
23. `createCardTransactionWithoutSecurity` => `getCalypsoCardApiFactory().createFreeTransactionManager`
24. `createSearchCommandData` => `getCalypsoCardApiFactory().createSearchCommandData`
25. `prepareComputeSignature` => `getCryptoExtension(CardTransactionLegacySamExtension.class).prepareComputeSignature`
26. `prepareVerifySignature` => `getCryptoExtension(CardTransactionLegacySamExtension.class).prepareVerifySignature`

### Card selection

#### Prepare a Calypso card selection case

- 2.+

{{< code lang="java" >}}
CalypsoCardSelection calypsoCardSelection = 
    CalypsoExtensionService.getInstance().createCardSelection()
        .filterByDfName(...)
        .setFileOccurrence(...)
        .setFileControlInformation(...);

cardSelectionManager.prepareSelection(calypsoCardSelection);
{{< /code >}}

- 3.+

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

- 3.+

{{< code lang="java" >}}
String powerOnDataFilter = LegacySamUtil.buildPowerOnDataFilter(productType, serialNumber);

BasicCardSelector basicCardSelector =
    SmartCardServiceProvider.getService().getReaderApiFactory().createBasicCardSelector()
        .filterByPowerOnData(powerOnDataFilter);

LegacySamSelectionExtension legacySamSelectionExtension =
    LegacySamExtensionService.getInstance().getLegacySamApiFactory().createLegacySamSelectionExtension();

cardSelectionManager.prepareSelection(basicCardSelector, legacySamSelectionExtension);
{{< /code >}}

#### Prepare a Generic card selection case

- 2.+

{{< code lang="java" >}}
GenericCardSelection genericCardSelection =
    GenericExtensionService.getInstance().createCardSelection()
        .filterByDfName(...)
        .setFileOccurrence(...)
        .setFileControlInformation(...);

cardSelectionManager.prepareSelection(genericCardSelection);
{{< /code >}}

- 3.+

{{< code lang="java" >}}
IsoCardSelector isoCardSelector =
    SmartCardServiceProvider.getService().getReaderApiFactory().createIsoCardSelector()
        .filterByDfName(...)
        .setFileOccurrence(...)
        .setFileControlInformation(...);

GenericCardSelectionExtension genericCardSelectionExtension =
    GenericExtensionService.getInstance().createGenericCardSelectionExtension();

cardSelectionManager.prepareSelection(isoCardSelector, genericCardSelectionExtension);
{{< /code >}}

#### Schedule a card selection scenario

- 2.+

{{< code lang="java" >}}
cardSelectionManager.scheduleCardSelectionScenario(
    observableCardReader,
    detectionMode,
    notificationMode);
{{< /code >}}

- 3.+

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

- 3.+

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

- 3.+

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

- 3.+

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

### PSO signature management (computation/verification)

- 2.+

{{< code lang="java" >}}
TraceableSignatureComputationData signatureComputationData =
    CalypsoExtensionService.getInstance()
        .createTraceableSignatureComputationData();

cardTransactionManager.prepareComputeSignature(signatureComputationData);
{{< /code >}}

- 3.+

{{< code lang="java" >}}
TraceableSignatureComputationData signatureComputationData =
    LegacySamExtensionService.getInstance()
        .getLegacySamApiFactory().createTraceableSignatureComputationData();

cardTransactionManager.getCryptoExtension(CardTransactionLegacySamExtension.class)
    .prepareComputeSignature(signatureComputationData);
{{< /code >}}

### SAM resource service

- 2.+

{{< code lang="java" >}}
CardResourceProfileExtension samResourceProfileExtension =
    CalypsoExtensionService.getInstance()
        .createSamResourceProfileExtension(
            CalypsoExtensionService.getInstance()
                .createSamSelection()
                .filterByProductType(CalypsoSam.ProductType.SAM_C1));
{{< /code >}}

- 3.+

{{< code lang="java" >}}
CardResourceProfileExtension samResourceProfileExtension =
    LegacySamExtensionService.getInstance()
        .createLegacySamResourceProfileExtension(
            LegacySamExtensionService.getInstance()
                .getLegacySamApiFactory()
                .createLegacySamSelectionExtension(),
            LegacySamUtil.buildPowerOnDataFilter(LegacySam.ProductType.SAM_C1, null));
{{< /code >}}

### Miscellaneous

#### Contact reader payload capacity management

- 2.+

{{< code lang="java" >}}
ContextSetting contextSetting = 
    CalypsoExtensionService.getInstance().getContextSetting().setContactReaderPayloadCapacity(...);
{{< /code >}}

- 3.+

{{< code lang="java" >}}
ContextSetting contextSetting = 
    LegacySamExtensionService.getInstance().getContextSetting().setContactReaderPayloadCapacity(...);
{{< /code >}}


<br>

---
## Upgrade from "1.+" to "2.+"

Here is a comparative review of the main API changes between Keyple 1.+ and 2.+:

### Dependency management

Use the [configuration wizard]({{< relref "/components/overview/configuration-wizard" >}}) to correctly import the new artifacts into your project.

### Initial configuration

#### Use of a provider to access the smart card service

- 1.+

{{< code lang="java" >}}
SmartCardService smartCardService = SmartCardService.getInstance();
{{< /code >}}

- 2.+

{{< code lang="java" >}}
SmartCardService smartCardService = SmartCardServiceProvider.getService();
{{< /code >}}

#### Use of builders to instantiate plugin factories

- 1.+

{{< code lang="java" >}}
Plugin plugin = smartCardService.registerPlugin(new PcscPluginFactory(null, new ExceptionHandlerImpl()));
...
((ObservableReader) reader).addObserver(new CardReaderObserver());
{{< /code >}}

- 2.+

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

- 1.+

{{< code lang="java" >}}
reader.activateProtocol(
    PcscSupportedContactlessProtocols.ISO_14443_4.name(), 
    ContactlessCardCommonProtocols.ISO_14443_4.name());
{{< /code >}}

- 2.+

{{< code lang="java" >}}
((ConfigurableCardReader) reader).activateProtocol(
    PcscSupportedContactlessProtocols.ISO_14443_4.name(), 
    CARD_ISO_14443_4);
{{< /code >}}

#### Use of plugin and reader extensions for specific configurations

{{% callout note %}}
The examples below show the evolutions for the configuration of a PC/SC reader but the principle is the same for all plugins and readers.
{{% /callout %}}

- 1.+

{{< code lang="java" >}}
reader
    .setContactless(true)
    .setIsoProtocol(PcscReader.IsoProtocol.T1);
{{< /code >}}

- 2.+

{{< code lang="java" >}}
plugin.getReaderExtension(PcscReader.class, reader.getName())
    .setContactless(true)
    .setIsoProtocol(PcscReader.IsoProtocol.T1);
{{< /code >}}

### Card selection

#### Use a manager instead of service for card selection

- 1.+

{{< code lang="java" >}}
CardSelectionsService cardSelectionsService = new CardSelectionsService();
{{< /code >}}

- 2.+

{{< code lang="java" >}}
CardSelectionManager cardSelectionManager = smartCardService.createCardSelectionManager();
{{< /code >}}

{{% callout note %}}
A new instance of the card selection manager is provided by the smart card service.
{{% /callout %}}

#### Use of a card extension to create a card selection

- 1.+

{{< code lang="java" >}}
GenericCardSelectionRequest genericCardSelectionRequest =
    new GenericCardSelectionRequest(
        CardSelector.builder()
            .aidSelector(CardSelector.AidSelector.builder().aidToSelect(cardAid).build())
            .build());
{{< /code >}}

- 2.+

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

- 1.+

{{< code lang="java" >}}
CardSelectionsResult selectionResult = cardSelectionsService.processExplicitSelections(reader);
{{< /code >}}

- 2.+

{{< code lang="java" >}}
CardSelectionResult selectionResult = cardSelectionManager.processCardSelectionScenario(reader);
{{< /code >}}

{{% callout note %}}
Note the removal of the "s" in `CardSelectionResult`.
{{% /callout %}}

#### Scheduled card selection

- 1.+

{{< code lang="java" >}}
((ObservableReader) reader)
    .setDefaultSelectionRequest(
        defaultSelectionsRequest,
        ObservableReader.NotificationMode.MATCHED_ONLY,
        ObservableReader.PollingMode.REPEATING);
((ObservableReader) reader).addObserver(new CardReaderObserver());
{{< /code >}}

- 2.+

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

- 1.+

{{< code lang="java" >}}
AbstractSmartCard smartCard =
  defaultSelection
      .processDefaultSelectionsResponse(event.getDefaultSelectionsResponse())
      .getActiveSmartCard();
{{< /code >}}

- 2.+

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

- 1.+

{{< code lang="java" >}}
PoTransaction poTransaction =
    new PoTransaction(
        new CardResource<CalypsoPo>(poReader, calypsoPo),
        CalypsoUtils.getSecuritySettings(samResource));
{{< /code >}}

- 2.+

{{< code lang="java" >}}
CardTransactionManager transactionManager = CalypsoExtensionService.getInstance()
    .createCardTransaction(cardReader, calypsoCard, cardSecuritySetting);
{{< /code >}}

### Distributed systems

#### Remote plugin registration

- 1.+

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

- 2.+

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

- 1.+

{{< code lang="java" >}}
// Init the local service using the associated factory.
LocalServiceClientFactory.builder()
    .withDefaultServiceName()
    .withSyncNode(endpointClient)
    .withoutReaderObservation()
    .getService();
{{< /code >}}

- 2.+

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