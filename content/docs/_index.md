---
title: Overview
type: book
toc: false
weight: 100
---

---

The diagram below shows the global architecture of the **Eclipse Keyple™** solution:

{{< figure library="true" src="docs-overview//Keyple-components.svg" title="Global Architecture of Eclipse Keyple™" >}}

**Eclipse Keyple™** is currently divided in two major layers:
- The **Keyple Core**: a smart card API which allows managing smart card readers in a generic way, whatever the reader driver or environment, and for standalone or distributed solution.
- A **Calypso Keyple extension**: a high level Calypso Processing API allowing to operate commands with a Calypso Portable Object, and to manage a secure Calypso transaction.

Dedicated reader’s plugins have to be implemented in order to interface the Plugin API with the specific reader’s drivers.
