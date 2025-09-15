---
title: Keyple Bill of Materials (BOM)
linktitle: Bill of Materials (BOM)
summary: A Bill of Materials (BOM) for applications to manage the versions of all Keyple artifacts.
type: book
weight: 15
toc: true
---

<br>

The **Keyple BOM** provides a centralized way to manage the versions of all Keyple artifacts for applications. 
It ensures that projects using multiple Keyple libraries stay consistent and compatible without requiring
explicit version declarations for each dependency.

{{% callout note %}}
The BOM also includes the versions of the [Keypop](https://keypop.org/) dependencies required by Keyple, so you
don’t need to manage them separately.
{{% /callout %}}

<br>

## Versioning

This project follows a date-based versioning scheme:
- **Format**: `YYYY.MM.DD` (year, month, day).
- **Release cadence**: A new version is released whenever one or more Keyple artifacts are updated.
- **Interpretation**: The version number indicates the release date, not the compatibility level.
  Users should check the release notes to see which artifacts were updated.

<br>

## Java component

{{% callout note %}}
**`{{% keyple-java-bom-version %}}`**
<span class="component-metadata">{{< icon name="download" pack="fas" >}} [Download](#download)</span>
<span class="component-metadata">{{< icon name="github" pack="fab" >}} [GitHub](https://github.com/eclipse-keyple/keyple-java-bom/)</span>
<span class="component-metadata">{{< icon name="exchange-alt" pack="fas" >}} [Changelog](https://github.com/eclipse-keyple/keyple-java-bom/blob/main/CHANGELOG.md)</span>
{{% /callout %}}
 
### Download

All deliverables are available directly from the [Maven Central Repository](https://central.sonatype.com/search?q=keyple-java-bom) or by using one of the project resource managers below:

{{< tabpane >}}
{{< tab header="Gradle Kotlin" >}}
{{< code lang="kotlin" copy="true">}}
implementation(platform("org.eclipse.keyple:keyple-java-bom:{{% keyple-java-bom-version %}}"))
{{< /code>}}
{{< /tab >}}
{{< tab header="Gradle Groovy" >}}
{{< code lang="gradle" copy="true">}}
implementation platform('org.eclipse.keyple:keyple-java-bom:{{% keyple-java-bom-version %}}')
{{< /code>}}
{{< /tab >}}
{{< tab header="Maven" >}}
{{< code lang="xml" copy="true">}}
<dependencyManagement>
  <dependencies>
    <dependency>
      <groupId>org.eclipse.keyple</groupId>
      <artifactId>keyple-java-bom</artifactId>
      <version>{{% keyple-java-bom-version %}}</version>
      <type>pom</type>
      <scope>import</scope>
    </dependency>
  </dependencies>
</dependencyManagement>
{{< /code>}}
{{< /tab >}}
{{< /tabpane >}}
