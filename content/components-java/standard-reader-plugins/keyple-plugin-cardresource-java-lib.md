---
title: Keyple Plugin Card Resource Java Library
linktitle: Card Resource
summary: Add-on to manage readers provided by the Card Resource Service.
type: book
toc: true
---

{{% callout note %}}
**`{{% keyple-plugin-cardresource-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} 
[GitHub](https://github.com/eclipse/keyple-plugin-cardresource-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} 
[Changelog](https://github.com/eclipse/keyple-plugin-cardresource-java-lib/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

## Overview

The **Keyple Plugin Card Resource Java Library** is a **PoolPlugin** to manage readers provided by the 
[**Card Resource Service**]({{< relref "/components-java/core/keyple-service-resource-java-lib" >}}).

Therefore, it should be used only by application developers.

The plugin's primary role is to allocate readers with smart cards, such as a SAM, already inserted and selected. 
The allocation process is based on the profile identifiers used to configure the **Card Resource Service**.

## Documentation

* [API documentation](https://eclipse.github.io/keyple-plugin-cardresource-java-lib)

## Download

All deliverables are available directly from the 
[Maven Central Repository](https://central.sonatype.dev/search?q=keyple-plugin-cardresource-java-lib) or by using one 
of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-plugin-cardresource-java-lib:{{% keyple-plugin-cardresource-java-lib-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-plugin-cardresource-java-lib:{{% keyple-plugin-cardresource-java-lib-version %}}"){{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-plugin-cardresource-java-lib</artifactId>
  <version>{{% keyple-plugin-cardresource-java-lib-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}