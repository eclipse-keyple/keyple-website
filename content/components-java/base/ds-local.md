---
title: Keyple DS Local
linktitle: DS Local
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
[GitHub](https://github.com/eclipse/keyple-java/tree/master/java/component/keyple-plugin/remote/local)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{< icon name="exchange-alt" pack="fas" >}}
[Changelogs](https://github.com/eclipse/keyple-java/releases/)
{{% /alert %}}

## Overview

The **Keyple DS Local** Java component is the part of the **Keyple DS (Distributed System)** solution which contains all the **local** services.

It must be imported and used by the application installed on the terminal having local access to the smart card reader but wishes to delegate all or part of the ticketing processing to a remote application.

It is important to note that it uses and exposes the APIs exposed by [Keyple DS Network]({{< relref "ds-network.md" >}}) component.

It is compatible with **PC**, **MAC** and **Android** platforms.

## Documentation

<ul>
    <li><a href="../../../docs/developer-guide/remote-application">Developer guide</a></li>
    <li><a href="../../../docs/api-reference/keyple-plugin-remote-local/{{% keyple-java-version %}}/index.html">JavaDoc API</a></li>
</ul>

## Download

All deliverables are available on the [Maven Central Repository](https://search.maven.org/).

* Using [Gradle](https://gradle.org/)

```gradle
implementation 'org.eclipse.keyple:keyple-plugin-remote-local:{{% keyple-java-version %}}'
```

* Using [Maven](https://maven.apache.org/)

```xml
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-plugin-remote-local</artifactId>
  <version>{{% keyple-java-version %}}</version>
</dependency>
```

* Direct [download](https://search.maven.org/search?q=a:keyple-plugin-remote-local)