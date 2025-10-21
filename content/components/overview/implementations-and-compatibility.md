---
title: Keyple Implementations & Compatibility
linktitle: Implementations
summary: A list all components provided by the project, along with their availability in both Java and C++ languages.
type: book
weight: 12
toc: false
---
<style>
table th:nth-child(1) {
  width: 20rem;
}
table th:nth-child(2), table th:nth-child(3) {
  width: 3rem;
}
.table td {
    padding-top: 0;
    padding-bottom: 0;
}
.item {
  margin-left: 1rem;
}
</style>

<br>

Keyple components are available in multiple languages and configurations.

All **Java components** released after **April 2024** are compiled with **Java API level 8**, ensuring compatibility with any platform running **Java SE 8+**, as well as with **Android 7+** systems.

**C++ components** are developed in compliance with the **C++ 11** standard, ensuring wide portability and interoperability across modern C++ environments.

| Component                                                                                                                                                    | Java | C++ | KMP |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------|:----:|:---:|-----|
| **Core**                                                                                                                                                     |      |     |     |
| <span class="item" />[Common API]({{< relref "/components/core/keyple-common-api" >}})                                                                       |  ✅   |  ✅  |     |
| <span class="item" />[Distributed Local API]({{< relref "/components/core/keyple-distributed-local-api" >}})                                                 |  ✅   |     |     |
| <span class="item" />[Distributed Remote API]({{< relref "/components/core/keyple-distributed-remote-api" >}})                                               |  ✅   |     |     |
| <span class="item" />[Plugin API]({{< relref "/components/core/keyple-plugin-api" >}})                                                                       |  ✅   |  ✅  |     |
| <span class="item" />[Plugin Storage Card API]({{< relref "/components/core/keyple-plugin-storagecard-api" >}})                                              |  ✅   |     |     |
| <span class="item" />[Service Library]({{< relref "/components/core/keyple-service-lib" >}})                                                                 |  ✅   |  ✅  |     |
| <span class="item" />[Service Resource Library]({{< relref "/components/core/keyple-service-resource-lib" >}})                                               |  ✅   |  ✅  |     |
| <span class="item" />[Util Library]({{< relref "/components/core/keyple-util-lib" >}})                                                                       |  ✅   |  ✅  |     |
| **Distributed Systems**                                                                                                                                      |      |     |     |
| <span class="item" />[Distributed Local Library]({{< relref "/components/distributed/keyple-distributed-local-lib" >}})                                      |  ✅   |     |     |
| <span class="item" />[Distributed Network Library]({{< relref "/components/distributed/keyple-distributed-network-lib" >}})                                  |  ✅   |     |     |
| <span class="item" />[Distributed Remote Library]({{< relref "/components/distributed/keyple-distributed-remote-lib" >}})                                    |  ✅   |     |     |
| **Card Extensions**                                                                                                                                          |      |     |     |
| <span class="item" />[Card Calypso Library]({{< relref "/components/card-extensions/keyple-card-calypso-lib" >}})                                            |  ✅   |  ✅  |     |
| <span class="item" />[Card Calypso Crypto Legacy SAM Library]({{< relref "/components/card-extensions/keyple-card-calypso-crypto-legacysam-lib" >}})         |  ✅   |  ✅  |     |
| <span class="item" />[Card Calypso Crypto PKI Library]({{< relref "/components/card-extensions/keyple-card-calypso-crypto-pki-lib" >}})                      |  ✅   |     |     |
| <span class="item" />[Card Generic Library]({{< relref "/components/card-extensions/keyple-card-generic-lib" >}})                                            |  ✅   |  ✅  |     |
| **Standard Reader Plugins**                                                                                                                                  |      |     |     |
| <span class="item" />[Plugin Android NFC Library]({{< relref "/components/standard-reader-plugins/keyple-plugin-android-nfc-lib" >}})                        |  ✅   |     |     |
| <span class="item" />[Plugin Android OMAPI Library]({{< relref "/components/standard-reader-plugins/keyple-plugin-android-omapi-lib" >}})                    |  ✅   |     |     |
| <span class="item" />[Plugin Card Resource Library]({{< relref "/components/standard-reader-plugins/keyple-plugin-cardresource-lib" >}})                     |  ✅   |     |     |
| <span class="item" />[Plugin PC/SC Library]({{< relref "/components/standard-reader-plugins/keyple-plugin-pcsc-lib" >}})                                     |  ✅   |  ✅  |     |
| <span class="item" />[Plugin Stub Library]({{< relref "/components/standard-reader-plugins/keyple-plugin-stub-lib" >}})                                      |  ✅   |  ✅  |     |
| **Interop Components**                                                                                                                                       |      |     |     |
| <span class="item" />[Interop JSON API Client Library]({{< relref "/components/interop-components/keyple-interop-jsonapi-client-kmp-lib" >}})                |      |     | ✅   |
| <span class="item" />[Interop Local Reader NFC Mobile Library]({{< relref "/components/interop-components/keyple-interop-localreader-nfcmobile-kmp-lib" >}}) |      |     | ✅   |
