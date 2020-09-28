---
title: (WIP)Develop a Ticketing Application
type: book
toc: true
draft: false
weight: 310
---

## Test shortcode "java-kotlin-cpp"

{{% java-kotlin-cpp 
java=`SelectionsResult selectionsResult = seSelection.processExplicitSelection(reader);
if (selectionsResult.hasActiveSelection()) {
    MatchingSe matchingSe = selectionsResult.getActiveMatchingSe();
}`  
kotlin=`val selectionsResult = seSelection.processExplicitSelection(reader)
if (selectionsResult.hasActiveSelection()) {
    val matchingSe = selectionsResult.activeMatchingSe
}` 
cpp=`if (selectionResult->hasActiveSelection()) {
    std::shared_ptr<MatchingSelection> matchingSelection =
        selectionResult->getActiveSelection();
    std::shared_ptr<CalypsoPo> calypsoPo =
        std::dynamic_pointer_cast<CalypsoPo>(
            matchingSelection->getMatchingSe());`
%}}

## Standard code insertion

```kotlin
//nativeReader is an instance of android.se.omapi.Reader
override fun checkSePresence(): Boolean {
    return nativeReader.isSecureElementPresent
}
```