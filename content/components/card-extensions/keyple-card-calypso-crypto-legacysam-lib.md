---
title: Keyple Card Calypso Crypto Legacy SAM Library
linktitle: Calypso Legacy SAM
summary: Add-on to manage Calypso® legacy SAMs (SAM-C1, HSM-C1, etc...).
type: book
toc: true
---

{{% callout warning %}}
This library is currently in **Beta** version as it implements the [Keypop Calypso Crypto Legacy SAM API](https://eclipse-keypop.github.io/keypop-website/apis/keypop-calypso-crypto-legacysam-api/),
which is also in **Beta**.
While it's nearly stable, future migration steps might be necessary. We aim to minimize any changes you'll need to make.
{{% /callout %}}

<br>

The **Keyple Card Calypso Crypto Legacy SAM Library** is an add-on to manage Calypso® legacy SAMs (SAM-C1, HSM-C1, etc.).

Therefore, it should be used only by application developers.

<br>

## Java component

{{% callout note %}}
**`{{% keyple-card-calypso-crypto-legacysam-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse-keyple/keyple-card-calypso-crypto-legacysam-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse-keyple/keyple-card-calypso-crypto-legacysam-java-lib/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

### Documentation

* [API documentation](https://eclipse-keyple.github.io/keyple-card-calypso-crypto-legacysam-java-lib)

### Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.dev/search?q=keyple-card-calypso-crypto-legacysam-java-lib) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-card-calypso-crypto-legacysam-java-lib:{{% keyple-card-calypso-crypto-legacysam-java-lib-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-card-calypso-crypto-legacysam-java-lib:{{% keyple-card-calypso-crypto-legacysam-java-lib-version %}}"){{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-card-calypso-crypto-legacysam-java-lib</artifactId>
  <version>{{% keyple-card-calypso-crypto-legacysam-java-lib-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}