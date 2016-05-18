> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Class @modifier**

Class @modifier
===============

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#class-modifier)

## Table of contents
  * [Class.New([component, options])](#class-classnewcomponent-component-object-options)
  * [Class()](#class-class)
  * [name](#string-classname)
  * [onNameChange(oldValue)](#signal-classonnamechangestring-oldvalue)
  * [*Renderer.Item* target](#rendereritem-classtarget)
  * [onTargetChange(*Renderer.Item* oldValue)](#signal-classontargetchangerendereritem-oldvalue)
  * [changes](#object-classchanges)
  * [priority = 0](#integer-classpriority--0)
  * [when](#boolean-classwhen)
  * [onWhenChange(oldValue)](#signal-classonwhenchangeboolean-oldvalue)
  * [children](#object-classchildren)
  * [children.length = 0](#integer-classchildrenlength--0)
  * [children.append(value)](#object-classchildrenappendobject-value)
  * [children.pop(index)](#object-classchildrenpopinteger-index)
  * [document](#classdocument-classdocument)
  * [onDocumentChange(document)](#signal-classondocumentchangeclassdocument-document)
  * [ClassDocument()](#classdocument-classdocument)
  * [query](#string-classdocumentquery)
  * [onNodeRemove(*Document.Element* node)](#signal-classdocumentonnoderemovedocumentelement-node)
  * [classes](#list-itemclasses)
  * [onClassesChange(added, removed)](#signal-itemonclasseschangestring-added-string-removed)

*Class* Class.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])
------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#class-classnewcomponent-component-object-options)

*Class* Class()
---------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#class-class)

*String* Class::name
--------------------

This property is used in the [Item::classes][renderer/Item::classes] list
to identify various classes.

## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Class::onNameChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classonnamechangestring-oldvalue)

*Renderer.Item* Class::target
-----------------------------

Reference to the [Item][renderer/Item] on which this class has effects.
If state is created inside the [Item][renderer/Item], this property is set automatically.

## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Class::onTargetChange(*Renderer.Item* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classontargetchangerendereritem-oldvalue)

[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) Class::changes
-----------------------

This objects contains all properties to change on the target item.
It accepts bindings and listeners as well.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#object-classchanges)

[*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) Class::priority = 0
-----------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Class::onPriorityChange([*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#integer-classpriority--0-signal-classonprioritychangeinteger-oldvalue)

*Boolean* Class::when
---------------------

Indicates whether the class is active or not.
When it's `true`, this state is appended on the
end of the [Item::classes][renderer/Item::classes] list.
Mostly used with bindings.
```nml
`Grid {
`   columns: 2
`   // reduce to one column if the view width is lower than 500 pixels
`   Class {
`       when: view.width < 500
`       changes: {
`           columns: 1
`       }
`   }
`}
```

## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Class::onWhenChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classonwhenchangeboolean-oldvalue)

[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) Class::children
------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#object-classchildren)

[*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) Class::children.length = 0
------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#integer-classchildrenlength--0)

[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) Class::children.append([*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) value)
-----------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#object-classchildrenappendobject-value)

[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) Class::children.pop([*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) index)
---------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#object-classchildrenpopinteger-index)

*ClassDocument* Class::document
-------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#classdocument-classdocument)

## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Class::onDocumentChange(*ClassDocument* document)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classondocumentchangeclassdocument-document)

*ClassDocument* ClassDocument()
-------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#classdocument-classdocument)

*String* ClassDocument::query
-----------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) ClassDocument::onQueryChange(*String* oldValue)
[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) ClassDocument::onNodeAdd(*Document.Element* node)
----------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#string-classdocumentquery-signal-classdocumentonquerychangestring-oldvaluesignal-classdocumentonnodeadddocumentelement-node)

[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) ClassDocument::onNodeRemove(*Document.Element* node)
-------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classdocumentonnoderemovedocumentelement-node)

[*List*](/Neft-io/neft/wiki/List-API.md#class-list) Item::classes
--------------------

Classs at the end of the list have the highest priority.
This property has a setter, which accepts a string and an array of strings.

## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onClassesChange(*String* added, *String* removed)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-itemonclasseschangestring-added-string-removed)

