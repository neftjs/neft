> [Wiki](Home) ▸ [API Reference](API-Reference)

Tag
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tag-virtualdom)

Tag
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tag-tag--element)

name
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#string-tagnamearray-tagchildren-signal-tagonchildrenchangeelement-added-element-removed)

attrs
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#attrs-tagattrs-signal-tagonattrschangestring-attribute-any-oldvalue)

cloneDeep
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tag-tagclonedeep)

getCopiedElement
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#element-taggetcopiedelementelement-lookforelement-element-copiedparent)

getChildByAccessPath
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tag-taggetchildbyaccesspatharray-accesspath)

queryAll
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#array-tagqueryallstring-query-function-onelement-any-onelementcontext)

query
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#element-tagquerystring-query)

watch
```javascript
var watcher = doc.watch('div > * > b[attr]');
watcher.onAdd(function(tag){});
watcher.onRemove(function(tag){});
watcher.disconnect();
```

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#watcher-tagwatchstring-query)

stringify
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#string-tagstringifyobject-replacements)

stringifyChildren
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#string-tagstringifychildrenobject-replacements)

replace
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#tagreplaceelement-oldelement-element-newelement)

Attrs
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#attrs-attrs)

item
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#array-attrsiteminteger-index-array-target)

has
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#boolean-attrshasstring-name)

set
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element/tag.litcoffee#boolean-attrssetstring-name-any-value)

