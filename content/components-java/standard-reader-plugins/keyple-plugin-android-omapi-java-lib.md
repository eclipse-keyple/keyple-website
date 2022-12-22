---
title: Keyple Plugin Android OMAPI Java Library
linktitle: Android OMAPI
summary: Add-on to manage Android OMAPI readers.
type: book
toc: true
---

{{% callout note %}}
**`{{% keyple-plugin-android-omapi-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse/keyple-plugin-android-omapi-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse/keyple-plugin-android-omapi-java-lib/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

## Overview

The **Keyple Plugin Android OMAPI Java Library** is an add-on to manage **Android OMAPI** readers.

Therefore, it should be used only by application developers.

It is compatible with **Android 4.4 minimum**.

**OMAPI (Open Mobile Application Programming Interface)** is the mechanism which enables an authorized mobile app to communicate with applets within a **SE** in a device.
This allows the app to benefit from enhanced SE-based security services.

## Documentation

* [API documentation](https://eclipse.github.io/keyple-plugin-android-omapi-java-lib)

## Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.dev/search?q=keyple-plugin-android-omapi-java-lib) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-plugin-android-omapi-java-lib:{{% keyple-plugin-android-omapi-java-lib-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-plugin-android-omapi-java-lib:{{% keyple-plugin-android-omapi-java-lib-version %}}"){{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-plugin-android-omapi-java-lib</artifactId>
  <version>{{% keyple-plugin-android-omapi-java-lib-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}