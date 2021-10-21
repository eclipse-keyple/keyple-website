---
title: Keyple Distributed Local Java API
linktitle: Distributed Local API
summary: Internal API dedicated to the development of custom local services components of the Keyple distributed solution.
type: book
toc: true
---

{{% alert note %}}
**`{{% keyple-distributed-local-java-api-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse/keyple-distributed-local-java-api/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse/keyple-distributed-local-java-api/blob/main/CHANGELOG.md)</span>
{{% /alert %}}

## Overview

The **Keyple Distributed Local Java API** defines the **internal API** dedicated to the development of local services components of the Keyple distributed solution.

Therefore, it must be used only by developers of custom local services.

## Documentation

* [API documentation](https://eclipse.github.io/keyple-distributed-local-java-api)

## Download

All deliverables are available directly from the [Maven Central Repository](https://search.maven.org/search?q=a:keyple-distributed-local-java-api) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-distributed-local-java-api:{{% keyple-distributed-local-java-api-dynamic-gradle-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-distributed-local-java-api:{{% keyple-distributed-local-java-api-dynamic-gradle-version %}}"){{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-distributed-local-java-api</artifactId>
  <version>{{% keyple-distributed-local-java-api-dynamic-maven-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}

{{% alert note %}}
The third version number (x.y.**z**) only concerns updates of the javadoc because this component does not contain any implementation, but only an API.
Therefore, it is recommended to always perform a **dynamic import** as described above in order to have the most up-to-date documentation.
{{% /alert %}}