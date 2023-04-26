---
title: Keyple Plugin Java API
linktitle: Plugin API
summary: Internal API dedicated to the development of custom reader plugins components.
type: book
toc: true
---

{{% callout note %}}
**`{{% keyple-plugin-java-api-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse/keyple-plugin-java-api/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse/keyple-plugin-java-api/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

## Overview

The **Keyple Plugin Java API** defines the **internal API** dedicated to the development of reader plugins components.

Therefore, it must be used only by developers of custom reader plugins.

## Documentation

* [API documentation](https://eclipse.github.io/keyple-plugin-java-api)
* [Developer guide]({{< relref "/learn/developer-guide/reader-plugin-add-on" >}})

## Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.dev/search?q=keyple-plugin-java-api) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-plugin-java-api:{{% keyple-plugin-java-api-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-plugin-java-api:{{% keyple-plugin-java-api-version %}}"){{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-plugin-java-api</artifactId>
  <version>{{% keyple-plugin-java-api-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}

{{% callout note %}}
The third version number (x.y.**z**) only concerns updates of the javadoc because this component does not contain any implementation, but only an API.
{{% /callout %}}