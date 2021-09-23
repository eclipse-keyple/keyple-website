---
title: Roadmap
---

# Current work
## Dependency removal:

 - Until the version 1.0.0, the source code of all the Keyple Java components was hosted in in a single repository: [https://github.com/eclipse/keyple-java](https://github.com/eclipse/keyple-java). It was the same for Keyple C++ components hosted in [https://github.com/eclipse/keyple-cpp](https://github.com/eclipse/keyple-cpp). For the version 1.0.0 and below, there were strong dependencies between the Keyple components which had all to be released in the same version number.
 - To facilitate the evolution and the maintenance, the version 2.0.0 proposes a full reorganization of the code. All the components are split in different repositories in order to allow them to evolve independently. The public interfaces are also separated to the specific implementations: the repositories are dedicated to host API or library implementation.
   - The Keyple Java components are managed through 16 repositories. 

## Calypso terminal compliance:

 - The 'Keyple Service' component in version 2.0.0 follows the 'Reader API 1.0' and 'Card API 1.0' standardized for the reader layer of Calypso terminals.
 - The 'Calypso extension' component in version 2.0.0 is also compliant with the 'Calypso API 1.0' standardized for the Calypso layer of Calypso terminals.

## Plugin support:

 - Thanks to the code reorganization, internal processing is more hidden. The version 2.0.0 defines a 'Plugin SPI' which is significantly reduced. The plugins could now be implemented without having to know how the Keyple Service works.

## Availability

 - The Keyple Java components will be released in version 2.0.0 beginning of October 2021.
 - The Keyple C++ 2.0.0 implementation is planned for November 2021 for the components: Service, Calypso, PC/SC plugin, the network client part of the distributed module.

# Future developments
Extension of the Calypso module features:

 - pre-personalization transaction (Change Key)
 - signature of data fields (SAM PSO commands)
 - confidential secure session (REV3.2 AES mode)
 - asymmetric authentication (REV3.3 PKI mode)
 - REV1/REV2 product specific supports
 - Hoplink high-level API
 - SAM Transaction API (for SAM management)

Standard plugins:

 - For Keyple C++, support of the NFC reader on iOS

# Version history
Until the version 2.0.0, all the different Keyple components (Core, Calypso extension, plugins) have to share the same version number. The components were released all together at a specific date for Jaa or C++.

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
    <td>2021/10<br>review in progress</td>
    <td>planned for 2021/11</td>
    <td><ul><li>Compliance with the Calypso terminal API</li><li>Removal of dependencies between components (Core, Calypso extension, and specific plugins): each component is released with its own version and a separate life cycle.</li></ul></td>
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
    <td><ul><li>Android plugins - NFC &amp; OMAPI plugins optimized for all Android versions</li><li>Calypso<ul><li>simplified high level API to parse the Portable Object APDU responses, &amp; recover the data through a card image.</li><li>addition of the support of the PO PIN feature, PO Stored Value transaction, &amp; the SAM lock</li></ul></li></ul></td>
  </tr>
  <tr>
    <td>0.8.1</td>
    <td>2020/01</td>
    <td>2020/05</td>
    <td><ul><li>Core - Observable Reader interface evolution to improve the support of smart card reader solutions.</li><li>Calypso - simplified high level API to build the Portable Object APDU commands (PO data still recovered through a lower API managing APDI response parser)</li></ul></td>
  </tr>
  <tr>
    <td>0.7.0</td>
    <td>2019/07</td>
    <td>-</td>
    <td>initial public java implementation<ul><li>Calypso - low level API to manage the common Calypso features (secure session for authentication, read and write commands of EF records)</li></ul></td>
  </tr>
</tbody>
</table>
