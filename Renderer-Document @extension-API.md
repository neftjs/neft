> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
Document
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/document.litcoffee#document-extension)

<dl><dt>Returns</dt><dd><i>Document</i></dd></dl>
Document
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/document.litcoffee#document-document)

<dl><dt>Prototype property of</dt><dd><i>Document</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>read only</dt></dl>
query
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/document.litcoffee#readonly-string-documentquery)

## Table of contents
    * [Document](#document)
    * [Document](#document)
    * [query](#query)
  * [*Document.Element* Document::node](#documentelement-documentnode)

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

