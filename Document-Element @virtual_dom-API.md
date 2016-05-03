Element @virtual_dom
====================

*Element* Element.fromHTML(*String* html)
-----------------------------------------

*Element* Element.fromJSON(*Array|String* json)
-----------------------------------------------

*Element* Element()
-------------------

*Integer* Element::index
------------------------

*Element* Element::nextSibling
------------------------------

*Element* Element::previousSibling
----------------------------------

*Element* Element::parent
-------------------------

## *Signal* Element::onParentChange(*Element* oldValue)

*Renderer.Item* Element::style
------------------------------

## *Signal* Element::onStyleChange(*Renderer.Item* oldValue)

*Boolean* Element::visible
--------------------------

## *Signal* Element::onVisibleChange(*Boolean* oldValue)

*Array* Element::queryAllParents(*String* query)
------------------------------------------------

*Element* Element::queryParents(*String* query)
-----------------------------------------------

*Array* Element::getAccessPath([*Tag* toParent])
------------------------------------------------

*Element* Element::clone()
--------------------------

*Array* Element::toJSON()
-------------------------

