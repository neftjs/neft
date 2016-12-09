# Document

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ [Item](/api/renderer-item.md) ▸ **Document**

<!-- toc -->

> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/document.litcoffee)


* * * 

### `query`

<dl><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/document.litcoffee#readonly-string-documentquery)


* * * 

### `node`

<dl><dt>Type</dt><dd><i>Document.Element</i></dd></dl>


* * * 

### `onNodeChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Document.Element</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/renderer/types/basics/item/document.litcoffee#signal-documentonnodechangedocumentelement-oldvalue)

