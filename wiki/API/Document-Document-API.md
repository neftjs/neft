> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ **Document**

# Document

> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file.litcoffee#document)

## Nested APIs

* [[neft:attr|Document-neft:attr-API]]
* [[Attributes evaluating|Document-Attributes evaluating-API]]
* [[Setting attributes|Document-Setting attributes-API]]
* [[neft:if|Document-neft:if-API]]
* [[neft:fragment|Document-neft:fragment-API]]
  * [[neft:require|Document-neft:require-API]]
* [[id|Document-id-API]]
* [[neft:each|Document-neft:each-API]]
* [[neft:log|Document-neft:log-API]]
* [[neft:rule|Document-neft:rule-API]]
* [[neft:script|Document-neft:script-API]]
* [[String Interpolation|Document-String Interpolation-API]]
* [[neft:target|Document-neft:target-API]]
* [[neft:use|Document-neft:use-API]]

## Table of contents
* [Document](#document)
* [**Class** Document](#class-document)
  * [onBeforeRender](#onbeforerender)
  * [onRender](#onrender)
  * [onBeforeRevert](#onbeforerevert)
  * [onRevert](#onrevert)
  * [fromHTML](#fromhtml)
  * [fromElement](#fromelement)
  * [fromJSON](#fromjson)
  * [parse](#parse)
  * [factory](#factory)
  * [constructor](#constructor)
* [render](#render)
  * [revert](#revert)
  * [use](#use)
  * [onReplaceByUse](#onreplacebyuse)
  * [clone](#clone)
  * [destroy](#destroy)
  * [toJSON](#tojson)
* [Glossary](#glossary)

# **Class** Document

> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file.litcoffee#class-document)

##onBeforeRender
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Document.onBeforeRender(&#x2A;Document&#x2A; file)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>file — <a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Corresponding node handler: *neft:onBeforeRender=""*.

> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file.litcoffee#onbeforerender)

##onRender
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Document.onRender(&#x2A;Document&#x2A; file)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>file — <a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Corresponding node handler: *neft:onRender=""*.

> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file.litcoffee#onrender)

##onBeforeRevert
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Document.onBeforeRevert(&#x2A;Document&#x2A; file)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>file — <a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Corresponding node handler: *neft:onBeforeRevert=""*.

> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file.litcoffee#onbeforerevert)

##onRevert
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Document.onRevert(&#x2A;Document&#x2A; file)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>file — <a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Corresponding node handler: *neft:onRevert=""*.

> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file.litcoffee#onrevert)

##fromHTML
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Document.fromHTML(&#x2A;String&#x2A; path, &#x2A;String&#x2A; html)</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li><li>html — <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file.litcoffee#fromhtml)

##fromElement
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Document.fromElement(&#x2A;String&#x2A; path, &#x2A;Element&#x2A; element)</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li><li>element — <a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file.litcoffee#fromelement)

##fromJSON
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Document.fromJSON(&#x2A;String&#x2A;|&#x2A;Object&#x2A; json)</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>json — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> or <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file.litcoffee#fromjson)

##parse
<dl><dt>Syntax</dt><dd><code>Document.parse(&#x2A;Document&#x2A; file)</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>file — <a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file.litcoffee#parse)

##factory
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Document.factory(&#x2A;String&#x2A; path)</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file.litcoffee#factory)

##constructor
<dl><dt>Syntax</dt><dd><code>Document::constructor(&#x2A;String&#x2A; path, &#x2A;Element&#x2A; element)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li><li>element — <a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file.litcoffee#constructor)

#render
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Document::render([&#x2A;Any&#x2A; props, &#x2A;Any&#x2A; root, &#x2A;Document&#x2A; source])</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>props — <i>Any</i> — <i>optional</i></li><li>root — <i>Any</i> — <i>optional</i></li><li>source — <a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file.litcoffee#render)

##revert
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Document::revert()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file.litcoffee#revert)

##use
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Document::use(&#x2A;String&#x2A; useName, [&#x2A;Document&#x2A; document])</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>useName — <i>String</i></li><li>document — <a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file.litcoffee#use)

##onReplaceByUse
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Document::onReplaceByUse(&#x2A;Document.Use&#x2A; use)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>use — <i>Document.Use</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Corresponding node handler: *neft:onReplaceByUse=""*.

> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file.litcoffee#onreplacebyuse)

##clone
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Document::clone()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file.litcoffee#clone)

##destroy
<dl><dt>Syntax</dt><dd><code>Document::destroy()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file.litcoffee#destroy)

##toJSON
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Document::toJSON()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Document-Document-API#class-document">Document</a></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file.litcoffee#tojson)

# Glossary

- [Document](#class-document)

