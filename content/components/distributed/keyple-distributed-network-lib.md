---
title: Keyple Distributed Network Library
linktitle: Network
summary: Part of the Keyple Distributed solution which contains the common network elements used by Local and Remote components.
type: book
toc: true
---

<br>

The **Keyple Distributed Network Library** is the part of the **Keyple Distributed** solution which contains the common
network elements used by **Local** and **Remote** components.

It is therefore intended for developers of distributed applications only.

It is compatible with **Windows**, **Linux**, **macOS** and **Android** platforms.

<br>

## Java component

{{% callout note %}}
**`{{% keyple-distributed-network-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse-keyple/keyple-distributed-network-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse-keyple/keyple-distributed-network-java-lib/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

### Documentation

* [API documentation](https://docs.keyple.org/keyple-distributed-network-java-lib)
* [User guide]({{< relref "/learn/user-guide/distributed-application" >}})

### Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.com/search?q=keyple-distributed-network-java-lib) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Kotlin" >}}
{{< code lang="kotlin" copy="true">}}
implementation("org.eclipse.keyple:keyple-distributed-network-java-lib:{{% keyple-distributed-network-java-lib-version %}}")
{{< /code>}}
{{< /tab >}}
{{< tab header="Gradle Groovy" >}}
{{< code lang="gradle" copy="true">}}
implementation 'org.eclipse.keyple:keyple-distributed-network-java-lib:{{% keyple-distributed-network-java-lib-version %}}'
{{< /code>}}
{{< /tab >}}
{{< tab header="Maven" >}}
{{< code lang="xml" copy="true">}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-distributed-network-java-lib</artifactId>
  <version>{{% keyple-distributed-network-java-lib-version %}}</version>
</dependency>
{{< /code>}}
{{< /tab >}}
{{< /tabpane >}}