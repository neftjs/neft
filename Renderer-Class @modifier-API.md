> [Wiki](Home) ▸ [API Reference](API-Reference)

Class
<dl><dt>Syntax</dt><dd>Class @modifier</dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#class-modifier)

New
<dl><dt>Syntax</dt><dd>*Class* Class.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])</dd><dt>Static method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Class</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#class-classnewcomponent-component-object-options)

Class
<dl><dt>Syntax</dt><dd>*Class* Class()</dd><dt>Returns</dt><dd><i>Class</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#class-class)

name
<dl><dt>Syntax</dt><dd>*String* Class::name</dd><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
This property is used in the [Item::classes][renderer/Item::classes] list
to identify various classes.

##onNameChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Class::onNameChange(*String* oldValue)</dd><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classonnamechangestring-oldvalue)

target
<dl><dt>Syntax</dt><dd>*Renderer.Item* Class::target</dd><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Renderer.Item</i></dd></dl>
Reference to the [Item][renderer/Item] on which this class has effects.
If state is created inside the [Item][renderer/Item], this property is set automatically.

##onTargetChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Class::onTargetChange(*Renderer.Item* oldValue)</dd><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Renderer.Item</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classontargetchangerendereritem-oldvalue)

changes
<dl><dt>Syntax</dt><dd>[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) Class::changes</dd><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Object</i></dd></dl>
This objects contains all properties to change on the target item.
It accepts bindings and listeners as well.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#object-classchanges)

priority
<dl><dt>Syntax</dt><dd>[*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) Class::priority = 0</dd><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Integer</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#integer-classpriority--0-signal-classonprioritychangeinteger-oldvalue)

when
<dl><dt>Syntax</dt><dd>*Boolean* Class::when</dd><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Boolean</i></dd></dl>
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
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Class::onWhenChange(*Boolean* oldValue)</dd><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classonwhenchangeboolean-oldvalue)

children
<dl><dt>Syntax</dt><dd>[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) Class::children</dd><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Object</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#object-classchildren)

children.length
<dl><dt>Syntax</dt><dd>[*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) Class::children.length = 0</dd><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Integer</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#integer-classchildrenlength--0)

children.append
<dl><dt>Syntax</dt><dd>[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) Class::children.append([*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) value)</dd><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Object</i></li></ul></dd><dt>Returns</dt><dd><i>Object</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#object-classchildrenappendobject-value)

children.pop
<dl><dt>Syntax</dt><dd>[*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) Class::children.pop([*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) index)</dd><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li>index — <i>Integer</i></li></ul></dd><dt>Returns</dt><dd><i>Object</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#object-classchildrenpopinteger-index)

document
<dl><dt>Syntax</dt><dd>*ClassDocument* Class::document</dd><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>ClassDocument</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#classdocument-classdocument)

##onDocumentChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Class::onDocumentChange(*ClassDocument* document)</dd><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li>document — <i>ClassDocument</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classondocumentchangeclassdocument-document)

ClassDocument
<dl><dt>Syntax</dt><dd>*ClassDocument* ClassDocument()</dd><dt>Returns</dt><dd><i>ClassDocument</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#classdocument-classdocument)

query
<dl><dt>Syntax</dt><dd>*String* ClassDocument::query</dd><dt>Prototype property of</dt><dd><i>ClassDocument</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#string-classdocumentquery-signal-classdocumentonquerychangestring-oldvaluesignal-classdocumentonnodeadddocumentelement-node)

onNodeRemove
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) ClassDocument::onNodeRemove(*Document.Element* node)</dd><dt>Prototype method of</dt><dd><i>ClassDocument</i></dd><dt>Parameters</dt><dd><ul><li>node — <i>Document.Element</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-classdocumentonnoderemovedocumentelement-node)

classes
<dl><dt>Syntax</dt><dd>[*List*](/Neft-io/neft/wiki/List-API.md#class-list) Item::classes</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>List</i></dd></dl>
Classs at the end of the list have the highest priority.
This property has a setter, which accepts a string and an array of strings.

##onClassesChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onClassesChange(*String* added, *String* removed)</dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>added — <i>String</i></li><li>removed — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/class.litcoffee#signal-itemonclasseschangestring-added-string-removed)

