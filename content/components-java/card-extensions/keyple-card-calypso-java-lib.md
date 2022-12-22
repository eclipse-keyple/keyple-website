---
title: Keyple Card Calypso Java Library
linktitle: Calypso Card
summary: Add-on to manage Calypso® cards.
type: book
toc: true
---

{{% callout note %}}
**`{{% keyple-card-calypso-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse/keyple-card-calypso-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse/keyple-card-calypso-java-lib/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

## Overview

The **Keyple Card Calypso Java Library** is an add-on to manage Calypso® cards.

Therefore, it should be used only by application developers.

It can be used on **Windows**, **Linux**, **macOS** and **Android** platforms.

## Documentation

* [API documentation](https://eclipse.github.io/keyple-card-calypso-java-lib)
* [User guide]({{< relref "/learn/user-guide/calypso-application" >}})

## Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.dev/search?q=keyple-card-calypso-java-lib) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-card-calypso-java-lib:{{% keyple-card-calypso-java-lib-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-card-calypso-java-lib:{{% keyple-card-calypso-java-lib-version %}}"){{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-card-calypso-java-lib</artifactId>
  <version>{{% keyple-card-calypso-java-lib-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}