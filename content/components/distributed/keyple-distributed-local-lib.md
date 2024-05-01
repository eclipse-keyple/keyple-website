---
title: Keyple Distributed Local Library
linktitle: Local
summary: Part of the Keyple Distributed solution which contains all the local services.
type: book
toc: true
---

<br>

The **Keyple Distributed Local Library** is the part of the **Keyple Distributed** solution which contains all the **local** services.

Therefore, it should be used only by developers of applications installed on the terminal having local access to the smart card reader but wishes to delegate all or part of the ticketing processing to a remote application.

It is compatible with **Windows**, **Linux**, **macOS** and **Android** platforms.

<br>

## Java component

{{% callout note %}}
**`{{% keyple-distributed-local-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse-keyple/keyple-distributed-local-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse-keyple/keyple-distributed-local-java-lib/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

### Documentation

* [API documentation](https://eclipse-keyple.github.io/keyple-distributed-local-java-lib)
* [User guide]({{< relref "/learn/user-guide/distributed-application" >}})

### Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.com/search?q=keyple-distributed-local-java-lib) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Kotlin" >}}
{{< code lang="kotlin" copy="true">}}
implementation("org.eclipse.keyple:keyple-distributed-local-java-lib:{{% keyple-distributed-local-java-lib-version %}}")
{{< /code>}}
{{< /tab >}}
{{< tab header="Gradle Groovy" >}}
{{< code lang="gradle" copy="true">}}
implementation 'org.eclipse.keyple:keyple-distributed-local-java-lib:{{% keyple-distributed-local-java-lib-version %}}'
{{< /code>}}
{{< /tab >}}
{{< tab header="Maven" >}}
{{< code lang="xml" copy="true">}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-distributed-local-java-lib</artifactId>
  <version>{{% keyple-distributed-local-java-lib-version %}}</version>
</dependency>
{{< /code>}}
{{< /tab >}}
{{< /tabpane >}}