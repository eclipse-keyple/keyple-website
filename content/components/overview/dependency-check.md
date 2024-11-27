---
title: Dependency check
linktitle: Dependency check
summary: Online tool to check the compatibility of Keyple components according to their internal API versions.
type: book
weight: 30
toc: false
---

<br>

This online tool helps you to check the compatibility of Keyple components according to their API versions.

Select the targeted versions of the APIs to show the associated compliant libraries versions (internal APIs are marked with an asterisk *):

<!-- 
##########################################################
/!\ Instructions to maintain the content of this table /!\
##########################################################

For each release, you need to update the table of release trains in the "/assets/js/custom.js" file, 
in order to update the dependency checking mechanism.

If the release of a component has no impact on the other components, 
you will need to insert a release train in the "releaseTrains" table, 
containing a single release for that component only.

If several components are released simultaneously, 
because they are dependent on each other, 
you will need to insert a single release train in the "releaseTrains" table, 
referencing all the related releases concerned.

Releases of bugfix API components (version X.Y.*) should not be included, 
as they only concern documentation updates.
-->

<table id="datatable-dependency-check" class="display compact stripe nowrap" style="width:100%">
    <thead class="text-center">
        <tr>
            <th colspan="6" class="bg-orange">Keypop APIs</th>
            <th colspan="4" class="bg-yellow">Core APIs</th>
            <th colspan="3" class="bg-blue">Core libraries</th>
            <th colspan="3" class="bg-purple">Distributed systems libraries</th>
            <th colspan="4" class="bg-green">Card extensions libraries</th>
            <th colspan="5" class="bg-red">Standard reader plugins libraries</th>
        </tr>
        <tr>
            <th class="bg-orange">Reader<br>API</th>
            <th class="bg-orange c-grey">Card<br>API*</th>
            <th class="bg-orange">Calypso Card<br>API</th>
            <th class="bg-orange c-grey">Calypso Crypto Symmetric<br>API*</th>
            <th class="bg-orange">Calypso Legacy SAM<br>API</th>
            <th class="bg-orange c-grey">Calypso Crypto Asymmetric<br>API*</th>
            <th class="bg-yellow">Common<br>API</th>
            <th class="bg-yellow c-grey">Distributed Local<br>API*</th>
            <th class="bg-yellow c-grey">Distributed Remote<br>API*</th>
            <th class="bg-yellow c-grey">Plugin<br>API*</th>
            <th class="bg-blue">Util<br>Lib</th>
            <th class="bg-blue">Service<br>Lib</th>
            <th class="bg-blue">Service Resource<br>Lib</th>
            <th class="bg-purple">Local<br>Lib</th>
            <th class="bg-purple">Network<br>Lib</th>
            <th class="bg-purple">Remote<br>Lib</th>
            <th class="bg-green">Calypso Card<br>Lib</th>
            <th class="bg-green">Calypso Legacy SAM<br>Lib</th>
            <th class="bg-green">Calypso PKI<br>Lib</th>
            <th class="bg-green">Generic<br>Lib</th>
            <th class="bg-red">Android NFC<br>Lib</th>
            <th class="bg-red">Android OMAPI<br>Lib</th>
            <th class="bg-red">Card Resource<br>Lib</th>
            <th class="bg-red">PC/SC<br>Lib</th>
            <th class="bg-red">Stub<br>Lib</th>
        </tr>
    </thead>
    <tbody class="text-center">
    </tbody>
</table>

<br>

## Components previously based on the Calypsonet Terminal API

<!-- 
##############################################################
/!\ Instructions to maintain the content of this old table /!\
##############################################################

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

<table id="datatable-dependency-check-old" class="display compact stripe nowrap" style="width:100%">
    <thead class="text-center">
        <tr>
            <th colspan="4" class="bg-orange">Calypso Networks Association APIs</th>
            <th colspan="4" class="bg-yellow">Core APIs</th>
            <th colspan="3" class="bg-blue">Core libraries</th>
            <th colspan="3" class="bg-purple">Distributed systems libraries</th>
            <th colspan="3" class="bg-green">Card extensions libraries</th>
            <th colspan="5" class="bg-red">Standard reader plugins libraries</th>
        </tr>
        <tr>
            <th class="bg-orange">Reader<br>API</th>
            <th class="bg-orange c-grey">Card<br>API*</th>
            <th class="bg-orange">Calypso Card<br>API</th>
            <th class="bg-orange">Calypso Legacy SAM<br>API</th>
            <th class="bg-yellow">Common<br>API</th>
            <th class="bg-yellow c-grey">Distributed Local<br>API*</th>
            <th class="bg-yellow c-grey">Distributed Remote<br>API*</th>
            <th class="bg-yellow c-grey">Plugin<br>API*</th>
            <th class="bg-blue">Util<br>Lib</th>
            <th class="bg-blue">Service<br>Lib</th>
            <th class="bg-blue">Service Resource<br>Lib</th>
            <th class="bg-purple">Local<br>Lib</th>
            <th class="bg-purple">Network<br>Lib</th>
            <th class="bg-purple">Remote<br>Lib</th>
            <th class="bg-green">Calypso Card<br>Lib</th>
            <th class="bg-green">Calypso Legacy SAM<br>Lib</th>
            <th class="bg-green">Generic<br>Lib</th>
            <th class="bg-red">Android NFC<br>Lib</th>
            <th class="bg-red">Android OMAPI<br>Lib</th>
            <th class="bg-red">Card Resource<br>Lib</th>
            <th class="bg-red">PC/SC<br>Lib</th>
            <th class="bg-red">Stub<br>Lib</th>
        </tr>
    </thead>
    <tbody class="text-center">
        <tr>
            <td>1.3.+</td><!-- calypsonet-terminal-reader-java-api -->
            <td>1.0.+</td><!-- calypsonet-terminal-card-java-api -->
            <td>1.8.+</td><!-- calypsonet-terminal-calypso-java-api -->
            <td>0.2.+</td><!-- calypsonet-terminal-calypso-crypto-legacysam-java-api -->
            <td>2.0.+</td><!-- keyple-common-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-local-java-api -->
            <td>2.1.+</td><!-- keyple-distributed-remote-java-api -->
            <td>2.3.+</td><!-- keyple-plugin-java-api -->
            <td>2.3.0...2.3.1</td><!-- keyple-util-java-lib -->
            <td>2.3.3...2.3.5</td><!-- keyple-service-java-lib -->
            <td>2.1.0...2.1.1</td><!-- keyple-service-resource-java-lib -->
            <td>2.2.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.2.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.2.0...2.2.1</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.3.4...2.3.13</td><!-- keyple-card-calypso-java-lib -->
            <td>0.3.0</td><!-- keyple-card-calypso-crypto-legacysam-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-card-generic-java-lib -->
            <td>2.0.0...2.1.0</td><!-- keyple-plugin-android-nfc-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-omapi-java-lib -->
            <td>1.0.0...1.0.1</td><!-- keyple-plugin-cardresource-java-lib -->
            <td>2.0.0...2.2.0</td><!-- keyple-plugin-pcsc-java-lib -->
            <td>2.0.0...2.2.0</td><!-- keyple-plugin-stub-java-lib -->
        </tr>
        <tr>
            <td>1.3.+</td><!-- calypsonet-terminal-reader-java-api -->
            <td>1.0.+</td><!-- calypsonet-terminal-card-java-api -->
            <td>1.8.+</td><!-- calypsonet-terminal-calypso-java-api -->
            <td>0.2.+</td><!-- calypsonet-terminal-calypso-crypto-legacysam-java-api -->
            <td>2.0.+</td><!-- keyple-common-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-local-java-api -->
            <td>2.1.+</td><!-- keyple-distributed-remote-java-api -->
            <td>2.2.+</td><!-- keyple-plugin-java-api -->
            <td>2.3.0...2.3.1</td><!-- keyple-util-java-lib -->
            <td>2.3.2...2.3.4</td><!-- keyple-service-java-lib -->
            <td>2.1.0...2.1.1</td><!-- keyple-service-resource-java-lib -->
            <td>2.2.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.2.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.2.0...2.2.1</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.3.4...2.3.13</td><!-- keyple-card-calypso-java-lib -->
            <td>0.3.0</td><!-- keyple-card-calypso-crypto-legacysam-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-card-generic-java-lib -->
            <td>2.0.0...2.1.0</td><!-- keyple-plugin-android-nfc-java-lib -->
            <td>2.0.0...2.0.1</td><!-- keyple-plugin-android-omapi-java-lib -->
            <td>1.0.0...1.0.1</td><!-- keyple-plugin-cardresource-java-lib -->
            <td>2.0.0...2.1.2</td><!-- keyple-plugin-pcsc-java-lib -->
            <td>2.0.0...2.2.0</td><!-- keyple-plugin-stub-java-lib -->
        </tr>
        <tr>
            <td>1.3.+</td><!-- calypsonet-terminal-reader-java-api -->
            <td>1.0.+</td><!-- calypsonet-terminal-card-java-api -->
            <td>1.8.+</td><!-- calypsonet-terminal-calypso-java-api -->
            <td>0.2.+</td><!-- calypsonet-terminal-calypso-crypto-legacysam-java-api -->
            <td>2.0.+</td><!-- keyple-common-java-api -->
            <td>2.0.+</td><!-- keyple-distributed-local-java-api -->
            <td>2.1.+</td><!-- keyple-distributed-remote-java-api -->
            <td>2.1.+</td><!-- keyple-plugin-java-api -->
            <td>2.3.0...2.3.1</td><!-- keyple-util-java-lib -->
            <td>2.3.0...2.3.4</td><!-- keyple-service-java-lib -->
            <td>2.1.0...2.1.1</td><!-- keyple-service-resource-java-lib -->
            <td>2.2.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.2.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.2.0...2.2.1</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.3.4...2.3.13</td><!-- keyple-card-calypso-java-lib -->
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
            <td>2.1.+</td><!-- keyple-plugin-java-api -->
            <td>2.3.0...2.3.1</td><!-- keyple-util-java-lib -->
            <td>2.2.0...2.2.1</td><!-- keyple-service-java-lib -->
            <td>2.1.0...2.1.1</td><!-- keyple-service-resource-java-lib -->
            <td>2.2.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.2.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.2.0...2.2.1</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.3.4...2.3.13</td><!-- keyple-card-calypso-java-lib -->
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
            <td>2.3.0...2.3.1</td><!-- keyple-util-java-lib -->
            <td>2.1.4</td><!-- keyple-service-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-service-resource-java-lib -->
            <td>2.2.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.2.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.2.0...2.2.1</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.3.4...2.3.13</td><!-- keyple-card-calypso-java-lib -->
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
            <td>2.3.0...2.3.1</td><!-- keyple-util-java-lib -->
            <td>2.1.3</td><!-- keyple-service-java-lib -->
            <td>2.0.0...2.0.2</td><!-- keyple-service-resource-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-local-java-lib -->
            <td>2.0.0</td><!-- keyple-distributed-network-java-lib -->
            <td>2.1.0</td><!-- keyple-distributed-remote-java-lib -->
            <td>2.3.4...2.3.13</td><!-- keyple-card-calypso-java-lib -->
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
            <td>2.3.0...2.3.1</td><!-- keyple-util-java-lib -->
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
            <td>2.3.0...2.3.1</td><!-- keyple-util-java-lib -->
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
            <td>2.3.0...2.3.1</td><!-- keyple-util-java-lib -->
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
            <td>2.3.0...2.3.1</td><!-- keyple-util-java-lib -->
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
            <td>2.3.0...2.3.1</td><!-- keyple-util-java-lib -->
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
            <td>2.3.0...2.3.1</td><!-- keyple-util-java-lib -->
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
            <td>2.3.0...2.3.1</td><!-- keyple-util-java-lib -->
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
    initDatatableDependencyCheckOld();
};
</script>
