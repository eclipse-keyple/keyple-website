---
title: Java - Configuration wizard
linktitle: Configuration wizard
summary: Online tool to generate the dependencies section of Gradle or Maven configuration files.
type: book
weight: 20
toc: false
---

---
This online tool generates for you the `dependencies` section of Gradle or Maven configuration files.

Choose your project profile and copy/paste the generated result into your project dependency manager.

{{< spoiler text="Client application" >}}
Please find below the configuration to use when developing an application that uses existing Keyple components:

---
**Which card extension do you want to use?**
<div>
  <input type="checkbox" id="cardGeneric" onclick="javascript:updateAppDependencies(1, this);">
  <label for="cardGeneric">Generic (with low level API)</label>
</div>
<div>
  <input type="checkbox" id="cardCalypso" onclick="javascript:updateAppDependencies(1, this);">
  <label for="cardCalypso">Calypso</label>
</div>

---
**Which reader plugin do you want to use?**
<div>
  <input type="checkbox" id="pluginAndroidNfc" onclick="javascript:updateAppDependencies(1, this);">
  <label for="pluginAndroidNfc">Android NFC</label>
</div>
<div>
  <input type="checkbox" id="pluginAndroidOmapi" onclick="javascript:updateAppDependencies(1, this);">
  <label for="pluginAndroidOmapi">Android OMAPI</label>
</div>
<div>
  <input type="checkbox" id="pluginPcsc" onclick="javascript:updateAppDependencies(1, this);">
  <label for="pluginPcsc">PC/SC</label>
</div>
<div>
  <input type="checkbox" id="pluginStub" onclick="javascript:updateAppDependencies(1, this);">
  <label for="pluginStub">Stub (simulated reader)</label>
</div>

---
**In case of a distributed system, on which side is your application located?**
<div>
  <input type="checkbox" id="distributedLocal" onclick="javascript:updateAppDependencies(1, this);">
  <label for="distributedLocal">On the device <strong>having</strong> local access to the smart card reader</label>
</div>
<div>
  <input type="checkbox" id="distributedRemote" onclick="javascript:updateAppDependencies(1, this);">
  <label for="distributedRemote">On the device <strong>not having</strong> local access to the smart card reader</label>
</div>

---
**Do you need additional services?**
<div>
  <input type="checkbox" id="serviceResource" onclick="javascript:updateAppDependencies(1, this);">
  <label for="serviceResource">Service for dynamic card resource allocation (e.g. for HSM or pool of readers)</label>
</div>

---
{{< tabpane ref="1" >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}{{< /tab >}}
{{< tab header="Maven" lang="xml" >}}{{< /tab >}}
{{< /tabpane >}}
{{< /spoiler >}}

{{< spoiler text="Custom Keyple card extension" >}}
Please find below the configuration to use when developing a specific Keyple card extension not already available:

---
**Do you need additional services?**
<div>
  <input type="checkbox" id="cardServiceResource" onclick="javascript:updateCardDependencies(2, this);">
  <label for="cardServiceResource">Service for dynamic card resource allocation (e.g. HSM or pool of readers)</label>
</div>

---
{{< tabpane ref="2" >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}{{< /tab >}}
{{< tab header="Maven" lang="xml" >}}{{< /tab >}}
{{< /tabpane >}}
{{< /spoiler >}}

{{< spoiler text="Custom Keyple reader plugin" >}}
Please find below the configuration to use when developing a specific Keyple reader plugin not already available:
{{< tabpane ref="3" >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-dynamic-gradle-version %}}'
implementation 'org.eclipse.keyple:keyple-plugin-java-api:{{% keyple-plugin-java-api-dynamic-gradle-version %}}'
implementation 'org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-dynamic-gradle-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-dynamic-gradle-version %}}")
implementation("org.eclipse.keyple:keyple-plugin-java-api:{{% keyple-plugin-java-api-dynamic-gradle-version %}}")
implementation("org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-dynamic-gradle-version %}}")
{{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-common-java-api</artifactId>
  <version>{{% keyple-common-java-api-dynamic-maven-version %}}</version>
</dependency>
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-plugin-java-api</artifactId>
  <version>{{% keyple-plugin-java-api-dynamic-maven-version %}}</version>
</dependency>
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-util-java-lib</artifactId>
  <version>{{% keyple-util-java-lib-dynamic-maven-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}
{{< /spoiler >}}

{{< spoiler text="Custom Keyple distributed solution" >}}
Please find below the configuration to use when developing an alternate Keyple distributed solution:

---
For the **Local Service** component:
{{< tabpane ref="4" >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-dynamic-gradle-version %}}'
implementation 'org.eclipse.keyple:keyple-distributed-local-java-api:{{% keyple-distributed-local-java-api-dynamic-gradle-version %}}'
implementation 'org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-dynamic-gradle-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-dynamic-gradle-version %}}")
implementation("org.eclipse.keyple:keyple-distributed-local-java-api:{{% keyple-distributed-local-java-api-dynamic-gradle-version %}}")
implementation("org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-dynamic-gradle-version %}}")
{{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-common-java-api</artifactId>
  <version>{{% keyple-common-java-api-dynamic-maven-version %}}</version>
</dependency>
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-distributed-local-java-api</artifactId>
  <version>{{% keyple-distributed-local-java-api-dynamic-maven-version %}}</version>
</dependency>
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-util-java-lib</artifactId>
  <version>{{% keyple-util-java-lib-dynamic-maven-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}

---
For the **Remote Plugin** component:
{{< tabpane ref="5" >}}
{{< tab header="Gradle Groovy" lang="gradle" >}}
implementation 'org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-dynamic-gradle-version %}}'
implementation 'org.eclipse.keyple:keyple-distributed-remote-java-api:{{% keyple-distributed-remote-java-api-dynamic-gradle-version %}}'
implementation 'org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-dynamic-gradle-version %}}'
{{< /tab >}}
{{< tab header="Gradle Kotlin" lang="kotlin" >}}
implementation("org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-dynamic-gradle-version %}}")
implementation("org.eclipse.keyple:keyple-distributed-remote-java-api:{{% keyple-distributed-remote-java-api-dynamic-gradle-version %}}")
implementation("org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-dynamic-gradle-version %}}")
{{< /tab >}}
{{< tab header="Maven" lang="xml" >}}
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-common-java-api</artifactId>
  <version>{{% keyple-common-java-api-dynamic-maven-version %}}</version>
</dependency>
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-distributed-remote-java-api</artifactId>
  <version>{{% keyple-distributed-remote-java-api-dynamic-maven-version %}}</version>
</dependency>
<dependency>
  <groupId>org.eclipse.keyple</groupId>
  <artifactId>keyple-util-java-lib</artifactId>
  <version>{{% keyple-util-java-lib-dynamic-maven-version %}}</version>
</dependency>
{{< /tab >}}
{{< /tabpane >}}
{{< /spoiler >}}

<!-- All groovy dependencies -->
<code id="all-groovy-dependencies" style="display:none">
<span id="keyple-common-java-api">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-dynamic-gradle-version %}}'</span></span>
<span id="keyple-distributed-local-java-api">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-distributed-local-java-api:{{% keyple-distributed-local-java-api-dynamic-gradle-version %}}'</span></span>
<span id="keyple-distributed-remote-java-api">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-distributed-remote-java-api:{{% keyple-distributed-remote-java-api-dynamic-gradle-version %}}'</span></span>
<span id="keyple-plugin-java-api">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-plugin-java-api:{{% keyple-plugin-java-api-dynamic-gradle-version %}}'</span></span>
<span id="keyple-service-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-service-java-lib:{{% keyple-service-java-lib-version %}}'</span></span>
<span id="keyple-service-resource-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-service-resource-java-lib:{{% keyple-service-resource-java-lib-version %}}'</span></span>
<span id="keyple-util-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-dynamic-gradle-version %}}'</span></span>
<span id="keyple-card-calypso-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-card-calypso-java-lib:{{% keyple-card-calypso-java-lib-version %}}'</span></span>
<span id="keyple-card-generic-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-card-generic-java-lib:{{% keyple-card-generic-java-lib-version %}}'</span></span>
<span id="keyple-distributed-local-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-distributed-local-java-lib:{{% keyple-distributed-local-java-lib-version %}}'</span></span>
<span id="keyple-distributed-network-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-distributed-network-java-lib:{{% keyple-distributed-network-java-lib-version %}}'</span></span>
<span id="keyple-distributed-remote-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-distributed-remote-java-lib:{{% keyple-distributed-remote-java-lib-version %}}'</span></span>
<span id="keyple-plugin-android-nfc-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-plugin-android-nfc-java-lib:{{% keyple-plugin-android-nfc-java-lib-version %}}'</span></span>
<span id="keyple-plugin-android-omapi-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-plugin-android-omapi-java-lib:{{% keyple-plugin-android-omapi-java-lib-version %}}'</span></span>
<span id="keyple-plugin-pcsc-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-plugin-pcsc-java-lib:{{% keyple-plugin-pcsc-java-lib-version %}}'</span></span>
<span id="keyple-plugin-stub-java-lib">implementation <span class="hljs-string">'org.eclipse.keyple:keyple-plugin-stub-java-lib:{{% keyple-plugin-stub-java-lib-version %}}'</span></span>
<span id="calypsonet-terminal-reader-java-api">implementation <span class="hljs-string">'org.calypsonet.terminal:calypsonet-terminal-reader-java-api:{{% calypsonet-terminal-reader-java-api-dynamic-gradle-version %}}'</span></span>
<span id="calypsonet-terminal-card-java-api">implementation <span class="hljs-string">'org.calypsonet.terminal:calypsonet-terminal-card-java-api:{{% calypsonet-terminal-card-java-api-dynamic-gradle-version %}}'</span></span>
<span id="calypsonet-terminal-calypso-java-api">implementation <span class="hljs-string">'org.calypsonet.terminal:calypsonet-terminal-calypso-java-api:{{% calypsonet-terminal-calypso-java-api-dynamic-gradle-version %}}'</span></span>
</code>

<!-- All kotlin dependencies -->
<code id="all-kotlin-dependencies" style="display:none">
<span id="keyple-common-java-api">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-dynamic-gradle-version %}}"</span>)</span>
<span id="keyple-distributed-local-java-api">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-distributed-local-java-api:{{% keyple-distributed-local-java-api-dynamic-gradle-version %}}"</span>)</span>
<span id="keyple-distributed-remote-java-api">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-distributed-remote-java-api:{{% keyple-distributed-remote-java-api-dynamic-gradle-version %}}"</span>)</span>
<span id="keyple-plugin-java-api">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-plugin-java-api:{{% keyple-plugin-java-api-dynamic-gradle-version %}}"</span>)</span>
<span id="keyple-service-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-service-java-lib:{{% keyple-service-java-lib-version %}}"</span>)</span>
<span id="keyple-service-resource-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-service-resource-java-lib:{{% keyple-service-resource-java-lib-version %}}"</span>)</span>
<span id="keyple-util-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-dynamic-gradle-version %}}"</span>)</span>
<span id="keyple-card-calypso-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-card-calypso-java-lib:{{% keyple-card-calypso-java-lib-version %}}"</span>)</span>
<span id="keyple-card-generic-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-card-generic-java-lib:{{% keyple-card-generic-java-lib-version %}}"</span>)</span>
<span id="keyple-distributed-local-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-distributed-local-java-lib:{{% keyple-distributed-local-java-lib-version %}}"</span>)</span>
<span id="keyple-distributed-network-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-distributed-network-java-lib:{{% keyple-distributed-network-java-lib-version %}}"</span>)</span>
<span id="keyple-distributed-remote-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-distributed-remote-java-lib:{{% keyple-distributed-remote-java-lib-version %}}"</span>)</span>
<span id="keyple-plugin-android-nfc-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-plugin-android-nfc-java-lib:{{% keyple-plugin-android-nfc-java-lib-version %}}"</span>)</span>
<span id="keyple-plugin-android-omapi-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-plugin-android-omapi-java-lib:{{% keyple-plugin-android-omapi-java-lib-version %}}"</span>)</span>
<span id="keyple-plugin-pcsc-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-plugin-pcsc-java-lib:{{% keyple-plugin-pcsc-java-lib-version %}}"</span>)</span>
<span id="keyple-plugin-stub-java-lib">implementation(<span class="hljs-string">"org.eclipse.keyple:keyple-plugin-stub-java-lib:{{% keyple-plugin-stub-java-lib-version %}}"</span>)</span>
<span id="calypsonet-terminal-reader-java-api">implementation(<span class="hljs-string">"org.calypsonet.terminal:calypsonet-terminal-reader-java-api:{{% calypsonet-terminal-reader-java-api-dynamic-gradle-version %}}"</span>)</span>
<span id="calypsonet-terminal-card-java-api">implementation(<span class="hljs-string">"org.calypsonet.terminal:calypsonet-terminal-card-java-api:{{% calypsonet-terminal-card-java-api-dynamic-gradle-version %}}"</span>)</span>
<span id="calypsonet-terminal-calypso-java-api">implementation(<span class="hljs-string">"org.calypsonet.terminal:calypsonet-terminal-calypso-java-api:{{% calypsonet-terminal-calypso-java-api-dynamic-gradle-version %}}"</span>)</span>
</code>

<!-- All maven dependencies -->
<code id="all-maven-dependencies" style="display:none">
<span id="keyple-common-java-api"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-common-java-api<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-common-java-api-dynamic-maven-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-distributed-local-java-api"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-distributed-local-java-api<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-distributed-local-java-api-dynamic-maven-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-distributed-remote-java-api"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-distributed-remote-java-api<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-distributed-remote-java-api-dynamic-maven-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-plugin-java-api"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-plugin-java-api<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-plugin-java-api-dynamic-maven-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-service-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-service-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-service-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-service-resource-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-service-resource-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-service-resource-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-util-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-util-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-util-java-lib-dynamic-maven-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-card-calypso-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-card-calypso-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-card-calypso-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-card-generic-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-card-generic-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-card-generic-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-distributed-local-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-distributed-local-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-distributed-local-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-distributed-network-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-distributed-network-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-distributed-network-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-distributed-remote-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-distributed-remote-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-distributed-remote-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-plugin-android-nfc-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-plugin-android-nfc-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-plugin-android-nfc-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-plugin-android-omapi-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-plugin-android-omapi-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-plugin-android-omapi-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-plugin-pcsc-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-plugin-pcsc-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-plugin-pcsc-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="keyple-plugin-stub-java-lib"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.eclipse.keyple<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>keyple-plugin-stub-java-lib<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% keyple-plugin-stub-java-lib-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="calypsonet-terminal-reader-java-api"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.calypsonet.terminal<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>calypsonet-terminal-reader-java-api<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% calypsonet-terminal-reader-java-api-dynamic-maven-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="calypsonet-terminal-card-java-api"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.calypsonet.terminal<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>calypsonet-terminal-card-java-api<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% calypsonet-terminal-card-java-api-dynamic-maven-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
<span id="calypsonet-terminal-calypso-java-api"><span class="hljs-tag">&lt;<span class="hljs-name">dependency</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">groupId</span>&gt;</span>org.calypsonet.terminal<span class="hljs-tag">&lt;/<span class="hljs-name">groupId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">artifactId</span>&gt;</span>calypsonet-terminal-calypso-java-api<span class="hljs-tag">&lt;/<span class="hljs-name">artifactId</span>&gt;</span>
  <span class="hljs-tag">&lt;<span class="hljs-name">version</span>&gt;</span>{{% calypsonet-terminal-calypso-java-api-dynamic-maven-version %}}<span class="hljs-tag">&lt;/<span class="hljs-name">version</span>&gt;</span>
<span class="hljs-tag">&lt;/<span class="hljs-name">dependency</span>&gt;</span></span>
</code>
<script type="text/javascript">
document.body.onload = function() {
    updateAppDependencies(1, null);
    updateCardDependencies(2, null);
};
</script>