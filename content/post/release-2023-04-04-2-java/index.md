---
title: "Keyple Distributed Solution (2.2.0) is available!"
summary: "Published on April 04, 2023, this version introduces improved network communication with updated JSON object 
    serialization in 'Distributed' solution and enhanced readability with 'lowerCamelCase' formatting for JSON property 
    names."
authors: [Calypso Networks Association]
tags: ["Eclipse", "Keyple", "Release", "OpenSource", "SDK", "API", "Ticketing", "Distributed"]
categories: [Release]
date: 2023-04-04T13:00:00+01:00
featured: false
draft: false
---

Published on April 04, 2023,
one of the key changes in this release is that objects transmitted through the network for the "Distributed" solution 
are now serialized/de-serialized as JSON objects, and no longer as strings containing JSON objects. 
This change will enhance the efficiency of the software, and help ensure a smoother and more reliable network 
communication.

In addition, all JSON property names are now formatted as "lowerCamelCase", providing a more consistent and 
easier-to-read format for the users.

For more information, please visit the components pages:
- [Keyple Distributed Network Library]({{< ref "components-java/distributed/keyple-distributed-network-java-lib" >}})
- [Keyple Distributed Local Library]({{< ref "components-java/distributed/keyple-distributed-local-java-lib" >}})
- [Keyple Distributed Remote Library]({{< ref "components-java/distributed/keyple-distributed-remote-java-lib" >}})
- [Keyple Service Library]({{< ref "components-java/core/keyple-service-java-lib" >}})