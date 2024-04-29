---
title: Keyple Util Library
linktitle: Util
summary: Utility classes for Keyple components.
type: book
toc: true
---

<br>

The **Keyple Util Library** contains utility classes used by all Keyple libraries.

Therefore, it can be used by all developers.

{{% callout warning %}}
Since this library is used by all Keyple libraries, it is recommended to import it explicitly.
{{% /callout %}}

<br>

## Java component

{{% callout note %}}
**`{{% keyple-util-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse-keyple/keyple-util-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse-keyple/keyple-util-java-lib/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

### Documentation

* [API documentation](https://eclipse-keyple.github.io/keyple-util-java-lib)

### Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.com/search?q=keyple-util-java-lib) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Groovy" >}}
{{< code lang="gradle" copy="true">}}
implementation 'org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-version %}}'
{{< /code>}}
{{< /tab >}}
{{< tab header="Gradle Kotlin" >}}
{{< code lang="kotlin" copy="true">}}
implementation("org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-version %}}")
{{< /code>}}
{{< /tab >}}
{{< tab header="Maven" >}}
{{< code lang="xml" copy="true">}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-util-java-lib</artifactId>
  <version>{{% keyple-util-java-lib-version %}}</version>
</dependency>
{{< /code>}}
{{< /tab >}}
{{< /tabpane >}}