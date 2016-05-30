> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Item|Renderer-Item-API]] ▸ **Document**

#Document
<dl><dt>Syntax</dt><dd><code>Item.Document</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/document.litcoffee#document)

## Table of contents
* [Document](#document)
* [**Class** Document](#class-document)
  * [query](#query)
  * [node](#node)
* [Glossary](#glossary)

# *[Class](/Neft-io/neft/wiki/Renderer-Class-API#class-class)* Document

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/document.litcoffee#class-document)

##query
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; Document::query</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/document.litcoffee#query)

##node
<dl><dt>Syntax</dt><dd><code>&#x2A;Document.Element&#x2A; Document::node</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd><dt>Type</dt><dd><i>Document.Element</i></dd></dl>
```javascript
Text {
    text: this.document.node.attrs.value
}
```

```javascript
Text {
    document.onNodeChange: function(){
        var inputs = this.document.node.queryAll('input[type=string]');
    }
}
```

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/document.litcoffee#node)

# Glossary

- [Item.Document](#class-document)

