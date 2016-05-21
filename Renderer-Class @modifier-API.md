> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
Class
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#class-modifier)

<dl><dt>Static method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li><b>component</b> — <i>Component</i> — <i>optional</i></li><li><b>options</b> — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Class</i></dd></dl>
New
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#class-classnewcomponent-component-object-options)

<dl><dt>Returns</dt><dd><i>Class</i></dd></dl>
Class
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#class-class)

<dl><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
name
This property is used in the [Item::classes][renderer/Item::classes] list
to identify various classes.

<dl><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
## Table of contents
    * [Class](#class)
    * [New](#new)
    * [Class](#class)
    * [name](#name)
  * [onNameChange](#onnamechange)
    * [target](#target)
  * [onTargetChange](#ontargetchange)
    * [changes](#changes)
    * [priority](#priority)
    * [when](#when)
  * [onWhenChange](#onwhenchange)
    * [children](#children)
    * [length](#length)
    * [append](#append)
  * [*Object* Class::children.pop(*Integer* index)](#object-classchildrenpopinteger-index)
  * [*ClassDocument* Class::document](#classdocument-classdocument)
  * [*Signal* Class::onDocumentChange(*ClassDocument* document)](#signal-classondocumentchangeclassdocument-document)
  * [*ClassDocument* ClassDocument()](#classdocument-classdocument)
  * [*String* ClassDocument::query](#string-classdocumentquery)
  * [*Signal* ClassDocument::onNodeRemove(*Document.Element* node)](#signal-classdocumentonnoderemovedocumentelement-node)
  * [*List* Item::classes](#list-itemclasses)
  * [*Signal* Item::onClassesChange(*String* added, *String* removed)](#signal-itemonclasseschangestring-added-string-removed)

##onNameChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classonnamechangestring-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Renderer.Item</i></dd></dl>
target
Reference to the [Item][renderer/Item] on which this class has effects.
If state is created inside the [Item][renderer/Item], this property is set automatically.

<dl><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Renderer.Item</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
##onTargetChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classontargetchangerendereritem-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Object</i></dd></dl>
changes
This objects contains all properties to change on the target item.
It accepts bindings and listeners as well.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#object-classchanges)

<dl><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Integer</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
priority
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#integer-classpriority--0-signal-classonprioritychangeinteger-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Boolean</i></dd></dl>
when
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

<dl><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Boolean</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
##onWhenChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classonwhenchangeboolean-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Object</i></dd></dl>
children
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#object-classchildren)

<dl><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Integer</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
<dl><dt>Static property of</dt><dd><i>children</i></dd></dl>
length
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#integer-classchildrenlength--0)

<dl><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Object</i></li></ul></dd><dt>Returns</dt><dd><i>Object</i></dd></dl>
<dl><dt>Static property of</dt><dd><i>children</i></dd></dl>
append
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

