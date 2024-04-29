---
title: Keyple Plugin Card Resource Library
linktitle: Card Resource
summary: Add-on to manage readers provided by the Card Resource Service.
type: book
toc: true
---

<br>

The **Keyple Plugin Card Resource Library** is a **PoolPlugin** to manage readers provided by the 
[**Card Resource Service**]({{< relref "/components/core/keyple-service-resource-lib" >}}).

Therefore, it should be used only by application developers.

The main role of the plugin is to allow remote access to the **Card Resource Service** via the **Keyple Distributed 
Solution** components. 
It provides an interface for allocating and deallocating readers by profiles that are part of those configured at the 
**Card Resource Service** level.

A typical use would be for the realization of a server providing cryptographic services through a pool of SAMs, each 
inserted in a dedicated PC/SC reader.

<br>

## Java component

{{% callout note %}}
**`{{% keyple-plugin-cardresource-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}}
[GitHub](https://github.com/eclipse-keyple/keyple-plugin-cardresource-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}}
[Changelog](https://github.com/eclipse-keyple/keyple-plugin-cardresource-java-lib/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

### Documentation

* [API documentation](https://eclipse-keyple.github.io/keyple-plugin-cardresource-java-lib)

### Download

All deliverables are available directly from the 
[Maven Central Repository](https://central.sonatype.com/search?q=keyple-plugin-cardresource-java-lib) or by using one 
of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Groovy" >}}
{{< code lang="gradle" copy="true">}}
implementation 'org.eclipse.keyple:keyple-plugin-cardresource-java-lib:{{% keyple-plugin-cardresource-java-lib-version %}}'
{{< /code>}}
{{< /tab >}}
{{< tab header="Gradle Kotlin" >}}
{{< code lang="kotlin" copy="true">}}
implementation("org.eclipse.keyple:keyple-plugin-cardresource-java-lib:{{% keyple-plugin-cardresource-java-lib-version %}}")
{{< /code>}}
{{< /tab >}}
{{< tab header="Maven" >}}
{{< code lang="xml" copy="true">}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-plugin-cardresource-java-lib</artifactId>
  <version>{{% keyple-plugin-cardresource-java-lib-version %}}</version>
</dependency>
{{< /code>}}
{{< /tab >}}
{{< /tabpane >}}