> [Wiki](Home) ▸ [API Reference](API-Reference)

File
<dl><dt>Syntax</dt><dd>File @class</dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-class)

onBeforeRender
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) File.onBeforeRender(*File* file)</dd><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>file — <i>File</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
Corresponding node handler: *neft:onBeforeRender=""*.

> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#signal-fileonbeforerenderfile-file)

onRender
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) File.onRender(*File* file)</dd><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>file — <i>File</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
Corresponding node handler: *neft:onRender=""*.

> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#signal-fileonrenderfile-file)

onBeforeRevert
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) File.onBeforeRevert(*File* file)</dd><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>file — <i>File</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
Corresponding node handler: *neft:onBeforeRevert=""*.

> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#signal-fileonbeforerevertfile-file)

onRevert
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) File.onRevert(*File* file)</dd><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>file — <i>File</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
Corresponding node handler: *neft:onRevert=""*.

> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#signal-fileonrevertfile-file)

fromHTML
<dl><dt>Syntax</dt><dd>*File* File.fromHTML(*String* path, *String* html)</dd><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li><li>html — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-filefromhtmlstring-path-string-html)

fromElement
<dl><dt>Syntax</dt><dd>*File* File.fromElement(*String* path, *Element* element)</dd><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li><li>element — <i>Element</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-filefromelementstring-path-element-element)

fromJSON
<dl><dt>Syntax</dt><dd>*File* File.fromJSON(*String|Object* json)</dd><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>json — <i>String or Object</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-filefromjsonstringobject-json)

parse
<dl><dt>Syntax</dt><dd>File.parse(*File* file)</dd><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>file — <i>File</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#fileparsefile-file)

factory
<dl><dt>Syntax</dt><dd>*File* File.factory(*String* path)</dd><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-filefactorystring-path)

File
<dl><dt>Syntax</dt><dd>*File* File(*String* path, *Element* element)</dd><dt>Parameters</dt><dd><ul><li>path — <i>String</i></li><li>element — <i>Element</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-filestring-path-element-element)

render
<dl><dt>Syntax</dt><dd>*File* File::render([*Any* attrs, *Any* scope, *File* source])</dd><dt>Prototype method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>attrs — <i>Any</i> — <i>optional</i></li><li>scope — <i>Any</i> — <i>optional</i></li><li>source — <i>File</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-filerenderany-attrs-any-scope-file-source)

revert
<dl><dt>Syntax</dt><dd>*File* File::revert()</dd><dt>Prototype method of</dt><dd><i>File</i></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-filerevert)

use
<dl><dt>Syntax</dt><dd>*File* File::use(*String* useName, [*File* document])</dd><dt>Prototype method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>useName — <i>String</i></li><li>document — <i>File</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-fileusestring-usename-file-document)

onReplaceByUse
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) File::onReplaceByUse(*File.Use* use)</dd><dt>Prototype method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li>use — <i>File.Use</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
Corresponding node handler: *neft:onReplaceByUse=""*.

> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#signal-fileonreplacebyusefileuse-use)

clone
<dl><dt>Syntax</dt><dd>*File* File::clone()</dd><dt>Prototype method of</dt><dd><i>File</i></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-fileclone)

destroy
<dl><dt>Syntax</dt><dd>File::destroy()</dd><dt>Prototype method of</dt><dd><i>File</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#filedestroy)

toJSON
<dl><dt>Syntax</dt><dd>[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) File::toJSON()</dd><dt>Prototype method of</dt><dd><i>File</i></dd><dt>Returns</dt><dd><i>Object</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#object-filetojson)

