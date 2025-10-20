---
title: Keyple Service Library
linktitle: Service
summary: Main library containing the implementation of the core Keyple components and services.
type: book
toc: true
---
<style>
table th:nth-child(1) {
  width: 13rem;
}
</style>

## Overview

|                                                            |                                                                                                                                                                                                          |
|------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| {{< icon name="file-alt" pack="fas" >}} **Description**    | The **Keyple Service Library** contains the implementation of the core Keyple components and services, such as the smart card service, the card selection manager and the card and reader event manager. |
| {{< icon name="users" pack="fas" >}} **Intended Audience** | Developers creating Keyple-based applications.                                                                                                                                                           |
| {{< icon name="laptop" pack="fas" >}} **Compatible OS**    | Windows, Linux, macOS, Android.                                                                                                                                                                          |

## Implementations

{{< tabpane showCopyButton="false" >}}

{{< tab header="Java" >}}

<table>
<thead><tr><th></th><th></th></tr></thead>
<tbody>
  <tr>
    <td>{{< icon name="tag" pack="fas" >}} <strong>Latest Version</strong></td>
    <td><strong><code>{{% keyple-service-java-lib-version %}}</code></strong></td>
  </tr>
  <tr>
    <td>{{< icon name="exchange-alt" pack="fas" >}} {{< external-link url="https://github.com/eclipse-keyple/keyple-service-java-lib/blob/main/CHANGELOG.md" name="Changelog" >}}</td>
    <td>List of changes and new features introduced in each release.</td>
  </tr>
  <tr>
    <td>{{< icon name="github" pack="fab" >}} {{< external-link url="https://github.com/eclipse-keyple/keyple-service-java-lib/" name="GitHub" >}}</td>
    <td>Source code repository and issue tracker for the Java project.</td>
  </tr>
  <tr>
    <td>{{< icon name="book" pack="fas" >}} {{< internal-link url="/learn/user-guide/standalone-application" name="User Guide" >}}</td>
    <td>Step-by-step guide to learn how to build a Keyple-based standalone application.</td>
  </tr>
  <tr>
    <td>{{< icon name="file-code" pack="fas" >}} {{< external-link url="https://docs.keyple.org/keyple-service-java-lib/" name="API Reference" >}}</td>
    <td>Complete documentation of all classes and methods in the Java API.</td>
  </tr>
  <tr>
    <td>{{< icon name="sitemap" pack="fas" >}} {{< external-link url="https://docs.keyple.org/keyple-service-java-lib/" name="UML Class Diagram" >}}</td>
    <td>UML diagram showing the structure and relationships between classes.</td>
  </tr>
  <tr>
    <td>{{< icon name="database" pack="fas" >}} {{< external-link url="https://central.sonatype.com/search?q=keyple-service-java-lib" name="Maven Central" >}}</td>
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
    <td>{{< icon name="tag" pack="fas" >}} <strong>Latest Version</strong> <strong><sup>1</sup></strong></td>
    <td><strong><code>{{% keyple-service-cpp-lib-version %}}</code></strong></td>
  </tr>
  <tr>
    <td>{{< icon name="exchange-alt" pack="fas" >}} {{< external-link url="https://github.com/eclipse-keyple/keyple-service-cpp-lib/releases/" name="Release History" >}} <strong><sup>1</sup></strong></td>
    <td>List of published releases and related release notes.</td>
  </tr>
  <tr>
    <td>{{< icon name="github" pack="fab" >}} {{< external-link url="https://github.com/eclipse-keyple/keyple-service-cpp-lib/" name="GitHub" >}}</td>
    <td>Source code repository and documentation for the C++ project.</td>
  </tr>
  <tr>
    <td>{{< icon name="book" pack="fas" >}} {{< internal-link url="/learn/user-guide/standalone-application" name="User Guide" >}} <strong><sup>1</sup></strong></td>
    <td>Step-by-step guide to learn how to build a Keyple-based standalone application.</td>
  </tr>
  <tr>
    <td>{{< icon name="file-code" pack="fas" >}} {{< external-link url="https://docs.keyple.org/keyple-service-cpp-lib/" name="API Reference" >}}</td>
    <td>Complete documentation of all classes and functions in the C++ API.</td>
  </tr>
  <tr>
    <td>{{< icon name="sitemap" pack="fas" >}} {{< external-link url="https://docs.keyple.org/keyple-service-uml-lib/" name="UML Class Diagram" >}} <strong><sup>1</sup></strong></td>
    <td>UML class diagram of the Java implementation, from which the C++ code is derived.</td>
  </tr>
</tbody>
</table>

<blockquote>
    <p>1. See the note below for key C++ specifics.</p>
</blockquote>

{{< content-include file="note-about-cpp" >}}

{{< /tab >}}

{{< /tabpane >}}