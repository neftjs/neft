> [Wiki](Home) ▸ [[API Reference|API-Reference]]

Document
<dl><dt>Syntax</dt><dd><code>Document @extension</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/document.litcoffee#document)

Document
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Document()</code></dd><dt>Returns</dt><dd><i>Document</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/document.litcoffee#document)

query
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; Document::query</code></dd><dt>Prototype property of</dt><dd><i>Document</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/document.litcoffee#query)

node
<dl><dt>Syntax</dt><dd><code>&#x2A;Document.Element&#x2A; Document::node</code></dd><dt>Prototype property of</dt><dd><i>Document</i></dd><dt>Type</dt><dd><i>Document.Element</i></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/document.litcoffee#node)

