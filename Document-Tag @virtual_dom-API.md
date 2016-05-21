> [Wiki](Home) ▸ [API Reference](API-Reference)

Tag
<dl></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tag-virtualdom)

Tag
<dl><dt>Extends</dt><dd><i>Element</i></dd><dt>Returns</dt><dd><i>Tag</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tag-tag--element)

name
<dl><dt>Prototype property of</dt><dd><i>Tag</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#string-tagnamearray-tagchildren-signal-tagonchildrenchangeelement-added-element-removed)

attrs
<dl><dt>Prototype property of</dt><dd><i>Tag</i></dd><dt>Type</dt><dd><i>Attrs</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#attrs-tagattrs-signal-tagonattrschangestring-attribute-any-oldvalue)

cloneDeep
<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Returns</dt><dd><i>Tag</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tag-tagclonedeep)

getCopiedElement
<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li><b>lookForElement</b> — <i>Element</i></li><li><b>copiedParent</b> — <i>Element</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#element-taggetcopiedelementelement-lookforelement-element-copiedparent)

getChildByAccessPath
<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li><b>accessPath</b> — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Tag</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tag-taggetchildbyaccesspatharray-accesspath)

queryAll
<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li><b>query</b> — <i>String</i></li><li><b>onElement</b> — <i>Function</i> — <i>optional</i></li><li><b>onElementContext</b> — <i>Any</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#array-tagqueryallstring-query-function-onelement-any-onelementcontext)

query
<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li><b>query</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#element-tagquerystring-query)

watch
<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li><b>query</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Watcher</i></dd></dl>
```javascript
var watcher = doc.watch('div > * > b[attr]');
watcher.onAdd(function(tag){});
watcher.onRemove(function(tag){});
watcher.disconnect();
```

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#watcher-tagwatchstring-query)

stringify
<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li><b>replacements</b> — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#string-tagstringifyobject-replacements)

stringifyChildren
<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li><b>replacements</b> — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#string-tagstringifychildrenobject-replacements)

replace
<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li><b>oldElement</b> — <i>Element</i></li><li><b>newElement</b> — <i>Element</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tagreplaceelement-oldelement-element-newelement)

Attrs
<dl><dt>Returns</dt><dd><i>Attrs</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#attrs-attrs)

item
<dl><dt>Prototype method of</dt><dd><i>Attrs</i></dd><dt>Parameters</dt><dd><ul><li><b>index</b> — <i>Integer</i></li><li><b>target</b> — <i>Array</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#array-attrsiteminteger-index-array-target)

has
<dl><dt>Prototype method of</dt><dd><i>Attrs</i></dd><dt>Parameters</dt><dd><ul><li><b>name</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#boolean-attrshasstring-name)

set
<dl><dt>Prototype method of</dt><dd><i>Attrs</i></dd><dt>Parameters</dt><dd><ul><li><b>name</b> — <i>String</i></li><li><b>value</b> — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#boolean-attrssetstring-name-any-value)

