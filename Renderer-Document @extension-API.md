> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Document @extension**

Document @extension
===================

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/document.litcoffee#document-extension)

## Table of contents
  * [Document()](#document-document)
  * [query](#readonly-string-documentquery)
  * [*Document.Element* node](#documentelement-documentnode)

*Document* Document()
---------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/document.litcoffee#document-document)

ReadOnly *String* Document::query
---------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/document.litcoffee#readonly-string-documentquery)

*Document.Element* Document::node
---------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Document::onNodeChange(*Document.Element* oldValue)

```nml
`Text {
`  text: this.document.node.attrs.value
`}
```
```nml
`Text {
`   document.onNodeChange: function(){
`       var inputs = this.document.node.queryAll('input[type=string]');
`   }
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/document.litcoffee#documentelement-documentnode-signal-documentonnodechangedocumentelement-oldvalue)

