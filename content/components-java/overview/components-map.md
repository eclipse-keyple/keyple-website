---
title: Java - Components map
linktitle: Components map
summary: General presentation of the dependencies between the different Keyple components.
type: book
weight: 10
toc: false
---

---
The dependencies between the Keyple components are shown in the diagram below:

{{< figure src="/media/learn/developer-guide/component-dependencies/component_dependencies_overview.drawio.svg" caption="" numbered="" >}}

Here are the most important things to remember:
* Each component has its **own life cycle**.
* There are two types of Keyple components: **APIs** and **libraries**.
* Some APIs are provided by Calypso Networks Association.
* APIs contain **only interfaces**.
* Libraries contain **interfaces and their implementation**.
* Some APIs are **public** while others are **internal**.
* All libraries are **public**.
* All **libraries** and **public APIs** can be used by the developer of the client application.
* The **internal APIs** are intended for the developer of Keyple add-ons only (e.g. custom reader plugin, custom card extension or custom distributed solution). 
