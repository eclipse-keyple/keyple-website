---
title: Keyple Distributed Remote API
linktitle: Distributed Remote API
summary: Internal API dedicated to the development of custom remote plugins components of the Keyple distributed solution.
type: book
toc: true
---

<br>

The **Keyple Distributed Remote API** defines the **internal API** dedicated to the development of remote plugins components of the Keyple distributed solution.

Therefore, it must be used only by developers of custom remote plugins.

{{% callout note %}}
The third version number (x.y.**z**) only concerns updates of the public API documentation because this component does not contain any implementation.
{{% /callout %}}

<br>

## Java component

{{% callout note %}}
**`{{% keyple-distributed-remote-java-api-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse-keyple/keyple-distributed-remote-java-api/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse-keyple/keyple-distributed-remote-java-api/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

### Documentation

* [API documentation](https://eclipse-keyple.github.io/keyple-distributed-remote-java-api)

### Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.com/search?q=keyple-distributed-remote-java-api) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-distributed-remote-java-api:{{% keyple-distributed-remote-java-api-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-distributed-remote-java-api:{{% keyple-distributed-remote-java-api-version %}}"){{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-distributed-remote-java-api</artifactId>
  <version>{{% keyple-distributed-remote-java-api-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}