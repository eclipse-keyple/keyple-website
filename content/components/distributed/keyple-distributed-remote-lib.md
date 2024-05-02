---
title: Keyple Distributed Remote Library
linktitle: Remote
summary: Part of the Keyple Distributed solution which contains all the remote plugins.
type: book
toc: true
---

<br>

The **Keyple Distributed Remote Library** is the part of the **Keyple Distributed** solution which contains all the **remote** plugins.

Therefore, it should be used only by developers of applications installed on the terminal not having local access to the smart card reader and that wishes to control the reader remotely.

It is compatible with **Windows**, **Linux**, **macOS** and **Android** platforms.

<br>

## Java component

{{% callout note %}}
**`{{% keyple-distributed-remote-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse-keyple/keyple-distributed-remote-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse-keyple/keyple-distributed-remote-java-lib/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

### Documentation

* [API documentation](https://eclipse-keyple.github.io/keyple-distributed-remote-java-lib)
* [User guide]({{< relref "/learn/user-guide/distributed-application" >}})

### Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.com/search?q=keyple-distributed-remote-java-lib) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Kotlin" >}}
{{< code lang="kotlin" copy="true">}}
implementation("org.eclipse.keyple:keyple-distributed-remote-java-lib:{{% keyple-distributed-remote-java-lib-version %}}")
{{< /code>}}
{{< /tab >}}
{{< tab header="Gradle Groovy" >}}
{{< code lang="gradle" copy="true">}}
implementation 'org.eclipse.keyple:keyple-distributed-remote-java-lib:{{% keyple-distributed-remote-java-lib-version %}}'
{{< /code>}}
{{< /tab >}}
{{< tab header="Maven" >}}
{{< code lang="xml" copy="true">}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-distributed-remote-java-lib</artifactId>
  <version>{{% keyple-distributed-remote-java-lib-version %}}</version>
</dependency>
{{< /code>}}
{{< /tab >}}
{{< /tabpane >}}