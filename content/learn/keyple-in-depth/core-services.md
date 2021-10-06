---
title: Core services
summary: In-depth technical information about Keyple core services.
type: book
toc: true
weight: 10
---

---
## Overview

You can find here some in-depth technical information about Keyple core services.

---
## Observable reader states

An observable reader is active only when at least one reader observer is registered, and if the start of the detection has been requested.
When active, an observable reader could switch between three internal states:
* **Wait for card insertion**
* **Wait for card processing**
* **Wait for card removal**

In the nominal case, a reader observer indicates to the observable reader that the processing of the card is finished by releasing the card channel.
To manage a failure of the reader observer process, the observable reader interface provides also a method to finalize the card processing.

{{< figure library="true" src="learn/keyple-in-depth/reader_observation_state_machine.svg" caption="Observable reader states" numbered="true" >}}

The states could be switched:
- due to an explicit API request (blue arrows):
    - the release of the card channel,
    - the call of an observable reader method:
        - the addition or the remove of an observable reader,
        - a request to start or stop the detection, to finalize the card processing.
- Or because of an external event (red arrows), the insertion or the remove of a card.
    - the insertion of a card causing the observable reader to notify a `CARD_MATCHED` reader event (in case of successful scheduled selection) or a `CARD_INSERTED` reader event (notification mode defined as `ALWAYS`).
    - the removal of a card causing the observable reader to notify a `CARD_REMOVED` reader event.

If a card detection is started with the `REPEATING` detection mode, then later when the card is removed, the reader starts again the detection of a new card.

Notification of card removal during the card removal wait state is a feature of any observable reader.
However, some observable readers may additionally have the ability to notify removal during the card processing state.

---
## Card selection modes

Depending on the card transaction use case, or on the reader capability, there are two ways to manage the selection of a card:
- Either on a simple reader, a selection could be operated directly by transmitting the card selection scenario. In this case the same entity manages both the card selection and the card processing.
- Otherwise, on an observable reader, a scheduled card selection could be defined. In this case the card selection is operated automatically at the insertion of the card. In this case, the card selection is next managed by the observable reader, but the card processing is managed by a reader observer.

{{< figure library="true" src="learn/keyple-in-depth/card_selection_modes_activity_diagram.svg" caption="Card selection modes" numbered="true" width="50%" >}}

---
## Internal adapters (release)

### Service

![coming soon!](https://raw.githubusercontent.com/eclipse/keyple-service-java-lib/{{% keyple-service-java-lib-version %}}/src/main/uml/adapter_class_diagram.svg)

### Card resource service

![coming soon!](https://raw.githubusercontent.com/eclipse/keyple-service-resource-java-lib/{{% keyple-service-resource-java-lib-version %}}/src/main/uml/adapter_class_diagram.svg)

### Distributed

![coming soon!](https://raw.githubusercontent.com/eclipse/keyple-distributed-network-java-lib/{{% keyple-distributed-network-java-lib-version %}}/src/main/uml/adapter_class_diagram.svg)

---
## Internal adapters (snapshot)

### Service

![coming soon!](https://raw.githubusercontent.com/eclipse/keyple-service-java-lib/main/src/main/uml/adapter_class_diagram.svg)

### Card resource service

![coming soon!](https://raw.githubusercontent.com/eclipse/keyple-service-resource-java-lib/main/src/main/uml/adapter_class_diagram.svg)

### Distributed

![coming soon!](https://raw.githubusercontent.com/eclipse/keyple-distributed-network-java-lib/main/src/main/uml/adapter_class_diagram.svg)
