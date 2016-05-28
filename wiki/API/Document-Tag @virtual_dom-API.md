> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]] ▸ [[Element|Document-Element @virtual_dom-API]]

Tag
<dl><dt>Syntax</dt><dd><code>Tag @virtual_dom</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/d388ebfb756a89ede607900f85ca7571fa993196/src/document/element/element/tag.litcoffee#tag)

Tag
<dl><dt>Syntax</dt><dd><code>&#x2A;Tag&#x2A; Tag() : &#x2A;Element&#x2A;</code></dd><dt>Extends</dt><dd><i>Element</i></dd><dt>Returns</dt><dd><i>Tag</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/d388ebfb756a89ede607900f85ca7571fa993196/src/document/element/element/tag.litcoffee#tag)

name
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Tag::name</code></dd><dt>Prototype property of</dt><dd><i>Tag</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/d388ebfb756a89ede607900f85ca7571fa993196/src/document/element/element/tag.litcoffee#name)

attrs
<dl><dt>Syntax</dt><dd><code>&#x2A;Attrs&#x2A; Tag::attrs</code></dd><dt>Prototype property of</dt><dd><i>Tag</i></dd><dt>Type</dt><dd><i>Attrs</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/d388ebfb756a89ede607900f85ca7571fa993196/src/document/element/element/tag.litcoffee#attrs)

cloneDeep
<dl><dt>Syntax</dt><dd><code>&#x2A;Tag&#x2A; Tag::cloneDeep()</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Returns</dt><dd><i>Tag</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/d388ebfb756a89ede607900f85ca7571fa993196/src/document/element/element/tag.litcoffee#clonedeep)

getCopiedElement
<dl><dt>Syntax</dt><dd><code>&#x2A;Element&#x2A; Tag::getCopiedElement(&#x2A;Element&#x2A; lookForElement, &#x2A;Element&#x2A; copiedParent)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>lookForElement — <i>Element</i></li><li>copiedParent — <i>Element</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/d388ebfb756a89ede607900f85ca7571fa993196/src/document/element/element/tag.litcoffee#getcopiedelement)

getChildByAccessPath
<dl><dt>Syntax</dt><dd><code>&#x2A;Tag&#x2A; Tag::getChildByAccessPath(&#x2A;Array&#x2A; accessPath)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>accessPath — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><i>Tag</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/d388ebfb756a89ede607900f85ca7571fa993196/src/document/element/element/tag.litcoffee#getchildbyaccesspath)

queryAll
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Tag::queryAll(&#x2A;String&#x2A; query, [&#x2A;Function&#x2A; onElement, &#x2A;Any&#x2A; onElementContext])</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li><li>onElement — <i>Function</i> — <i>optional</i></li><li>onElementContext — <i>Any</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/d388ebfb756a89ede607900f85ca7571fa993196/src/document/element/element/tag.litcoffee#queryall)

query
<dl><dt>Syntax</dt><dd><code>&#x2A;Element&#x2A; Tag::query(&#x2A;String&#x2A; query)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/d388ebfb756a89ede607900f85ca7571fa993196/src/document/element/element/tag.litcoffee#query)

watch
<dl><dt>Syntax</dt><dd><code>&#x2A;Watcher&#x2A; Tag::watch(&#x2A;String&#x2A; query)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Watcher</i></dd></dl>
```javascript
var watcher = doc.watch('div > * > b[attr]');
watcher.onAdd(function(tag){});
watcher.onRemove(function(tag){});
watcher.disconnect();
```

> [`Source`](/Neft-io/neft/blob/d388ebfb756a89ede607900f85ca7571fa993196/src/document/element/element/tag.litcoffee#watch)

stringify
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Tag::stringify([&#x2A;Object&#x2A; replacements])</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>replacements — <a href="/Neft-io/neft/wiki/API/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/d388ebfb756a89ede607900f85ca7571fa993196/src/document/element/element/tag.litcoffee#stringify)

stringifyChildren
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Tag::stringifyChildren([&#x2A;Object&#x2A; replacements])</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>replacements — <a href="/Neft-io/neft/wiki/API/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/d388ebfb756a89ede607900f85ca7571fa993196/src/document/element/element/tag.litcoffee#stringifychildren)

replace
<dl><dt>Syntax</dt><dd><code>Tag::replace(&#x2A;Element&#x2A; oldElement, &#x2A;Element&#x2A; newElement)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>oldElement — <i>Element</i></li><li>newElement — <i>Element</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/d388ebfb756a89ede607900f85ca7571fa993196/src/document/element/element/tag.litcoffee#replace)

Attrs
<dl><dt>Syntax</dt><dd><code>&#x2A;Attrs&#x2A; Attrs()</code></dd><dt>Returns</dt><dd><i>Attrs</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/d388ebfb756a89ede607900f85ca7571fa993196/src/document/element/element/tag.litcoffee#attrs)

item
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Attrs::item(&#x2A;Integer&#x2A; index, [&#x2A;Array&#x2A; target])</code></dd><dt>Prototype method of</dt><dd><i>Attrs</i></dd><dt>Parameters</dt><dd><ul><li>index — <a href="/Neft-io/neft/wiki/API/Utils-API#isinteger">Integer</a></li><li>target — <i>Array</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/d388ebfb756a89ede607900f85ca7571fa993196/src/document/element/element/tag.litcoffee#item)

has
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Attrs::has(&#x2A;String&#x2A; name)</code></dd><dt>Prototype method of</dt><dd><i>Attrs</i></dd><dt>Parameters</dt><dd><ul><li>name — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/d388ebfb756a89ede607900f85ca7571fa993196/src/document/element/element/tag.litcoffee#has)

set
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Attrs::set(&#x2A;String&#x2A; name, &#x2A;Any&#x2A; value)</code></dd><dt>Prototype method of</dt><dd><i>Attrs</i></dd><dt>Parameters</dt><dd><ul><li>name — <i>String</i></li><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/d388ebfb756a89ede607900f85ca7571fa993196/src/document/element/element/tag.litcoffee#set)

