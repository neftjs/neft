> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
Tag
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tag-virtualdom)

<dl><dt>Extends</dt><dd><i>Element</i></dd><dt>Returns</dt><dd><i>Tag</i></dd></dl>
Tag
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tag-tag--element)

<dl><dt>Prototype property of</dt><dd><i>Tag</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
name
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#string-tagnamearray-tagchildren-signal-tagonchildrenchangeelement-added-element-removed)

<dl><dt>Prototype property of</dt><dd><i>Tag</i></dd><dt>Type</dt><dd><i>Attrs</i></dd></dl>
attrs
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#attrs-tagattrs-signal-tagonattrschangestring-attribute-any-oldvalue)

<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Returns</dt><dd><i>Tag</i></dd></dl>
cloneDeep
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tag-tagclonedeep)

<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li><b>lookForElement</b> — <i>Element</i></li><li><b>copiedParent</b> — <i>Element</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
getCopiedElement
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#element-taggetcopiedelementelement-lookforelement-element-copiedparent)

<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li><b>accessPath</b> — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Tag</i></dd></dl>
getChildByAccessPath
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tag-taggetchildbyaccesspatharray-accesspath)

<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li><b>query</b> — <i>String</i></li><li><b>onElement</b> — <i>Function</i> — <i>optional</i></li><li><b>onElementContext</b> — <i>Any</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
queryAll
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#array-tagqueryallstring-query-function-onelement-any-onelementcontext)

<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li><b>query</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
query
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#element-tagquerystring-query)

<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li><b>query</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Watcher</i></dd></dl>
watch
```javascript
var watcher = doc.watch('div > * > b[attr]');
watcher.onAdd(function(tag){});
watcher.onRemove(function(tag){});
watcher.disconnect();
```

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#watcher-tagwatchstring-query)

<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li><b>replacements</b> — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
stringify
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#string-tagstringifyobject-replacements)

<dl><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li><b>replacements</b> — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
stringifyChildren
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#string-tagstringifychildrenobject-replacements)

## Table of contents
    * [Tag](#tag)
    * [Tag](#tag)
    * [name](#name)
    * [attrs](#attrs)
    * [cloneDeep](#clonedeep)
    * [getCopiedElement](#getcopiedelement)
    * [getChildByAccessPath](#getchildbyaccesspath)
    * [queryAll](#queryall)
    * [query](#query)
    * [watch](#watch)
    * [stringify](#stringify)
    * [stringifyChildren](#stringifychildren)
  * [Tag::replace(*Element* oldElement, *Element* newElement)](#tagreplaceelement-oldelement-element-newelement)
  * [*Attrs* Attrs()](#attrs-attrs)
  * [*Array* Attrs::item(*Integer* index, [*Array* target])](#array-attrsiteminteger-index-array-target)
  * [*Boolean* Attrs::has(*String* name)](#boolean-attrshasstring-name)
  * [*Boolean* Attrs::set(*String* name, *Any* value)](#boolean-attrssetstring-name-any-value)

Tag::replace(*Element* oldElement, *Element* newElement)
--------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tagreplaceelement-oldelement-element-newelement)

*Attrs* Attrs()
---------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#attrs-attrs)

*Array* Attrs::item([*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) index, [*Array* target])
------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#array-attrsiteminteger-index-array-target)

*Boolean* Attrs::has(*String* name)
-----------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#boolean-attrshasstring-name)

*Boolean* Attrs::set(*String* name, *Any* value)
------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#boolean-attrssetstring-name-any-value)

