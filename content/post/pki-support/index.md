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

Since April, Keyple supports sessions secured by public key cryptography on Calypso Prime PKI cards.
This makes it possible to perform strong authentication of data read from the card, without the need for a SAM.

#### Keypop APIs for PKI-based Ticketing Systems

The latest Keypop APIs dedicated to Public Key Infrastructure (PKI) offer integrators the flexibility to define any
type of chain-of-trust model for a PKI-based ticketing system.

#### Extensible Certificate Format Support

The Keyple libraries natively support the card (CardCert) and authority (CACert) certificate formats defined in the
Calypso Prime PKI specification.

However, they can be extended to support any other certificate format,
allowing for seamless integration with various PKI implementations.

#### Modular Cryptographic Processing

Keyple's internal interfaces for managing cryptographic processing have been designed, like most Keyple components, as
separate libraries to enable upgrades and modifications independently of Keyple-based ticketing terminal applications.

For asymmetric cryptographic computations (ECC/RSA),
Keyple provides a specific library using the Java Runtime Environment libraries 
and the open-source Bouncy Castle libraries.
However, ticketing integrators have the option to use Keyple Calypso Card extension with their own cryptographic
engine implementations, enabling support for any certificate formats.

Keyple already supports such scheme for the support of secure card sessions with a SAM module,
being prepared to seamlessly integrate the future OpenSAM solution.
This forward-thinking design allows for easy adoption of emerging security technologies.
