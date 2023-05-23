---
title: "Keyple Service Java Lib (2.3.0) is available!"
summary: "Published on May 22, 2023, this minor version implements the 'Calypsonet Terminal Reader Java API (1.3.0)'
    and therefore introduced a new capability to export a locally processed card selection scenario to be imported and 
    analyzed remotely by another card selection manager."
authors: [Calypso Networks Association]
tags: ["Eclipse", "Keyple", "Release", "OpenSource", "SDK", "API", "Ticketing"]
categories: [Release]
date: 2023-05-22T12:00:00+01:00
featured: false
draft: false
---

Published on May 22, 2023, this minor version implements the
[Calypsonet Terminal Reader Java API (1.3.0)](https://terminal-api.calypsonet.org/apis/calypsonet-terminal-reader-api/)
and therefore introduced a new capability to export a locally processed card selection scenario to be imported and 
analyzed remotely by another card selection manager.

For this purpose, the following two methods have been added to the `CardSelectionManager` interface:
- `exportProcessedCardSelectionScenario`
- `importProcessedCardSelectionScenario`.

For more information, please visit the component
[page]({{< relref "/components-java/core/keyple-service-java-lib" >}}).