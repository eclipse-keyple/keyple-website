---
title: Keyple Core
linktitle: Core
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
[GitHub](https://github.com/eclipse/keyple-java/tree/master/java/component/keyple-core)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{{< icon name="exchange-alt" pack="fas" >}}
[Changelogs](https://github.com/eclipse/keyple-java/releases/)
{{% /callout %}}

## Overview

The **Keyple Core** Java component contains all the fundamental requires components of the Keyple solution.

It is compatible with **PC**, **MAC** and **Android** platforms.

## Documentation

* [Developer guide]({{< ref "docs-1.0/developer-guide/standalone-application.md" >}})
* <a href="../../../docs-1.0/api-reference/java-api/keyple-java-core/{{% keyple-java-version %}}/index.html">JavaDoc API</a>

## Download

All deliverables are available on the [Maven Central Repository](https://search.maven.org/).

* Using [Gradle](https://gradle.org/)

```gradle
implementation 'org.eclipse.keyple:keyple-java-core:{{% keyple-java-version %}}'
```

* Using [Maven](https://maven.apache.org/)

```xml
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-java-core</artifactId>
  <version>{{% keyple-java-version %}}</version>
</dependency>
```

* Direct [download](https://central.sonatype.dev/search?q=keyple-java-core)