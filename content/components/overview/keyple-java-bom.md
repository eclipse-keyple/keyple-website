---
title: Keyple Bill of Materials (BOM)
linktitle: Bill of Materials (BOM)
summary: A Bill of Materials (BOM) for applications to manage the versions of all Keyple artifacts.
type: book
weight: 15
toc: true
---
<style>
table th:nth-child(1) {
  width: 12rem;
}
</style>

## Overview

|                                                                |                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|----------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| {{< icon name="file-alt" pack="fas" >}} **Description**        | The **Keyple BOM** provides a centralized way to manage the versions of all Keyple artifacts for applications. It ensures that projects using multiple Keyple libraries stay consistent and compatible without requiring explicit version declarations for each dependency.<br><br>**Important Note:** The BOM also includes the versions of the [Keypop](https://keypop.org/) dependencies required by Keyple, so you don’t need to manage them separately. |
| {{< icon name="users" pack="fas" >}} **Intended Audience**     | Developers creating Keyple-based applications.                                                                                                                                                                                                                                                                                                                                                                                                               |
| {{< icon name="laptop" pack="fas" >}} **Compatible OS**        | Windows, Linux, macOS, Android.                                                                                                                                                                                                                                                                                                                                                                                                                              |
| {{< icon name="code-branch" pack="fas" >}} **Versioning Note** | This project follows a **date-based** versioning scheme:<ul><li>**Format**: `YYYY.MM.DD` (year, month, day).</li><li>**Release cadence**: A new version is released whenever one or more Keyple artifacts are updated.</li><li>**Interpretation**: The version number indicates the release date, not the compatibility level. Users should check the release notes to see which artifacts were updated.</li></ul>                                           |

## Implementations

{{< tabpane showCopyButton="false" >}}

{{< tab header="Java" >}}

<table>
<thead><tr><th></th><th></th></tr></thead>
<tbody>
  <tr>
    <td>{{< icon name="tag" pack="fas" >}} <strong>Latest Version</strong></td>
    <td><strong><code>{{% keyple-java-bom-version %}}</code></strong></td>
  </tr>
  <tr>
    <td>{{< icon name="exchange-alt" pack="fas" >}} <a href="https://github.com/eclipse-keyple/keyple-java-bom/blob/main/CHANGELOG.md">Changelog</a></td>
    <td>Provides a detailed mapping of Keyple component versions included in each BOM release.</td>
  </tr>
  <tr>
    <td>{{< icon name="github" pack="fab" >}} <a href="https://github.com/eclipse-keyple/keyple-java-bom/">GitHub</a></td>
    <td>Source code repository containing useful information for importing the Java BOM in your project.</td>
  </tr>
</tbody>
</table>

{{< /tab >}}

{{< /tabpane >}}