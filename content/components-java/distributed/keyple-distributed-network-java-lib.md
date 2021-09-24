---
title: Keyple Distributed Network Java Library
linktitle: Network
summary: Part of the Keyple Distributed solution which contains the common network elements used by Local and Remote components.
type: book
toc: true
---

{{% alert note %}}
**`{{% keyple-distributed-network-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse/keyple-distributed-network-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelogs](https://github.com/eclipse/keyple-distributed-network-java-lib/releases/)</span>
{{% /alert %}}

## Overview

The **Keyple Distributed Network Java Library** is the part of the **Keyple Distributed** solution which contains the common network elements used by **Local** and **Remote** components.

Therefore, it should be used only by developers of distributed applications.

It is compatible with **PC**, **MAC** and **Android** platforms.

## Documentation

* [API documentation](https://eclipse.github.io/keyple-distributed-network-java-lib)
* [Developer guide]({{< relref "/learn/developer-guide/distributed-application" >}})

## Download

All deliverables are available directly from the [Maven Central Repository](https://search.maven.org/search?q=a:keyple-distributed-network-java-lib) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-distributed-network-java-lib:{{% keyple-distributed-network-java-lib-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-distributed-network-java-lib:{{% keyple-distributed-network-java-lib-version %}}"){{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-distributed-network-java-lib</artifactId>
  <version>{{% keyple-distributed-network-java-lib-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}