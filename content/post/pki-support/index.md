---
title: "Keyple supports Calypso Prime PKI cards!"
summary: "Since April, Keyple supports sessions secured by public key cryptography on Calypso Prime PKI cards.
    This makes it possible to perform strong authentication of data read from the card, without the need for a SAM."
authors: [ Calypso Networks Association ]
tags: [ "Eclipse", "Keyple", "Keypop", "Release", "OpenSource", "Middleware", "API", "Ticketing", "PKI" ]
categories: [ Release ]
date: 2024-05-29T00:00:00+01:00
featured: false
draft: false
---

Since April, Keyple supports sessions secured by public key cryptography on Calypso Prime PKI cards. This enables
strong authentication of both the card and the data read from it, without necessarily requiring a SAM.

#### Keypop APIs for PKI-based Ticketing Systems

The Keypop Calypso Card Java API now includes features for managing Public Key Infrastructure (PKI) mode, offering
integrators the flexibility to define any type of chain-of-trust model for a PKI-based ticketing system.

#### Extensible Certificate Format Support

The Keyple libraries natively support the card (CardCert) and authority (CACert) certificate formats defined in the
Calypso Prime PKI specification. Moreover, they have been designed for easy extension to support any other
certificate format, ensuring seamless integration with various PKI implementations.

#### Modular Cryptographic Processing

Like most other Keyple components, Keyple’s internal interfaces for managing cryptographic processing are designed as
separate libraries. This modular design allows for upgrades and modifications independent of Keyple-based ticketing
terminal applications.

For asymmetric cryptographic computations (ECC/RSA), Keyple provides a specific library using Java Runtime Environment
libraries and the open-source “Bouncy Castle” libraries. Ticketing integrators can also opt to use Keyple Calypso Card
extensions with their own cryptographic engine implementations, supporting any certificate format.

Keyple already supports such a scheme for secure card sessions with a SAM module and is prepared to seamlessly integrate
the future OpenSAM solution.

