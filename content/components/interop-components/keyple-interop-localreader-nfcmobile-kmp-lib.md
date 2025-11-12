---
title: Keyple Interop Local Reader NFC Mobile Library
linktitle: Local Reader NFC Mobile
summary: A multiplatform adapter providing a LocalReader SPI implementation to allow non-Keyple mobile applications to control their local NFC smart card reader.
type: book
toc: true
---
<style>
table th:nth-child(1) {
  width: 12rem;
}
</style>

## Overview

|                                                            |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| {{< icon name="file-alt" pack="fas" >}} **Description**    | The **Keyple Interop Local Reader NFC Mobile Library** is a Kotlin Multiplatform adapter that provides an implementation of the `LocalReader` SPI required by the [Keyple Interop JSON API Client Library]({{< relref "keyple-interop-jsonapi-client-kmp-lib.md" >}}), specifically designed for mobile NFC readers.<br><br>It enables non-Keyple applications to interact with the built-in NFC readers of **Android** and **iOS** devices, making it possible to perform smart card communication in compliance with the Keyple interop model. This library is optimized for mobile platforms and serves as a bridge between the application logic and the device's native NFC capabilities, facilitating seamless integration without requiring a full Keyple stack. |
| {{< icon name="users" pack="fas" >}} **Intended Audience** | Developers creating non-Keyple client applications.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {{< icon name="laptop" pack="fas" >}} **Compatible OS**    | Android, iOS.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |

## Implementations

{{< tabpane showCopyButton="false" >}}

{{< tab header="Kotlin Multiplatform" >}}

<table>
<thead><tr><th></th><th></th></tr></thead>
<tbody>
  <tr>
    <td>{{< icon name="tag" pack="fas" >}} <strong>Latest Version</strong></td>
    <td><strong><code>{{% keyple-interop-localreader-nfcmobile-kmp-lib-version %}}</code></strong></td>
  </tr>
  <tr>
    <td>{{< icon name="exchange-alt" pack="fas" >}} <a href="https://github.com/eclipse-keyple/keyple-interop-localreader-nfcmobile-kmp-lib/blob/main/CHANGELOG.md">Changelog</a></td>
    <td>List of changes and new features introduced in each release.</td>
  </tr>
  <tr>
    <td>{{< icon name="github" pack="fab" >}} <a href="https://github.com/eclipse-keyple/keyple-interop-localreader-nfcmobile-kmp-lib/">GitHub</a></td>
    <td>Source code repository and issue tracker for the Java project.</td>
  </tr>
  <tr>
    <td>{{< icon name="book" pack="fas" >}} <a href="/user-guides/non-keyple-client/content">User Guide</a></td>
    <td>Step-by-step guide to learn how to build a non-Keyple client.</td>
  </tr>
  <tr>
    <td>{{< icon name="file-code" pack="fas" >}} <a href="https://docs.keyple.org/keyple-interop-localreader-nfcmobile-kmp-lib/">API Reference</a></td>
    <td>Complete documentation of all classes and methods in the Java API.</td>
  </tr>
  <tr>
    <td>{{< icon name="sitemap" pack="fas" >}} <a href="https://docs.keyple.org/keyple-interop-localreader-nfcmobile-kmp-lib/">UML Class Diagram</a></td>
    <td>UML diagram showing the structure and relationships between classes.</td>
  </tr>
  <tr>
    <td>{{< icon name="database" pack="fas" >}} <a href="https://central.sonatype.com/search?q=keyple-interop-localreader-nfcmobile-kmp-lib">Maven Central</a></td>
    <td>Official Maven Central page to include the Java component in your project.</td>
  </tr>
</tbody>
</table>

{{< /tab >}}

{{< /tabpane >}}

{{% callout note %}}
### Kotlin Multiplatform Note

Here is a summary table describing the purpose and usage of each target module generated by this Kotlin Multiplatform
library, including the root (no-suffix) module and platform-specific variants:

<div id="download-table-1">

| Artifact ID                                                                          |   Format    | Purpose                                     | Main Use Case                                             |
|--------------------------------------------------------------------------------------|:-----------:|---------------------------------------------|-----------------------------------------------------------|
| `keyple-interop-localreader-nfcmobile-kmp-lib`                                       |   `.jar`    | Common code shared across all platforms     | Used by multiplatform consumers to pull platform variants |
| `keyple-interop-localreader-nfcmobile-kmp-lib-jvm`                                   |   `.jar`    | Non-Android JVM applications                | Used in backend apps, desktop apps, or CLI                |
| `keyple-interop-localreader-nfcmobile-kmp-lib-android`                               |   `.aar`    | Production Android apps                     | Integrated into final APK/AAB builds                      |
| `keyple-interop-localreader-nfcmobile-kmp-lib-iosarm64`                              |   `.klib`   | Real iOS devices (ARM64 architecture)       | Required for running the app on physical iPhones          |
| `keyple-interop-localreader-nfcmobile-kmp-lib-iossimulatorarm64`                     |   `.klib`   | iOS Simulator on Apple Silicon Macs (ARM64) | Used for development/testing on simulators on M1/M2 Macs  |
| `keyple-interop-localreader-nfcmobile-kmp-lib-iosx64`                                |   `.klib`   | iOS Simulator on Intel-based Macs (x86_64)  | Used for development/testing on simulators on Intel Macs  |
| [Keyple Interop iOS XCFramework]({{< relref "keyple-interop-ios-xcframework.md" >}}) | XCFramework | iOS applications                            | Integrated directly into final iOS apps                   |

</div>
<style>
#download-table-1 table th:nth-child(1) {
    width: 19rem;
}
</style>

- The root module serves as the entry point for consumers. When you add `implementation("[root-lib]")`, Gradle
  automatically selects the correct variant (jvm, android, etc.) based on the target platform.
- The platform-specific modules (android, jvm, etc.) contain compiled code that can be executed or packaged directly.
{{% /callout %}}