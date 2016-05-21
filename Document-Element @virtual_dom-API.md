> [Wiki](Home) ▸ [API Reference](API-Reference)

Element
<dl></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-virtualdom)

fromHTML
<dl><dt>Static method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li><b>html</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementfromhtmlstring-html)

fromJSON
<dl><dt>Static method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li><b>json</b> — <i>Array or String</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementfromjsonarraystring-json)

Element
<dl><dt>Returns</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-element)

index
<dl><dt>Prototype property of</dt><dd><i>Element</i></dd><dt>Type</dt><dd><i>Integer</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#integer-elementindex)

nextSibling
<dl><dt>Prototype property of</dt><dd><i>Element</i></dd><dt>Type</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementnextsibling)

previousSibling
<dl><dt>Prototype property of</dt><dd><i>Element</i></dd><dt>Type</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementprevioussibling)

parent
<dl><dt>Prototype property of</dt><dd><i>Element</i></dd><dt>Type</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementparent)

## Table of contents
    * [Element](#element)
    * [fromHTML](#fromhtml)
    * [fromJSON](#fromjson)
    * [Element](#element)
    * [index](#index)
    * [nextSibling](#nextsibling)
    * [previousSibling](#previoussibling)
    * [parent](#parent)
  * [onParentChange](#onparentchange)
    * [style](#style)
  * [onStyleChange](#onstylechange)
    * [visible](#visible)
  * [onVisibleChange](#onvisiblechange)
    * [queryAllParents](#queryallparents)
    * [queryParents](#queryparents)
    * [getAccessPath](#getaccesspath)
    * [clone](#clone)
    * [toJSON](#tojson)

##onParentChange
<dl><dt>Prototype method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Element</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#signal-elementonparentchangeelement-oldvalue)

style
<dl><dt>Prototype property of</dt><dd><i>Element</i></dd><dt>Type</dt><dd><i>Renderer.Item</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#rendereritem-elementstyle)

##onStyleChange
<dl><dt>Prototype method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Renderer.Item</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#signal-elementonstylechangerendereritem-oldvalue)

visible
<dl><dt>Prototype property of</dt><dd><i>Element</i></dd><dt>Type</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#boolean-elementvisible)

##onVisibleChange
<dl><dt>Prototype method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Boolean</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#signal-elementonvisiblechangeboolean-oldvalue)

queryAllParents
<dl><dt>Prototype method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li><b>query</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#array-elementqueryallparentsstring-query)

queryParents
<dl><dt>Prototype method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li><b>query</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementqueryparentsstring-query)

getAccessPath
<dl><dt>Prototype method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li><b>toParent</b> — <i>Tag</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#array-elementgetaccesspathtag-toparent)

clone
<dl><dt>Prototype method of</dt><dd><i>Element</i></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementclone)

toJSON
<dl><dt>Prototype method of</dt><dd><i>Element</i></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#array-elementtojson)

