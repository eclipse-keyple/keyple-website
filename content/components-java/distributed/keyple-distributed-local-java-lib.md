---
title: Keyple Distributed Local Java Library
linktitle: Local
summary: Part of the Keyple Distributed solution which contains all the local services.
type: book
toc: true
---

{{% callout note %}}
**`{{% keyple-distributed-local-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse/keyple-distributed-local-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse/keyple-distributed-local-java-lib/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

## Overview

The **Keyple Distributed Local Java Library** is the part of the **Keyple Distributed** solution which contains all the **local** services.

Therefore, it should be used only by developers of applications installed on the terminal having local access to the smart card reader but wishes to delegate all or part of the ticketing processing to a remote application.

It is compatible with **Windows**, **Linux**, **macOS** and **Android** platforms.

## Documentation

* [API documentation](https://eclipse.github.io/keyple-distributed-local-java-lib)
* [User guide]({{< relref "/learn/user-guide/distributed-application" >}})

## Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.dev/search?q=keyple-distributed-local-java-lib) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-distributed-local-java-lib:{{% keyple-distributed-local-java-lib-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-distributed-local-java-lib:{{% keyple-distributed-local-java-lib-version %}}"){{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-distributed-local-java-lib</artifactId>
  <version>{{% keyple-distributed-local-java-lib-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}