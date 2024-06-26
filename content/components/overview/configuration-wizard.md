---
title: Configuration wizard
linktitle: Configuration wizard
summary: Online tool to generate the dependencies section of Gradle or Maven configuration files.
type: book
weight: 20
toc: true
---

<br>

This online tool generates for you the `dependencies` section of Gradle or Maven configuration files.
Choose your project profile and copy/paste the generated result into your project dependency manager.

What type of Keyple component are you working on?
- [An application](#application)
- [A specific reader plugin add-on](#reader-plugin-add-on)
- [A specific card extension add-on](#card-extension-add-on)
- [An alternate distributed solution add-on](#distributed-solution-add-on)

<br>

## Application

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
  >    <label for="cardCalypsoLegacySam">Calypso Legacy SAM (required for secure card transactions)</label>
  >  </div>
  >  <div>
  >    <input type="checkbox" id="cardCalypsoPki" onclick="javascript:updateAppDependencies(1, this);">
  >    <label for="cardCalypsoPki">Calypso PKI (required for PKI card transactions)</label>
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
{{< tab header="Gradle Kotlin" >}}
{{< code lang="kotlin" copy="true">}}
{{< /code>}}
{{< /tab >}}
{{< tab header="Gradle Groovy" >}}
{{< code lang="gradle" copy="true">}}
{{< /code>}}
{{< /tab >}}
{{< tab header="Maven" >}}
{{< code lang="xml" copy="true">}}
{{< /code>}}
{{< /tab >}}
{{< /tabpane >}}

<br>

## Reader plugin add-on

{{< tabpane ref="2" >}}
{{< tab header="Gradle Kotlin" >}}
{{< code lang="kotlin" copy="true">}}
// Begin Keyple configuration (generated by 'https://keyple.org/components/overview/configuration-wizard/')
implementation("org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-version %}}")
implementation("org.eclipse.keyple:keyple-plugin-java-api:{{% keyple-plugin-java-api-version %}}")
implementation("org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-version %}}")
// End Keyple configuration
{{< /code>}}
{{< /tab >}}
{{< tab header="Gradle Groovy" >}}
{{< code lang="gradle" copy="true">}}
// Begin Keyple configuration (generated by 'https://keyple.org/components/overview/configuration-wizard/')
implementation 'org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-version %}}'
implementation 'org.eclipse.keyple:keyple-plugin-java-api:{{% keyple-plugin-java-api-version %}}'
implementation 'org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-version %}}'
// End Keyple configuration
{{< /code>}}
{{< /tab >}}
{{< tab header="Maven" >}}
{{< code lang="xml" copy="true">}}
<!-- Begin Keyple configuration (generated by 'https://keyple.org/components/overview/configuration-wizard/') -->
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
<!-- End Keyple configuration -->
{{< /code>}}
{{< /tab >}}
{{< /tabpane >}}

<br>

## Card extension add-on

- Do you need additional services?
  >  <div>
  >    <input type="checkbox" id="cardServiceResource" onclick="javascript:updateCardDependencies(3, this);">
  >    <label for="cardServiceResource">Service for dynamic card resource allocation (e.g. HSM or pool of readers)</label>
  >  </div>

{{< tabpane ref="3" >}}
{{< tab header="Gradle Kotlin" >}}
{{< code lang="kotlin" copy="true">}}
{{< /code>}}
{{< /tab >}}
{{< tab header="Gradle Groovy" >}}
{{< code lang="gradle" copy="true">}}
{{< /code>}}
{{< /tab >}}
{{< tab header="Maven" >}}
{{< code lang="xml" copy="true">}}
{{< /code>}}
{{< /tab >}}
{{< /tabpane >}}

<br>

## Distributed solution add-on

- **For the "Local Service" component:**
{{< tabpane ref="4" >}}
{{< tab header="Gradle Kotlin" >}}
{{< code lang="kotlin" copy="true">}}
// Begin Keyple configuration (generated by 'https://keyple.org/components/overview/configuration-wizard/')
implementation("org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-version %}}")
implementation("org.eclipse.keyple:keyple-distributed-local-java-api:{{% keyple-distributed-local-java-api-version %}}")
implementation("org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-version %}}")
// End Keyple configuration
{{< /code>}}
{{< /tab >}}
{{< tab header="Gradle Groovy" >}}
{{< code lang="gradle" copy="true">}}
// Begin Keyple configuration (generated by 'https://keyple.org/components/overview/configuration-wizard/')
implementation 'org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-version %}}'
implementation 'org.eclipse.keyple:keyple-distributed-local-java-api:{{% keyple-distributed-local-java-api-version %}}'
implementation 'org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-version %}}'
// End Keyple configuration
{{< /code>}}
{{< /tab >}}
{{< tab header="Maven" >}}
{{< code lang="xml" copy="true">}}
<!-- Begin Keyple configuration (generated by 'https://keyple.org/components/overview/configuration-wizard/') -->
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
<!-- End Keyple configuration -->
{{< /code>}}
{{< /tab >}}
{{< /tabpane >}}

- **For the "Remote Plugin" component:**
{{< tabpane ref="5" >}}
{{< tab header="Gradle Kotlin" >}}
{{< code lang="kotlin" copy="true">}}
// Begin Keyple configuration (generated by 'https://keyple.org/components/overview/configuration-wizard/')
implementation("org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-version %}}")
implementation("org.eclipse.keyple:keyple-distributed-remote-java-api:{{% keyple-distributed-remote-java-api-version %}}")
implementation("org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-version %}}")
// End Keyple configuration
{{< /code>}}
{{< /tab >}}
{{< tab header="Gradle Groovy" >}}
{{< code lang="gradle" copy="true">}}
// Begin Keyple configuration (generated by 'https://keyple.org/components/overview/configuration-wizard/')
implementation 'org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-version %}}'
implementation 'org.eclipse.keyple:keyple-distributed-remote-java-api:{{% keyple-distributed-remote-java-api-version %}}'
implementation 'org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-version %}}'
// End Keyple configuration
{{< /code>}}
{{< /tab >}}
{{< tab header="Maven" >}}
{{< code lang="xml" copy="true">}}
<!-- Begin Keyple configuration (generated by 'https://keyple.org/components/overview/configuration-wizard/') -->
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
<!-- End Keyple configuration -->
{{< /code>}}
{{< /tab >}}
{{< /tabpane >}}

<!-- All groovy dependencies -->
<code id="all-groovy-dependencies" style="display:none">
<span id="keyple-common-java-api"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-version %}}'</span></span></span></span>
<span id="keyple-service-java-lib"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keyple:keyple-service-java-lib:{{% keyple-service-java-lib-version %}}'</span></span></span></span>
<span id="keyple-service-resource-java-lib"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keyple:keyple-service-resource-java-lib:{{% keyple-service-resource-java-lib-version %}}'</span></span></span></span>
<span id="keyple-util-java-lib"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-version %}}'</span></span></span></span>
<span id="keyple-card-calypso-java-lib"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keyple:keyple-card-calypso-java-lib:{{% keyple-card-calypso-java-lib-version %}}'</span></span></span></span>
<span id="keyple-card-calypso-crypto-legacysam-java-lib"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keyple:keyple-card-calypso-crypto-legacysam-java-lib:{{% keyple-card-calypso-crypto-legacysam-java-lib-version %}}'</span></span></span></span>
<span id="keyple-card-calypso-crypto-pki-java-lib"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keyple:keyple-card-calypso-crypto-pki-java-lib:{{% keyple-card-calypso-crypto-pki-java-lib-version %}}'</span></span></span></span>
<span id="keyple-card-generic-java-lib"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keyple:keyple-card-generic-java-lib:{{% keyple-card-generic-java-lib-version %}}'</span></span></span></span>
<span id="keyple-distributed-local-java-lib"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keyple:keyple-distributed-local-java-lib:{{% keyple-distributed-local-java-lib-version %}}'</span></span></span></span>
<span id="keyple-distributed-network-java-lib"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keyple:keyple-distributed-network-java-lib:{{% keyple-distributed-network-java-lib-version %}}'</span></span></span></span>
<span id="keyple-distributed-remote-java-lib"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keyple:keyple-distributed-remote-java-lib:{{% keyple-distributed-remote-java-lib-version %}}'</span></span></span></span>
<span id="keyple-plugin-android-nfc-java-lib"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keyple:keyple-plugin-android-nfc-java-lib:{{% keyple-plugin-android-nfc-java-lib-version %}}'</span></span></span></span>
<span id="keyple-plugin-android-omapi-java-lib"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keyple:keyple-plugin-android-omapi-java-lib:{{% keyple-plugin-android-omapi-java-lib-version %}}'</span></span></span></span>
<span id="keyple-plugin-cardresource-java-lib"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keyple:keyple-plugin-cardresource-java-lib:{{% keyple-plugin-cardresource-java-lib-version %}}'</span></span></span></span>
<span id="keyple-plugin-pcsc-java-lib"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keyple:keyple-plugin-pcsc-java-lib:{{% keyple-plugin-pcsc-java-lib-version %}}'</span></span></span></span>
<span id="keyple-plugin-stub-java-lib"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keyple:keyple-plugin-stub-java-lib:{{% keyple-plugin-stub-java-lib-version %}}'</span></span></span></span>
<span id="keypop-reader-java-api"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keypop:keypop-reader-java-api:{{% keypop-reader-java-api-version %}}'</span></span></span></span>
<span id="keypop-card-java-api"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keypop:keypop-card-java-api:{{% keypop-card-java-api-version %}}'</span></span></span></span>
<span id="keypop-calypso-card-java-api"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keypop:keypop-calypso-card-java-api:{{% keypop-calypso-card-java-api-version %}}'</span></span></span></span>
<span id="keypop-calypso-crypto-legacysam-java-api"><span class="line"><span class="cl"><span class="n">implementation</span> <span class="s1">'org.eclipse.keypop:keypop-calypso-crypto-legacysam-java-api:{{% keypop-calypso-crypto-legacysam-java-api-version %}}'</span></span></span></span>
</code>

<!-- All kotlin dependencies -->
<code id="all-kotlin-dependencies" style="display:none">
<span id="keyple-common-java-api"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keyple:keyple-common-java-api:{{% keyple-common-java-api-version %}}"</span>)</span></span></span>
<span id="keyple-service-java-lib"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keyple:keyple-service-java-lib:{{% keyple-service-java-lib-version %}}"</span>)</span></span></span>
<span id="keyple-service-resource-java-lib"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keyple:keyple-service-resource-java-lib:{{% keyple-service-resource-java-lib-version %}}"</span>)</span></span></span>
<span id="keyple-util-java-lib"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keyple:keyple-util-java-lib:{{% keyple-util-java-lib-version %}}"</span>)</span></span></span>
<span id="keyple-card-calypso-java-lib"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keyple:keyple-card-calypso-java-lib:{{% keyple-card-calypso-java-lib-version %}}"</span>)</span></span></span>
<span id="keyple-card-calypso-crypto-legacysam-java-lib"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keyple:keyple-card-calypso-crypto-legacysam-java-lib:{{% keyple-card-calypso-crypto-legacysam-java-lib-version %}}"</span>)</span></span></span>
<span id="keyple-card-calypso-crypto-pki-java-lib"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keyple:keyple-card-calypso-crypto-pki-java-lib:{{% keyple-card-calypso-crypto-pki-java-lib-version %}}"</span>)</span></span></span>
<span id="keyple-card-generic-java-lib"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keyple:keyple-card-generic-java-lib:{{% keyple-card-generic-java-lib-version %}}"</span>)</span></span></span>
<span id="keyple-distributed-local-java-lib"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keyple:keyple-distributed-local-java-lib:{{% keyple-distributed-local-java-lib-version %}}"</span>)</span></span></span>
<span id="keyple-distributed-network-java-lib"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keyple:keyple-distributed-network-java-lib:{{% keyple-distributed-network-java-lib-version %}}"</span>)</span></span></span>
<span id="keyple-distributed-remote-java-lib"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keyple:keyple-distributed-remote-java-lib:{{% keyple-distributed-remote-java-lib-version %}}"</span>)</span></span></span>
<span id="keyple-plugin-android-nfc-java-lib"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keyple:keyple-plugin-android-nfc-java-lib:{{% keyple-plugin-android-nfc-java-lib-version %}}"</span>)</span></span></span>
<span id="keyple-plugin-android-omapi-java-lib"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keyple:keyple-plugin-android-omapi-java-lib:{{% keyple-plugin-android-omapi-java-lib-version %}}"</span>)</span></span></span>
<span id="keyple-plugin-cardresource-java-lib"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keyple:keyple-plugin-cardresource-java-lib:{{% keyple-plugin-cardresource-java-lib-version %}}"</span>)</span></span></span>
<span id="keyple-plugin-pcsc-java-lib"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keyple:keyple-plugin-pcsc-java-lib:{{% keyple-plugin-pcsc-java-lib-version %}}"</span>)</span></span></span>
<span id="keyple-plugin-stub-java-lib"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keyple:keyple-plugin-stub-java-lib:{{% keyple-plugin-stub-java-lib-version %}}"</span>)</span></span></span>
<span id="keypop-reader-java-api"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keypop:keypop-reader-java-api:{{% keypop-reader-java-api-version %}}"</span>)</span></span></span>
<span id="keypop-card-java-api"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keypop:keypop-card-java-api:{{% keypop-card-java-api-version %}}"</span>)</span></span></span>
<span id="keypop-calypso-card-java-api"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keypop:keypop-calypso-card-java-api:{{% keypop-calypso-card-java-api-version %}}"</span>)</span></span></span>
<span id="keypop-calypso-crypto-legacysam-java-api"><span class="line"><span class="cl"><span class="c1"></span><span class="n">implementation</span><span class="p">(</span><span class="s2">"org.eclipse.keypop:keypop-calypso-crypto-legacysam-java-api:{{% keypop-calypso-crypto-legacysam-java-api-version %}}"</span>)</span></span></span>
</code>

<!-- All maven dependencies -->
<pre style="display:none">
<code id="all-maven-dependencies">
<span id="keyple-common-java-api"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keyple<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keyple-common-java-api<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keyple-common-java-api-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
<span id="keyple-service-java-lib"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keyple<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keyple-service-java-lib<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keyple-service-java-lib-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
<span id="keyple-service-resource-java-lib"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keyple<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keyple-service-resource-java-lib<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keyple-service-resource-java-lib-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
<span id="keyple-util-java-lib"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keyple<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keyple-util-java-lib<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keyple-util-java-lib-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
<span id="keyple-card-calypso-java-lib"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keyple<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keyple-card-calypso-java-lib<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keyple-card-calypso-java-lib-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
<span id="keyple-card-calypso-crypto-legacysam-java-lib"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keyple<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keyple-card-calypso-crypto-legacysam-java-lib<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keyple-card-calypso-crypto-legacysam-java-lib-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
<span id="keyple-card-calypso-crypto-pki-java-lib"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keyple<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keyple-card-calypso-crypto-pki-java-lib<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keyple-card-calypso-crypto-pki-java-lib-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
<span id="keyple-card-generic-java-lib"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keyple<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keyple-card-generic-java-lib<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keyple-card-generic-java-lib-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
<span id="keyple-distributed-local-java-lib"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keyple<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keyple-distributed-local-java-lib<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keyple-distributed-local-java-lib-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
<span id="keyple-distributed-network-java-lib"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keyple<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keyple-distributed-network-java-lib<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keyple-distributed-network-java-lib-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
<span id="keyple-distributed-remote-java-lib"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keyple<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keyple-distributed-remote-java-lib<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keyple-distributed-remote-java-lib-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
<span id="keyple-plugin-android-nfc-java-lib"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keyple<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keyple-plugin-android-nfc-java-lib<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keyple-plugin-android-nfc-java-lib-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
<span id="keyple-plugin-android-omapi-java-lib"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keyple<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keyple-plugin-android-omapi-java-lib<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keyple-plugin-android-omapi-java-lib-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
<span id="keyple-plugin-cardresource-java-lib"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keyple<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keyple-plugin-cardresource-java-lib<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keyple-plugin-cardresource-java-lib-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
<span id="keyple-plugin-pcsc-java-lib"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keyple<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keyple-plugin-pcsc-java-lib<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keyple-plugin-pcsc-java-lib-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
<span id="keyple-plugin-stub-java-lib"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keyple<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keyple-plugin-stub-java-lib<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keyple-plugin-stub-java-lib-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
<span id="keypop-reader-java-api"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keypop<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keypop-reader-java-api<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keypop-reader-java-api-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
<span id="keypop-card-java-api"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keypop<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keypop-card-java-api<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keypop-card-java-api-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
<span id="keypop-calypso-card-java-api"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keypop<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keypop-calypso-card-java-api<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keypop-calypso-card-java-api-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
<span id="keypop-calypso-crypto-legacysam-java-api"><span class="line"><span class="cl"><span class="nt">&lt;dependency&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;groupId&gt;</span>org.eclipse.keypop<span class="nt">&lt;/groupId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;artifactId&gt;</span>keypop-calypso-crypto-legacysam-java-api<span class="nt">&lt;/artifactId&gt;</span></span></span>
  <span class="line"><span class="cl"><span class="nt">&lt;version&gt;</span>{{% keypop-calypso-crypto-legacysam-java-api-version %}}<span class="nt">&lt;/version&gt;</span></span></span>
<span class="line"><span class="cl"><span class="nt">&lt;/dependency&gt;</span></span></span></span>
</code>
</pre>
<script type="text/javascript">
document.body.onload = function() {
    updateAppDependencies(1, null);
    updateCardDependencies(3, null);
};
</script>