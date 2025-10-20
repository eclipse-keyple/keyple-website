---
title: Keyple Card Calypso Library
linktitle: Calypso Card
summary: Add-on to manage Calypso® cards.
type: book
toc: true
---
<style>
table th:nth-child(1) {
  width: 13rem;
}
</style>

## Overview

|                                                            |                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| {{< icon name="file-alt" pack="fas" >}} **Description**    | The **Keyple Card Calypso Library** is a card extension add-on to manage Calypso® cards.                                                                                                                                                                                                                                                                                                                                                                         |
| {{< icon name="users" pack="fas" >}} **Intended Audience** | Developers creating Keyple-based Calypso applications.                                                                                                                                                                                                                                                                                                                                                                                                           |
| {{< icon name="laptop" pack="fas" >}} **Compatible OS**    | Windows, Linux, macOS, Android.                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| {{< icon name="lock" pack="fas" >}} **Security Note**      | For card transactions that need to be secured by cryptographic calculations using symmetrical keys (SAM or HSM) or asymmetrical keys (PKI), **it is mandatory to use one of the dedicated crypto libraries** (Open SAM, Legacy SAM, PKI). At present, only the [Calypso Crypto Legacy SAM]({{< relref "keyple-card-calypso-crypto-legacysam-lib" >}}) and the [Calypso Crypto PKI]({{< relref "keyple-card-calypso-crypto-pki-lib" >}}) libraries are available. |

## Implementations

{{< tabpane showCopyButton="false" >}}

{{< tab header="Java" >}}

<table>
<thead><tr><th></th><th></th></tr></thead>
<tbody>
  <tr>
    <td>{{< icon name="tag" pack="fas" >}} <strong>Latest Version</strong></td>
    <td><strong><code>{{% keyple-card-calypso-java-lib-version %}}</code></strong></td>
  </tr>
  <tr>
    <td>{{< icon name="exchange-alt" pack="fas" >}} {{< external-link url="https://github.com/eclipse-keyple/keyple-card-calypso-java-lib/blob/main/CHANGELOG.md" name="Changelog" >}}</td>
    <td>List of changes and new features introduced in each release.</td>
  </tr>
  <tr>
    <td>{{< icon name="github" pack="fab" >}} {{< external-link url="https://github.com/eclipse-keyple/keyple-card-calypso-java-lib/" name="GitHub" >}}</td>
    <td>Source code repository and issue tracker for the Java project.</td>
  </tr>
  <tr>
    <td>{{< icon name="book" pack="fas" >}} {{< internal-link url="/learn/user-guide/calypso-application" name="User Guide" >}}</td>
    <td>Step-by-step guide to learn how to build a Keyple-based Calypso application.</td>
  </tr>
  <tr>
    <td>{{< icon name="file-code" pack="fas" >}} {{< external-link url="https://docs.keyple.org/keyple-card-calypso-java-lib/" name="API Reference" >}}</td>
    <td>Complete documentation of all classes and methods in the Java API.</td>
  </tr>
  <tr>
    <td>{{< icon name="sitemap" pack="fas" >}} {{< external-link url="https://docs.keyple.org/keyple-card-calypso-java-lib/" name="UML Class Diagram" >}}</td>
    <td>UML diagram showing the structure and relationships between classes.</td>
  </tr>
  <tr>
    <td>{{< icon name="database" pack="fas" >}} {{< external-link url="https://central.sonatype.com/search?q=keyple-card-calypso-java-lib" name="Maven Central" >}}</td>
    <td>Official Maven Central page to include the Java component in your project.</td>
  </tr>
</tbody>
</table>

{{< /tab >}}

{{< tab header="C++" >}}

<table>
<thead><tr><th></th><th></th></tr></thead>
<tbody>
  <tr>
    <td>{{< icon name="tag" pack="fas" >}} <strong>Latest Version</strong></td>
    <td><strong><code>{{% keyple-card-calypso-cpp-lib-version %}}</code></strong></td>
  </tr>
  <tr>
    <td>{{< icon name="exchange-alt" pack="fas" >}} {{< external-link url="https://github.com/eclipse-keyple/keyple-card-calypso-cpp-lib/releases/" name="Release History" >}}</td>
    <td>List of published releases and related release notes.</td>
  </tr>
  <tr>
    <td>{{< icon name="github" pack="fab" >}} {{< external-link url="https://github.com/eclipse-keyple/keyple-card-calypso-cpp-lib/" name="GitHub" >}}</td>
    <td>Source code repository and documentation for the C++ project.</td>
  </tr>
  <tr>
    <td>{{< icon name="book" pack="fas" >}} {{< internal-link url="/learn/user-guide/calypso-application" name="User Guide" >}}</td>
    <td>Step-by-step guide to learn how to build a Keyple-based Calypso application.</td>
  </tr>
  <tr>
    <td>{{< icon name="file-code" pack="fas" >}} {{< external-link url="https://docs.keyple.org/keyple-card-calypso-cpp-lib/" name="API Reference" >}}</td>
    <td>Complete documentation of all classes and functions in the C++ API.</td>
  </tr>
  <tr>
    <td>{{< icon name="sitemap" pack="fas" >}} {{< external-link url="https://docs.keyple.org/keyple-card-calypso-uml-lib/" name="UML Class Diagram" >}}</td>
    <td>UML class diagram of the Java implementation, from which the C++ code is derived.</td>
  </tr>
</tbody>
</table>

{{< content-include file="note-about-cpp" >}}

{{< /tab >}}

{{< /tabpane >}}