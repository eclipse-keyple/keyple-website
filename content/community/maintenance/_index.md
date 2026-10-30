---
title: Maintenance policy
linktitle: Maintenance
summary: Versioning and maintenance policy of the Keyple components.
type: book
toc: true
weight: 4
---

Since October 2021 (start of the 2.x.y branches of the Keyple Service and Calypso libraries), the project has been split into a multitude of API and library components, hosted in dedicated repositories and versioned separately with their own lifecycles.
Dependencies between APIs are limited, and libraries have almost no dependencies between them: this architecture means that upgrades and corrections can be proposed on a frequent basis (more than 50 component versions per year on average between 2021 and 2025).
- Corrections and minor evolutions are backward compatible, following semantic versioning: they have no impact on applications or extensions.
- A major evolution may require adaptations on a limited scope, as indicated in the [dedicated migration guides]({{< relref "/learn/user-guide/migration-guide" >}}).

In November 2023 (start of the 3.x.y branches of the Keyple Service and Calypso libraries), the terminal APIs have been moved to the Eclipse Keypop open source project. Since then, new features have been regularly integrated into the 3.x.y branches via minor evolutions.

All component versions and their changes are listed in the [Changelog]({{< relref "/community/changelog" >}}).

## Supported versions

Corrections and security fixes are only provided for the latest major version of each Keyple component (see the [security policy](https://github.com/eclipse-keyple/.github/blob/master/SECURITY.md)). Users of older major versions are encouraged to migrate.

In particular:
- The 2.x.y branches of the Keyple Service and Calypso libraries are no longer maintained. Their last versions were released in December 2024 (Keyple Service 2.3.6) and April 2025 (Keyple Calypso 2.3.15).
- The very first Keyple implementations, from 0.7 to 1.0 (July 2019 to December 2020), are no longer maintained.
