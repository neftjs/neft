> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Element @virtual_dom**

Element @virtual_dom
====================

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-virtualdom)

## Table of contents
  * [Element.fromHTML(html)](#element-elementfromhtmlstring-html)
  * [Element.fromJSON(*Array|String* json)](#element-elementfromjsonarraystring-json)
  * [Element()](#element-element)
  * [index](#integer-elementindex)
  * [nextSibling](#element-elementnextsibling)
  * [previousSibling](#element-elementprevioussibling)
  * [parent](#element-elementparent)
  * [onParentChange(oldValue)](#signal-elementonparentchangeelement-oldvalue)
  * [*Renderer.Item* style](#rendereritem-elementstyle)
  * [onStyleChange(*Renderer.Item* oldValue)](#signal-elementonstylechangerendereritem-oldvalue)
  * [visible](#boolean-elementvisible)
  * [onVisibleChange(oldValue)](#signal-elementonvisiblechangeboolean-oldvalue)
  * [queryAllParents(query)](#array-elementqueryallparentsstring-query)
  * [queryParents(query)](#element-elementqueryparentsstring-query)
  * [getAccessPath([toParent])](#array-elementgetaccesspathtag-toparent)
  * [clone()](#element-elementclone)
  * [toJSON()](#array-elementtojson)

*Element* Element.fromHTML(*String* html)
-----------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementfromhtmlstring-html)

*Element* Element.fromJSON(*Array|String* json)
-----------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementfromjsonarraystring-json)

*Element* Element()
-------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-element)

[*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) Element::index
------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#integer-elementindex)

*Element* Element::nextSibling
------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementnextsibling)

*Element* Element::previousSibling
----------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementprevioussibling)

*Element* Element::parent
-------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#element-elementparent)

## *Signal* Element::onParentChange(*Element* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#signal-elementonparentchangeelement-oldvalue)

*Renderer.Item* Element::style
------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#rendereritem-elementstyle)

## *Signal* Element::onStyleChange(*Renderer.Item* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#signal-elementonstylechangerendereritem-oldvalue)

*Boolean* Element::visible
--------------------------

> [`Source`](/Neft-io/neft/tree/master/src/document/element/element.litcoffee#boolean-elementvisible)

## *Signal* Element::onVisibleChange(*Boolean* oldValue)

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

