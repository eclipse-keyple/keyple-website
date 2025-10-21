---
title: Keyple Plugin Card Resource Library
linktitle: Card Resource
summary: Add-on to manage readers provided by the Card Resource Service.
type: book
toc: true
---
<style>
table th:nth-child(1) {
  width: 12rem;
}
</style>

## Overview

|                                                            |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| {{< icon name="file-alt" pack="fas" >}} **Description**    | The **Keyple Plugin Card Resource Library** is a **PoolPlugin** to manage readers provided by the [**Card Resource Service**]({{< relref "/components/core/keyple-service-resource-lib" >}}).<br><br>The main role of the plugin is to allow remote access to the **Card Resource Service** via the **Keyple Distributed Solution** components. It provides an interface for allocating and deallocating readers by profiles that are part of those configured at the **Card Resource Service** level.<br><br>A typical use would be for the realization of a server providing cryptographic services through a pool of SAMs, each inserted in a dedicated PC/SC reader. |
| {{< icon name="users" pack="fas" >}} **Intended Audience** | Developers creating Keyple-based distributed applications with remote HSM/pool of SAMs.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| {{< icon name="laptop" pack="fas" >}} **Compatible OS**    | Windows, Linux, macOS, Android.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |

## Implementations

{{< tabpane showCopyButton="false" >}}

{{< tab header="Java" >}}

<table>
<thead><tr><th></th><th></th></tr></thead>
<tbody>
  <tr>
    <td>{{< icon name="tag" pack="fas" >}} <strong>Latest Version</strong></td>
    <td><strong><code>{{% keyple-plugin-cardresource-java-lib-version %}}</code></strong></td>
  </tr>
  <tr>
    <td>{{< icon name="exchange-alt" pack="fas" >}} <a href="https://github.com/eclipse-keyple/keyple-plugin-cardresource-java-lib/blob/main/CHANGELOG.md">Changelog</a></td>
    <td>List of changes and new features introduced in each release.</td>
  </tr>
  <tr>
    <td>{{< icon name="github" pack="fab" >}} <a href="https://github.com/eclipse-keyple/keyple-plugin-cardresource-java-lib/">GitHub</a></td>
    <td>Source code repository and issue tracker for the Java project.</td>
  </tr>
  <tr>
    <td>{{< icon name="book" pack="fas" >}} <a href="/learn/user-guide/card-resource-service">User Guide</a></td>
    <td>Step-by-step guide to learn how to configure and use the Keyple card resource service.</td>
  </tr>
  <tr>
    <td>{{< icon name="file-code" pack="fas" >}} <a href="https://docs.keyple.org/keyple-plugin-cardresource-java-lib/">API Reference</a></td>
    <td>Complete documentation of all classes and methods in the Java API.</td>
  </tr>
  <tr>
    <td>{{< icon name="sitemap" pack="fas" >}} <a href="https://docs.keyple.org/keyple-plugin-cardresource-java-lib/">UML Class Diagram</a></td>
    <td>UML diagram showing the structure and relationships between classes.</td>
  </tr>
  <tr>
    <td>{{< icon name="database" pack="fas" >}} <a href="https://central.sonatype.com/search?q=keyple-plugin-cardresource-java-lib">Maven Central</a></td>
    <td>Official Maven Central page to include the Java component in your project.</td>
  </tr>
</tbody>
</table>

{{< /tab >}}

{{< /tabpane >}}