> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]] ▸ [[Element|Document-Element-API]] ▸ **Tag**

#Tag
<dl><dt>Syntax</dt><dd><code>Element.Tag</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/element/element/tag.litcoffee#elementtag)

## Table of contents
* [Tag](#tag)
* [**Class** Tag](#class-tag)
  * [name](#name)
  * [children](#children)
  * [onChildrenChange](#onchildrenchange)
  * [props](#props)
  * [onPropsChange](#onpropschange)
  * [cloneDeep](#clonedeep)
  * [getCopiedElement](#getcopiedelement)
  * [getChildByAccessPath](#getchildbyaccesspath)
  * [queryAll](#queryall)
  * [query](#query)
  * [watch](#watch)
  * [stringify](#stringify)
  * [stringifyChildren](#stringifychildren)
  * [replace](#replace)
* [**Class** Props](#class-props)
  * [item](#item)
  * [has](#has)
  * [set](#set)
* [Glossary](#glossary)

#**Class** Tag
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Tag : &#x2A;Element&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/element/element/tag.litcoffee#class-tag--element)

##name
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Tag::name</code></dd><dt>Prototype property of</dt><dd><i>Tag</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
##children
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Tag::children</code></dd><dt>Prototype property of</dt><dd><i>Tag</i></dd><dt>Type</dt><dd><i>Array</i></dd></dl>
##onChildrenChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Tag::onChildrenChange(&#x2A;Element&#x2A; added, &#x2A;Element&#x2A; removed)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>added — <a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></li><li>removed — <a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/element/element/tag.litcoffee#signal-tagonchildrenchangeelement-added-element-removed)

##props
<dl><dt>Syntax</dt><dd><code>&#x2A;Element.Tag.Props&#x2A; Tag::props</code></dd><dt>Prototype property of</dt><dd><i>Tag</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Document-Element.Tag-API#class-props">Element.Tag.Props</a></dd></dl>
##onPropsChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Tag::onPropsChange(&#x2A;String&#x2A; attribute, &#x2A;Any&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>attribute — <i>String</i></li><li>oldValue — <i>Any</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/element/element/tag.litcoffee#signal-tagonpropschangestring-attribute-any-oldvalue)

##cloneDeep
<dl><dt>Syntax</dt><dd><code>&#x2A;Element.Tag&#x2A; Tag::cloneDeep()</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-Element.Tag-API#class-tag">Element.Tag</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/element/element/tag.litcoffee#elementtag-tagclonedeep)

##getCopiedElement
<dl><dt>Syntax</dt><dd><code>&#x2A;Element&#x2A; Tag::getCopiedElement(&#x2A;Element&#x2A; lookForElement, &#x2A;Element&#x2A; copiedParent)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>lookForElement — <a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></li><li>copiedParent — <a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/element/element/tag.litcoffee#element-taggetcopiedelementelement-lookforelement-element-copiedparent)

##getChildByAccessPath
<dl><dt>Syntax</dt><dd><code>&#x2A;Element.Tag&#x2A; Tag::getChildByAccessPath(&#x2A;Array&#x2A; accessPath)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>accessPath — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-Element.Tag-API#class-tag">Element.Tag</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/element/element/tag.litcoffee#elementtag-taggetchildbyaccesspatharray-accesspath)

##queryAll
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Tag::queryAll(&#x2A;String&#x2A; query, [&#x2A;Function&#x2A; onElement, &#x2A;Any&#x2A; onElementContext])</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li><li>onElement — <i>Function</i> — <i>optional</i></li><li>onElementContext — <i>Any</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/element/element/tag.litcoffee#array-tagqueryallstring-query-function-onelement-any-onelementcontext)

##query
<dl><dt>Syntax</dt><dd><code>&#x2A;Element&#x2A; Tag::query(&#x2A;String&#x2A; query)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/element/element/tag.litcoffee#element-tagquerystring-query)

##watch
<dl><dt>Syntax</dt><dd><code>&#x2A;Watcher&#x2A; Tag::watch(&#x2A;String&#x2A; query)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Watcher</i></dd></dl>
```javascript
var watcher = doc.watch('div > * > b[attr]');
watcher.onAdd(function(tag){});
watcher.onRemove(function(tag){});
watcher.disconnect();
```

> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/element/element/tag.litcoffee#watcher-tagwatchstring-query)

##stringify
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Tag::stringify([&#x2A;Object&#x2A; replacements])</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>replacements — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/element/element/tag.litcoffee#string-tagstringifyobject-replacements)

##stringifyChildren
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Tag::stringifyChildren([&#x2A;Object&#x2A; replacements])</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>replacements — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/element/element/tag.litcoffee#string-tagstringifychildrenobject-replacements)

##replace
<dl><dt>Syntax</dt><dd><code>Tag::replace(&#x2A;Element&#x2A; oldElement, &#x2A;Element&#x2A; newElement)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>oldElement — <a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></li><li>newElement — <a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/element/element/tag.litcoffee#tagreplaceelement-oldelement-element-newelement)

# **Class** Props

> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/element/element/tag.litcoffee)

##item
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Props::item(&#x2A;Integer&#x2A; index, [&#x2A;Array&#x2A; target])</code></dd><dt>Prototype method of</dt><dd><i>Props</i></dd><dt>Parameters</dt><dd><ul><li>index — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></li><li>target — <i>Array</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/element/element/tag.litcoffee#array-propsiteminteger-index-array-target)

##has
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Props::has(&#x2A;String&#x2A; name)</code></dd><dt>Prototype method of</dt><dd><i>Props</i></dd><dt>Parameters</dt><dd><ul><li>name — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/element/element/tag.litcoffee#boolean-propshasstring-name)

##set
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Props::set(&#x2A;String&#x2A; name, &#x2A;Any&#x2A; value)</code></dd><dt>Prototype method of</dt><dd><i>Props</i></dd><dt>Parameters</dt><dd><ul><li>name — <i>String</i></li><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/element/element/tag.litcoffee#boolean-propssetstring-name-any-value)

# Glossary

- [Element.Tag](#class-tag)
- [Element.Tag.Props](#class-props)

