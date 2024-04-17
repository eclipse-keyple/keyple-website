---
title: "Keyple adopts the Eclipse Keypop API!"
summary: "The Keyple SDK is enhanced by the Eclipse Keypop project with new UML-compliant interfaces and APIs, offering 
    new possibilities for the management of SAMs and PKI cards."
authors: [Calypso Networks Association]
tags: ["Eclipse", "Keyple", "Keypop", "Release", "OpenSource", "Middleware", "API", "Ticketing"]
categories: [Release]
date: 2023-11-28T12:00:00+01:00
featured: false
draft: false
---

The field of compliance management for ticketing terminals has recently seen a paradigm shift with the launch of the
[Eclipse Keypop](https://eclipse-keypop.github.io/keypop-website) project.
This initiative defines a series of UML-compliant interfaces established by
the [Calypso Networks Association](https://calypsonet.org).

As a result, the Keyple SDK components are upgraded to a new version, which adopts the Keypop APIs in place of the CNA
Terminal APIs.
As well as implementing these new APIs, this upgrade removes classes and methods previously marked as deprecated and
brings a number of additional improvements.
The main enhancement is the processing of Calypso cards.

Keypop introduces new APIs for managing cryptographic components, in particular SAMs and PKI service providers.

These innovations pave the way for new solutions, particularly in view of the forthcoming **Open SAM**
and **PKI-based card transactions**.

For this purpose, the **Calypso Card** library and the new **Calypso Legacy SAM** library are now based on these new
Keypop APIs.
Details of changes to Keyple components are described in the CHANGELOG files at the root of each corresponding
repository and the Keyple website has been updated accordingly.

Here is the list of libraries affected by the Keypop update:
- Core
  - [Service]({{< relref "/components/core/keyple-service-lib" >}})
  - [Service Resource]({{< relref "/components/core/keyple-service-resource-lib" >}})
- Card extension add-ons
  - [Calypso Card]({{< relref "/components/card-extensions/keyple-card-calypso-lib" >}})
  - [Calypso Legacy SAM]({{< relref "/components/card-extensions/keyple-card-calypso-crypto-legacysam-lib" >}})
  - [Generic]({{< relref "/components/card-extensions/keyple-card-generic-lib" >}})
- Reader plugin add-ons
  - [Card Resource]({{< relref "/components/standard-reader-plugins/keyple-plugin-cardresource-lib" >}})
- Distributed add-ons
  - [Local]({{< relref "/components/distributed/keyple-distributed-local-lib" >}})
  - [Network]({{< relref "/components/distributed/keyple-distributed-network-lib" >}})
  - [Remote]({{< relref "/components/distributed/keyple-distributed-remote-lib" >}})