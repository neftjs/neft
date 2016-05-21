> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
Element
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-virtualdom)

<dl><dt>Static method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li><b>html</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
fromHTML
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementfromhtmlstring-html)

<dl><dt>Static method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li><b>json</b> — <i>Array or String</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
fromJSON
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementfromjsonarraystring-json)

<dl><dt>Returns</dt><dd><i>Element</i></dd></dl>
Element
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-element)

<dl><dt>Prototype property of</dt><dd><i>Element</i></dd><dt>Type</dt><dd><i>Integer</i></dd></dl>
index
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#integer-elementindex)

<dl><dt>Prototype property of</dt><dd><i>Element</i></dd><dt>Type</dt><dd><i>Element</i></dd></dl>
nextSibling
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementnextsibling)

<dl><dt>Prototype property of</dt><dd><i>Element</i></dd><dt>Type</dt><dd><i>Element</i></dd></dl>
previousSibling
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementprevioussibling)

<dl><dt>Prototype property of</dt><dd><i>Element</i></dd><dt>Type</dt><dd><i>Element</i></dd></dl>
parent
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementparent)

<dl><dt>Prototype method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Element</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
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
  * [*Signal* Element::onVisibleChange(*Boolean* oldValue)](#signal-elementonvisiblechangeboolean-oldvalue)
  * [*Array* Element::queryAllParents(*String* query)](#array-elementqueryallparentsstring-query)
  * [*Element* Element::queryParents(*String* query)](#element-elementqueryparentsstring-query)
  * [*Array* Element::getAccessPath([*Tag* toParent])](#array-elementgetaccesspathtag-toparent)
  * [*Element* Element::clone()](#element-elementclone)
  * [*Array* Element::toJSON()](#array-elementtojson)

##onParentChange
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#signal-elementonparentchangeelement-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Element</i></dd><dt>Type</dt><dd><i>Renderer.Item</i></dd></dl>
style
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#rendereritem-elementstyle)

<dl><dt>Prototype method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Renderer.Item</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
##onStyleChange
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#signal-elementonstylechangerendereritem-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Element</i></dd><dt>Type</dt><dd><i>Boolean</i></dd></dl>
visible
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#boolean-elementvisible)

## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Element::onVisibleChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#signal-elementonvisiblechangeboolean-oldvalue)

*Array* Element::queryAllParents(*String* query)
------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#array-elementqueryallparentsstring-query)

*Element* Element::queryParents(*String* query)
-----------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementqueryparentsstring-query)

*Array* Element::getAccessPath([*Tag* toParent])
------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#array-elementgetaccesspathtag-toparent)

*Element* Element::clone()
--------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementclone)

*Array* Element::toJSON()
-------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#array-elementtojson)

