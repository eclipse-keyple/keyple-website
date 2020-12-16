---
title: Keyple Distributed Remote
linktitle: Remote
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
[GitHub](https://github.com/eclipse/keyple-java/tree/master/java/component/keyple-plugin/remote/remote)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{< icon name="exchange-alt" pack="fas" >}}
[Changelogs](https://github.com/eclipse/keyple-java/releases/)
{{% /alert %}}

## Overview

The **Keyple Distributed Remote** Java component is the part of the **Keyple Distributed** solution which contains all the **remote** plugins.

It must be imported and used by the application installed on the terminal not having local access to the smart card reader and that wishes to control the reader remotely.

It is important to note that it uses and exposes the APIs exposed by [Keyple Distributed Network]({{< relref "network.md" >}}) component.

It is compatible with **PC**, **MAC** and **Android** platforms.

## Documentation

* [Developer guide]({{< relref "../../../docs/developer-guide/distributed-application.md" >}})
* <a href="../../../docs/api-reference/keyple-plugin-remote-remote/{{% keyple-java-version %}}/index.html">JavaDoc API</a>

## Download

All deliverables are available on the [Maven Central Repository](https://search.maven.org/).

* Using [Gradle](https://gradle.org/)

```gradle
implementation 'org.eclipse.keyple:keyple-plugin-remote-remote:{{% keyple-java-version %}}'
```

* Using [Maven](https://maven.apache.org/)

```xml
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-plugin-remote-remote</artifactId>
  <version>{{% keyple-java-version %}}</version>
</dependency>
```

* Direct [download](https://search.maven.org/search?q=a:keyple-plugin-remote-remote)