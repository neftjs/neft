> [Wiki](Home) ▸ [API Reference](API-Reference)

Class
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#class-modifier)

New
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#class-classnewcomponent-component-object-options)

Class
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#class-class)

name
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
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classonnamechangestring-oldvalue)

target
Reference to the [Item][renderer/Item] on which this class has effects.
If state is created inside the [Item][renderer/Item], this property is set automatically.

##onTargetChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classontargetchangerendereritem-oldvalue)

changes
This objects contains all properties to change on the target item.
It accepts bindings and listeners as well.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#object-classchanges)

priority
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#integer-classpriority--0-signal-classonprioritychangeinteger-oldvalue)

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

##onWhenChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classonwhenchangeboolean-oldvalue)

children
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#object-classchildren)

children.length
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#integer-classchildrenlength--0)

children.append
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#object-classchildrenappendobject-value)

children.pop
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#object-classchildrenpopinteger-index)

document
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#classdocument-classdocument)

##onDocumentChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classondocumentchangeclassdocument-document)

ClassDocument
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#classdocument-classdocument)

query
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#string-classdocumentquery-signal-classdocumentonquerychangestring-oldvaluesignal-classdocumentonnodeadddocumentelement-node)

onNodeRemove
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classdocumentonnoderemovedocumentelement-node)

classes
Classs at the end of the list have the highest priority.
This property has a setter, which accepts a string and an array of strings.

##onClassesChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-itemonclasseschangestring-added-string-removed)

