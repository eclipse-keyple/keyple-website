---
title: Overview
subtitle: "Global Architecture of Keyple"
type: book
toc: false
weight: 100
---
{{% callout warning %}}
Version 1.0 of the documentation is no longer actively maintained. The site that you are currently viewing is an archived snapshot. For up-to-date documentation, see the latest version.
{{% /callout %}}

## About this documentation

This documentation is constantly evolving according to the feedback from its readers. Do not hesitate to [open a ticket](https://github.com/eclipse/keyple-website/issues) or to join our [mailing list](https://accounts.eclipse.org/mailing-list/keyple-dev) with questions and/or any topic you think deserves clarification or seems confusing.

## Global Architecture

{{< figure src="/media/archive-1.0/docs-overview/Keyple-components.svg" title="Global Architecture of Keyple" >}}

Keyple is currently divided in two major layers:
- The ‘Keyple Core' : a smart card API which allows managing smart card readers in a generic way, whaterver the reader driver or environment, and for standalone or distributed solution.
- A ‘Calypso Keyple extension' : a high-level Calypso Processing API allowing to operate commands with a Calypso Portable Object, and to manage a secure Calypso transaction.

Dedicated reader’s plugins have to be implemented in order to interface the Plugin API with the specific reader’s drivers.
