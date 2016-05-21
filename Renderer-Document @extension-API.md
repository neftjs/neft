> [Wiki](Home) ▸ [API Reference](API-Reference)

Document
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/document.litcoffee#document-extension)

Document
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/document.litcoffee#document-document)

query
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/document.litcoffee#readonly-string-documentquery)

node
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

