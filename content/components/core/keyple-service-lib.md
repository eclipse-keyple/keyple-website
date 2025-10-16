---
title: Keyple Service Library
linktitle: Service
summary: Main library containing the implementation of the core Keyple components and services.
type: book
toc: true
---

<br>

The **Keyple Service Library** contains the implementation of the core Keyple components and services, such as the smart
card service, the card selection manager or the card and reader event manager.

It is therefore intended for application developers only.

<br>

## Java component

{{% callout note %}}
**`{{% keyple-service-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse-keyple/keyple-service-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse-keyple/keyple-service-java-lib/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

### Documentation

* [API documentation](https://docs.keyple.org/keyple-service-java-lib)
* [User guide]({{< relref "/learn/user-guide/standalone-application" >}})

### Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.com/search?q=keyple-service-java-lib) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Kotlin" >}}
{{< code lang="kotlin" copy="true">}}
implementation("org.eclipse.keyple:keyple-service-java-lib:{{% keyple-service-java-lib-version %}}")
{{< /code>}}
{{< /tab >}}
{{< tab header="Gradle Groovy" >}}
{{< code lang="gradle" copy="true">}}
implementation 'org.eclipse.keyple:keyple-service-java-lib:{{% keyple-service-java-lib-version %}}'
{{< /code>}}
{{< /tab >}}
{{< tab header="Maven" >}}
{{< code lang="xml" copy="true">}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-service-java-lib</artifactId>
  <version>{{% keyple-service-java-lib-version %}}</version>
</dependency>
{{< /code>}}
{{< /tab >}}
{{< /tabpane >}}

<br>

## C++ component

{{% callout note %}}
**`{{% keyple-service-cpp-lib-version %}}`**
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse-keyple/keyple-service-cpp-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [History](https://github.com/eclipse-keyple/keyple-service-cpp-lib/releases)</span>
{{% /callout %}}

### Documentation

* [API documentation](https://docs.keyple.org/keyple-service-cpp-lib)
* [User guide]({{< relref "/learn/user-guide/standalone-application" >}})

{{< content-include file="note-about-cpp" >}}