---
title: Build process and continuous integration
linktitle: Build and CI
summary: Learn how the Keyple components are built, tested and published.
type: book
toc: true
weight: 30
---

---
## Build automation tool

Keyple uses Gradle.

---
## Versioning rules

Keyple components are versioned according to [Semantic Versioning 2.0.0](https://semver.org) which is based on the three numbers `X.Y.Z`

{{% alert note %}}
For API components (i.e. artifacts suffixed with `-api`), the incrementation of `Z` indicates only a documentation update.
{{% /alert %}}

---
## Continuous integration

Keyple continuous integration works with the [Jenkins server](https://ci.eclipse.org/keyple/job/Keyple/) of the Eclipse Foundation.

The build process uses the home-made gradle plugin **Keyple Gradle** available directly from the [Maven Central Repository](https://search.maven.org/search?q=a:keyple-gradle) and whose sources are available on [GitHub](https://github.com/eclipse/keyple-ops).

The CI automates the following tasks (defined in the `Jenkinsfile` file):
* verify the validity of the version;
* verify the code formatting using [Spotless](https://github.com/diffplug/spotless);
* build the code;
* execute unit tests;
* sign and publish artifacts to Maven Central Repository;
* publish the javadoc to the corresponding GitHub Pages;
* publish the code quality report to [SonarCloud](https://sonarcloud.io/organizations/eclipse/projects?search=keyple&sort=-analysis_date).

---
## Snapshot publication

A snapshot artifact (suffixed with `-SNAPSHOT`) is automatically published after each commit on the `main` branch, except in the case of a release (see [Release publication](#release-publication)).

{{% alert warning %}}
The artifact version defined in the `gradle.properties` file must not have a `-SNAPSHOT` suffix because the suffix is automatically added by the Keyple Gradle plugin.
{{% /alert %}}

---
## Release publication

A release artifact is automatically published if and only if the following two conditions are met:
* The commit is done on the `main` branch or on a `release-X.Y.Z` branch.
* The commit message starts with `Release X.Y.Z`.

{{% alert warning %}}
`X.Y.Z` must be the version defined in the `gradle.properties` file.
{{% /alert %}}

---
## Integration tests

Integration tests are defined in an independent GitHub repository: [keyple-integration-java-test](https://github.com/eclipse/keyple-integration-java-test)