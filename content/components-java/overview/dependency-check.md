---
title: Java - Dependency check
linktitle: Dependency check
summary: Online tool to check the compatibility of Keyple components according to their internal API versions.
type: book
weight: 30
toc: false
---

---
This online tool helps you to check the compatibility of Keyple components according to their API versions.

Select the targeted versions of the APIs to show the associated compliant libraries versions:

<!-- 
##########################################################
/!\ Instructions to maintain the content of this table /!\
##########################################################

- Insert a row each time an API has been updated (major or minor version) then update all impacted components.

- If the update does not concern the APIs, but only the libraries, then update only the version range of the concerned libraries
(ex: if keyple-service-java-api goes from "2.0.0" to "2.0.3", then put "2.0.0...2.0.3" in the table)

Warning:

- If "keyple-util-java-lib" changes minor or major version,
  it is imperative to add a new line if at least one of the other libraries uses one of the new features.

- If "keyple-service-java-lib" changes of minor or major version,
  it is imperative to add a new line if "keyple-service-resource-java-lib" uses one of the new functionalities.

- If "keyple-service-resource-java-lib" changes of minor or major version,
  it is imperative to add a new line if "keyple-card-calypso-java-lib" or "keyple-card-generic-java-lib" uses one of the new features.
-->

<table id="datatable-dependency-check" class="display compact" style="width:100%">
    <thead>
        <tr>
            <th colspan="4" class="text-center c-orange">Calypso Networks Association APIs</th>
            <th colspan="4" class="text-center c-yellow">Core APIs</th>
            <th colspan="3" class="text-center c-blue">Core libraries</th>
            <th colspan="3" class="text-center c-purple">Distributed systems libraries</th>
            <th colspan="3" class="text-center c-green">Card extensions libraries</th>
            <th colspan="5" class="text-center c-red">Standard reader plugins libraries</th>
        </tr>
        <tr>
            <th class="rotate c-orange"><div class="rotate-190">calypsonet-terminal-reader-java-api</div></th>
            <th class="rotate c-orange"><div class="rotate-190">calypsonet-terminal-card-java-api</div></th>
            <th class="rotate c-orange"><div class="rotate-190">calypsonet-terminal-calypso-java-api</div></th>
            <th class="rotate c-orange"><div class="rotate-190">calypsonet-terminal-calypso-crypto-legacysam-java-api</div></th>
            <th class="rotate c-yellow"><div class="rotate-190">keyple-common-java-api</div></th>
            <th class="rotate c-yellow"><div class="rotate-190">keyple-distributed-local-java-api</div></th>
            <th class="rotate c-yellow"><div class="rotate-190">keyple-distributed-remote-java-api</div></th>
            <th class="rotate c-yellow"><div class="rotate-190">keyple-plugin-java-api</div></th>
            <th class="rotate c-blue"><div class="rotate-190">keyple-util-java-lib</div></th>
            <th class="rotate c-blue"><div class="rotate-190">keyple-service-java-lib</div></th>
            <th class="rotate c-blue"><div class="rotate-190">keyple-service-resource-java-lib</div></th>
            <th class="rotate c-purple"><div class="rotate-190">keyple-distributed-local-java-lib</div></th>
            <th class="rotate c-purple"><div class="rotate-190">keyple-distributed-network-java-lib</div></th>
            <th class="rotate c-purple"><div class="rotate-190">keyple-distributed-remote-java-lib</div></th>
            <th class="rotate c-green"><div class="rotate-190">keyple-card-calypso-java-lib</div></th>
            <th class="rotate c-green"><div class="rotate-190">keyple-card-calypso-crypto-legacysam-java-lib</div></th>
            <th class="rotate c-green"><div class="rotate-190">keyple-card-generic-java-lib</div></th>
            <th class="rotate c-red"><div class="rotate-190">keyple-plugin-android-nfc-java-lib</div></th>
            <th class="rotate c-red"><div class="rotate-190">keyple-plugin-android-omapi-java-lib</div></th>
            <th class="rotate c-red"><div class="rotate-190">keyple-plugin-cardresource-java-lib</div></th>
            <th class="rotate c-red"><div class="rotate-190">keyple-plugin-pcsc-java-lib</div></th>
            <th class="rotate c-red"><div class="rotate-190">keyple-plugin-stub-java-lib</div></th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1.2.+</td><!-- calypsonet-terminal-reader-java-api -->
            <td>1.0.+</td><!-- calypsonet-terminal-card-java-api -->
            <td>1.8.+</td><!-- calypsonet-terminal-calypso-java-api -->
            <td>0.2.+</td><!-- calypsonet-terminal-calypso-crypto-legacysam-java-api -->
            <td>2.0.+</td><!-- keyple-common-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-local-java-api -->
            <td>2.1.+</td><!-- keyple-distributed-remote-java-api -->
            <td>2.1.+</td><!-- keyple-plugin-java-api -->
            <td>2.3.0</td><!-- keyple-util-java-lib -->
            <td>2.2.0...2.2.1</td><!-- keyple-service-java-lib -->
            <td>2.1.0...2.1.1</td><!-- keyple-service-resource-java-lib -->
            <td>2.2.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.2.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.2.0...2.2.1</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.3.4...2.3.5</td><!-- keyple-card-calypso-java-lib -->
            <td>0.3.0</td><!-- keyple-card-calypso-crypto-legacysam-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-card-generic-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-nfc-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-omapi-java-lib -->
            <td>1.0.0...1.0.1</td><!-- keyple-plugin-cardresource-java-lib -->
            <td>2.0.0...2.1.2</td><!-- keyple-plugin-pcsc-java-lib -->
            <td>2.0.0...2.1.0</td><!-- keyple-plugin-stub-java-lib -->
        </tr>
        <tr>
            <td>1.2.+</td><!-- calypsonet-terminal-reader-java-api -->
            <td>1.0.+</td><!-- calypsonet-terminal-card-java-api -->
            <td>1.8.+</td><!-- calypsonet-terminal-calypso-java-api -->
            <td>0.2.+</td><!-- calypsonet-terminal-calypso-crypto-legacysam-java-api -->
            <td>2.0.+</td><!-- keyple-common-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-local-java-api -->
            <td>2.1.+</td><!-- keyple-distributed-remote-java-api -->
            <td>2.0.+</td><!-- keyple-plugin-java-api -->
            <td>2.3.0</td><!-- keyple-util-java-lib -->
            <td>2.1.4</td><!-- keyple-service-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-service-resource-java-lib -->
            <td>2.2.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.2.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.2.0...2.2.1</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.3.4...2.3.5</td><!-- keyple-card-calypso-java-lib -->
            <td>0.3.0</td><!-- keyple-card-calypso-crypto-legacysam-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-card-generic-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-nfc-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-omapi-java-lib -->
            <td>-</td><!-- keyple-plugin-cardresource-java-lib -->
            <td>2.0.0...2.1.2</td><!-- keyple-plugin-pcsc-java-lib -->
            <td>2.0.0...2.1.0</td><!-- keyple-plugin-stub-java-lib -->
        </tr>
        <tr>
            <td>1.2.+</td><!-- calypsonet-terminal-reader-java-api -->
            <td>1.0.+</td><!-- calypsonet-terminal-card-java-api -->
            <td>1.8.+</td><!-- calypsonet-terminal-calypso-java-api -->
            <td>0.2.+</td><!-- calypsonet-terminal-calypso-crypto-legacysam-java-api -->
            <td>2.0.+</td><!-- keyple-common-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-local-java-api -->
            <td>2.1.+</td><!-- keyple-distributed-remote-java-api -->
            <td>2.0.+</td><!-- keyple-plugin-java-api -->
            <td>2.3.0</td><!-- keyple-util-java-lib -->
            <td>2.1.3</td><!-- keyple-service-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-service-resource-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.1.0</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.3.4...2.3.5</td><!-- keyple-card-calypso-java-lib -->
            <td>0.3.0</td><!-- keyple-card-calypso-crypto-legacysam-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-card-generic-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-nfc-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-omapi-java-lib -->
            <td>-</td><!-- keyple-plugin-cardresource-java-lib -->
            <td>2.0.0...2.1.2</td><!-- keyple-plugin-pcsc-java-lib -->
            <td>2.0.0...2.1.0</td><!-- keyple-plugin-stub-java-lib -->
        </tr>
        <tr>
            <td>1.2.+</td><!-- calypsonet-terminal-reader-java-api -->
            <td>1.0.+</td><!-- calypsonet-terminal-card-java-api -->
            <td>1.7.+</td><!-- calypsonet-terminal-calypso-java-api -->
            <td>0.2.+</td><!-- calypsonet-terminal-calypso-crypto-legacysam-java-api -->
            <td>2.0.+</td><!-- keyple-common-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-local-java-api -->
            <td>2.1.+</td><!-- keyple-distributed-remote-java-api -->
            <td>2.0.+</td><!-- keyple-plugin-java-api -->
            <td>2.3.0</td><!-- keyple-util-java-lib -->
            <td>2.1.3</td><!-- keyple-service-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-service-resource-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.1.0</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.3.3</td><!-- keyple-card-calypso-java-lib -->
            <td>0.3.0</td><!-- keyple-card-calypso-crypto-legacysam-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-card-generic-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-nfc-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-omapi-java-lib -->
            <td>-</td><!-- keyple-plugin-cardresource-java-lib -->
            <td>2.0.0...2.1.2</td><!-- keyple-plugin-pcsc-java-lib -->
            <td>2.0.0...2.1.0</td><!-- keyple-plugin-stub-java-lib -->
        </tr>
        <tr>
            <td>1.2.+</td><!-- calypsonet-terminal-reader-java-api -->
            <td>1.0.+</td><!-- calypsonet-terminal-card-java-api -->
            <td>1.6.+</td><!-- calypsonet-terminal-calypso-java-api -->
            <td>0.2.+</td><!-- calypsonet-terminal-calypso-crypto-legacysam-java-api -->
            <td>2.0.+</td><!-- keyple-common-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-local-java-api -->
            <td>2.1.+</td><!-- keyple-distributed-remote-java-api -->
            <td>2.0.+</td><!-- keyple-plugin-java-api -->
            <td>2.3.0</td><!-- keyple-util-java-lib -->
            <td>2.1.3</td><!-- keyple-service-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-service-resource-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.1.0</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.3.2</td><!-- keyple-card-calypso-java-lib -->
            <td>0.3.0</td><!-- keyple-card-calypso-crypto-legacysam-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-card-generic-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-nfc-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-omapi-java-lib -->
            <td>-</td><!-- keyple-plugin-cardresource-java-lib -->
            <td>2.0.0...2.1.2</td><!-- keyple-plugin-pcsc-java-lib -->
            <td>2.0.0...2.1.0</td><!-- keyple-plugin-stub-java-lib -->
        </tr>
        <tr>
            <td>1.2.+</td><!-- calypsonet-terminal-reader-java-api -->
            <td>1.0.+</td><!-- calypsonet-terminal-card-java-api -->
            <td>1.6.+</td><!-- calypsonet-terminal-calypso-java-api -->
            <td>0.1.+</td><!-- calypsonet-terminal-calypso-crypto-legacysam-java-api -->
            <td>2.0.+</td><!-- keyple-common-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-local-java-api -->
            <td>2.1.+</td><!-- keyple-distributed-remote-java-api -->
            <td>2.0.+</td><!-- keyple-plugin-java-api -->
            <td>2.3.0</td><!-- keyple-util-java-lib -->
            <td>2.1.3</td><!-- keyple-service-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-service-resource-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.1.0</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.3.2</td><!-- keyple-card-calypso-java-lib -->
            <td>0.1.0...0.2.0</td><!-- keyple-card-calypso-crypto-legacysam-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-card-generic-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-nfc-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-omapi-java-lib -->
            <td>-</td><!-- keyple-plugin-cardresource-java-lib -->
            <td>2.0.0...2.1.2</td><!-- keyple-plugin-pcsc-java-lib -->
            <td>2.0.0...2.1.0</td><!-- keyple-plugin-stub-java-lib -->
        </tr>
        <tr>
            <td>1.2.+</td><!-- calypsonet-terminal-reader-java-api -->
            <td>1.0.+</td><!-- calypsonet-terminal-card-java-api -->
            <td>1.5.+</td><!-- calypsonet-terminal-calypso-java-api -->
            <td>0.1.+</td><!-- calypsonet-terminal-calypso-crypto-legacysam-java-api -->
            <td>2.0.+</td><!-- keyple-common-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-local-java-api -->
            <td>2.1.+</td><!-- keyple-distributed-remote-java-api -->
            <td>2.0.+</td><!-- keyple-plugin-java-api -->
            <td>2.3.0</td><!-- keyple-util-java-lib -->
            <td>2.1.3</td><!-- keyple-service-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-service-resource-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.1.0</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.3.1</td><!-- keyple-card-calypso-java-lib -->
            <td>0.1.0...0.2.0</td><!-- keyple-card-calypso-crypto-legacysam-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-card-generic-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-nfc-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-omapi-java-lib -->
            <td>-</td><!-- keyple-plugin-cardresource-java-lib -->
            <td>2.0.0...2.1.2</td><!-- keyple-plugin-pcsc-java-lib -->
            <td>2.0.0...2.1.0</td><!-- keyple-plugin-stub-java-lib -->
        </tr>
        <tr>
            <td>1.2.+</td><!-- calypsonet-terminal-reader-java-api -->
            <td>1.0.+</td><!-- calypsonet-terminal-card-java-api -->
            <td>1.5.+</td><!-- calypsonet-terminal-calypso-java-api -->
            <td>0.1.+</td><!-- calypsonet-terminal-calypso-crypto-legacysam-java-api -->
            <td>2.0.+</td><!-- keyple-common-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-local-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-remote-java-api -->
            <td>2.0.+</td><!-- keyple-plugin-java-api -->
            <td>2.3.0</td><!-- keyple-util-java-lib -->
            <td>2.1.2</td><!-- keyple-service-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-service-resource-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.3.1</td><!-- keyple-card-calypso-java-lib -->
            <td>0.1.0...0.2.0</td><!-- keyple-card-calypso-crypto-legacysam-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-card-generic-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-nfc-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-omapi-java-lib -->
            <td>-</td><!-- keyple-plugin-cardresource-java-lib -->
            <td>2.0.0...2.1.2</td><!-- keyple-plugin-pcsc-java-lib -->
            <td>2.0.0...2.1.0</td><!-- keyple-plugin-stub-java-lib -->
        </tr>
        <tr>
            <td>1.1.+</td><!-- calypsonet-terminal-reader-java-api -->
            <td>1.0.+</td><!-- calypsonet-terminal-card-java-api -->
            <td>1.5.+</td><!-- calypsonet-terminal-calypso-java-api -->
            <td>0.1.+</td><!-- calypsonet-terminal-calypso-crypto-legacysam-java-api -->
            <td>2.0.+</td><!-- keyple-common-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-local-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-remote-java-api -->
            <td>2.0.+</td><!-- keyple-plugin-java-api -->
            <td>2.3.0</td><!-- keyple-util-java-lib -->
            <td>2.1.1</td><!-- keyple-service-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-service-resource-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.3.1</td><!-- keyple-card-calypso-java-lib -->
            <td>0.1.0...0.2.0</td><!-- keyple-card-calypso-crypto-legacysam-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-card-generic-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-nfc-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-omapi-java-lib -->
            <td>-</td><!-- keyple-plugin-cardresource-java-lib -->
            <td>2.0.0...2.1.2</td><!-- keyple-plugin-pcsc-java-lib -->
            <td>2.0.0...2.1.0</td><!-- keyple-plugin-stub-java-lib -->
        </tr>
        <tr>
            <td>1.1.+</td><!-- calypsonet-terminal-reader-java-api -->
            <td>1.0.+</td><!-- calypsonet-terminal-card-java-api -->
            <td>1.4.+</td><!-- calypsonet-terminal-calypso-java-api -->
            <td>0.1.+</td><!-- calypsonet-terminal-calypso-crypto-legacysam-java-api -->
            <td>2.0.+</td><!-- keyple-common-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-local-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-remote-java-api -->
            <td>2.0.+</td><!-- keyple-plugin-java-api -->
            <td>2.3.0</td><!-- keyple-util-java-lib -->
            <td>2.1.1</td><!-- keyple-service-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-service-resource-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.2.4...2.3.0</td><!-- keyple-card-calypso-java-lib -->
            <td>0.1.0...0.2.0</td><!-- keyple-card-calypso-crypto-legacysam-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-card-generic-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-nfc-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-omapi-java-lib -->
            <td>-</td><!-- keyple-plugin-cardresource-java-lib -->
            <td>2.0.0...2.1.2</td><!-- keyple-plugin-pcsc-java-lib -->
            <td>2.0.0...2.1.0</td><!-- keyple-plugin-stub-java-lib -->
        </tr>
        <tr>
            <td>1.1.+</td><!-- calypsonet-terminal-reader-java-api -->
            <td>1.0.+</td><!-- calypsonet-terminal-card-java-api -->
            <td>1.4.+</td><!-- calypsonet-terminal-calypso-java-api -->
            <td>0.1.+</td><!-- calypsonet-terminal-calypso-crypto-legacysam-java-api -->
            <td>2.0.+</td><!-- keyple-common-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-local-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-remote-java-api -->
            <td>2.0.+</td><!-- keyple-plugin-java-api -->
            <td>2.1.0...2.2.0</td><!-- keyple-util-java-lib -->
            <td>2.1.1</td><!-- keyple-service-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-service-resource-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.2.3</td><!-- keyple-card-calypso-java-lib -->
            <td>-</td><!-- keyple-card-calypso-crypto-legacysam-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-card-generic-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-nfc-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-omapi-java-lib -->
            <td>-</td><!-- keyple-plugin-cardresource-java-lib -->
            <td>2.0.0...2.1.2</td><!-- keyple-plugin-pcsc-java-lib -->
            <td>2.0.0...2.1.0</td><!-- keyple-plugin-stub-java-lib -->
        </tr>
        <tr>
            <td>1.0.+</td><!-- calypsonet-terminal-reader-java-api -->
            <td>1.0.+</td><!-- calypsonet-terminal-card-java-api -->
            <td>1.3.+</td><!-- calypsonet-terminal-calypso-java-api -->
            <td>0.1.+</td><!-- calypsonet-terminal-calypso-crypto-legacysam-java-api -->
            <td>2.0.+</td><!-- keyple-common-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-local-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-remote-java-api -->
            <td>2.0.+</td><!-- keyple-plugin-java-api -->
            <td>2.1.0...2.2.0</td><!-- keyple-util-java-lib -->
            <td>2.0.0...2.1.0</td><!-- keyple-service-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-service-resource-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.2.0...2.2.2</td><!-- keyple-card-calypso-java-lib -->
            <td>-</td><!-- keyple-card-calypso-crypto-legacysam-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-card-generic-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-nfc-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-omapi-java-lib -->
            <td>-</td><!-- keyple-plugin-cardresource-java-lib -->
            <td>2.0.0...2.1.2</td><!-- keyple-plugin-pcsc-java-lib -->
            <td>2.0.0...2.1.0</td><!-- keyple-plugin-stub-java-lib -->
        </tr>
        <tr>
            <td>1.0.+</td><!-- calypsonet-terminal-reader-java-api -->
            <td>1.0.+</td><!-- calypsonet-terminal-card-java-api -->
            <td>1.2.+</td><!-- calypsonet-terminal-calypso-java-api -->
            <td>0.1.+</td><!-- calypsonet-terminal-calypso-crypto-legacysam-java-api -->
            <td>2.0.+</td><!-- keyple-common-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-local-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-remote-java-api -->
            <td>2.0.+</td><!-- keyple-plugin-java-api -->
            <td>2.1.0...2.2.0</td><!-- keyple-util-java-lib -->
            <td>2.0.0...2.1.0</td><!-- keyple-service-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-service-resource-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.2.0...2.2.1</td><!-- keyple-card-calypso-java-lib -->
            <td>-</td><!-- keyple-card-calypso-crypto-legacysam-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-card-generic-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-nfc-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-omapi-java-lib -->
            <td>-</td><!-- keyple-plugin-cardresource-java-lib -->
            <td>2.0.0...2.1.2</td><!-- keyple-plugin-pcsc-java-lib -->
            <td>2.0.0...2.1.0</td><!-- keyple-plugin-stub-java-lib -->
        </tr>
        <tr>
            <td>1.0.+</td><!-- calypsonet-terminal-reader-java-api -->
            <td>1.0.+</td><!-- calypsonet-terminal-card-java-api -->
            <td>1.1.+</td><!-- calypsonet-terminal-calypso-java-api -->
            <td>0.1.+</td><!-- calypsonet-terminal-calypso-crypto-legacysam-java-api -->
            <td>2.0.+</td><!-- keyple-common-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-local-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-remote-java-api -->
            <td>2.0.+</td><!-- keyple-plugin-java-api -->
            <td>2.0.0</td><!-- keyple-util-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-service-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-service-resource-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.1.0</td><!-- keyple-card-calypso-java-lib -->
            <td>-</td><!-- keyple-card-calypso-crypto-legacysam-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-card-generic-java-lib -->
            <td>2.0.0</td><!-- keyple-plugin-android-nfc-java-lib -->
            <td>2.0.0</td><!-- keyple-plugin-android-omapi-java-lib -->
            <td>-</td><!-- keyple-plugin-cardresource-java-lib -->
            <td>2.0.0</td><!-- keyple-plugin-pcsc-java-lib -->
            <td>2.0.0</td><!-- keyple-plugin-stub-java-lib -->
        </tr>
        <tr>
            <td>1.0.+</td><!-- calypsonet-terminal-reader-java-api -->
            <td>1.0.+</td><!-- calypsonet-terminal-card-java-api -->
            <td>1.0.+</td><!-- calypsonet-terminal-calypso-java-api -->
            <td>0.1.+</td><!-- calypsonet-terminal-calypso-crypto-legacysam-java-api -->
            <td>2.0.+</td><!-- keyple-common-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-local-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-remote-java-api -->
            <td>2.0.+</td><!-- keyple-plugin-java-api -->
            <td>2.0.0</td><!-- keyple-util-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-service-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-service-resource-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.0.0...2.0.3</td><!-- keyple-card-calypso-java-lib -->
            <td>-</td><!-- keyple-card-calypso-crypto-legacysam-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-card-generic-java-lib -->
            <td>2.0.0</td><!-- keyple-plugin-android-nfc-java-lib -->
            <td>2.0.0</td><!-- keyple-plugin-android-omapi-java-lib -->
            <td>-</td><!-- keyple-plugin-cardresource-java-lib -->
            <td>2.0.0</td><!-- keyple-plugin-pcsc-java-lib -->
            <td>2.0.0</td><!-- keyple-plugin-stub-java-lib -->
        </tr>
    </tbody>
</table>
<script type="text/javascript">
document.body.onload = function() {
    initDatatableDependencyCheck();
};
</script>
