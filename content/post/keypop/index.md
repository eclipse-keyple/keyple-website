---
title: "Keyple adopts the Eclipse Keypop API!"
summary: "The Keyple SDK is enhanced by the Eclipse Keypop project with new UML-compliant interfaces and APIs, offering 
new possibilities for the management of SAMs and PKI cards."
authors: [Calypso Networks Association]
tags: ["Eclipse", "Keyple", "Keypop", "Release", "OpenSource", "SDK", "API", "Ticketing"]
categories: [Release]
date: 2023-11-29T12:00:00+01:00
featured: false
draft: false
---

The field of compliance management for ticketing terminals has recently seen a paradigm shift with the launch of the
[Eclipse Keypop](https://keypop.org) project.

This initiative defines a series of UML-compliant interfaces established by
the [Calypso Networks Association](https://calypsonet.org).

As a result, the Keyple SDK components are upgraded to a new version, which adopts the Keypop APIs in place of the CNA
Terminal APIs.

As well as implementing these new APIs, this upgrade removes classes and methods previously marked as deprecated and
brings a number of additional improvements.

The main enhancement is the processing of Calypso cards.

Keypop introduces new APIs for managing cryptographic components, in particular SAMs and PKI service providers.

These innovations pave the way for a wide range of new solutions, particularly in view of the forthcoming **Open SAM**
and **PKI-based card transactions**.

For this purpose, the **Calypso Card** library and the new **Calypso Legacy SAM** library are now based on these new
Keypop APIs.

Details of changes to Keyple components are described in the CHANGELOG files at the root of each corresponding
repository and the Keyple website has been updated accordingly.

Here is the list of components affected by the Keypop update:

For more information, please visit the component
[page]({{< relref "/components/core/keyple-service-lib" >}}).