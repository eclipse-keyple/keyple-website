---
title: "Release 0.9.0 C++ on the field"
subtitle: ""
summary: "Version 0.9.0 of the Java implementation of Eclipse Keyple® was released January 26, 2021."
authors: [Calypso Networks Association]
tags: ["Eclipse", "Keyple", "Release", "OpenSource", "SDK", "API", "OpenSolutions", "Ticketing", "MaaS", "CNA"]
categories: [Release]
date: 2021-01-26T14:57:56+02:00
featured: false
draft: false
---

We are pleased to announce that the version 0.9.0 of the C++ implementation of Eclipse Keyple® was released January 26th, 2021.

This 0.9.0 C++ Keyple implementation follows the API design for the 0.9.0 Java Keyple implementation.
 - New simplifications are introduced on the Calypso API. Keyple 0.8 had a high-level API for building map commands, but the map response data needed to be parsed with a low-level API. The Calypso 0.9.0 API provided a high-level API for retrieving map response data from a map image for which the file structure could be browsed.
 - The Core 0.9.0 has also made the reader observation function more reliable in order to be notified in case of card withdrawal.  

[C++ API reference]({{< ref "../../docs-1.0/api-reference/cpp-api/" >}})

[Build your first C++ application]({{< ref "../../docs-1.0/build-your-first-app/cpp-app/" >}})


The source of Keyple C++ is available on [https://github.com/eclipse/keyple-cpp](https://github.com/eclipse/keyple-cpp).
Some dedicated support is provided on keyple.org:
 - [the documentation of the C++ API]({{< ref "../../docs-1.0/api-reference/cpp-api/" >}})
 - [a guide to Build a first C++ application]({{< ref "../../docs-1.0/build-your-first-app/cpp-app/" >}})
