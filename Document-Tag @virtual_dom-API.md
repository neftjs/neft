> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Tag @virtual_dom**

Tag @virtual_dom
================

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tag-virtualdom)

## Table of contents
  * [Tag() : *Element*](#tag-tag--element)
  * [name](#string-tagname)
  * [attrs](#attrs-tagattrs)
  * [cloneDeep()](#tag-tagclonedeep)
  * [getCopiedElement(lookForElement, copiedParent)](#element-taggetcopiedelementelement-lookforelement-element-copiedparent)
  * [getChildByAccessPath(accessPath)](#tag-taggetchildbyaccesspatharray-accesspath)
  * [queryAll(query, [onElement, onElementContext])](#array-tagqueryallstring-query-function-onelement-any-onelementcontext)
  * [query(query)](#element-tagquerystring-query)
  * [watch(query)](#watcher-tagwatchstring-query)
  * [stringify([replacements])](#string-tagstringifyobject-replacements)
  * [stringifyChildren([replacements])](#string-tagstringifychildrenobject-replacements)
  * [replace(oldElement, newElement)](#tagreplaceelement-oldelement-element-newelement)
  * [Attrs()](#attrs-attrs)
  * [item(index, [target])](#array-attrsiteminteger-index-array-target)
  * [has(name)](#boolean-attrshasstring-name)
  * [set(name, value)](#boolean-attrssetstring-name-any-value)

*Tag* Tag() : *Element*
-----------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tag-tag--element)

*String* Tag::name
------------------
*Array* Tag::children
---------------------
## *Signal* Tag::onChildrenChange(*Element* added, *Element* removed)

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#string-tagnamearray-tagchildren-signal-tagonchildrenchangeelement-added-element-removed)

*Attrs* Tag::attrs
------------------
## *Signal* Tag::onAttrsChange(*String* attribute, *Any* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#attrs-tagattrs-signal-tagonattrschangestring-attribute-any-oldvalue)

*Tag* Tag::cloneDeep()
----------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tag-tagclonedeep)

*Element* Tag::getCopiedElement(*Element* lookForElement, *Element* copiedParent)
---------------------------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#element-taggetcopiedelementelement-lookforelement-element-copiedparent)

*Tag* Tag::getChildByAccessPath(*Array* accessPath)
---------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tag-taggetchildbyaccesspatharray-accesspath)

*Array* Tag::queryAll(*String* query, [*Function* onElement, *Any* onElementContext])
-------------------------------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#array-tagqueryallstring-query-function-onelement-any-onelementcontext)

*Element* Tag::query(*String* query)
------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#element-tagquerystring-query)

*Watcher* Tag::watch(*String* query)
------------------------------------

```javascript
var watcher = doc.watch('div > * > b[attr]');
watcher.onAdd(function(tag){});
watcher.onRemove(function(tag){});
watcher.disconnect();
```

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#watcher-tagwatchstring-query)

*String* Tag::stringify([[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) replacements])
------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#string-tagstringifyobject-replacements)

*String* Tag::stringifyChildren([[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) replacements])
--------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#string-tagstringifychildrenobject-replacements)

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

