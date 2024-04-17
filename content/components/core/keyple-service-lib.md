---
title: Keyple Service Library
linktitle: Service
summary: Main library containing the implementation of the core Keyple components and services.
type: book
toc: true
---

<br>

The **Keyple Service Library** contains the implementation of the core Keyple components and services, such as the smart card service, the card selection manager or the card and reader event manager.

Therefore, it must be used only by application developers.

<br>

## Java component

{{% callout note %}}
**`{{% keyple-service-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse-keyple/keyple-service-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse-keyple/keyple-service-java-lib/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

### Documentation

* [API documentation](https://eclipse-keyple.github.io/keyple-service-java-lib)
* [User guide]({{< relref "/learn/user-guide/standalone-application" >}})

### Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.com/search?q=keyple-service-java-lib) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-service-java-lib:{{% keyple-service-java-lib-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-service-java-lib:{{% keyple-service-java-lib-version %}}"){{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-service-java-lib</artifactId>
  <version>{{% keyple-service-java-lib-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}