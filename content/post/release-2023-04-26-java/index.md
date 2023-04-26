---
title: "Keyple Plugin Card Resource Java Lib (1.0.0) is available!"
summary: "Published on April 26, 2023, this new component is a 'PoolPlugin' to manage readers provided by the
    'Card Resource Service'. Its role is to allow remote access to the 'Card Resource Service' via the 
    'Keyple Distributed Solution' components."
authors: [Calypso Networks Association]
tags: ["Eclipse", "Keyple", "Release", "OpenSource", "SDK", "API", "Ticketing", "Plugin", "Card Resource Service"]
categories: [Release]
date: 2023-04-26T12:00:00+01:00
featured: false
draft: false
---

Published on April 26, 2023, this new component is a **PoolPlugin** to manage readers provided by the
**Card Resource Service**.

The main role of the plugin is to allow remote access to the **Card Resource Service** via the **Keyple Distributed
Solution** components.
It provides an interface for allocating and deallocating readers by profiles that are part of those configured at the
**Card Resource Service** level.

A typical use would be for the realization of a server providing cryptographic services through a pool of SAMs, each
inserted in a dedicated PC/SC reader.

To realize this plugin it was necessary to make evolve the following components:
- [**Keyple Plugin Java API**]({{< relref "/components-java/core/keyple-plugin-java-api" >}}) (2.1.0)
- [**Keyple Service Java Lib**]({{< relref "/components-java/core/keyple-service-java-lib" >}}) (2.2.0)
- [**Keyple Service Resource Java Lib**]({{< relref "/components-java/core/keyple-service-resource-java-lib" >}}) (2.1.0)

For more information, please visit the component
[page]({{< ref "components-java/standard-reader-plugins/keyple-plugin-cardresource-java-lib" >}}).