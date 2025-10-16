---
title: Keyple Plugin API
linktitle: Plugin API
summary: Internal API dedicated to the development of custom reader plugins components.
type: book
toc: true
---

<br>

The **Keyple Plugin API** defines the **internal API** dedicated to the development of reader plugins components.

It is therefore intended for developers of custom reader plugins only.

{{% callout note %}}
The third version number (x.y.**z**) only concerns updates of the public API documentation because this component does not contain any implementation.
{{% /callout %}}

<br>

## Java component

{{% callout note %}}
**`{{% keyple-plugin-java-api-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse-keyple/keyple-plugin-java-api/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse-keyple/keyple-plugin-java-api/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

### Documentation

* [API documentation](https://docs.keyple.org/keyple-plugin-java-api)
* [Developer guide]({{< relref "/learn/developer-guide/reader-plugin-add-on" >}})

### Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.com/search?q=keyple-plugin-java-api) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Kotlin" >}}
{{< code lang="kotlin" copy="true">}}
implementation("org.eclipse.keyple:keyple-plugin-java-api:{{% keyple-plugin-java-api-version %}}")
{{< /code>}}
{{< /tab >}}
{{< tab header="Gradle Groovy" >}}
{{< code lang="gradle" copy="true">}}
implementation 'org.eclipse.keyple:keyple-plugin-java-api:{{% keyple-plugin-java-api-version %}}'
{{< /code>}}
{{< /tab >}}
{{< tab header="Maven" >}}
{{< code lang="xml" copy="true">}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-plugin-java-api</artifactId>
  <version>{{% keyple-plugin-java-api-version %}}</version>
</dependency>
{{< /code>}}
{{< /tab >}}
{{< /tabpane >}}

<br>

## C++ component

{{% callout note %}}
**`{{% keyple-plugin-cpp-api-version %}}`**
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse-keyple/keyple-plugin-cpp-api/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [History](https://github.com/eclipse-keyple/keyple-plugin-cpp-api/releases)</span>
{{% /callout %}}

### Documentation

* [API documentation](https://docs.keyple.org/keyple-plugin-cpp-api)
* [Developer guide]({{< relref "/learn/developer-guide/reader-plugin-add-on" >}})

{{< content-include file="note-about-cpp" >}}