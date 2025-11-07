---
title: Keyple Interop iOS XCFramework
linktitle: iOS XCFramework
summary: A native iOS framework providing a LocalReader SPI implementation to allow non-Keyple mobile applications to control their local NFC smart card reader on iOS devices.
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
| {{< icon name="file-alt" pack="fas" >}} **Description**    | The **Keyple Interop iOS XCFramework** is a native iOS adapter that provides an implementation of the `LocalReader` SPI required by the [Keyple Interop JSON API Client Library]({{< relref "keyple-interop-jsonapi-client-kmp-lib.md" >}}), specifically designed for iOS NFC readers.<br><br>It enables non-Keyple applications to interact with the built-in NFC readers of **iOS** devices, making it possible to perform smart card communication in compliance with the Keyple interop model. This framework is optimized for the iOS platform and serves as a bridge between the application logic and the device's native NFC capabilities, facilitating seamless integration without requiring a full Keyple stack. |
| {{< icon name="users" pack="fas" >}} **Intended Audience** | Developers creating non-Keyple client applications for iOS.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| {{< icon name="laptop" pack="fas" >}} **Compatible OS**    | iOS.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |

## Implementations

{{< tabpane showCopyButton="false" >}}

{{< tab header="iOS" >}}

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
    <td>{{< icon name="file-code" pack="fas" >}} <a href="https://docs.keyple.org/keyple-interop-ios-xcframework/">API Reference</a></td>
    <td>Complete documentation of all classes and methods in the iOS API.</td>
  </tr>
  <tr>
    <td>{{< icon name="sitemap" pack="fas" >}} <a href="https://docs.keyple.org/keyple-interop-ios-xcframework/">UML Class Diagram</a></td>
    <td>UML diagram showing the structure and relationships between classes.</td>
  </tr>
  <tr>
    <td>{{< icon name="database" pack="fas" >}} <a href="https://cocoapods.org/pods/KeypleInteropIosXcframework">CocoaPods</a></td>
    <td>Official CocoaPods page to include the iOS framework in your project.</td>
  </tr>
  <tr>
    <td>{{< icon name="cube" pack="fas" >}} <a href="https://github.com/eclipse-keyple/keyple-interop-ios-xcframework">Swift Package Manager</a></td>
    <td>Add the framework to your project using Swift Package Manager.</td>
  </tr>
</tbody>
</table>

{{< /tab >}}

{{< /tabpane >}}

{{% callout note %}}
### iOS XCFramework Note

This component is distributed as a prebuilt XCFramework, which is a unified binary framework format that supports multiple platforms and architectures in a single bundle.

**Supported Architectures:**
- **Real iOS Devices:** ARM64 (iPhone, iPad)
- **iOS Simulator:** ARM64 (Apple Silicon Macs) and x86_64 (Intel-based Macs)

**Integration Methods:**

**CocoaPods:**
```ruby
pod 'KeypleInteropIosXcframework', '~> [version]'
```

**Swift Package Manager:**
Add the following dependency to your `Package.swift`:
```swift
dependencies: [
    .package(url: "https://github.com/eclipse-keyple/keyple-interop-ios-xcframework.git", from: "[version]")
]
```

Or add it directly in Xcode via File → Add Package Dependencies.

**Manual Integration:**
Download the XCFramework from the GitHub releases page and drag it into your Xcode project.

{{% /callout %}}
