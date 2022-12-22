---
title: Keyple Service Resource Java Library
linktitle: Service Resource
summary: Add-on library providing profile-based card resource allocation mechanism.
type: book
toc: true
---

{{% callout note %}}
**`{{% keyple-service-resource-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse/keyple-service-resource-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse/keyple-service-resource-java-lib/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

## Overview

The **Keyple Service Resource Java Library** is an **add-on** providing profile-based card resource allocation mechanism.

Therefore, it can be used by developers of applications or card extensions.

## Documentation

* [API documentation](https://eclipse.github.io/keyple-service-resource-java-lib)
* [User guide]({{< relref "/learn/user-guide/card-resource-service" >}})

## Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.dev/search?q=keyple-service-resource-java-lib) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-service-resource-java-lib:{{% keyple-service-resource-java-lib-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-service-resource-java-lib:{{% keyple-service-resource-java-lib-version %}}"){{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-service-resource-java-lib</artifactId>
  <version>{{% keyple-service-resource-java-lib-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}