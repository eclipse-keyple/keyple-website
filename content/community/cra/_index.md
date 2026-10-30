---
title: "Keyple and the Cyber Resilience Act (CRA)"
linktitle: CRA compliance
summary: How Keyple and its Eclipse Foundation governance can support the CRA compliance of digital products placed on the European market.
type: book
toc: true
weight: 5
---

The **Cyber Resilience Act (CRA)**, [Regulation (EU) 2024/2847](https://eur-lex.europa.eu/eli/reg/2024/2847/oj), sets mandatory cybersecurity requirements for products with digital elements placed on the European market, such as the validators, vending machines and mobile applications used in smart ticketing.

| Date                 | Milestone                                                                                                                                                              |
|----------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **10 December 2024** | Entry into force of the regulation.                                                                                                                                    |
| **11 September 2026** | Reporting obligations apply: manufacturers must report actively exploited vulnerabilities and severe incidents affecting their products, including products already on the market. |
| **11 December 2027** | All other obligations apply: products placed on the market must meet the essential cybersecurity requirements and bear the **CE marking**.                            |

If you are building your product using **Keyple**, this page explains what remains your responsibility and how the project and its **Eclipse Foundation** governance can support you.

{{% callout note %}}
This page is provided for information purposes only and does not constitute legal advice.
{{% /callout %}}

## 1. Who is responsible?

Under the CRA, the responsibility for compliance lies with the **manufacturer**: the entity that places the final product (e.g., a validator or a mobile app) on the market under its own name or trademark.

* **Keyple's status:** Keyple is open-source software distributed free of charge under the [Eclipse Public License 2.0]({{< relref "/community/licenses" >}}). The CRA does not apply its manufacturer obligations to free and open-source software that is not monetised by its developers. The compliance of your product, including the Keyple components it integrates, therefore rests with you.
* **Keyple's governance:** Keyple is an [Eclipse Foundation project](https://projects.eclipse.org/projects/iot.keyple/). It follows the Eclipse Foundation development process, intellectual property policy and vulnerability reporting policy, which provide the information you need to assess it.

## 2. Your obligations regarding the Keyple components you integrate

As a manufacturer, the CRA requires you to:

* **Exercise due diligence:** Third-party components, including open-source ones, must not compromise the security of your product. The information presented on this page (security policy, quality checks, maintenance policy, changelog) is meant to support this assessment.
* **Report vulnerabilities found in Keyple:** If you identify a vulnerability in a Keyple component, you must report it to the project. Use the channel described in the [security policy](https://github.com/eclipse-keyple/.github/blob/master/SECURITY.md).
* **Report exploited vulnerabilities and severe incidents:** Since 11 September 2026, you must notify actively exploited vulnerabilities and severe incidents affecting your product through the single reporting platform managed by ENISA: early warning within 24 hours, notification within 72 hours, followed by a final report.
* **Document your components:** Your technical documentation must include a **Software Bill of Materials (SBOM)** listing at least the top-level dependencies of your product (see [section 3.C](#c-dependencies-and-sbom)).

## 3. What the Eclipse Foundation governance provides

### A. Coordinated vulnerability disclosure

Keyple adheres to the **[Eclipse Foundation Vulnerability Reporting Policy](https://www.eclipse.org/security/policy/)**:
* **Confidential reporting:** Vulnerabilities are reported confidentially through the Eclipse Foundation Vulnerability Reporting Tracker, as described in the Keyple [security policy](https://github.com/eclipse-keyple/.github/blob/master/SECURITY.md).
* **Coordinated disclosure:** The [Eclipse Foundation Security Team](https://www.eclipse.org/security/) assists the project in handling reports, assigning CVE identifiers and publishing advisories, listed on the [Known Vulnerabilities](https://www.eclipse.org/security/known/) page.

### B. Automated quality checks

Each Keyple component goes through [continuous integration]({{< relref "/learn/keyple-in-depth/build-and-ci" >}}) including static code analysis with [SonarCloud](https://sonarcloud.io/organizations/eclipse-keyple/projects), unit tests and [integration tests](https://github.com/eclipse-keyple/keyple-integration-java-test), in order to detect flaws before release.

### C. Dependencies and SBOM

* **SBOM generation:** Keyple artifacts are published on Maven Central with their standard Maven/Gradle metadata. SBOM generators such as the CycloneDX plugins for Maven and Gradle can therefore include them, together with their transitive dependencies, in the SBOM of your product.
* **Version alignment:** The [Keyple Java BOM]({{< relref "/components/overview/keyple-java-bom" >}}) ensures that all Keyple and [Eclipse Keypop®](https://keypop.org/) modules used by your application are version-aligned and tested together. Note that this Maven "Bill of Materials" is a version management tool, not an SBOM.
* **Third-party dependencies:** The licenses of third-party dependencies are systematically verified in CI using the [Eclipse Dash License Tool](https://github.com/eclipse-dash/dash-licenses).

## 4. Modular architecture and maintenance

The CRA requires you to handle vulnerabilities throughout your product's support period. This is where Keyple's modularity helps:

* **BOM-Managed Components:** Keyple is organized into [multiple specialized components]({{< relref "/components/overview" >}}), versioned separately with their own lifecycles.
* **Rapid Patching:** If a vulnerability is detected in a specific component, the modular nature of Keyple allows for a surgical update. Developers can update the library version in their build configuration and redeploy their application without refactoring the entire ticketing logic.
* **Supported Versions:** As stated in the [maintenance policy]({{< relref "/community/maintenance" >}}) and the [security policy](https://github.com/eclipse-keyple/.github/blob/master/SECURITY.md), corrections and security fixes are provided for the latest major version of each Keyple component only. Minor and patch versions have no impact on your application, while a major version may require limited adaptations described in the [migration guides]({{< relref "/learn/user-guide/migration-guide" >}}).
* **Plan for Major Versions:** The CRA requires you to provide security updates throughout your product's support period (generally at least five years). Your maintenance plan should therefore include upgrading to new major versions of the Keyple components you use.

## 5. What to include in your technical documentation

For most products, the conformity assessment is carried out by the manufacturer itself. Some categories of important or critical products listed in the annexes of the CRA require the application of harmonised standards or an assessment by a third party: check the classification of your product.

Regarding Keyple, your technical documentation can rely on:
1. **Component inventory:** The Keyple components and versions used by your product, as listed in your SBOM.
2. **Vulnerability status:** The advisories published on the Eclipse Foundation [Known Vulnerabilities](https://www.eclipse.org/security/known/) page.
3. **Development process:** The peer-reviewed [contribution]({{< relref "/community/contributing" >}}) and [build/CI process]({{< relref "/learn/keyple-in-depth/build-and-ci" >}}).
4. **Maintenance:** The published [maintenance policy]({{< relref "/community/maintenance" >}}) and the centralized [Changelog]({{< relref "/community/changelog" >}}), which tracks every correction and security fix across components.

---

{{% callout note %}}
**The Bottom Line:**
You are responsible for the compliance of your final product, including the open-source components it integrates. **Keyple provides the transparency and processes that support this work:** coordinated vulnerability disclosure, automated quality checks, a published maintenance policy and a modular architecture that makes security updates easier, provided you keep up with the latest major version of each component.
{{% /callout %}}
