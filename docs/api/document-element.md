# Element

> **API Reference** ▸ [Document](/api/document.md) ▸ **Element**

<!-- toc -->

> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/document/element/element.litcoffee)


* * * 

### `Element.fromHTML()`

<dl><dt>Static method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li>html — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/document/element/element.litcoffee#element-elementfromhtmlstring-html)


* * * 

### `Element.fromJSON()`

<dl><dt>Static method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li>json — <i>String</i> or <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/document/element/element.litcoffee#element-elementfromjsonarraystring-json)


* * * 

### `constructor()`

<dl><dt>Returns</dt><dd><i>Element</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/document/element/element.litcoffee#element-elementconstructor)


* * * 

### `index`

<dl><dt>Type</dt><dd><i>Integer</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/document/element/element.litcoffee#integer-elementindex)


* * * 

### `nextSibling`

<dl><dt>Type</dt><dd><i>Element</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/document/element/element.litcoffee#element-elementnextsibling)


* * * 

### `previousSibling`

<dl><dt>Type</dt><dd><i>Element</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/document/element/element.litcoffee#element-elementprevioussibling)


* * * 

### `parent`

<dl><dt>Type</dt><dd><i>Element</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/document/element/element.litcoffee#element-elementparent)


* * * 

### `onParentChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Element</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/document/element/element.litcoffee#signal-elementonparentchangeelement-oldvalue)


* * * 

### `style`

<dl><dt>Type</dt><dd><i>Renderer.Item</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/document/element/element.litcoffee#rendereritem-elementstyle)


* * * 

### `onStyleChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Renderer.Item</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/document/element/element.litcoffee#signal-elementonstylechangerendereritem-oldvalue)


* * * 

### `visible`

<dl><dt>Type</dt><dd><i>Boolean</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/document/element/element.litcoffee#boolean-elementvisible)


* * * 

### `onVisibleChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/document/element/element.litcoffee#signal-elementonvisiblechangeboolean-oldvalue)


* * * 

### `queryAllParents()`

<dl><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/document/element/element.litcoffee#array-elementqueryallparentsstring-query)


* * * 

### `queryParents()`

<dl><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/document/element/element.litcoffee#element-elementqueryparentsstring-query)


* * * 

### `getAccessPath()`

<dl><dt>Parameters</dt><dd><ul><li>toParent — <i>Tag</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/document/element/element.litcoffee#array-elementgetaccesspathtag-toparent)


* * * 

### `clone()`

<dl><dt>Returns</dt><dd><i>Element</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/document/element/element.litcoffee#element-elementclone)


* * * 

### `toJSON()`

<dl><dt>Returns</dt><dd><i>Array</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/document/element/element.litcoffee#array-elementtojson)

