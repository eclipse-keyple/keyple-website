---
title: Calypso Networks Association
summary: As initiator of the Keyple project, CNA offers numerous additional resources such as reader plugins, 
  demonstrations, tools, training and support for implementing Keyple.
tags: ["ReaderPlugins", "Demos", "Tools", "Training"]
---

> {{< icon name="globe" pack="fas" >}} [Discover more about CNA here](https://calypsonet.org)
>
> {{< icon name="envelope" pack="fas" >}} [Get in touch with the CNA team for more information](https://calypsonet.org/contact-us/)

Calypso Networks Association (CNA) is a non-profit organization dedicated to improve contactless
electronic ticketing for transportation and access control standards since 2003.
For many years, our mission has been to create innovative solutions that are fully interoperable,
reliable, secure, and open. We collaborate with a dynamic network of city leaders and transport
authorities that are keen to work with system integrators with Calypso® standard expertise.

Discover more about CNA here: http://calypsonet.org

Calypso Networks Association offers comprehensive [technical support and documentation](https://calypsonet.org/technical-support-documentation/)
to ensure all users can get the most out of Calypso® technology and Eclipse Keyple®.

Calypso Networks Association provides a Calypso Test Kit. The Calypso Test Kit aims at helping
ticketing system developers to fully experience Eclipse Keyple® with a set of Calypso® SAM and
Calypso® certified portable objects from several manufacturers in various configurations.

<br>

## Reader plugins

<table id="external-resource-table-1" class="table table-striped">
    <thead>
    <tr>
        <th scope="col" class="text-center">Name</th>
        <th scope="col" class="text-center">Device</th>
        <th scope="col" class="text-center">Interface</th>
        <th scope="col" class="text-center">OS</th>
        <th scope="col" class="text-center">Language</th>
        <th scope="col" class="text-center">License</th>
        <th scope="col" class="text-center">Access</th>
        <th scope="col" class="text-center" data-orderable="false">Info</th>
    </tr>
    </thead>
    <tbody id="external-resource-table-1-content">
    <tr>
        <td class="text-center"><a href="https://github.com/calypsonet/keyple-plugin-cna-coppernic-cone2-java-lib" target="_blank" rel="noopener">Coppernic</a></td>
        <td class="text-center">C-One v2</td>
        <td class="text-center">Internal</td>
        <td class="text-center">Android</td>
        <td class="text-center">Java/Kotlin</td>
        <td class="text-center"><a href="https://www.eclipse.org/legal/epl-2.0/" target="_blank" rel="noopener">EPL-2.0</a></td>
        <td class="text-center">Open Source</td>
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
        <td class="text-center"></td>
    </tr>
    </tbody>
</table>

<br>

## Demos


<table id="external-resource-table-2" class="table table-striped">
    <thead>
    <tr>
        <th scope="col" class="text-center">Name</th>
        <th scope="col" class="text-center">OS</th>
        <th scope="col" class="text-center">Language</th>
        <th scope="col" class="text-center">Access</th>
        <th scope="col" class="text-center" data-orderable="false">Info</th>
    </tr>
    </thead>
    <tbody id="external-resource-table-2-content">
    <tr>
        <td class="text-center"><a href="https://github.com/calypsonet/keyple-java-demo-remote" target="_blank" rel="noopener">Reload Remote</a></td>
        <td class="text-center">Windows, Linux, macOS, Android</td>
        <td class="text-center">Java/Kotlin, C#</td>
        <td class="text-center">Open Source</td>
        <td class="text-center">
{{% modal title="Demo Reload Remote" %}}
This demo requires a client/server environment:
<br><br>
<ul>
    <li>
<strong>On the client side</strong>, an Android application loaded in a standard NFC smartphone provides the means to a customer to 
make the ticket purchase.
The Android NFC plugin is used to communicate with the contactless card, and the Calypso card commands are fully 
managed by the back-office ticketing server using the Keyple Distributed solution.
    </li>
</ul>
<ul>
    <li>
<strong>On the server side</strong>, the back-office includes a Java server application to process the ticketing sale and manage the 
Calypso secure session to reload contracts in remote cards.
The server manages a pool of Calypso SAM using the PC/SC plugin and the Calypso SAM resource manager.
    </li>
</ul>
{{% /modal %}}
        </td>
    </tr>
    <tr>
        <td class="text-center"><a href="https://github.com/calypsonet/keyple-android-demo-validation" target="_blank" rel="noopener">Validation</a></td>
        <td class="text-center">Android</td>
        <td class="text-center">Java/Kotlin</td>
        <td class="text-center">Open Source</td>
        <td class="text-center">
{{% modal title="Demo Validation" %}}
This demo can be installed on various terminals such as Coppernic, Famoco, Flowbird, and Bluebird provided by CNA.
For further information and guides on these demos, please visit the <a href="https://calypsonet.org/keyple-resources/" target="_blank" rel="noopener">CNA website</a>.
<br><br>
Scenario:
<br><br>
<ul>
    <li>
An autonomous validator on Android-based ticketing terminal that seamlessly starts a secure session when a contactless card is detected.
    </li>
</ul>
<ul>
    <li>
The machine checks the last transport event and the available ticketing contracts.
    </li>
</ul>
<ul>
    <li>
If access is granted, a new event is written.
    </li>
</ul>
{{% /modal %}}
        </td>
    </tr>
    <tr>
        <td class="text-center"><a href="https://github.com/calypsonet/keyple-android-demo-control" target="_blank" rel="noopener">Control</a></td>
        <td class="text-center">Android</td>
        <td class="text-center">Java/Kotlin</td>
        <td class="text-center">Open Source</td>
        <td class="text-center">
{{% modal title="Demo Control" %}}
This demo can be installed on various terminals such as Coppernic, Famoco, Flowbird, and Bluebird provided by CNA.
For further information and guides on these demos, please visit the <a href="https://calypsonet.org/keyple-resources/" target="_blank" rel="noopener">CNA website</a>.
<br><br>
Scenario:
<br><br>
<ul>
    <li>
A hand-held inspection terminal on Android portable terminal that allows an operator to check the content of a card.
    </li>
</ul>
<ul>
    <li>
The application verifies the validity of the last transport event regarding the current time and location.
    </li>
</ul>
<ul>
    <li>
Finally, it displays the result.
    </li>
</ul>
{{% /modal %}}
        </td>
    </tr>
    </tbody>
</table>

<br>

## Tools

<table id="external-resource-table-3" class="table table-striped">
    <thead>
    <tr>
        <th scope="col" class="text-center">Name</th>
        <th scope="col" class="text-center">OS</th>
        <th scope="col" class="text-center">Language</th>
        <th scope="col" class="text-center">License</th>
        <th scope="col" class="text-center">Access</th>
        <th scope="col" class="text-center" data-orderable="false">Info</th>
    </tr>
    </thead>
    <tbody id="external-resource-table-3-content">
    <tr>
        <td class="text-center"><a href="https://github.com/calypsonet/calypso-card-analyzer" target="_blank" rel="noopener">Calypso Card Analyzer</a></td>
        <td class="text-center">Windows, Linux, macOS</td>
        <td class="text-center">Java/Kotlin</td>
        <td class="text-center"><a href="https://www.eclipse.org/legal/epl-2.0/" target="_blank" rel="noopener">EPL-2.0</a></td>
        <td class="text-center">Open Source</td>
        <td class="text-center">
{{% modal title="Calypso Card Analyzer" %}}
The Calypso Networks Association provides a first tool to showcase the potential of Keyple 
Java-based ticketing terminals, to help check the configuration and file structure of Calypso cards.
{{% /modal %}}
        </td>
    </tr>
    </tbody>
</table>

<script type="text/javascript">
document.body.onload = function() {
    initExternalResourceTable("external-resource-table-1");
    initExternalResourceTable("external-resource-table-2");
    initExternalResourceTable("external-resource-table-3");
};
</script>