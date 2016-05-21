> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
File
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-class)

<dl><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li><b>file</b> — <i>File</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
onBeforeRender
Corresponding node handler: *neft:onBeforeRender=""*.

> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#signal-fileonbeforerenderfile-file)

<dl><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li><b>file</b> — <i>File</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
onRender
Corresponding node handler: *neft:onRender=""*.

> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#signal-fileonrenderfile-file)

<dl><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li><b>file</b> — <i>File</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
onBeforeRevert
Corresponding node handler: *neft:onBeforeRevert=""*.

> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#signal-fileonbeforerevertfile-file)

<dl><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li><b>file</b> — <i>File</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
onRevert
Corresponding node handler: *neft:onRevert=""*.

> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#signal-fileonrevertfile-file)

<dl><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li><b>path</b> — <i>String</i></li><li><b>html</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
fromHTML
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-filefromhtmlstring-path-string-html)

<dl><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li><b>path</b> — <i>String</i></li><li><b>element</b> — <i>Element</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
fromElement
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-filefromelementstring-path-element-element)

<dl><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li><b>json</b> — <i>String or Object</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
fromJSON
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-filefromjsonstringobject-json)

<dl><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li><b>file</b> — <i>File</i></li></ul></dd></dl>
parse
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#fileparsefile-file)

<dl><dt>Static method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li><b>path</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
factory
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-filefactorystring-path)

<dl><dt>Parameters</dt><dd><ul><li><b>path</b> — <i>String</i></li><li><b>element</b> — <i>Element</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
File
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-filestring-path-element-element)

<dl><dt>Prototype method of</dt><dd><i>File</i></dd><dt>Parameters</dt><dd><ul><li><b>attrs</b> — <i>Any</i> — <i>optional</i></li><li><b>scope</b> — <i>Any</i> — <i>optional</i></li><li><b>source</b> — <i>File</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
render
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-filerenderany-attrs-any-scope-file-source)

<dl><dt>Prototype method of</dt><dd><i>File</i></dd><dt>Returns</dt><dd><i>File</i></dd></dl>
revert
> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-filerevert)

## Table of contents
    * [File](#file)
    * [onBeforeRender](#onbeforerender)
    * [onRender](#onrender)
    * [onBeforeRevert](#onbeforerevert)
    * [onRevert](#onrevert)
    * [fromHTML](#fromhtml)
    * [fromElement](#fromelement)
    * [fromJSON](#fromjson)
    * [parse](#parse)
    * [factory](#factory)
    * [File](#file)
    * [render](#render)
    * [revert](#revert)
  * [*File* File::use(*String* useName, [*File* document])](#file-fileusestring-usename-file-document)
  * [*Signal* File::onReplaceByUse(*File.Use* use)](#signal-fileonreplacebyusefileuse-use)
  * [*File* File::clone()](#file-fileclone)
  * [File::destroy()](#filedestroy)
  * [*Object* File::toJSON()](#object-filetojson)

*File* File::use(*String* useName, [*File* document])
-----------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-fileusestring-usename-file-document)

[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) File::onReplaceByUse(*File.Use* use)
---------------------------------------------

Corresponding node handler: *neft:onReplaceByUse=""*.

> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#signal-fileonreplacebyusefileuse-use)

*File* File::clone()
--------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#file-fileclone)

File::destroy()
---------------

> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#filedestroy)

[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) File::toJSON()
-----------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/file.litcoffee#object-filetojson)

