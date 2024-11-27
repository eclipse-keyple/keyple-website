---
title: Keyple Card Calypso Library
linktitle: Calypso Card
summary: Add-on to manage Calypso® cards.
type: book
toc: true
---

<br>

The **Keyple Card Calypso Library** is an add-on to manage Calypso® cards.

Therefore, it should be used only by application developers.

{{% callout warning %}}
For card transactions that need to be secured by cryptographic calculations using symmetrical keys (SAM or HSM) or
asymmetrical keys (PKI), **it is mandatory to use one of the dedicated crypto libraries** (Open SAM, Legacy SAM, PKI).
At present, only the [Calypso Crypto Legacy SAM]({{< relref "keyple-card-calypso-crypto-legacysam-lib" >}}) library is available.
{{% /callout %}}

<br>

## Java component

{{% callout note %}}
**`{{% keyple-card-calypso-java-lib-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse-keyple/keyple-card-calypso-java-lib/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse-keyple/keyple-card-calypso-java-lib/blob/main/CHANGELOG.md)</span>
{{% /callout %}}

### Documentation

* [API documentation](https://docs.keyple.org/keyple-card-calypso-java-lib)
* [User guide]({{< relref "/learn/user-guide/calypso-application" >}})

### Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.com/search?q=keyple-card-calypso-java-lib) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Kotlin" >}}
{{< code lang="kotlin" copy="true">}}
implementation("org.eclipse.keyple:keyple-card-calypso-java-lib:{{% keyple-card-calypso-java-lib-version %}}")
{{< /code>}}
{{< /tab >}}
{{< tab header="Gradle Groovy" >}}
{{< code lang="gradle" copy="true">}}
implementation 'org.eclipse.keyple:keyple-card-calypso-java-lib:{{% keyple-card-calypso-java-lib-version %}}'
{{< /code>}}
{{< /tab >}}
{{< tab header="Maven" >}}
{{< code lang="xml" copy="true">}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-card-calypso-java-lib</artifactId>
  <version>{{% keyple-card-calypso-java-lib-version %}}</version>
</dependency>
{{< /code>}}
{{< /tab >}}
{{< /tabpane >}}