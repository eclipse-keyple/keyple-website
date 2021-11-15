---
title: Eclipse Keyple® project roadmap
linktitle: Roadmap
summary: Overview of past and future Keyple Releases.
type: book
toc: true
weight: 2
---

---
## Current work
 - The porting of Keyple 2.0.0 in C++ is in progress.
 - New enhancements are planned for the Calypso library
   - pre-personalization transaction (Change Key)
   - signature of data fields (SAM PSO commands)
   - confidential secure session (REV3.2 AES mode)
   - asymmetric authentication (REV3.3 PKI mode)
   - REV1/REV2 product specific supports
   - SAM Transaction API (for SAM management)
 - Looking to provide a NFC reader plugin for iOS sytems.

## Future developments
A Hoplink extension will be proposed (based on a high-level API on top of the Calypso API).

## Version history
<table>
<thead>
  <tr>
    <th>Release</th>
    <th>Java</th>
    <th>C++</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>2.0.0</td>
    <td>2021/10</td>
    <td>planned for 2021/12</td>
   <td><ul><li><b>Calypso terminal compliance</b>
   <ul><li>The <a href="https://keyple.org/components-java/core/keyple-service-java-lib/">Keyple Service</a> component implements the <a href="https://terminal-api.calypsonet.org/">Reader API 1.0</a> and <a href="https://terminal-api.calypsonet.org/">Card API 1.0</a> standardized for the reader layer of Calypso terminals. The implementation is compliant with the <a href="https://calypsonet.org/calypso-for-terminals/">reader layer requirements</a> for Calypso terminals</li>
   <li>The <a href="https://keyple.org/components-java/card-extensions/keyple-card-calypso-java-lib/">Calypso card extension</a> library in version 2.0.0 follows also the <a href="https://calypsonet.org/calypso-for-terminals/">Calypso layer requirements</a> defined for Calypso terminals, it implements the <a href="https://terminal-api.calypsonet.org/">Calypso API 1.0</a>.</ul></li>
    <li><b>Removal of dependencies</b> between Keyple components (Core, Calypso extension, and specific plugins): all components are released with their own version number and could evolve separately.
     <ul><li>Until the version 1.0.0, the source code of all the Keyple Java components was hosted in a single repository: <a href="https://github.com/eclipse/keyple-java">https://github.com/eclipse/keyple-java</a>. It was the same for Keyple C++ components hosted in <a href="https://github.com/eclipse/keyple-cpp">https://github.com/eclipse/keyple-cpp</a>. For the version 1.0.0 and below, there were strong dependencies between the Keyple components which had all to be released in the same version number.</li>
<li>To facilitate the evolution and the maintenance, the version 2.0.0 proposes a full reorganization of the code. All the components are split in different repositories in order to allow them to evolve independently. The public interfaces are also separated to the specific implementations: the repositories are dedicated to host API or library implementation.</li>
<li>The Keyple Java components are managed through <a href="https://keyple.org/projects-dashboard/">16 repositories</a>.</li>
     </li></ul>
     <li>The API for plugin implementation and for distributed architecture configuration have been simplified</li></ul></td>
  </tr>
  <tr>
    <td>1.0.0</td>
    <td>2020/12</td>
    <td>not planned</td>
    <td><ul><li>Core - simplifications of the low-level Plugin API dedicated for plugin developers.</li><li>Remote Plugin - new stable &amp; simpler version</li></ul>Main unsolved issue: the versioning of the different components (Core, Calypso extension, and specific plugins) is still linked: to manage transitive importation the artifact are built with the same version reference.</td>
  </tr>
  <tr>
    <td>0.9.0</td>
    <td>2020/09</td>
    <td>2021/01</td>
    <td><ul><li>Android plugins - NFC &amp; OMAPI plugins optimized for all Android versions</li><li>Calypso<ul><li>simplified high-level API to parse the Portable Object APDU responses, &amp; recover the data through a card image.</li><li>addition of the support of the PO PIN feature, PO Stored Value transaction, &amp; the SAM lock</li></ul></li></ul></td>
  </tr>
  <tr>
    <td>0.8.1</td>
    <td>2020/01</td>
    <td>2020/05</td>
    <td><ul><li>Core - Observable Reader interface evolution to improve the support of smart card reader solutions.</li><li>Calypso - simplified high-level API to build the Portable Object APDU commands (PO data still recovered through a lower API managing APDI response parser)</li></ul></td>
  </tr>
  <tr>
    <td>0.7.0</td>
    <td>2019/07</td>
    <td>-</td>
    <td>initial public java implementation<ul><li>Calypso - low-level API to manage the common Calypso features (secure session for authentication, read and write commands of EF records)</li></ul></td>
  </tr>
</tbody>
</table>
