# Document

> **API Reference** ▸ **Document**

<!-- toc -->

> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/document/index.litcoffee)


* * * 

### `Document.onBeforeRender()`

<dl><dt>Static property of</dt><dd><i>Document</i></dd><dt>Parameters</dt><dd><ul><li>file — <i>Document</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>

Corresponding node handler: *n-onBeforeRender=""*.


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/document/index.litcoffee#signal-documentonbeforerenderdocument-file)


* * * 

### `Document.onRender()`

<dl><dt>Static property of</dt><dd><i>Document</i></dd><dt>Parameters</dt><dd><ul><li>file — <i>Document</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>

Corresponding node handler: *n-onRender=""*.


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/document/index.litcoffee#signal-documentonrenderdocument-file)


* * * 

### `Document.onBeforeRevert()`

<dl><dt>Static property of</dt><dd><i>Document</i></dd><dt>Parameters</dt><dd><ul><li>file — <i>Document</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>

Corresponding node handler: *n-onBeforeRevert=""*.


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/document/index.litcoffee#signal-documentonbeforerevertdocument-file)


* * * 

### `Document.onRevert()`

<dl><dt>Static property of</dt><dd><i>Document</i></dd><dt>Parameters</dt><dd><ul><li>file — <i>Document</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>

Corresponding node handler: *n-onRevert=""*.


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/document/index.litcoffee#signal-documentonrevertdocument-file)


* * * 

### `Document.fromHTML()`

<dl><dt>Static method of</dt><dd><i>Document</i></dd><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li><li>html — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Document</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/document/index.litcoffee#document-documentfromhtmlstring-path-string-html)


* * * 

### `Document.fromElement()`

<dl><dt>Static method of</dt><dd><i>Document</i></dd><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li><li>element — <i>Element</i></li></ul></dd><dt>Returns</dt><dd><i>Document</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/document/index.litcoffee#document-documentfromelementstring-path-element-element)


* * * 

### `Document.fromJSON()`

<dl><dt>Static method of</dt><dd><i>Document</i></dd><dt>Parameters</dt><dd><ul><li>json — <i>Object</i> or <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Document</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/document/index.litcoffee#document-documentfromjsonstringobject-json)


* * * 

### `Document.parse()`

<dl><dt>Static method of</dt><dd><i>Document</i></dd><dt>Parameters</dt><dd><ul><li>file — <i>Document</i></li></ul></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/document/index.litcoffee#documentparsedocument-file)


* * * 

### `Document.factory()`

<dl><dt>Static method of</dt><dd><i>Document</i></dd><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Document</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/document/index.litcoffee#document-documentfactorystring-path)


* * * 

### `constructor()`

<dl><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li><li>element — <i>Element</i></li></ul></dd><dt>Returns</dt><dd><i>Document</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/document/index.litcoffee#document-documentconstructorstring-path-element-element)


* * * 

### `render()`

<dl><dt>Parameters</dt><dd><ul><li>props — <i>Any</i> — <i>optional</i></li><li>context — <i>Any</i> — <i>optional</i></li><li>source — <i>Document</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Document</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/document/index.litcoffee#document-documentrenderany-props-any-context-document-source)


* * * 

### `revert()`

<dl><dt>Returns</dt><dd><i>Document</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/document/index.litcoffee#document-documentrevert)


* * * 

### `use()`

<dl><dt>Parameters</dt><dd><ul><li>useName — <i>String</i></li><li>document — <i>Document</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Document</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/document/index.litcoffee#document-documentusestring-usename-document-document)


* * * 

### `onReplaceByUse()`

<dl><dt>Parameters</dt><dd><ul><li>use — <i>Document.Use</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>

Corresponding node handler: *n-onReplaceByUse=""*.


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/document/index.litcoffee#signal-documentonreplacebyusedocumentuse-use)


* * * 

### `clone()`

<dl><dt>Returns</dt><dd><i>Document</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/document/index.litcoffee#document-documentclone)


* * * 

### `destroy()`

> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/document/index.litcoffee#documentdestroy)


* * * 

### `toJSON()`

<dl><dt>Returns</dt><dd><i>Object</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/3dc9f5366bf00b190122a2aec6eec7c6b4593c4f/src/document/index.litcoffee#object-documenttojson)

