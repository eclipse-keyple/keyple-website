---
title: Keyple Distributed Remote Java Library
linktitle: Remote
summary: Part of the Keyple Distributed solution which contains all the remote plugins.
type: book
toc: true
---

{{% alert note %}}
**`{{% keyple-distributed-remote-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse/keyple-distributed-remote-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelogs](https://github.com/eclipse/keyple-distributed-remote-java-lib/releases/)</span>
{{% /alert %}}

## Overview

The **Keyple Distributed Remote Java Library** is the part of the **Keyple Distributed** solution which contains all the **remote** plugins.

Therefore, it should be used only by developers of applications installed on the terminal not having local access to the smart card reader and that wishes to control the reader remotely.

It is compatible with **PC**, **MAC** and **Android** platforms.

## Documentation

* [API documentation](https://eclipse.github.io/keyple-distributed-remote-java-lib)
* [Developer guide]({{< relref "/learn/developer-guide/distributed-application" >}})

## Download

All deliverables are available directly from the [Maven Central Repository](https://search.maven.org/search?q=a:keyple-distributed-remote-java-lib) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-distributed-remote-java-lib:{{% keyple-distributed-remote-java-lib-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-distributed-remote-java-lib:{{% keyple-distributed-remote-java-lib-version %}}"){{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-distributed-remote-java-lib</artifactId>
  <version>{{% keyple-distributed-remote-java-lib-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}