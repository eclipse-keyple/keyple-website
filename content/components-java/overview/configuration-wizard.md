---
title: Java - Configuration wizard
linktitle: Configuration wizard
summary: Online tool to generate the dependencies section of Gradle or Maven configuration files.
type: book
weight: 20
toc: true
---

---
This online tool generates for you the `dependencies` section of Gradle or Maven configuration files.
Choose your project profile and copy/paste the generated result into your project dependency manager.

What do you want to develop?
- [An application that uses existing Keyple components.](#client-application)
- [A specific Keyple reader plugin add-on not already available.](#reader-plugin-add-on)
- [A specific Keyple card extension add-on not already available.](#card-extension-add-on)
- [An alternate Keyple distributed solution add-on.](#distributed-solution-add-on)

---
## Client application
Please find below the configuration to use when developing an application that uses existing Keyple components:

- Which card extension do you want to use?
  >  <div>
  >    <input type="checkbox" id="cardGeneric" onclick="javascript:updateAppDependencies(1, this);">
  >    <label for="cardGeneric">Generic (with low-level API)</label>
  >  </div>
  >  <div>
  >    <input type="checkbox" id="cardCalypso" onclick="javascript:updateAppDependencies(1, this);">
  >    <label for="cardCalypso">Calypso Card</label>
  >  </div>
  >  <div>
  >    <input type="checkbox" id="cardCalypsoLegacySam" onclick="javascript:updateAppDependencies(1, this);">
  >    <label for="cardCalypsoLegacySam">Calypso Legacy SAM</label>
  >  </div>

- Which reader plugin do you want to use?
  >  <div>
  >    <input type="checkbox" id="pluginAndroidNfc" onclick="javascript:updateAppDependencies(1, this);">
  >    <label for="pluginAndroidNfc">Android NFC</label>
  >  </div>
  >  <div>
  >    <input type="checkbox" id="pluginAndroidOmapi" onclick="javascript:updateAppDependencies(1, this);">
  >    <label for="pluginAndroidOmapi">Android OMAPI</label>
  >  </div>
  >  <div>
  >    <input type="checkbox" id="pluginCardResource" onclick="javascript:updateAppDependencies(1, this);">
  >    <label for="pluginCardResource">Card Resource</label>
  >  </div>
  >  <div>
  >    <input type="checkbox" id="pluginPcsc" onclick="javascript:updateAppDependencies(1, this);">
  >    <label for="pluginPcsc">PC/SC</label>
  >  </div>
  >  <div>
  >    <input type="checkbox" id="pluginStub" onclick="javascript:updateAppDependencies(1, this);">
  >    <label for="pluginStub">Stub (simulated reader)</label>
  >  </div>

- In case of a distributed system, on which side is your application located?
  >  <div>
  >    <input type="checkbox" id="distributedLocal" onclick="javascript:updateAppDependencies(1, this);">
  >    <label for="distributedLocal">On the device <strong>having</strong> local access to the smart card reader</label>
  >  </div>
  >  <div>
  >    <input type="checkbox" id="distributedRemote" onclick="javascript:updateAppDependencies(1, this);">
  >    <label for="distributedRemote">On the device <strong>not having</strong> local access to the smart card reader</label>
  >  </div>

- Do you need additional services?
  >  <div>
  >    <input type="checkbox" id="serviceResource" onclick="javascript:updateAppDependencies(1, this);">
  >    <label for="serviceResource">Service for dynamic card resource allocation (e.g. for HSM or pool of readers)</label>
  >  </div>

{{< tabpane ref="1" >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}{{< /tab >}}
{{< tab header="Maven" lang="xml" >}}{{< /tab >}}
{{< /tabpane >}}

---
## Reader plugin add-on
Please find below the configuration to use when developing a specific Keyple reader plugin add-on not already available:
{{< tabpane ref="2" >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-version %}}'
implementation 'org.eclipse.keyple:keyple-plugin-java-api:{{% keyple-plugin-java-api-version %}}'
implementation 'org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-version %}}")
implementation("org.eclipse.keyple:keyple-plugin-java-api:{{% keyple-plugin-java-api-version %}}")
implementation("org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-version %}}")
{{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-common-java-api</artifactId>
  <version>{{% keyple-common-java-api-version %}}</version>
</dependency>
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-plugin-java-api</artifactId>
  <version>{{% keyple-plugin-java-api-version %}}</version>
</dependency>
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-util-java-lib</artifactId>
  <version>{{% keyple-util-java-lib-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}

---
## Card extension add-on
Please find below the configuration to use when developing a specific Keyple card extension add-on not already available:

- Do you need additional services?
  >  <div>
  >    <input type="checkbox" id="cardServiceResource" onclick="javascript:updateCardDependencies(3, this);">
  >    <label for="cardServiceResource">Service for dynamic card resource allocation (e.g. HSM or pool of readers)</label>
  >  </div>

{{< tabpane ref="3" >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}{{< /tab >}}
{{< tab header="Maven" lang="xml" >}}{{< /tab >}}
{{< /tabpane >}}

---
## Distributed solution add-on
Please find below the configuration to use when developing an alternate Keyple distributed solution add-on:

- **For the "Local Service" component:**
{{< tabpane ref="4" >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-version %}}'
implementation 'org.eclipse.keyple:keyple-distributed-local-java-api:{{% keyple-distributed-local-java-api-version %}}'
implementation 'org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-version %}}")
implementation("org.eclipse.keyple:keyple-distributed-local-java-api:{{% keyple-distributed-local-java-api-version %}}")
implementation("org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-version %}}")
{{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-common-java-api</artifactId>
  <version>{{% keyple-common-java-api-version %}}</version>
</dependency>
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-distributed-local-java-api</artifactId>
  <version>{{% keyple-distributed-local-java-api-version %}}</version>
</dependency>
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-util-java-lib</artifactId>
  <version>{{% keyple-util-java-lib-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}

- **For the "Remote Plugin" component:**
{{< tabpane ref="5" >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-version %}}'
implementation 'org.eclipse.keyple:keyple-distributed-remote-java-api:{{% keyple-distributed-remote-java-api-version %}}'
implementation 'org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-version %}}")
implementation("org.eclipse.keyple:keyple-distributed-remote-java-api:{{% keyple-distributed-remote-java-api-version %}}")
implementation("org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-version %}}")
{{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-common-java-api</artifactId>
  <version>{{% keyple-common-java-api-version %}}</version>
</dependency>
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-distributed-remote-java-api</artifactId>
  <version>{{% keyple-distributed-remote-java-api-version %}}</version>
</dependency>
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-util-java-lib</artifactId>
  <version>{{% keyple-util-java-lib-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}

<!-- All groovy dependencies -->
<code id="all-groovy-dependencies" style="display:none">
<span id="keyple-common-java-api">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-version %}}'</span></span>
<span id="keyple-service-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-service-java-lib:{{% keyple-service-java-lib-version %}}'</span></span>
<span id="keyple-service-resource-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-service-resource-java-lib:{{% keyple-service-resource-java-lib-version %}}'</span></span>
<span id="keyple-util-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-version %}}'</span></span>
<span id="keyple-card-calypso-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-card-calypso-java-lib:{{% keyple-card-calypso-java-lib-version %}}'</span></span>
<span id="keyple-card-calypso-crypto-legacysam-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-card-calypso-crypto-legacysam-java-lib:{{% keyple-card-calypso-crypto-legacysam-java-lib-version %}}'</span></span>
<span id="keyple-card-generic-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-card-generic-java-lib:{{% keyple-card-generic-java-lib-version %}}'</span></span>
<span id="keyple-distributed-local-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-distributed-local-java-lib:{{% keyple-distributed-local-java-lib-version %}}'</span></span>
<span id="keyple-distributed-network-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-distributed-network-java-lib:{{% keyple-distributed-network-java-lib-version %}}'</span></span>
<span id="keyple-distributed-remote-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-distributed-remote-java-lib:{{% keyple-distributed-remote-java-lib-version %}}'</span></span>
<span id="keyple-plugin-android-nfc-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-plugin-android-nfc-java-lib:{{% keyple-plugin-android-nfc-java-lib-version %}}'</span></span>
<span id="keyple-plugin-android-omapi-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-plugin-android-omapi-java-lib:{{% keyple-plugin-android-omapi-java-lib-version %}}'</span></span>
<span id="keyple-plugin-cardresource-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-plugin-cardresource-java-lib:{{% keyple-plugin-cardresource-java-lib-version %}}'</span></span>
<span id="keyple-plugin-pcsc-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-plugin-pcsc-java-lib:{{% keyple-plugin-pcsc-java-lib-version %}}'</span></span>
<span id="keyple-plugin-stub-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-plugin-stub-java-lib:{{% keyple-plugin-stub-java-lib-version %}}'</span></span>
<span id="calypsonet-terminal-reader-java-api">implementation <span class="hljs-string">'org.calypsonet.terminal:calypsonet-terminal-reader-java-api:{{% calypsonet-terminal-reader-java-api-version %}}'</span></span>
<span id="calypsonet-terminal-card-java-api">implementation <span class="hljs-string">'org.calypsonet.terminal:calypsonet-terminal-card-java-api:{{% calypsonet-terminal-card-java-api-version %}}'</span></span>
<span id="calypsonet-terminal-calypso-java-api">implementation <span class="hljs-string">'org.calypsonet.terminal:calypsonet-terminal-calypso-java-api:{{% calypsonet-terminal-calypso-java-api-version %}}'</span></span>
<span id="calypsonet-terminal-calypso-crypto-legacysam-java-api">implementation <span class="hljs-string">'org.calypsonet.terminal:calypsonet-terminal-calypso-crypto-legacysam-java-api:{{% calypsonet-terminal-calypso-crypto-legacysam-java-api-version %}}'</span></span>
</code>

<!-- All kotlin dependencies -->
<code id="all-kotlin-dependencies" style="display:none">
<span id="keyple-common-java-api">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-version %}}"</span>)</span>
<span id="keyple-service-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-service-java-lib:{{% keyple-service-java-lib-version %}}"</span>)</span>
<span id="keyple-service-resource-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-service-resource-java-lib:{{% keyple-service-resource-java-lib-version %}}"</span>)</span>
<span id="keyple-util-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-version %}}"</span>)</span>
<span id="keyple-card-calypso-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-card-calypso-java-lib:{{% keyple-card-calypso-java-lib-version %}}"</span>)</span>
<span id="keyple-card-calypso-crypto-legacysam-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-card-calypso-crypto-legacysam-java-lib:{{% keyple-card-calypso-crypto-legacysam-java-lib-version %}}"</span>)</span>
<span id="keyple-card-generic-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-card-generic-java-lib:{{% keyple-card-generic-java-lib-version %}}"</span>)</span>
<span id="keyple-distributed-local-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-distributed-local-java-lib:{{% keyple-distributed-local-java-lib-version %}}"</span>)</span>
<span id="keyple-distributed-network-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-distributed-network-java-lib:{{% keyple-distributed-network-java-lib-version %}}"</span>)</span>
<span id="keyple-distributed-remote-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-distributed-remote-java-lib:{{% keyple-distributed-remote-java-lib-version %}}"</span>)</span>
<span id="keyple-plugin-android-nfc-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-plugin-android-nfc-java-lib:{{% keyple-plugin-android-nfc-java-lib-version %}}"</span>)</span>
<span id="keyple-plugin-android-omapi-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-plugin-android-omapi-java-lib:{{% keyple-plugin-android-omapi-java-lib-version %}}"</span>)</span>
<span id="keyple-plugin-cardresource-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-plugin-cardresource-java-lib:{{% keyple-plugin-cardresource-java-lib-version %}}"</span>)</span>
<span id="keyple-plugin-pcsc-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-plugin-pcsc-java-lib:{{% keyple-plugin-pcsc-java-lib-version %}}"</span>)</span>
<span id="keyple-plugin-stub-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-plugin-stub-java-lib:{{% keyple-plugin-stub-java-lib-version %}}"</span>)</span>
<span id="calypsonet-terminal-reader-java-api">implementation(<span class="hljs-string">"org.calypsonet.terminal:calypsonet-terminal-reader-java-api:{{% calypsonet-terminal-reader-java-api-version %}}"</span>)</span>
<span id="calypsonet-terminal-card-java-api">implementation(<span class="hljs-string">"org.calypsonet.terminal:calypsonet-terminal-card-java-api:{{% calypsonet-terminal-card-java-api-version %}}"</span>)</span>
<span id="calypsonet-terminal-calypso-java-api">implementation(<span class="hljs-string">"org.calypsonet.terminal:calypsonet-terminal-calypso-java-api:{{% calypsonet-terminal-calypso-java-api-version %}}"</span>)</span>
<span id="calypsonet-terminal-calypso-crypto-legacysam-java-api">implementation(<span class="hljs-string">"org.calypsonet.terminal:calypsonet-terminal-calypso-crypto-legacysam-java-api:{{% calypsonet-terminal-calypso-crypto-legacysam-java-api-version %}}"</span>)</span>
</code>

<!-- All maven dependencies -->
<code id="all-maven-dependencies" style="display:none">
<span id="keyple-common-java-api"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-common-java-api<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-common-java-api-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-service-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-service-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-service-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-service-resource-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-service-resource-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-service-resource-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-util-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-util-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-util-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-card-calypso-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-card-calypso-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-card-calypso-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-card-calypso-crypto-legacysam-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-card-calypso-crypto-legacysam-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-card-calypso-crypto-legacysam-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-card-generic-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-card-generic-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-card-generic-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-distributed-local-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-distributed-local-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-distributed-local-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-distributed-network-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-distributed-network-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-distributed-network-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-distributed-remote-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-distributed-remote-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-distributed-remote-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-plugin-android-nfc-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-plugin-android-nfc-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-plugin-android-nfc-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-plugin-android-omapi-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-plugin-android-omapi-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-plugin-android-omapi-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-plugin-cardresource-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-plugin-cardresource-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-plugin-cardresource-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-plugin-pcsc-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-plugin-pcsc-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-plugin-pcsc-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-plugin-stub-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-plugin-stub-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-plugin-stub-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="calypsonet-terminal-reader-java-api"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.calypsonet.terminal<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>calypsonet-terminal-reader-java-api<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% calypsonet-terminal-reader-java-api-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="calypsonet-terminal-card-java-api"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.calypsonet.terminal<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>calypsonet-terminal-card-java-api<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% calypsonet-terminal-card-java-api-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="calypsonet-terminal-calypso-java-api"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.calypsonet.terminal<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>calypsonet-terminal-calypso-java-api<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% calypsonet-terminal-calypso-java-api-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="calypsonet-terminal-calypso-crypto-legacysam-java-api"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.calypsonet.terminal<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>calypsonet-terminal-calypso-crypto-legacysam-java-api<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
&nbsp;&nbsp;<span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% calypsonet-terminal-calypso-crypto-legacysam-java-api-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
</code>
<script type="text/javascript">
document.body.onload = function() {
    updateAppDependencies(1, null);
    updateCardDependencies(3, null);
};
</script>