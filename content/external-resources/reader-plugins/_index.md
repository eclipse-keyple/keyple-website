---
title: External reader plugins
---

{{% callout note %}}
To reference your reader plugin please [create an issue](https://github.com/eclipse-keyple/keyple-website/issues) on 
GitHub **and/or** directly contribute to this website using the 
[contribution guide]({{< relref "community/contributing/" >}}).
{{% /callout %}}

<table id="external-resource-table" class="table table-striped">
    <thead>
    <tr>
        <th scope="col" class="text-center">Name</th>
        <th scope="col" class="text-center">Device</th>
        <th scope="col" class="text-center">Interface</th>
        <th scope="col" class="text-center">OS</th>
        <th scope="col" class="text-center">Language</th>
        <th scope="col" class="text-center">License</th>
        <th scope="col" class="text-center">Access</th>
        <th scope="col" class="text-center">Supplier</th>
        <th scope="col" class="text-center" data-orderable="false">Info</th>
    </tr>
    </thead>
    <tbody id="external-resource-table-content">
    <tr>
        <td class="text-center"><a href="https://github.com/springcard/android-keyple" target="_blank" rel="noopener">SpringCard Android</a></td>
        <td class="text-center">Puck One, Prox'N'Roll, Puck Blue</td>
        <td class="text-center">USB PC/SC, BLE</td>
        <td class="text-center">Android</td>
        <td class="text-center">Java/Kotlin</td>
        <td class="text-center">SpringCard</td>
        <td class="text-center">Open Source</td>
        <td class="text-center"><a href="https://www.springcard.com/" target="_blank" rel="noopener">SpringCard</a></td>
        <td class="text-center">
{{% modal title="SpringCard Android" %}}
SpringCard is happy to contribute to the Keyple project by providing a plugin that makes it possible to use SpringCard 
PC/SC couplers from a stock Android tablet or mobile phone.

The plugin works
- with all SpringCard PC/SC over USB devices.

This includes all the SpringCard Puck family (for instance SpringCard Puck One, featuring contactless+SAM:
https://www.springcard.com/en/products/puck-one),
SpringCard Prox'N'Roll (https://www.springcard.com/en/products/proxnroll-pcsc-hsp)
and virtually all PC/SC over USB (CCID) devices.

The Android host must be a complete USB host (https://developer.android.com/guide/topics/connectivity/usb/host).
USB on-the-go (OTG) is not enough!
Pay attention that the Android host must also be able to provide enough power to the reader (more than 250mA),
which is not the case for many tablets and mobile phones. Using a USB 3 hub with power delivery is generally the solution.
- with SpringCard PC/SC over BLE (Bluetooth Low Energy) devices.

First BLE PC/SC reader in SpringCard's portfolio is SpringCard Puck Blue (https://www.springcard.com/en/products/puck-blue).
Other devices will be introduced in the future. The Android host must support BLE (https://developer.android.com/guide/topics/connectivity/bluetooth/ble-overview).

The plugin is hosted on GitHub: https://github.com/springcard/android-keyple

It is based on SpringCard's PC/SC-Like for Android libraries (https://github.com/springcard/android-pcsclike)
that connects to the reader in BLE or USB using only 'user-land' methods.
{{% /modal %}}
        </td>
    </tr>
    <tr>
        <td class="text-center"><a href="https://github.com/calypsonet/keyple-plugin-cna-coppernic-cone2-java-lib" target="_blank" rel="noopener">Coppernic</a></td>
        <td class="text-center">C-One v2</td>
        <td class="text-center">Internal</td>
        <td class="text-center">Android</td>
        <td class="text-center">Java/Kotlin</td>
        <td class="text-center"><a href="https://www.eclipse.org/legal/epl-2.0/" target="_blank" rel="noopener">EPL-2.0</a></td>
        <td class="text-center">Open Source</td>
        <td class="text-center"><a href="https://calypsonet.org" target="_blank" rel="noopener">CNA</a></td>
        <td class="text-center"></td>
    </tr>
    <tr>
        <td class="text-center"><a href="https://github.com/calypsonet/keyple-plugin-cna-famoco-se-communication-java-lib" target="_blank" rel="noopener">Famoco</a></td>
        <td class="text-center">FX100, FX105, FX200, FX205, FX300, FX915, FX920</td>
        <td class="text-center">Internal</td>
        <td class="text-center">Android</td>
        <td class="text-center">Java/Kotlin</td>
        <td class="text-center"><a href="https://www.eclipse.org/legal/epl-2.0/" target="_blank" rel="noopener">EPL-2.0</a></td>
        <td class="text-center">Open Source</td>
        <td class="text-center"><a href="https://calypsonet.org" target="_blank" rel="noopener">CNA</a></td>
        <td class="text-center"></td>
    </tr>
    <tr>
        <td class="text-center"><a href="https://github.com/calypsonet/keyple-plugin-cna-flowbird-android-java-lib" target="_blank" rel="noopener">Flowbird</a></td>
        <td class="text-center">Axio Touch Validator/MTBorne validator, Magnetic Axio Touch Validator, Axio 4 Validator, Infigo Driver Console, Voyager Embedded Ticketing Vending Machine, Coppernic C-One, Coppernic C-One V2, Zebra TC77, ACTIA PSDT</td>
        <td class="text-center">Internal</td>
        <td class="text-center">Android</td>
        <td class="text-center">Java/Kotlin</td>
        <td class="text-center">Flowbird</td>
        <td class="text-center">Restricted</td>
        <td class="text-center"><a href="https://calypsonet.org" target="_blank" rel="noopener">CNA</a></td>
        <td class="text-center"></td>
    </tr>
    <tr>
        <td class="text-center"><a href="https://github.com/calypsonet/keyple-plugin-cna-bluebird-specific-nfc-java-lib" target="_blank" rel="noopener">Bluebird</a></td>
        <td class="text-center">EF501, EF551</td>
        <td class="text-center">Internal</td>
        <td class="text-center">Android</td>
        <td class="text-center">Java/Kotlin</td>
        <td class="text-center">Bluebird</td>
        <td class="text-center">Restricted</td>
        <td class="text-center"><a href="https://calypsonet.org" target="_blank" rel="noopener">CNA</a></td>
        <td class="text-center"></td>
    </tr>
    <tr>
        <td class="text-center"><a href="https://github.com/calypsonet/keyple-plugin-cna-legacyhsm-java-lib" target="_blank" rel="noopener">Legacy HSM</a></td>
        <td class="text-center">Spirtech HSM</td>
        <td class="text-center">IP</td>
        <td class="text-center">Windows, Linux, macOS</td>
        <td class="text-center">Java/Kotlin</td>
        <td class="text-center">Spirtech</td>
        <td class="text-center">Restricted</td>
        <td class="text-center"><a href="https://calypsonet.org" target="_blank" rel="noopener">CNA</a></td>
        <td class="text-center"></td>
    </tr>
    </tbody>
</table>
<script type="text/javascript">
document.body.onload = function() {
    initExternalResourceTable();
};
</script>