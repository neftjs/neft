> [Wiki](Home) ▸ [API Reference](API-Reference)

Document
<dl><dt>Syntax</dt><dd>Document @extension</dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/document.litcoffee#document-extension)

Document
<dl><dt>Syntax</dt><dd>*Document* Document()</dd><dt>Returns</dt><dd><i>Document</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/document.litcoffee#document-document)

query
<dl><dt>Syntax</dt><dd>ReadOnly *String* Document::query</dd><dt>Prototype property of</dt><dd><i>Document</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/document.litcoffee#readonly-string-documentquery)

node
<dl><dt>Syntax</dt><dd>*Document.Element* Document::node</dd><dt>Prototype property of</dt><dd><i>Document</i></dd><dt>Type</dt><dd><i>Document.Element</i></dd></dl>
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

