---
title: Support and long-term maintenance
linktitle: Maintenance
summary: Evolution and maintenance service.
type: book
toc: true
weight: 3
---

Since October 2021 (start of the 2.x.y branches of the Keyple Service and Calypso libraries), the project has been split into a multitude of API and library components, hosted in dedicated repositories and versioned separately with their own lifecycles.
Dependencies between APIs are limited, and libraries have almost no dependencies between them: this architecture means that upgrades and corrections can be proposed on a frequent basis (an average of 80 component versions per year between 2021 and 2025.
- Any correction or minor component evolution is guaranteed to have no impact on applications or extensions.
- A major evolution may require adaptations on a limited perimeter: as indicated in the [dedicated migration guides](https://keyple.org/learn/user-guide/migration-guide/).

In November 2023 (start of the 3.x.y branches of the Keyple Service and Calypso libraries), the terminal APIs are hosted within the Eclipse Keypop open source project. Since then:
- new feature additions are regularly integrated into the 3.x.y branches via minor evolutions.
- but the older 2.x.y branches continue to be actively maintained with multiple patches (static scope of functionality).

Patches are no longer offered for the very first Keyple implementations: 0.7 to 1.0 (July 2019 to December 2020): migration to a more recent version of Keyple is recommended.
