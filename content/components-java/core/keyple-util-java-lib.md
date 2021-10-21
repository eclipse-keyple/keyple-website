---
title: Keyple Util Java Library
linktitle: Util
summary: Utility classes for Keyple components.
type: book
toc: true
---

{{% alert note %}}
**`{{% keyple-util-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse/keyple-util-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse/keyple-util-java-lib/blob/main/CHANGELOG.md)</span>
{{% /alert %}}

## Overview

The **Keyple Util Java Library** contains utility classes used by all Keyple libraries.

Therefore, it can be used by all developers.

## Documentation

* [API documentation](https://eclipse.github.io/keyple-util-java-lib)

## Download

All deliverables are available directly from the [Maven Central Repository](https://search.maven.org/search?q=a:keyple-util-java-lib) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-dynamic-gradle-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-dynamic-gradle-version %}}"){{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-util-java-lib</artifactId>
  <version>{{% keyple-util-java-lib-dynamic-maven-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}

{{% alert warning %}}
Since this library is used by all Keyple libraries, it is recommended to explicitly perform a **dynamic import** of the library for a given major version.
This ensures compatibility with all the used libraries.
{{% /alert %}}