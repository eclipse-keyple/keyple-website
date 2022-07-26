---
title: Build your first Android application
linktitle: Android
summary: This guide describes how to start a ticketing application using Keyple and Android NFC plugin to read the content of a Calypso card.
type: book
toc: true
weight: 2
---

---
## Overview

The development of an Android application based on Keyple follows the same principles as those exposed in the Java part.

However, this guide points out the specificities of this environment based on the **Android NFC application** example provided in the [keyple-java-example](https://github.com/eclipse/keyple-java-example) repository.

We recommend that Android application developers clone this example to better understand how Keyple works on Android.

{{% callout warning %}}  
The application available in the example repository requires: 
* a retail Device with NFC powered by android.nfc library (integrated into standard Android SDK),
* Android OS 19+,
* a Calypso card (contactless smart card, NFC mobile phone with a Calypso applet or application).
{{% /callout %}}

It uses three main components of Keyple:
* [Keyple Service Java Library]({{< relref "/components-java/core/" >}})
  which is the base component to which all the others refer,
* [Keyple Card Generic]({{< relref "/components-java/card-extensions/keyple-card-generic-java-lib" >}})
  add-on to handle the commands sent to the Calypso card,
* [Keyple Plugin Android NFC]({{< relref "/components-java/standard-reader-plugins/keyple-plugin-android-nfc-java-lib" >}})
  add-on to provide the ability to drive the NFC reader.

[Gradle](https://gradle.org/) is used as build automation tool, but it is easy to transpose these explanations to another tool
such as Maven for example.

---
## Project setup

The dependencies to be imported into the project are accessible with the [configuration wizard]({{< relref "/components-java/overview/configuration-wizard" >}}).

Depending on the nature of the hardware resources required, it is necessary to declare certain permissions in the project manifest file.
In the case of the Android NFC example, access to NFC functions is declared as follows:
{{< code lang="xml" >}}
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    ...
    <uses-permission android:name="android.permission.NFC" />
    <uses-feature android:name="android.hardware.nfc" android:required="true" />
    ...
    <application ...>
        ...
        <activity ... >
            ...
            <intent-filter>
                <action android:name="android.nfc.action.TECH_DISCOVERED" />
            </intent-filter>
            <meta-data
                    android:name="android.nfc.action.TECH_DISCOVERED"
                    android:resource="@xml/tech_list" />
        </activity>
    </application>
</manifest>
{{< /code >}}

You will have to adapt this section according to the reader plugin used.

---
## Focus on Keyple specific code

{{< code lang="kotlin" >}}
...
abstract class AbstractExampleActivity : ..., CardReaderObserverSpi, CardReaderObservationExceptionHandlerSpi {
    ...
}
{{< /code >}}


{{< code lang="kotlin" >}}
...
class CoreExamplesActivity : AbstractExampleActivity() {

    private val CARD_ISO_14443_4 = "ISO_14443_4_CARD"

    private lateinit var plugin: Plugin
    private lateinit var reader: CardReader

    override fun onCreate(savedInstanceState: Bundle?) {
        ...
        // Register AndroidNfc plugin Factory
        plugin = SmartCardServiceProvider.getService()
            .registerPlugin(AndroidNfcPluginFactoryProvider(this).getFactory())

        // Configure Nfc Reader
        with(plugin.getReader(AndroidNfcReader.READER_NAME) as ObservableCardReader) {
            setReaderObservationExceptionHandler(this@CoreExamplesActivity)
            addObserver(this@CoreExamplesActivity)
            // with this protocol settings we activate the nfc for ISO1443_4 protocol
            (this as ConfigurableCardReader).activateProtocol(
                AndroidNfcSupportedProtocols.ISO_14443_4.name, CARD_ISO_14443_4)
            reader = this
        }
    }

    override fun onDestroy() {
        SmartCardServiceProvider.getService().unregisterPlugin(AndroidNfcPlugin.PLUGIN_NAME)
        ...
    }

    override fun onResume() {
        ...
        try {
            checkNfcAvailability()
            if (intent.action != null && intent.action == NfcAdapter.ACTION_TECH_DISCOVERED) run {
                ...
                // notify reader that card detection has been launched
                (reader as ObservableCardReader).startCardDetection(
                    ObservableCardReader.DetectionMode.SINGLESHOT)
                ...
                plugin.getReaderExtension(AndroidNfcReader.class, reader.name).processIntent(intent)
                configureUseCase1ExplicitSelectionAid()
            } else {
                ...
                // enable detection
                (reader as ObservableCardReader).startCardDetection(
                    ObservableCardReader.DetectionMode.SINGLESHOT)
            }
        } catch (e: IOException) {
            ...
        }
    }
    ...
    private fun configureUseCase1ExplicitSelectionAid() {
        ...
        with(reader as ObservableCardReader) {
            ...
            if (isCardPresent) {
                val smartCardService = SmartCardServiceProvider.getService()

                // Get the generic card extension service
                val cardExtension = GenericExtensionService.getInstance()

                // Verify that the extension API level is consistent with the current service.
                smartCardService.checkCardExtension(cardExtension)

                /*
                 * Setting of an AID based selection (in this example a Calypso REV3 PO)
                 *
                 * Select the first application matching the selection AID whatever the card communication
                 * protocol keep the logical channel open after the selection
                 */
                val aid = CalypsoClassicInfo.AID_CD_LIGHT_GTML

                /*
                 * Generic selection: configures a CardSelector with all the desired attributes to make
                 * the selection and read additional information afterwards
                 */
                val cardSelection = cardExtension.createCardSelection()
                    .filterByCardProtocol(CARD_ISO_14443_4)
                    .filterByDfName(aid)

                // Create a card selection using the generic card extension.
                cardSelectionManager.prepareSelection(cardSelection)

                // Provide the Reader with the selection operation to be processed when a card is inserted.
                cardSelectionManager.scheduleCardSelectionScenario(
                    reader as ObservableCardReader,
                    ObservableCardReader.DetectionMode.SINGLESHOT,
                    ObservableCardReader.NotificationMode.MATCHED_ONLY)
                ...
                try {
                    val cardSelectionsResult = cardSelectionManager.processCardSelectionScenario(this)
                    if (cardSelectionsResult.activeSmartCard != null) {
                        val matchedCard = cardSelectionsResult.activeSmartCard
                        ...
                    } else {
                        // selection failed
                        ...
                    }
                    (reader as ObservableCardReader).finalizeCardProcessing()
                } catch (e: CardCommunicationException) {
                    ...
                } catch (e: ReaderCommunicationException) {
                    ...
                }
            } else {
                // No cards were detected
                ...
            }
            ...
        }
    }
    ...
}
{{< /code >}}

---
## FAQ

#### How to fix "_More than one file was found with OS independent path 'META-INF/NOTICE.md'_".

Add lines below to your :app build.gradle file

{{< code lang="kotlin" >}}
android {
    packagingOptions {
        exclude 'META-INF/NOTICE.md'
    }
}
{{< /code >}}