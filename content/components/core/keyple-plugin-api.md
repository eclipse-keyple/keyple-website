---
title: Keyple Plugin API
linktitle: Plugin API
summary: Internal API dedicated to the development of custom reader plugins components.
type: book
toc: true
---
<style>
table th:nth-child(1) {
  width: 13rem;
}
</style>

## Overview

|                                                                |                                                                                                                      |
|----------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| {{< icon name="file-alt" pack="fas" >}} **Description**        | The **Keyple Plugin API** defines the **internal interfaces** dedicated to the development of reader plugin add-ons. |
| {{< icon name="users" pack="fas" >}} **Intended Audience**     | Developers creating custom Keyple reader plugin add-ons.                                                             |
| {{< icon name="laptop" pack="fas" >}} **Compatible OS**        | Windows, Linux, macOS, Android.                                                                                      |
| {{< icon name="code-branch" pack="fas" >}} **Versioning Note** | {{< content-include file="api-versioning-note" >}}                                                                   |

## Implementations

{{< tabpane showCopyButton="false" >}}

{{< tab header="Java" >}}

<table>
<thead><tr><th></th><th></th></tr></thead>
<tbody>
  <tr>
    <td>{{< icon name="tag" pack="fas" >}} <strong>Latest Version</strong></td>
    <td><strong><code>{{% keyple-plugin-java-api-version %}}</code></strong></td>
  </tr>
  <tr>
    <td>{{< icon name="exchange-alt" pack="fas" >}} {{< external-link url="https://github.com/eclipse-keyple/keyple-plugin-java-api/blob/main/CHANGELOG.md" name="Changelog" >}}</td>
    <td>List of changes and new features introduced in each release.</td>
  </tr>
  <tr>
    <td>{{< icon name="github" pack="fab" >}} {{< external-link url="https://github.com/eclipse-keyple/keyple-plugin-java-api/" name="GitHub" >}}</td>
    <td>Source code repository and issue tracker for the Java project.</td>
  </tr>
  <tr>
    <td>{{< icon name="book" pack="fas" >}} {{< internal-link url="/learn/developer-guide/reader-plugin-add-on" name="User Guide" >}}</td>
    <td>Step-by-step guide to learn how to create a Keyple reader plugin add-on.</td>
  </tr>
  <tr>
    <td>{{< icon name="file-code" pack="fas" >}} {{< external-link url="https://docs.keyple.org/keyple-plugin-java-api/" name="API Reference" >}}</td>
    <td>Complete documentation of all classes and methods in the Java API.</td>
  </tr>
  <tr>
    <td>{{< icon name="sitemap" pack="fas" >}} {{< external-link url="https://docs.keyple.org/keyple-plugin-java-api/" name="UML Class Diagram" >}}</td>
    <td>UML diagram showing the structure and relationships between classes.</td>
  </tr>
  <tr>
    <td>{{< icon name="database" pack="fas" >}} {{< external-link url="https://central.sonatype.com/search?q=keyple-plugin-java-api" name="Maven Central" >}}</td>
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
    <td><strong><code>{{% keyple-plugin-cpp-api-version %}}</code></strong></td>
  </tr>
  <tr>
    <td>{{< icon name="exchange-alt" pack="fas" >}} {{< external-link url="https://github.com/eclipse-keyple/keyple-plugin-cpp-api/releases/" name="Release History" >}} <strong><sup>1</sup></strong></td>
    <td>List of published releases and related release notes.</td>
  </tr>
  <tr>
    <td>{{< icon name="github" pack="fab" >}} {{< external-link url="https://github.com/eclipse-keyple/keyple-plugin-cpp-api/" name="GitHub" >}}</td>
    <td>Source code repository and documentation for the C++ project.</td>
  </tr>
  <tr>
    <td>{{< icon name="book" pack="fas" >}} {{< internal-link url="/learn/developer-guide/reader-plugin-add-on" name="User Guide" >}} <strong><sup>1</sup></strong></td>
    <td>Step-by-step guide to learn how to create a Keyple reader plugin add-on.</td>
  </tr>
  <tr>
    <td>{{< icon name="file-code" pack="fas" >}} {{< external-link url="https://docs.keyple.org/keyple-plugin-cpp-api/" name="API Reference" >}}</td>
    <td>Complete documentation of all classes and functions in the C++ API.</td>
  </tr>
  <tr>
    <td>{{< icon name="sitemap" pack="fas" >}} {{< external-link url="https://docs.keyple.org/keyple-plugin-uml-api/" name="UML Class Diagram" >}} <strong><sup>1</sup></strong></td>
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