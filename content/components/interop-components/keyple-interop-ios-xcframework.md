---
title: Keyple Interop iOS XCFramework
linktitle: iOS XCFramework
summary: A native iOS XCFramework acting as a unified umbrella project, bundling a multiplatform Keyple Server JSON client library for HTTP interaction with a Keyple-based server, and a multiplatform LocalReader adapter enabling control of the local NFC smart card reader on mobile.
type: book
toc: true
---
<style>
table th:nth-child(1) {
  width: 13rem;
}
</style>

## Overview

|                                                            |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| {{< icon name="file-alt" pack="fas" >}} **Description**    | The **Keyple Interop iOS XCFramework** is a native iOS XCFramework acting as a unified umbrella project, bundling the [Keyple Interop JSON API Client Library]({{< relref "keyple-interop-jsonapi-client-kmp-lib.md" >}}) and the [Keyple Interop Local Reader NFC Mobile Library]({{< relref "keyple-interop-localreader-nfcmobile-kmp-lib.md" >}}).<br><br>It enables non-Keyple applications to interact with a Keyple-based server and the built-in NFC readers of **iOS** devices |
| {{< icon name="users" pack="fas" >}} **Intended Audience** | Developers creating non-Keyple client applications for iOS.                                                                                                                                                                                                                                                                                                                                                                                                                            |
| {{< icon name="laptop" pack="fas" >}} **Compatible OS**    | iOS.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |

## Implementations

{{< tabpane showCopyButton="false" >}}

{{< tab header="iOS XCFramework" >}}

<table>
<thead><tr><th></th><th></th></tr></thead>
<tbody>
  <tr>
    <td>{{< icon name="tag" pack="fas" >}} <strong>Latest Version</strong></td>
    <td><strong><code>{{% keyple-interop-ios-xcframework-version %}}</code></strong></td>
  </tr>
  <tr>
    <td>{{< icon name="exchange-alt" pack="fas" >}} <a href="https://github.com/eclipse-keyple/keyple-interop-ios-xcframework/blob/main/CHANGELOG.md">Changelog</a></td>
    <td>List of changes and new features introduced in each release.</td>
  </tr>
  <tr>
    <td>{{< icon name="github" pack="fab" >}} <a href="https://github.com/eclipse-keyple/keyple-interop-ios-xcframework/">GitHub</a></td>
    <td>Source code repository and issue tracker for the iOS project.</td>
  </tr>
  <tr>
    <td>{{< icon name="book" pack="fas" >}} <a href="/user-guides/non-keyple-client/content">User Guide</a></td>
    <td>Step-by-step guide to learn how to build a non-Keyple client.</td>
  </tr>
  <tr>
    <td>{{< icon name="database" pack="fas" >}} <a href="https://github.com/eclipse-keyple/keyple-interop-ios-xcframework">Swift Package Manager</a></td>
    <td>Add the framework to your project using Swift Package Manager.</td>
  </tr>
</tbody>
</table>

{{< /tab >}}

{{< /tabpane >}}
