> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Item|Renderer-Item-API]] ▸ **Document**

#Document
<dl><dt>Syntax</dt><dd><code>Item.Document</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/renderer/types/basics/item/document.litcoffee#itemdocument)

## Table of contents
* [Document](#document)
* [**Class** Document](#class-document)
  * [query](#query)
  * [node](#node)
  * [onNodeChange](#onnodechange)
* [Glossary](#glossary)

# **Class** Document

> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/renderer/types/basics/item/document.litcoffee)

##query
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; Document::query</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/renderer/types/basics/item/document.litcoffee#readonly-string-documentquery)

##node
<dl><dt>Syntax</dt><dd><code>&#x2A;Document.Element&#x2A; Document::node</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd><dt>Type</dt><dd><i>Document.Element</i></dd></dl>
##onNodeChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Document::onNodeChange(&#x2A;Document.Element&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Document.Element</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
```javascript
Text {
    text: this.document.node.props.value
}
```

```javascript
Text {
    document.onNodeChange: function(){
        var inputs = this.document.node.queryAll('input[type=string]');
    }
}
```

> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/renderer/types/basics/item/document.litcoffee#signal-documentonnodechangedocumentelement-oldvalue)

# Glossary

- [Item.Document](#class-document)

