---
title: Keyple Common Java API
linktitle: Common API
summary: Public API which defines the elements shared between all Keyple libraries.
type: book
toc: true
---

{{% callout note %}}
**`{{% keyple-common-java-api-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse/keyple-common-java-api/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse/keyple-common-java-api/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

## Overview

The **Keyple Common Java API** defines the public elements shared between all Keyple libraries.

Therefore, it must be used by all developers.

## Documentation

* [API documentation](https://eclipse.github.io/keyple-common-java-api)
* [User guide]({{< relref "/learn/user-guide/standalone-application" >}})
 
## Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.dev/search?q=keyple-common-java-api) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-version %}}"){{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-common-java-api</artifactId>
  <version>{{% keyple-common-java-api-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}

{{% callout note %}}
The third version number (x.y.**z**) only concerns updates of the javadoc because this component does not contain any implementation, but only an API.
{{% /callout %}}