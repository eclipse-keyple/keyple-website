---
title: Build process and continuous integration
linktitle: Build and CI
summary: Learn how the Keyple components are built, tested and published.
type: book
toc: true
weight: 30
---

<br>

## Build automation tool

Keyple uses Gradle.

<br>

## Versioning rules

Keyple components are versioned according to [Semantic Versioning 2.0.0](https://semver.org) which is based on the three numbers `X.Y.Z`

{{% callout note %}}
For API components (i.e. artifacts suffixed with `-api`), the incrementation of `Z` indicates only a documentation update.
{{% /callout %}}

<br>

## Continuous integration

Keyple continuous integration is based on **GitHub Actions** and uses the reusable
workflows defined in the dedicated [Keyple Actions repository](https://github.com/eclipse-keyple/keyple-actions).

The CI automates the following tasks:
* verify the validity of the version;
* verify the code formatting using [spotless](https://github.com/diffplug/spotless);
* verify the licenses of third-party dependencies using the [Eclipse Dash License Tool](https://github.com/eclipse-dash/dash-licenses);
* build the code;
* execute unit tests;
* sign and publish artifacts to Maven Central Repository;
* publish the API documentation to the unified [Keyple's documentation GitHub pages](https://docs.keyple.org/);
* publish the code quality report to [SonarCloud](https://sonarcloud.io/organizations/eclipse/projects?search=keyple&sort=-analysis_date).

<br>

## License verification

The **Eclipse Dash License Tool** analyzes the project's dependencies to identify their licenses and verify compliance
with the [Eclipse Foundation Governance Documents](https://www.eclipse.org/org/documents/). It retrieves license
information from the Eclipse Foundation's database and the ClearlyDefined service.

The license check is an integral part of the build workflow. If the **Eclipse Dash License Tool** detects dependencies
that require manual review, the build fails with an error. In such cases, a committer must intervene.

A [script](https://github.com/eclipse-keyple/keyple-actions/tree/main/tools/dash-licenses), available in the
**Keyple Actions repository**, supports committers by automatically publishing the necessary issues to the
dedicated [repository](https://gitlab.eclipse.org/eclipsefdn/emo-team/iplab/-/issues) of the Eclipse Foundation
for license-related matters. This step is performed manually by the committer from a local workstation.

<br>

## Snapshot publication

A new **snapshot** version (suffixed with `-SNAPSHOT`) is automatically built and published each time a commit is pushed
to the `main` branch.

This allows developers to use the latest development state of Keyple without waiting for an official release. The
published SNAPSHOT artifacts are available from
the [Eclipse Maven Snapshots repository](https://central.sonatype.com/service/rest/repository/browse/maven-snapshots).

{{% callout warning %}}
The component version defined in `gradle.properties` must contain the `-SNAPSHOT` suffix.
{{% /callout %}}

<br>

## Release publication

A new **release** version is automatically built and published whenever a GitHub release is created.

The generated artifact is based on the **commit referenced by the newly created tag**, ensuring full traceability
between the source code and the published artifacts.

{{% callout warning %}}
The GitHub release **tag name** must strictly match the version declared in the `gradle.properties` file (without the
`-SNAPSHOT` suffix).

For example, if the component version in `gradle.properties` is `2.5.0-SNAPSHOT`, the GitHub release tag must be
`2.5.0`.
{{% /callout %}}

<br>

## Integration tests

Integration tests are defined in an independent GitHub repository: [keyple-integration-java-test](https://github.com/eclipse-keyple/keyple-integration-java-test)

<br>

## Release procedure

1. Create a branch dedicated to the current release.
2. Check `gradle.properties` file:
    - Check the consistency of the version (**do not remove** `-SNAPSHOT` suffix).
3. Check `build.gradle.kts` file:
    - Use only released dependencies.
    - Upgrade Keyple dependencies to their latest released versions.
4. Update `CHANGELOG.md` file:
    - Verify the consistency of the `Unreleased` section.
    - Move content of `Unreleased` section to a new "release" section.
    - Update bottom links.
5. Build and test the component locally.
6. Commit the modified files.
7. Push and create a pull request to merge the branch into `main`.
8. Await the success of the build by the CI on source branch.
9. Squash and merge the pull request.
10. Await the success of the **snapshot** publication by the CI on `main` branch.
11. Create a release on GitHub:
    - Set tag `x.y.z`
    - Set release name `x.y.z`
    - Set the content by copying/pasting the content of the current release description in the `CHANGELOG.md` file
      without the bottom links.
12. Await the success of the **release** publication by the CI on `main` branch.
13. Check the availability of the release on
    the [Maven Repository](https://repo.maven.apache.org/maven2/org/eclipse/keyple/). This step may take from 10 minutes
    to 2 hours.
14. Update this website:
    - Update version in `params.yaml` file.
    - Update table content of `dependency-check.md` file.
    - Update others elements if needed (user guides, developer guides, etc...).
    - Commit and push the modifications.