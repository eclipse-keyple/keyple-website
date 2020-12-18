---
title: Keyple Calypso
type: book
toc: true
draft: false
weight: 130
---


## Features / packages and corresponding usages

The Calypso transaction API provides a high-level of abstraction to define functional commands to manage a secure session with a Calypso Portable Object, to update or authenticate its data.

The transaction API is defined on a low-level Calypso commands API which contains the builders of PO and SAM APDU commands, and the corresponding parsers of APDU responses. This internal library is deprecated, and will be refactorized for the version 2.0.0 of Keyple Calypso.

<table>
<thead>
  <tr>
    <th>Package</th>
    <th>API<br/>level</th>
    <th>Feature</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td width="50%">org.eclipse.keyple.calypso.<b>transaction</b></td>
    <td width="8%">high</td>
    <td>Calypso Portable Object commands and secure transaction management<br/>
      <ul><li>CalypsoAPI, commands’ settings are limited to functional parameters<br/></li>
        <li>Calypso SAM (Secure Module) operations automatically processed<br/></li></ul>
      (only functional parameters)</td>
  </tr>
  <tr>
    <td>org.eclipse.keyple.calypso.<b>command</b><br/>
      org.eclipse.keyple.calypso.<b>command</b>.po<br/>
      org.eclipse.keyple.calypso.<b>command</b>.po.builder<br/>
      org.eclipse.keyple.calypso.<b>command</b>.po.parser<br/>
      org.eclipse.keyple.calypso.<b>command</b>.po.parser.session<br/>
      org.eclipse.keyple.calypso.<b>command</b>.sam<br/>
      org.eclipse.keyple.calypso.<b>command</b>.sam.builder<br/>
      org.eclipse.keyple.calypso.<b>command</b>.sam.parser<br/>
      org.eclipse.keyple.calypso.<b>command</b>.sam.parser.session</td>
    <td>low</td>
    <td>Calypso PO &amp; SAM APDU commands' sets<br/>
      <ul><li>APDU command builders<br/></li>
        <li>APDU response parsers<br/></li></ul>
      (technical parameter settings specific to the PO &amp; SAM revisions)<br></td>
  </tr>
</tbody>
</table>

Ticketing terminal applications must import only the high-level Calypso transaction package.

{{< figure library="true" src="architecture/KeypleCalypso_Packages.svg" title="Calypso packages" >}}

<!-- The only exception is the implementation a Calypso PO/SAM test tool, the setting of low-level APDU commands with wrong settings could require the usage of the Calypso command packages. -->

## Calypso Portable Object Selection
Compared to the generic Card Selection API (cf. https://keyple.org/docs/architecture/keyple-core/#card-selection), a PO Selector could be defined to accept only non-invalidated Portable Object (in this cas an invalidated PO isn't selected).

In addition, a PO Selection Request provides methods:

 - to prepare Select File command (useful in particular to manage REV1 Calypso PO for which the select of the targeted DF is required).
 - and to prepare simple read record command (useful to optimize the read of a file present on all targeted PO).

The matching SmartCard resulting from a PO Selection Request is a Calypso PO. In case file records have been read during the selection: the corresponding data could be recovered in the Calypso PO card image.

{{< figure library="true" src="architecture/KeypleCalypso_Transaction_ClassDiag_PO_Selection_1_0_0.svg" title="Calypso Selection v1.0.0" >}}

## Calypso Portable Object Transaction

A Card Resource is a set of a Reader and a **selected** Card application.

 - A Calypso Portable Object is the image of a selected Calypso PO.
 - A Calypso SAM is the image of a selected Calypso SAM.

To operate a Calypso transaction:

 - At least a Calypso Resource (CardResource&lt;CalypsoPo&gt;) is required.
 - A SAM Resource ((CardResource&lt;CalypsoSam&gt;) is required too if security features are involved (Calypso secure session, Stored value transaction, PIN encryption, etc…).

A Calypso PO image provides public ‘getters’ in order to **recover** the information of the selected PO (startup data, file data, … etc).

A transaction with a Calypso PO is fully managed through the PoTransaction object:

 - First a set of PO commands could be defined through ‘**prepare**’ commands.
 - Next the prepared PO commands transmitted when operating a ‘**process**’ command.
 - The responses of the PO are then recovered through the Calypso PO image.

{{< figure library="true" src="architecture/KeypleCalypso_Transaction_ClassDiag_Overview.svg" title="Calypso API Global Architecture" >}}

### Calypso card image
When read commands have been exchanged with a Calypso PO, the corresponding data could be recovered by parsing the file structure of the PO card image.

{{< figure library="true" src="architecture/KeypleCalypso_Transaction_ClassDiag_CalypsoPo_1_0_0.svg" title="Calypso PO card image" >}}

### Calypso transaction
Only the 'process' methods generate communication with the Calypso PO and SAM.
 - processPoCommands is used to transmit a set of prepared PO commands (outside or inside a secure session).
 - processOpening issues an Open Secure Session followed by the prepared PO commands.
 - processClosing issues the last prepared PO commands and transmits a Close Secure Session.
<!---
 - prepareManageSession allows to change authenticate or change the encryption mode.
-->

The prepareReleaseChannel method allows to the logical channel with the Calypso PO at the end of the processing of the next process method.

{{< figure library="true" src="architecture/KeypleCalypso_Transaction_ClassDiag_PoTransaction_1_0_0.svg" title="Calypso transaction" >}}

## Data model extension

{{< figure library="true" src="architecture/KeypleCalypso_Transaction_ClassDiag_SpecificPoTransaction_1_0_0.svg" title="Calypso Data Model" >}}

## Secure session sequence

{{< figure library="true" src="architecture/KeypleCalypso_Transaction_SequenceDiag_SecureSessionProcessing_1_0_0.svg" title="Calypso session" >}}
