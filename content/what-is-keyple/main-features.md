+++
title = "Keyple's main features"
subtitle = ""
summary = "Keyple makes contactless ticketing accessible."
date = ""

weight = 50
+++

The goal of Eclipse Keyple® is to allow developers to easily implement fast and secure off-line contactless transactions 
(using NFC cards, mobile phones, …) based on ticket processing integrating technologies other than Calypso® the Calypso standard.

More specifically, Keyple is a set of open source libraries that will initially be available in Java and C++, 
designed on the same mutual Object-Oriented Model compatible with any terminal architecture: mobile, embedded 
or server and Interoperable with any smart card reader solution: standard or proprietary, local or remote.

To fully understand how Keyple works, it is important to discern two main components of contactless ticketing technology:
- **Smart Card Readers**: Readers are situated at the entrance and exit of events, venues and transport sites. 
For example, a smart card reader could be a terminal, a portable scanning laser gun, or a swipe tablet area that is embedded 
into a door, vehicle or gate. Code is written for a terminal to set the parameters for allowing cards or apps to transmit 
ticketing information data. Sometimes in a distributed architecture system design, the code for the reader is not on the 
terminal, but in a cloud environment, so the reader sends the data to cloud-based architecture.  
- **Ticketing application**: This is behind-the-scenes code that is able to take the data from the smart card reader 
and, in milliseconds real-time, analyze the balance of the ticket, confirm the permissions for entry, and update the data 
on the ticket (for example, to confirm that the ticket holder can enter the gate or vehicle, and then to deduct the cost 
of the journey and calculate the new balance).

**According to this scheme, Keyple defines two layers:**
- **Smart Card readers** are integrated through plugins implementing the SE Proxy API which manages the communications with 
a smart card through any type of contactless or contact reader (local, remote, standard, proprietary…)
- **Ticketing applications** relies on a high-level Calypso® processing API to manage Calypso® commands & security features. 
This API uses the SE Proxy API to communicate with the reader


Keyple comes with dedicated plugins that integrate directly with smart card readers that have been built on standard 
software interfaces including PC/SC, Android NFC reader, and Android OMAPI. 

In cases where there is a distributed architecture design, Keyple includes a Remote API plugin so that 
a smart card terminal can be operated remotely, as if it were local to the terminal, and ensures that robust security and 
speed is not sacrificed in a cloud-based system. 

The Calypso Processing API is also available as a Keyple extension. This component carries out the terminal processing 
element of ticketing technology. Access to Calypso’s security features are automatically managed by the Keyple extension. 
