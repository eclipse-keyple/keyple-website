---
title: Keyple Service Resource Library
linktitle: Service Resource
summary: Add-on library providing profile-based card resource allocation mechanism.
type: book
toc: true
---

<br>

The **Keyple Service Resource Library** is an **add-on** providing profile-based card resource allocation mechanism.

Therefore, it can be used by developers of applications or card extensions.

<br>

## Java component

{{% callout note %}}
**`{{% keyple-service-resource-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse-keyple/keyple-service-resource-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse-keyple/keyple-service-resource-java-lib/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

### Documentation

* [API documentation](https://eclipse-keyple.github.io/keyple-service-resource-java-lib)
* [User guide]({{< relref "/learn/user-guide/card-resource-service" >}})

### Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.com/search?q=keyple-service-resource-java-lib) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Groovy" >}}
{{< code lang="gradle" copy="true">}}
implementation 'org.eclipse.keyple:keyple-service-resource-java-lib:{{% keyple-service-resource-java-lib-version %}}'
{{< /code>}}
{{< /tab >}}
{{< tab header="Gradle Kotlin" >}}
{{< code lang="kotlin" copy="true">}}
implementation("org.eclipse.keyple:keyple-service-resource-java-lib:{{% keyple-service-resource-java-lib-version %}}")
{{< /code>}}
{{< /tab >}}
{{< tab header="Maven" >}}
{{< code lang="xml" copy="true">}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-service-resource-java-lib</artifactId>
  <version>{{% keyple-service-resource-java-lib-version %}}</version>
</dependency>
{{< /code>}}
{{< /tab >}}
{{< /tabpane >}}