---
title: Keyple Plugin OMAPI
linktitle: OMAPI
type: book
weight: 10
toc: true
---

{{% alert note %}}
**`{{% keyple-java-version %}}`**
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{< icon name="users-cog" pack="fas" >}}
Keyple project
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{< icon name="download" pack="fas" >}}
[Download](#download)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{< icon name="github" pack="fab" >}}
[GitHub](https://github.com/eclipse/keyple-java/tree/master/android/keyple-plugin/android-omapi)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{< icon name="exchange-alt" pack="fas" >}}
[Changelogs](https://github.com/eclipse/keyple-java/releases/)
{{% /alert %}}

## Overview

The **Keyple Plugin OMAPI** Java component is a Keyple plugin for **Android** devices using **OMAPI** technology.

It is compatible with **Android 4.4 minimum**.

**OMAPI (Open Mobile Application Programming Interface)** is the mechanism which enables an authorized mobile app to communicate with applets within a **SE** in a device.
This allows the app to benefit from enhanced SE-based security services.

## Documentation

* [Developer guide]({{< relref "../../../docs/developer-guide/standalone-application.md" >}})
* <a href="../../../docs/api-reference/java-api/keyple-android-plugin-omapi/{{% keyple-java-version %}}/index.html">JavaDoc API</a>

## Download

All deliverables are available on the [Maven Central Repository](https://search.maven.org/).

* Using [Gradle](https://gradle.org/)

```gradle
implementation 'org.eclipse.keyple:keyple-android-plugin-omapi:{{% keyple-java-version %}}'
```

* Using [Maven](https://maven.apache.org/)

```xml
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-android-plugin-omapi</artifactId>
  <version>{{% keyple-java-version %}}</version>
</dependency>
```

* Direct [download](https://search.maven.org/search?q=a:keyple-android-plugin-omapi)