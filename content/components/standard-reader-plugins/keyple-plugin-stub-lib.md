---
title: Keyple Plugin Stub Library
linktitle: Stub
summary: Add-on to manage virtual readers and cards.
type: book
toc: true
---

<br>

The **Keyple Plugin Stub Library** is an add-on to manage **virtual** readers and cards.

Therefore, it should be used only by application developers.

It is compatible with **Windows**, **Linux**, **macOS** and **Android** platforms.

<br>

## Java component

{{% callout note %}}
**`{{% keyple-plugin-stub-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse-keyple/keyple-plugin-stub-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse-keyple/keyple-plugin-stub-java-lib/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

### Documentation

* [API documentation](https://eclipse-keyple.github.io/keyple-plugin-stub-java-lib)

### Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.dev/search?q=keyple-plugin-stub-java-lib) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-plugin-stub-java-lib:{{% keyple-plugin-stub-java-lib-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-plugin-stub-java-lib:{{% keyple-plugin-stub-java-lib-version %}}"){{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-plugin-stub-java-lib</artifactId>
  <version>{{% keyple-plugin-stub-java-lib-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}