> [Wiki](Home) ▸ [API Reference](API-Reference)

Class
<dl></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#class-modifier)

New
<dl><dt>Static method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li><b>component</b> — <i>Component</i> — <i>optional</i></li><li><b>options</b> — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Class</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#class-classnewcomponent-component-object-options)

Class
<dl><dt>Returns</dt><dd><i>Class</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#class-class)

name
<dl><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
This property is used in the [Item::classes][renderer/Item::classes] list
to identify various classes.

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
    * [children.length](#childrenlength)
    * [children.append](#childrenappend)
    * [children.pop](#childrenpop)
    * [document](#document)
  * [onDocumentChange](#ondocumentchange)
    * [ClassDocument](#classdocument)
    * [query](#query)
    * [onNodeRemove](#onnoderemove)
    * [classes](#classes)
  * [onClassesChange](#onclasseschange)

##onNameChange
<dl><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classonnamechangestring-oldvalue)

target
<dl><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Renderer.Item</i></dd></dl>
Reference to the [Item][renderer/Item] on which this class has effects.
If state is created inside the [Item][renderer/Item], this property is set automatically.

##onTargetChange
<dl><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Renderer.Item</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classontargetchangerendereritem-oldvalue)

changes
<dl><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Object</i></dd></dl>
This objects contains all properties to change on the target item.
It accepts bindings and listeners as well.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#object-classchanges)

priority
<dl><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Integer</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#integer-classpriority--0-signal-classonprioritychangeinteger-oldvalue)

when
<dl><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Boolean</i></dd></dl>
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

##onWhenChange
<dl><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Boolean</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classonwhenchangeboolean-oldvalue)

children
<dl><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Object</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#object-classchildren)

children.length
<dl><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Integer</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#integer-classchildrenlength--0)

children.append
<dl><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Object</i></li></ul></dd><dt>Returns</dt><dd><i>Object</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#object-classchildrenappendobject-value)

children.pop
<dl><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li><b>index</b> — <i>Integer</i></li></ul></dd><dt>Returns</dt><dd><i>Object</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#object-classchildrenpopinteger-index)

document
<dl><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>ClassDocument</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#classdocument-classdocument)

##onDocumentChange
<dl><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li><b>document</b> — <i>ClassDocument</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classondocumentchangeclassdocument-document)

ClassDocument
<dl><dt>Returns</dt><dd><i>ClassDocument</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#classdocument-classdocument)

query
<dl><dt>Prototype property of</dt><dd><i>ClassDocument</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#string-classdocumentquery-signal-classdocumentonquerychangestring-oldvaluesignal-classdocumentonnodeadddocumentelement-node)

onNodeRemove
<dl><dt>Prototype method of</dt><dd><i>ClassDocument</i></dd><dt>Parameters</dt><dd><ul><li><b>node</b> — <i>Document.Element</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classdocumentonnoderemovedocumentelement-node)

classes
<dl><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>List</i></dd></dl>
Classs at the end of the list have the highest priority.
This property has a setter, which accepts a string and an array of strings.

##onClassesChange
<dl><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li><b>added</b> — <i>String</i></li><li><b>removed</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-itemonclasseschangestring-added-string-removed)

