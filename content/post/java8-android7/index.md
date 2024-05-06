---
title: "Keyple goes Java 8, Android 7.0!"
summary: "Keyple project adapts libraries to Java 8 and Android 7.0, reflecting evolving development needs."
authors: [Calypso Networks Association]
tags: ["Eclipse", "Keyple", "Keypop", "Release", "OpenSource", "Middleware", "API", "Ticketing"]
categories: [Release]
date: 2024-05-06T00:00:00+01:00
featured: false
draft: false
---

All Keyple components have been updated to set the minimum API level to **Java 8** 
and **Android 7.0 Nougat (API Level 24)**.

This update was necessary to resolve compatibility issues with modern code analysis and continuous integration tools.
Many cutting-edge development tools like SonarCloud no longer support older Java versions.
Keyple components were still based on Java 6, causing errors and preventing complete code analysis when integrated 
with these tools. 

The decision to update the Keyple project's libraries to Java 8 and Android 7.0 Nougat reflects the evolving landscape 
of development environments. 
With the diminishing presence of Java 6 and Android versions prior to 7 in the installed base, 
continuing support for these older platforms is no longer warranted.