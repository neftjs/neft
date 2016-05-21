> [Wiki](Home) ▸ [[API Reference|API-Reference]]

neft:attr
<dl><dt>Syntax</dt><dd><code>neft:attr @xml</code></dd></dl>
Tag used to dynamically change an attribute of the parent element.
```xml
<header neft:style="header">
    <neft:attr name="isActive" value="true" neft:if="${data.isActive}" />
    <span neft:if="${isActive}">You are active</span>
</header>
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file/parse/attrChanges.litcoffee#neftattr)

