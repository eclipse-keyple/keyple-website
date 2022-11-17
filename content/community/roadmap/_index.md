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
 - New enhancements are planned for the Calypso library
   - confidential secure session (REV3.2 Prime Extended based on AES)
   - asymmetric authentication (REV3.3 Prime PKI based on ECC)
   - REV1/REV2 product specific supports
 - Looking to migrate the Java implementation in Kotlin Multiplatform in order to handle iOS & some native target for ticketing application based on a generic code compliant with Java environment.
 - Refactoring of the Calypso API to support extensions of different kind of Calypso SAM solutions (current legacy SAM-C1, coming Open-SAM).

## Future developments
A Hoplink extension will be proposed (based on a high-level API on top of the Calypso API).

## Version history
### Evolutions of the Keyple components after the version 2.0.0 of the SDK

<table>
<thead>
  <tr>
    <th rowspan="2">Component</th>
    <th rowspan="2">Version</th>
    <th colspan="2">Availability Date</th>   
    <th rowspan="2">Description</th>
  </tr>
  <tr>
    <th>Java</th>
    <th>C++</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Calypso lib</td>
    <td>2.1</td>
    <td>2022/02</td>
    <td>2022/08</td>
    <td><ul><li><b>Support of the full card command set of Calypso Prime Regular</b>
    <ul><li>For the Get Data command, addition of the mode 'EF list' & 'traceability',</li>
    <li>Binary files' access for read, write, & update,</li>
    <li>Read Record Multiple, Search Record Multiple, Increase Multiple & Decrease Multiple</li>
    <li>Pre-personalization : possibility to personalized keyset with Change Key</li></ul>
    </ul></li></td>
  </tr>
  <tr>
    <td>Calypso lib</td>
    <td>2.2</td>
    <td>2022/06</td>
    <td><mark>planned for 2022/11</mark></td>
    <td><ul><li><b>SAM operation improvements</b>
    <ul><li>Defintion of an API to operate standalone SAM transaction</li>
    <li>Support of the PSO data signature feature: signature generation & verification. Possibility to operate a signature operation through the Card Transaction or a SAM Transaction.</li></ul></li></ul></td>
  </tr>
  <tr>
    <td>Calypso lib</td>
    <td>2.3</td>
    <td><mark>planned for 2022/12</mark></td>
    <td>-</td>
   <td><ul><li><b>Support of Calypso Prime PKI</b>
    <ul><li>Asymetric authentication of a Calypso card without involving a SAM</li>
    </ul></li></ul></td>
  </tr>
  <tr>
    <td>Calypso lib</td>
    <td>2.4</td>
    <td><mark>planned for 2023/Q1</mark></td>
    <td></td>
    <td><ul><li><b>Support of Calypso Prime Extended</b>
    <ul><li>Capability to operate a Calypso secure session in confidential mode</li>
    </ul></li></ul></td>
  </tr>
    <tr>
    <td>Calypso lib</td>
    <td>3.0</td>
    <td><mark>planned for 2023/Q1</mark></td>
    <td></td>
    <td><ul><li><b>Extended API to interface Calypso SAM solutions</b>
    <ul><li>Full management of the legacy SAM-C1 (Control SAM to target SAM transactions)</li>
    <li>Preparation to support the new Calypso Open SAM</li>
    </ul></li></ul></td>
  </tr>
</tbody>
</table>


### Global evolutions to the Keyple SDK until version 2.0.0 <mark>(obsolete)</mark>
Until the version 2.0.0 of Keyple, the components of Keyple Java or Keyple C++ were released at the same time with the same version number.
The porting in C++ of Keyple Java is based on the same Object-Oriented Model. The Keyple C++ implemntation provides the same core & Calypso feature, but the support of the distributed module isn't part of the scope, and for reader integration, only the PC/SC reader is provided.

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
    <td>planned for 2022/03</td>
   <td><ul><li><b>Calypso terminal compliance</b>
   <ul><li>The <a href="https://keyple.org/components-java/core/keyple-service-java-lib/">Keyple Service</a> component implements the <a href="https://terminal-api.calypsonet.org/apis/calypsonet-terminal-reader-api/">Reader API 1.0</a> and <a href="https://terminal-api.calypsonet.org/apis/calypsonet-terminal-card-api/">Card API 1.0</a> standardized for the reader layer of Calypso terminals. The implementation is compliant with the <a href="https://calypsonet.org/calypso-for-terminals/">reader layer requirements</a> for Calypso terminals</li>
   <li>The <a href="https://keyple.org/components-java/card-extensions/keyple-card-calypso-java-lib/">Calypso card extension</a> library in version 2.0.0 follows also the <a href="https://calypsonet.org/calypso-for-terminals/">Calypso layer requirements</a> defined for Calypso terminals, it implements the <a href="https://terminal-api.calypsonet.org/apis/calypsonet-terminal-calypso-api/">Calypso API 1.0</a>.</li></ul>
    <li><b>Removal of dependencies</b> between Keyple components (Core, Calypso extension, and specific plugins): all components are released with their own version number and could evolve separately.
     <ul><li>Until the version 1.0.0, the source code of all the Keyple Java components was hosted in a single repository: <a href="https://github.com/eclipse/keyple-java">https://github.com/eclipse/keyple-java</a>. It was the same for Keyple C++ components hosted in <a href="https://github.com/eclipse/keyple-cpp">https://github.com/eclipse/keyple-cpp</a>. For the version 1.0.0 and below, there were strong dependencies between the Keyple components which had all to be released in the same version number.</li>
<li>To facilitate the evolution and the maintenance, the version 2.0.0 proposes a full reorganization of the code. All the components are split in different repositories in order to allow them to evolve independently. The public interfaces are also separated to the specific implementations: the repositories are dedicated to host API or library implementation.</li>
<li>The Keyple Java components are managed through <a href="https://keyple.org/project-dashboard/">16 repositories</a>.</li>
     </li></ul>
     <li>The API for plugin implementation and for distributed architecture configuration have been simplified</li></ul></td>
  </tr>
  <tr>
    <td>1.0.0</td>
    <td>2020/12</td>
    <td>dropped</td>
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
