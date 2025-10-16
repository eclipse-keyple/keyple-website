---
title: Keyple Distributed Local API
linktitle: Distributed Local API
summary: Internal API dedicated to the development of custom local services components of the Keyple distributed solution.
type: book
toc: true
---

<br>

The **Keyple Distributed Local API** defines the **internal API** dedicated to the development of local services
components of the Keyple distributed solution.

It is therefore intended for developers of custom local services only.

{{% callout note %}}
The third version number (x.y.**z**) only concerns updates of the public API documentation because this component does not contain any implementation.
{{% /callout %}}

<br>

## Java component

{{% callout note %}}
**`{{% keyple-distributed-local-java-api-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse-keyple/keyple-distributed-local-java-api/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse-keyple/keyple-distributed-local-java-api/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

### Documentation

* [API documentation](https://docs.keyple.org/keyple-distributed-local-java-api)

### Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.com/search?q=keyple-distributed-local-java-api) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Kotlin" >}}
{{< code lang="kotlin" copy="true">}}
implementation("org.eclipse.keyple:keyple-distributed-local-java-api:{{% keyple-distributed-local-java-api-version %}}")
{{< /code>}}
{{< /tab >}}
{{< tab header="Gradle Groovy" >}}
{{< code lang="gradle" copy="true">}}
implementation 'org.eclipse.keyple:keyple-distributed-local-java-api:{{% keyple-distributed-local-java-api-version %}}'
{{< /code>}}
{{< /tab >}}
{{< tab header="Maven" >}}
{{< code lang="xml" copy="true">}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-distributed-local-java-api</artifactId>
  <version>{{% keyple-distributed-local-java-api-version %}}</version>
</dependency>
{{< /code>}}
{{< /tab >}}
{{< /tabpane >}}