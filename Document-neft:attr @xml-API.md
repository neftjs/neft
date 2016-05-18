> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **neft:attr @xml**

neft:attr @xml
==============

Tag used to dynamically change an attribute of the parent element.
```xml
<header neft:style="header">
    <neft:attr name="isActive" value="true" neft:if="${data.isActive}" />
    <span neft:if="${isActive}">You are active</span>
</header>
```

> [`Source`](/Neft-io/neft/tree/master/src/document/file/parse/attrChanges.litcoffee#neftattr-xml)

