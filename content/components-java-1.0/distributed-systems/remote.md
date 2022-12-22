---
title: Keyple Distributed Remote
linktitle: Remote
summary: Part of the Keyple Distributed solution which contains all the remote plugins.
type: book
weight: 10
toc: true
---
{{% callout warning %}}
Version 1.0 of the documentation is no longer actively maintained. The site that you are currently viewing is an archived snapshot. For up-to-date documentation, see the latest version.
{{% /callout %}}

{{% callout note %}}
**`{{% keyple-java-version %}}`**
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{< icon name="users-cog" pack="fas" >}}
Keyple project
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{< icon name="download" pack="fas" >}}
[Download](#download)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{< icon name="github" pack="fab" >}}
[GitHub](https://github.com/eclipse/keyple-java/tree/master/java/component/keyple-distributed/remote)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{< icon name="exchange-alt" pack="fas" >}}
[Changelogs](https://github.com/eclipse/keyple-java/releases/)
{{% /callout %}}

## Overview

The **Keyple Distributed Remote** Java component is the part of the **Keyple Distributed** solution which contains all the **remote** plugins.

It must be imported and used by the application installed on the terminal not having local access to the smart card reader and that wishes to control the reader remotely.

It is important to note that it uses and exposes the APIs exposed by [Keyple Distributed Network]({{< relref "network.md" >}}) component.

It is compatible with **PC**, **MAC** and **Android** platforms.

## Documentation

* [Developer guide]({{< ref "docs-1.0/developer-guide/distributed-application.md" >}})
* <a href="../../../docs-1.0/api-reference/java-api/keyple-java-distributed-remote/{{% keyple-java-version %}}/index.html">JavaDoc API</a>

## Download

All deliverables are available on the [Maven Central Repository](https://search.maven.org/).

* Using [Gradle](https://gradle.org/)

```gradle
implementation 'org.eclipse.keyple:keyple-java-distributed-remote:{{% keyple-java-version %}}'
```

* Using [Maven](https://maven.apache.org/)

```xml
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-java-distributed-remote</artifactId>
  <version>{{% keyple-java-version %}}</version>
</dependency>
```

* Direct [download](https://central.sonatype.dev/search?q=keyple-java-distributed-remote)