> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ **Document**

# Document

> [`Source`](/Neft-io/neft/blob/77d8497b4d0bb74a9ed8e3bfac808f2a5d6c59d2/src/document/index.litcoffee)

## Nested APIs

* [[Attributes evaluating|Document-Attributes evaluating-API]]
* [[Element|Document-Element-API]]
  * [[Tag|Document-Element.Tag-API]]
  * [[Text|Document-Element.Text-API]]
* [[Setting attributes|Document-Setting attributes-API]]
* [[String Interpolation|Document-String Interpolation-API]]
* [[component|Document-component-API]]
* [[import|Document-import-API]]
* [[log|Document-log-API]]
* [[n-each|Document-n-each-API]]
* [[n-if|Document-n-if-API]]
* [[prop|Document-prop-API]]
* [[ref|Document-ref-API]]
* [[script|Document-script-API]]
* [[style|Document-style-API]]
* [[target|Document-target-API]]
* [[use|Document-use-API]]

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

> [`Source`](/Neft-io/neft/blob/77d8497b4d0bb74a9ed8e3bfac808f2a5d6c59d2/src/document/index.litcoffee)

##onBeforeRender
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Document.onBeforeRender(&#x2A;Document&#x2A; file)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>file — <a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Corresponding node handler: *n-onBeforeRender=""*.

> [`Source`](/Neft-io/neft/blob/77d8497b4d0bb74a9ed8e3bfac808f2a5d6c59d2/src/document/index.litcoffee#signal-documentonbeforerenderdocument-file)

##onRender
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Document.onRender(&#x2A;Document&#x2A; file)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>file — <a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Corresponding node handler: *n-onRender=""*.

> [`Source`](/Neft-io/neft/blob/77d8497b4d0bb74a9ed8e3bfac808f2a5d6c59d2/src/document/index.litcoffee#signal-documentonrenderdocument-file)

##onBeforeRevert
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Document.onBeforeRevert(&#x2A;Document&#x2A; file)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>file — <a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Corresponding node handler: *n-onBeforeRevert=""*.

> [`Source`](/Neft-io/neft/blob/77d8497b4d0bb74a9ed8e3bfac808f2a5d6c59d2/src/document/index.litcoffee#signal-documentonbeforerevertdocument-file)

##onRevert
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Document.onRevert(&#x2A;Document&#x2A; file)</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>file — <a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Corresponding node handler: *n-onRevert=""*.

> [`Source`](/Neft-io/neft/blob/77d8497b4d0bb74a9ed8e3bfac808f2a5d6c59d2/src/document/index.litcoffee#signal-documentonrevertdocument-file)

##fromHTML
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Document.fromHTML(&#x2A;String&#x2A; path, &#x2A;String&#x2A; html)</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li><li>html — <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/77d8497b4d0bb74a9ed8e3bfac808f2a5d6c59d2/src/document/index.litcoffee#document-documentfromhtmlstring-path-string-html)

##fromElement
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Document.fromElement(&#x2A;String&#x2A; path, &#x2A;Element&#x2A; element)</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li><li>element — <a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/77d8497b4d0bb74a9ed8e3bfac808f2a5d6c59d2/src/document/index.litcoffee#document-documentfromelementstring-path-element-element)

##fromJSON
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Document.fromJSON(&#x2A;String&#x2A;|&#x2A;Object&#x2A; json)</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>json — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> or <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/77d8497b4d0bb74a9ed8e3bfac808f2a5d6c59d2/src/document/index.litcoffee#document-documentfromjsonstringobject-json)

##parse
<dl><dt>Syntax</dt><dd><code>Document.parse(&#x2A;Document&#x2A; file)</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>file — <a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/77d8497b4d0bb74a9ed8e3bfac808f2a5d6c59d2/src/document/index.litcoffee#documentparsedocument-file)

##factory
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Document.factory(&#x2A;String&#x2A; path)</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/77d8497b4d0bb74a9ed8e3bfac808f2a5d6c59d2/src/document/index.litcoffee#document-documentfactorystring-path)

##constructor
<dl><dt>Syntax</dt><dd><code>Document::constructor(&#x2A;String&#x2A; path, &#x2A;Element&#x2A; element)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li><li>element — <a href="/Neft-io/neft/wiki/Document-Element-API#class-element">Element</a></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/77d8497b4d0bb74a9ed8e3bfac808f2a5d6c59d2/src/document/index.litcoffee#documentconstructorstring-path-element-element)

#render
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Document::render([&#x2A;Any&#x2A; props, &#x2A;Any&#x2A; context, &#x2A;Document&#x2A; source])</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>props — <i>Any</i> — <i>optional</i></li><li>context — <i>Any</i> — <i>optional</i></li><li>source — <a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/77d8497b4d0bb74a9ed8e3bfac808f2a5d6c59d2/src/document/index.litcoffee#document-documentrenderany-props-any-context-document-source)

##revert
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Document::revert()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/77d8497b4d0bb74a9ed8e3bfac808f2a5d6c59d2/src/document/index.litcoffee#document-documentrevert)

##use
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Document::use(&#x2A;String&#x2A; useName, [&#x2A;Document&#x2A; document])</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>useName — <i>String</i></li><li>document — <a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/77d8497b4d0bb74a9ed8e3bfac808f2a5d6c59d2/src/document/index.litcoffee#document-documentusestring-usename-document-document)

##onReplaceByUse
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Document::onReplaceByUse(&#x2A;Document.Use&#x2A; use)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd><dt>Parameters</dt><dd><ul><li>use — <i>Document.Use</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Corresponding node handler: *n-onReplaceByUse=""*.

> [`Source`](/Neft-io/neft/blob/77d8497b4d0bb74a9ed8e3bfac808f2a5d6c59d2/src/document/index.litcoffee#signal-documentonreplacebyusedocumentuse-use)

##clone
<dl><dt>Syntax</dt><dd><code>&#x2A;Document&#x2A; Document::clone()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/77d8497b4d0bb74a9ed8e3bfac808f2a5d6c59d2/src/document/index.litcoffee#document-documentclone)

##destroy
<dl><dt>Syntax</dt><dd><code>Document::destroy()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/77d8497b4d0bb74a9ed8e3bfac808f2a5d6c59d2/src/document/index.litcoffee#documentdestroy)

##toJSON
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Document::toJSON()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Document-API#class-document">Document</a></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/77d8497b4d0bb74a9ed8e3bfac808f2a5d6c59d2/src/document/index.litcoffee#object-documenttojson)

# Glossary

- [Document](#class-document)

