Document @extension
===================

*Document* Document()
---------------------

ReadOnly *String* Document::query
---------------------------------

*Document.Element* Document::node
---------------------------------

## *Signal* Document::onNodeChange(*Document.Element* oldValue)

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

