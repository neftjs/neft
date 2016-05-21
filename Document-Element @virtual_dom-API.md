> [Wiki](Home) ▸ [API Reference](API-Reference)

Element
<dl><dt>Syntax</dt><dd>Element @virtual_dom</dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-virtualdom)

fromHTML
<dl><dt>Syntax</dt><dd>*Element* Element.fromHTML(*String* html)</dd><dt>Static method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li>html — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementfromhtmlstring-html)

fromJSON
<dl><dt>Syntax</dt><dd>*Element* Element.fromJSON(*Array|String* json)</dd><dt>Static method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li>json — <i>Array or String</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementfromjsonarraystring-json)

Element
<dl><dt>Syntax</dt><dd>*Element* Element()</dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-element)

index
<dl><dt>Syntax</dt><dd>[*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) Element::index</dd><dt>Prototype property of</dt><dd><i>Element</i></dd><dt>Type</dt><dd><i>Integer</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#integer-elementindex)

nextSibling
<dl><dt>Syntax</dt><dd>*Element* Element::nextSibling</dd><dt>Prototype property of</dt><dd><i>Element</i></dd><dt>Type</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementnextsibling)

previousSibling
<dl><dt>Syntax</dt><dd>*Element* Element::previousSibling</dd><dt>Prototype property of</dt><dd><i>Element</i></dd><dt>Type</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementprevioussibling)

parent
<dl><dt>Syntax</dt><dd>*Element* Element::parent</dd><dt>Prototype property of</dt><dd><i>Element</i></dd><dt>Type</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementparent)

##onParentChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Element::onParentChange(*Element* oldValue)</dd><dt>Prototype method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Element</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#signal-elementonparentchangeelement-oldvalue)

style
<dl><dt>Syntax</dt><dd>*Renderer.Item* Element::style</dd><dt>Prototype property of</dt><dd><i>Element</i></dd><dt>Type</dt><dd><i>Renderer.Item</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#rendereritem-elementstyle)

##onStyleChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Element::onStyleChange(*Renderer.Item* oldValue)</dd><dt>Prototype method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Renderer.Item</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#signal-elementonstylechangerendereritem-oldvalue)

visible
<dl><dt>Syntax</dt><dd>*Boolean* Element::visible</dd><dt>Prototype property of</dt><dd><i>Element</i></dd><dt>Type</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#boolean-elementvisible)

##onVisibleChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Element::onVisibleChange(*Boolean* oldValue)</dd><dt>Prototype method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#signal-elementonvisiblechangeboolean-oldvalue)

queryAllParents
<dl><dt>Syntax</dt><dd>*Array* Element::queryAllParents(*String* query)</dd><dt>Prototype method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#array-elementqueryallparentsstring-query)

queryParents
<dl><dt>Syntax</dt><dd>*Element* Element::queryParents(*String* query)</dd><dt>Prototype method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li>query — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementqueryparentsstring-query)

getAccessPath
<dl><dt>Syntax</dt><dd>*Array* Element::getAccessPath([*Tag* toParent])</dd><dt>Prototype method of</dt><dd><i>Element</i></dd><dt>Parameters</dt><dd><ul><li>toParent — <i>Tag</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#array-elementgetaccesspathtag-toparent)

clone
<dl><dt>Syntax</dt><dd>*Element* Element::clone()</dd><dt>Prototype method of</dt><dd><i>Element</i></dd><dt>Returns</dt><dd><i>Element</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementclone)

toJSON
<dl><dt>Syntax</dt><dd>*Array* Element::toJSON()</dd><dt>Prototype method of</dt><dd><i>Element</i></dd><dt>Returns</dt><dd><i>Array</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#array-elementtojson)

