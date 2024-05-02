---
title: Keyple Plugin PC/SC Library
linktitle: PC/SC
summary: Add-on to manage PC/SC readers.
type: book
toc: true
---

<br>

The **Keyple Plugin PC/SC Library** is an add-on to manage **PC/SC** readers.

Therefore, it should be used only by application developers.

It is compatible with **PC/SC Reader** (Windows PC/SC WinScard API, Unix PC/SC lite API) equipment.

<br>

## Java component

{{% callout note %}}
**`{{% keyple-plugin-pcsc-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse-keyple/keyple-plugin-pcsc-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse-keyple/keyple-plugin-pcsc-java-lib/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

### Documentation

* [API documentation](https://eclipse-keyple.github.io/keyple-plugin-pcsc-java-lib)

### Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.com/search?q=keyple-plugin-pcsc-java-lib) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Kotlin" >}}
{{< code lang="kotlin" copy="true">}}
implementation("org.eclipse.keyple:keyple-plugin-pcsc-java-lib:{{% keyple-plugin-pcsc-java-lib-version %}}")
{{< /code>}}
{{< /tab >}}
{{< tab header="Gradle Groovy" >}}
{{< code lang="gradle" copy="true">}}
implementation 'org.eclipse.keyple:keyple-plugin-pcsc-java-lib:{{% keyple-plugin-pcsc-java-lib-version %}}'
{{< /code>}}
{{< /tab >}}
{{< tab header="Maven" >}}
{{< code lang="xml" copy="true">}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-plugin-pcsc-java-lib</artifactId>
  <version>{{% keyple-plugin-pcsc-java-lib-version %}}</version>
</dependency>
{{< /code>}}
{{< /tab >}}
{{< /tabpane >}}