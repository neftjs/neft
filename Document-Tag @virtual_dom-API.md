> [Wiki](Home) ▸ [API Reference](API-Reference)

Tag
<dl><dt>Syntax</dt><dd><code>Tag @virtual_dom</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/element/element/tag.litcoffee#tag-virtualdom)

Tag
<dl><dt>Syntax</dt><dd><code>&#x2A;Tag&#x2A; Tag() : &#x2A;Element&#x2A;</code></dd><dt>Extends</dt><dd><i>Element</i></dd><dt>Returns</dt><dd><i>Tag</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/element/element/tag.litcoffee#tag-tag--element)

name
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Tag::name</code></dd><dt>Prototype property of</dt><dd><i>Tag</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/element/element/tag.litcoffee#string-tagnamearray-tagchildren-signal-tagonchildrenchangeelement-added-element-removed)

attrs
<dl><dt>Syntax</dt><dd><code>&#x2A;Attrs&#x2A; Tag::attrs</code></dd><dt>Prototype property of</dt><dd><i>Tag</i></dd><dt>Type</dt><dd><i>Attrs</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/element/element/tag.litcoffee#attrs-tagattrs-signal-tagonattrschangestring-attribute-any-oldvalue)

cloneDeep
<dl><dt>Syntax</dt><dd><code>&#x2A;Tag&#x2A; Tag::cloneDeep()</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Returns</dt><dd><i>Tag</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/element/element/tag.litcoffee#tag-tagclonedeep)

getCopiedElement
<dl><dt>Syntax</dt><dd><code>&#x2A;Element&#x2A; Tag::getCopiedElement(&#x2A;Element&#x2A; lookForElement, &#x2A;Element&#x2A; copiedParent)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>lookForElement — <i>Element</i></li><li>copiedParent — <i>Element</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/element/element/tag.litcoffee#element-taggetcopiedelementelement-lookforelement-element-copiedparent)

getChildByAccessPath
<dl><dt>Syntax</dt><dd><code>&#x2A;Tag&#x2A; Tag::getChildByAccessPath(&#x2A;Array&#x2A; accessPath)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>accessPath — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Tag</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/element/element/tag.litcoffee#tag-taggetchildbyaccesspatharray-accesspath)

queryAll
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Tag::queryAll(&#x2A;String&#x2A; query, [&#x2A;Function&#x2A; onElement, &#x2A;Any&#x2A; onElementContext])</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li><li>onElement — <i>Function</i> — <i>optional</i></li><li>onElementContext — <i>Any</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/element/element/tag.litcoffee#array-tagqueryallstring-query-function-onelement-any-onelementcontext)

query
<dl><dt>Syntax</dt><dd><code>&#x2A;Element&#x2A; Tag::query(&#x2A;String&#x2A; query)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/element/element/tag.litcoffee#element-tagquerystring-query)

watch
<dl><dt>Syntax</dt><dd><code>&#x2A;Watcher&#x2A; Tag::watch(&#x2A;String&#x2A; query)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Watcher</i></dd></dl>
```javascript
var watcher = doc.watch('div > * > b[attr]');
watcher.onAdd(function(tag){});
watcher.onRemove(function(tag){});
watcher.disconnect();
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/element/element/tag.litcoffee#watcher-tagwatchstring-query)

stringify
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Tag::stringify([&#x2A;Object&#x2A; replacements])</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>replacements — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/element/element/tag.litcoffee#string-tagstringifyobject-replacements)

stringifyChildren
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Tag::stringifyChildren([&#x2A;Object&#x2A; replacements])</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>replacements — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/element/element/tag.litcoffee#string-tagstringifychildrenobject-replacements)

replace
<dl><dt>Syntax</dt><dd><code>Tag::replace(&#x2A;Element&#x2A; oldElement, &#x2A;Element&#x2A; newElement)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>oldElement — <i>Element</i></li><li>newElement — <i>Element</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/element/element/tag.litcoffee#tagreplaceelement-oldelement-element-newelement)

Attrs
<dl><dt>Syntax</dt><dd><code>&#x2A;Attrs&#x2A; Attrs()</code></dd><dt>Returns</dt><dd><i>Attrs</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/element/element/tag.litcoffee#attrs-attrs)

item
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Attrs::item(&#x2A;Integer&#x2A; index, [&#x2A;Array&#x2A; target])</code></dd><dt>Prototype method of</dt><dd><i>Attrs</i></dd><dt>Parameters</dt><dd><ul><li>index — <i>Integer</i></li><li>target — <i>Array</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/element/element/tag.litcoffee#array-attrsiteminteger-index-array-target)

has
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Attrs::has(&#x2A;String&#x2A; name)</code></dd><dt>Prototype method of</dt><dd><i>Attrs</i></dd><dt>Parameters</dt><dd><ul><li>name — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/element/element/tag.litcoffee#boolean-attrshasstring-name)

set
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Attrs::set(&#x2A;String&#x2A; name, &#x2A;Any&#x2A; value)</code></dd><dt>Prototype method of</dt><dd><i>Attrs</i></dd><dt>Parameters</dt><dd><ul><li>name — <i>String</i></li><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/element/element/tag.litcoffee#boolean-attrssetstring-name-any-value)

