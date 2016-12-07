# Tag

> **API Reference** ▸ [Document](/api/document.md) ▸ [Element](/api/document-element.md) ▸ **Tag**

<!-- toc -->

> [`Source`](https:/github.com/Neft-io/neft/blob/214bc7eaad621898160a3fcef3785f39f21aa083/src/document/element/element/tag.litcoffee)


* * * 

### `constructor()`

<dl><dt>Extends</dt><dd><i>Element</i></dd><dt>Returns</dt><dd><i>Tag</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/214bc7eaad621898160a3fcef3785f39f21aa083/src/document/element/element/tag.litcoffee#tag-tagconstructor--element)


* * * 

### `name`

<dl><dt>Type</dt><dd><i>String</i></dd></dl>


* * * 

### `children`

<dl><dt>Type</dt><dd><i>Array</i></dd></dl>


* * * 

### `onChildrenChange()`

<dl><dt>Parameters</dt><dd><ul><li>added — <i>Element</i></li><li>removed — <i>Element</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/214bc7eaad621898160a3fcef3785f39f21aa083/src/document/element/element/tag.litcoffee#signal-tagonchildrenchangeelement-added-element-removed)


* * * 

### `props`

<dl><dt>Type</dt><dd><i>Element.Tag.Props</i></dd></dl>


* * * 

### `onPropsChange()`

<dl><dt>Parameters</dt><dd><ul><li>attribute — <i>String</i></li><li>oldValue — <i>Any</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/214bc7eaad621898160a3fcef3785f39f21aa083/src/document/element/element/tag.litcoffee#signal-tagonpropschangestring-attribute-any-oldvalue)


* * * 

### `cloneDeep()`

<dl><dt>Returns</dt><dd><i>Element.Tag</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/214bc7eaad621898160a3fcef3785f39f21aa083/src/document/element/element/tag.litcoffee#elementtag-tagclonedeep)


* * * 

### `getCopiedElement()`

<dl><dt>Parameters</dt><dd><ul><li>lookForElement — <i>Element</i></li><li>copiedParent — <i>Element</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/214bc7eaad621898160a3fcef3785f39f21aa083/src/document/element/element/tag.litcoffee#element-taggetcopiedelementelement-lookforelement-element-copiedparent)


* * * 

### `getChildByAccessPath()`

<dl><dt>Parameters</dt><dd><ul><li>accessPath — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Element.Tag</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/214bc7eaad621898160a3fcef3785f39f21aa083/src/document/element/element/tag.litcoffee#elementtag-taggetchildbyaccesspatharray-accesspath)


* * * 

### `queryAll()`

<dl><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li><li>onElement — <i>Function</i> — <i>optional</i></li><li>onElementContext — <i>Any</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/214bc7eaad621898160a3fcef3785f39f21aa083/src/document/element/element/tag.litcoffee#array-tagqueryallstring-query-function-onelement-any-onelementcontext)


* * * 

### `query()`

<dl><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/214bc7eaad621898160a3fcef3785f39f21aa083/src/document/element/element/tag.litcoffee#element-tagquerystring-query)


* * * 

### `watch()`

<dl><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Watcher</i></dd></dl>

```javascript
var watcher = doc.watch('div > * > b[attr]');
watcher.onAdd(function(tag){});
watcher.onRemove(function(tag){});
watcher.disconnect();
```


> [`Source`](https:/github.com/Neft-io/neft/blob/214bc7eaad621898160a3fcef3785f39f21aa083/src/document/element/element/tag.litcoffee#watcher-tagwatchstring-query)


* * * 

### `stringify()`

<dl><dt>Parameters</dt><dd><ul><li>replacements — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/214bc7eaad621898160a3fcef3785f39f21aa083/src/document/element/element/tag.litcoffee#string-tagstringifyobject-replacements)


* * * 

### `stringifyChildren()`

<dl><dt>Parameters</dt><dd><ul><li>replacements — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/214bc7eaad621898160a3fcef3785f39f21aa083/src/document/element/element/tag.litcoffee#string-tagstringifychildrenobject-replacements)


* * * 

### `replace()`

<dl><dt>Parameters</dt><dd><ul><li>oldElement — <i>Element</i></li><li>newElement — <i>Element</i></li></ul></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/214bc7eaad621898160a3fcef3785f39f21aa083/src/document/element/element/tag.litcoffee#tagreplaceelement-oldelement-element-newelement)

