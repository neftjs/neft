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
<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>lookForElement — <i>Element</i></li><li>copiedParent — <i>Element</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#element-taggetcopiedelementelement-lookforelement-element-copiedparent)

getChildByAccessPath
<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>accessPath — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Tag</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tag-taggetchildbyaccesspatharray-accesspath)

queryAll
<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li><li>onElement — <i>Function</i> — <i>optional</i></li><li>onElementContext — <i>Any</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#array-tagqueryallstring-query-function-onelement-any-onelementcontext)

query
<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#element-tagquerystring-query)

watch
<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Watcher</i></dd></dl>
```javascript
var watcher = doc.watch('div > * > b[attr]');
watcher.onAdd(function(tag){});
watcher.onRemove(function(tag){});
watcher.disconnect();
```

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#watcher-tagwatchstring-query)

stringify
<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>replacements — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#string-tagstringifyobject-replacements)

stringifyChildren
<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>replacements — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#string-tagstringifychildrenobject-replacements)

replace
<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>oldElement — <i>Element</i></li><li>newElement — <i>Element</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tagreplaceelement-oldelement-element-newelement)

Attrs
<dl><dt>Returns</dt><dd><i>Attrs</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#attrs-attrs)

item
<dl><dt>Prototype method of</dt><dd><i>Attrs</i></dd><dt>Parameters</dt><dd><ul><li>index — <i>Integer</i></li><li>target — <i>Array</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#array-attrsiteminteger-index-array-target)

has
<dl><dt>Prototype method of</dt><dd><i>Attrs</i></dd><dt>Parameters</dt><dd><ul><li>name — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#boolean-attrshasstring-name)

set
<dl><dt>Prototype method of</dt><dd><i>Attrs</i></dd><dt>Parameters</dt><dd><ul><li>name — <i>String</i></li><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#boolean-attrssetstring-name-any-value)

