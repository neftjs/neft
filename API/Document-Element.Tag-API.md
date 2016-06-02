> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]] ▸ [[Element|Document-Element-API]] ▸ **Tag**

#Tag
<dl><dt>Syntax</dt><dd><code>Element.Tag</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/element/element/tag.litcoffee#tag)

## Table of contents
* [Tag](#tag)
* [**Class** Tag](#class-tag)
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
  * [replace](#replace)
* [**Class** Attrs](#class-attrs)
  * [item](#item)
  * [has](#has)
  * [set](#set)
* [Glossary](#glossary)

#**Class** Tag
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Tag : &#x2A;Element&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/element/element/tag.litcoffee#class-tag)

##name
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Tag::name</code></dd><dt>Prototype property of</dt><dd><i>Tag</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/element/element/tag.litcoffee#name)

##attrs
<dl><dt>Syntax</dt><dd><code>&#x2A;Element.Tag.Attrs&#x2A; Tag::attrs</code></dd><dt>Prototype property of</dt><dd><i>Tag</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Document-Element.Tag-API#class-attrs">Element.Tag.Attrs</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/element/element/tag.litcoffee#attrs)

##cloneDeep
<dl><dt>Syntax</dt><dd><code>&#x2A;Element.Tag&#x2A; Tag::cloneDeep()</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-Element.Tag-API#class-tag">Element.Tag</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/element/element/tag.litcoffee#clonedeep)

##getCopiedElement
<dl><dt>Syntax</dt><dd><code>&#x2A;Element&#x2A; Tag::getCopiedElement(&#x2A;Element&#x2A; lookForElement, &#x2A;Element&#x2A; copiedParent)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>lookForElement — <a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></li><li>copiedParent — <a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/element/element/tag.litcoffee#getcopiedelement)

##getChildByAccessPath
<dl><dt>Syntax</dt><dd><code>&#x2A;Element.Tag&#x2A; Tag::getChildByAccessPath(&#x2A;Array&#x2A; accessPath)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>accessPath — <i>Array</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-Element.Tag-API#class-tag">Element.Tag</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/element/element/tag.litcoffee#getchildbyaccesspath)

##queryAll
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Tag::queryAll(&#x2A;String&#x2A; query, [&#x2A;Function&#x2A; onElement, &#x2A;Any&#x2A; onElementContext])</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li><li>onElement — <i>Function</i> — <i>optional</i></li><li>onElementContext — <i>Any</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/element/element/tag.litcoffee#queryall)

##query
<dl><dt>Syntax</dt><dd><code>&#x2A;Element&#x2A; Tag::query(&#x2A;String&#x2A; query)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/element/element/tag.litcoffee#query)

##watch
<dl><dt>Syntax</dt><dd><code>&#x2A;Watcher&#x2A; Tag::watch(&#x2A;String&#x2A; query)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Watcher</i></dd></dl>
```javascript
var watcher = doc.watch('div > * > b[attr]');
watcher.onAdd(function(tag){});
watcher.onRemove(function(tag){});
watcher.disconnect();
```

> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/element/element/tag.litcoffee#watch)

##stringify
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Tag::stringify([&#x2A;Object&#x2A; replacements])</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>replacements — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/element/element/tag.litcoffee#stringify)

##stringifyChildren
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Tag::stringifyChildren([&#x2A;Object&#x2A; replacements])</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>replacements — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/element/element/tag.litcoffee#stringifychildren)

##replace
<dl><dt>Syntax</dt><dd><code>Tag::replace(&#x2A;Element&#x2A; oldElement, &#x2A;Element&#x2A; newElement)</code></dd><dt>Prototype method of</dt><dd><i>Tag</i></dd><dt>Parameters</dt><dd><ul><li>oldElement — <a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></li><li>newElement — <a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/element/element/tag.litcoffee#replace)

# **Class** Attrs

> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/element/element/tag.litcoffee#class-attrs)

##item
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Attrs::item(&#x2A;Integer&#x2A; index, [&#x2A;Array&#x2A; target])</code></dd><dt>Prototype method of</dt><dd><i>Attrs</i></dd><dt>Parameters</dt><dd><ul><li>index — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></li><li>target — <i>Array</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/element/element/tag.litcoffee#item)

##has
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Attrs::has(&#x2A;String&#x2A; name)</code></dd><dt>Prototype method of</dt><dd><i>Attrs</i></dd><dt>Parameters</dt><dd><ul><li>name — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/element/element/tag.litcoffee#has)

##set
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Attrs::set(&#x2A;String&#x2A; name, &#x2A;Any&#x2A; value)</code></dd><dt>Prototype method of</dt><dd><i>Attrs</i></dd><dt>Parameters</dt><dd><ul><li>name — <i>String</i></li><li>value — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/element/element/tag.litcoffee#set)

# Glossary

- [Element.Tag](#class-tag)
- [Element.Tag.Attrs](#class-attrs)

