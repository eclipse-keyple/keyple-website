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

{{% callout note %}}
For API components (i.e. artifacts suffixed with `-api`), the incrementation of `Z` indicates only a documentation update.
{{% /callout %}}

---
## Continuous integration

Keyple continuous integration works with the [Jenkins server](https://ci.eclipse.org/keyple/job/Keyple/) of the Eclipse Foundation.

The build process uses the home-made gradle plugin **Keyple Gradle** available directly from the [Maven Central Repository](https://central.sonatype.dev/search?q=keyple-gradle) and whose sources are available on [GitHub](https://github.com/eclipse/keyple-ops).

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

{{% callout warning %}}
The artifact version defined in the `gradle.properties` file must not have a `-SNAPSHOT` suffix because the suffix is automatically added by the Keyple Gradle plugin.
{{% /callout %}}

---
## Release publication

A release artifact is automatically published if and only if the following two conditions are met:
* The commit is done on the `main` branch or on a `release-X.Y.Z` branch.
* The commit message starts with `Release X.Y.Z`.

{{% callout warning %}}
`X.Y.Z` must be the version defined in the `gradle.properties` file.
{{% /callout %}}

---
## Integration tests

Integration tests are defined in an independent GitHub repository: [keyple-integration-java-test](https://github.com/eclipse/keyple-integration-java-test)

## Release procedure

1. Create a branch dedicated to the current release.
2. Check `gradle.properties` file:
    - Check the consistency of the version.
3. Check `build.gradle.kts` file:
    - Use only released dependencies.
    - Upgrade Keyple dependencies to their latest released versions.
4. Update `CHANGELOG.md` file:
    - Verify the consistency of the `Unreleased` section.
    - Move content of `Unreleased` section to a new "release" section.
    - Update bottom links.
5. Build and test the component.
6. Commit the modified files using the commit message `Release x.y.z`.
7. Push and create a pull request to merge the branch into `main`.
8. Await the success of the build by the CI.
9. Squash and merge the pull request.
10. Await the success of the build by the CI.
11. Connect to [Nexus Repository Manager](https://oss.sonatype.org/#welcome) of Eclipse Keyple and go to "Staging Repositories" page:
    - Select the correct folder to Close & Release. It must contain the manifests, the JAR and all the others elements (sources, javadoc).
    - Close the folder.
    - Release the folder.
    - The other unwanted folders could be dropped.
12. Check the availability of the release on the [Maven Repository](https://repo.maven.apache.org/maven2/org/eclipse/keyple/). This step may take from 10 minutes to 2 hours.
13. Create a release on GitHub:
    - Set tag `x.y.z`
    - Set release name `x.y.z`
    - Set the content by copying/pasting the content of the current release description in the `CHANGELOG.md` file without the bottom links.
14. Increment the version in the `gradle.properties` file and commit it to prepare the code for the next release (e.g. `2.0.0 -> 2.0.1`).
15. Update this website:
    - Update version in `params.yaml` file.
    - Update table content of `dependency-check.md` file.
    - Update others elements if needed (user guides, developer guides, etc...).
    - Commit and push the modifications.