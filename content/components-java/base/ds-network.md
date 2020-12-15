---
title: Keyple DS Network
linktitle: DS Network
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
[GitHub](https://github.com/eclipse/keyple-java/tree/master/java/component/keyple-plugin/remote/network)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{< icon name="exchange-alt" pack="fas" >}}
[Changelogs](https://github.com/eclipse/keyple-java/releases/)
{{% /alert %}}

## Overview

The **Keyple DS Network** Java component is the part of the **Keyple DS (Distributed System)** solution which contains the common network elements used by [Keyple DS Local]({{< relref "ds-local.md" >}}) and [Keyple DS Remote]({{< relref "ds-remote.md" >}}) components.

This library **should not be import explicitly because it's imported by transitivity** by the main libraries.

It is compatible with **PC**, **MAC** and **Android** platforms.

## Documentation

<ul>
    <li><a href="../../../docs/developer-guide/remote-application">Developer guide</a></li>
    <li><a href="../../../docs/api-reference/keyple-plugin-remote-network/{{% keyple-java-version %}}/index.html">JavaDoc API</a></li>
</ul>

## Download

All deliverables are available on the [Maven Central Repository](https://search.maven.org/).

* Using [Gradle](https://gradle.org/)

```gradle
implementation 'org.eclipse.keyple:keyple-plugin-remote-network:{{% keyple-java-version %}}'
```

* Using [Maven](https://maven.apache.org/)

```xml
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-plugin-remote-network</artifactId>
  <version>{{% keyple-java-version %}}</version>
</dependency>
```

* Direct [download](https://search.maven.org/search?q=a:keyple-plugin-remote-network)