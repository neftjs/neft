> [Wiki](Home) ▸ [[API Reference|API-Reference]]

> * [[neft:attr|Document-neft:attr @xml-API]]
> * [[Attributes evaluating|Document-Attributes evaluating @learn-API]]
> * [[neft:fragment|Document-neft:fragment @xml-API]]
>  * [[neft:require|Document-neft:require @xml-API]]
> * [[neft:if|Document-neft:if @xml-API]]
> * [[Setting attributes|Document-Setting attributes @learn-API]]
> * [[neft:function|Document-neft:function @xml-API]]
> * [[id|Document-id @xml-API]]
> * [[neft:each|Document-neft:each @xml-API]]
> * [[neft:log|Document-neft:log @xml-API]]
> * [[neft:rule|Document-neft:rule @xml-API]]
> * [[neft:script|Document-neft:script @xml-API]]
> * [[neft:target|Document-neft:target @xml-API]]
> * [[String Interpolation|Document-String Interpolation @learn-API]]
> * [[neft:use|Document-neft:use @xml-API]]

File
<dl><dt>Syntax</dt><dd><code>File @class</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file.litcoffee#file)

onBeforeRender
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; File.onBeforeRender(&#x2A;File&#x2A; file)</code></dd><dt>Static property of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>file — <i>File</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Corresponding node handler: *neft:onBeforeRender=""*.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file.litcoffee#onbeforerender)

onRender
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; File.onRender(&#x2A;File&#x2A; file)</code></dd><dt>Static property of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>file — <i>File</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Corresponding node handler: *neft:onRender=""*.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file.litcoffee#onrender)

onBeforeRevert
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; File.onBeforeRevert(&#x2A;File&#x2A; file)</code></dd><dt>Static property of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>file — <i>File</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Corresponding node handler: *neft:onBeforeRevert=""*.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file.litcoffee#onbeforerevert)

onRevert
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; File.onRevert(&#x2A;File&#x2A; file)</code></dd><dt>Static property of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>file — <i>File</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Corresponding node handler: *neft:onRevert=""*.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file.litcoffee#onrevert)

fromHTML
<dl><dt>Syntax</dt><dd><code>&#x2A;File&#x2A; File.fromHTML(&#x2A;String&#x2A; path, &#x2A;String&#x2A; html)</code></dd><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li><li>html — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file.litcoffee#fromhtml)

fromElement
<dl><dt>Syntax</dt><dd><code>&#x2A;File&#x2A; File.fromElement(&#x2A;String&#x2A; path, &#x2A;Element&#x2A; element)</code></dd><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li><li>element — <i>Element</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file.litcoffee#fromelement)

fromJSON
<dl><dt>Syntax</dt><dd><code>&#x2A;File&#x2A; File.fromJSON(&#x2A;String|Object&#x2A; json)</code></dd><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>json — <i>String or Object</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file.litcoffee#fromjson)

parse
<dl><dt>Syntax</dt><dd><code>File.parse(&#x2A;File&#x2A; file)</code></dd><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>file — <i>File</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file.litcoffee#parse)

factory
<dl><dt>Syntax</dt><dd><code>&#x2A;File&#x2A; File.factory(&#x2A;String&#x2A; path)</code></dd><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file.litcoffee#factory)

File
<dl><dt>Syntax</dt><dd><code>&#x2A;File&#x2A; File(&#x2A;String&#x2A; path, &#x2A;Element&#x2A; element)</code></dd><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li><li>element — <i>Element</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file.litcoffee#file)

render
<dl><dt>Syntax</dt><dd><code>&#x2A;File&#x2A; File::render([&#x2A;Any&#x2A; attrs, &#x2A;Any&#x2A; scope, &#x2A;File&#x2A; source])</code></dd><dt>Prototype method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>attrs — <i>Any</i> — <i>optional</i></li><li>scope — <i>Any</i> — <i>optional</i></li><li>source — <i>File</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file.litcoffee#render)

revert
<dl><dt>Syntax</dt><dd><code>&#x2A;File&#x2A; File::revert()</code></dd><dt>Prototype method of</dt><dd><i>File</i></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file.litcoffee#revert)

use
<dl><dt>Syntax</dt><dd><code>&#x2A;File&#x2A; File::use(&#x2A;String&#x2A; useName, [&#x2A;File&#x2A; document])</code></dd><dt>Prototype method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>useName — <i>String</i></li><li>document — <i>File</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file.litcoffee#use)

onReplaceByUse
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; File::onReplaceByUse(&#x2A;File.Use&#x2A; use)</code></dd><dt>Prototype method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>use — <i>File.Use</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Corresponding node handler: *neft:onReplaceByUse=""*.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file.litcoffee#onreplacebyuse)

clone
<dl><dt>Syntax</dt><dd><code>&#x2A;File&#x2A; File::clone()</code></dd><dt>Prototype method of</dt><dd><i>File</i></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file.litcoffee#clone)

destroy
<dl><dt>Syntax</dt><dd><code>File::destroy()</code></dd><dt>Prototype method of</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file.litcoffee#destroy)

toJSON
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; File::toJSON()</code></dd><dt>Prototype method of</dt><dd><i>File</i></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file.litcoffee#tojson)

