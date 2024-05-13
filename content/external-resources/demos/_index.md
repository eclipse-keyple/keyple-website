---
title: External demos
---

{{% callout note %}}
To reference your demo please [create an issue](https://github.com/eclipse-keyple/keyple-website/issues) on
GitHub **and/or** directly contribute to this website using the
[contribution guide]({{< relref "community/contributing/" >}}).
{{% /callout %}}

<table id="external-resource-table" class="table table-striped">
    <thead>
    <tr>
        <th scope="col" class="text-center">Name</th>
        <th scope="col" class="text-center">OS</th>
        <th scope="col" class="text-center">Language</th>
        <th scope="col" class="text-center">Access</th>
        <th scope="col" class="text-center">Supplier</th>
        <th scope="col" class="text-center" data-orderable="false">Info</th>
    </tr>
    </thead>
    <tbody id="external-resource-table-content">
    <tr>
        <td class="text-center"><a href="https://github.com/calypsonet/keyple-java-demo-remote" target="_blank" rel="noopener">Reload Remote</a></td>
        <td class="text-center">Windows, Linux, macOS, Android</td>
        <td class="text-center">Java/Kotlin, C#</td>
        <td class="text-center">Open Source</td>
        <td class="text-center"><a href="https://calypsonet.org" target="_blank" rel="noopener">CNA</a></td>
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
        <td class="text-center"><a href="https://calypsonet.org" target="_blank" rel="noopener">CNA</a></td>
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
        <td class="text-center"><a href="https://calypsonet.org" target="_blank" rel="noopener">CNA</a></td>
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
<script type="text/javascript">
document.body.onload = function() {
    initExternalResourceTable();
};
</script>