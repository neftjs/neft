> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]]

Class
<dl><dt>Syntax</dt><dd><code>Class @modifier</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/class.litcoffee#class)

New
<dl><dt>Syntax</dt><dd><code>&#x2A;Class&#x2A; Class.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/Utils-API.md#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Class</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/class.litcoffee#new)

Class
<dl><dt>Syntax</dt><dd><code>&#x2A;Class&#x2A; Class()</code></dd><dt>Returns</dt><dd><i>Class</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/class.litcoffee#class)

name
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Class::name</code></dd><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
This property is used in the [Item::classes][renderer/Item::classes] list
to identify various classes.

##onNameChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Class::onNameChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/class.litcoffee#onnamechange)

target
<dl><dt>Syntax</dt><dd><code>&#x2A;Renderer.Item&#x2A; Class::target</code></dd><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Renderer.Item</i></dd></dl>
Reference to the [Item][renderer/Item] on which this class has effects.

If state is created inside the [Item][renderer/Item], this property is set automatically.

##onTargetChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Class::onTargetChange(&#x2A;Renderer.Item&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Renderer.Item</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/class.litcoffee#ontargetchange)

changes
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Class::changes</code></dd><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Utils-API.md#isobject">Object</a></dd></dl>
This objects contains all properties to change on the target item.

It accepts bindings and listeners as well.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/class.litcoffee#changes)

priority
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; Class::priority = 0</code></dd><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Utils-API.md#isinteger">Integer</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/class.litcoffee#priority)

when
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Class::when</code></dd><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>Boolean</i></dd></dl>
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
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Class::onWhenChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/class.litcoffee#onwhenchange)

children
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Class::children</code></dd><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Utils-API.md#isobject">Object</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/class.litcoffee#children)

children.length
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; Class::children.length = 0</code></dd><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Utils-API.md#isinteger">Integer</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/class.litcoffee#childrenlength)

children.append
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Class::children.append(&#x2A;Object&#x2A; value)</code></dd><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li>value — <a href="/Neft-io/neft/Utils-API.md#isobject">Object</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/Utils-API.md#isobject">Object</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/class.litcoffee#childrenappend)

children.pop
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Class::children.pop(&#x2A;Integer&#x2A; index)</code></dd><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li>index — <a href="/Neft-io/neft/Utils-API.md#isinteger">Integer</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/Utils-API.md#isobject">Object</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/class.litcoffee#childrenpop)

document
<dl><dt>Syntax</dt><dd><code>&#x2A;ClassDocument&#x2A; Class::document</code></dd><dt>Prototype property of</dt><dd><i>Class</i></dd><dt>Type</dt><dd><i>ClassDocument</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/class.litcoffee#document)

##onDocumentChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Class::onDocumentChange(&#x2A;ClassDocument&#x2A; document)</code></dd><dt>Prototype method of</dt><dd><i>Class</i></dd><dt>Parameters</dt><dd><ul><li>document — <i>ClassDocument</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/class.litcoffee#ondocumentchange)

ClassDocument
<dl><dt>Syntax</dt><dd><code>&#x2A;ClassDocument&#x2A; ClassDocument()</code></dd><dt>Returns</dt><dd><i>ClassDocument</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/class.litcoffee#classdocument)

query
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; ClassDocument::query</code></dd><dt>Prototype property of</dt><dd><i>ClassDocument</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/class.litcoffee#query)

onNodeRemove
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; ClassDocument::onNodeRemove(&#x2A;Document.Element&#x2A; node)</code></dd><dt>Prototype method of</dt><dd><i>ClassDocument</i></dd><dt>Parameters</dt><dd><ul><li>node — <i>Document.Element</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/class.litcoffee#onnoderemove)

classes
<dl><dt>Syntax</dt><dd><code>&#x2A;List&#x2A; Item::classes</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/Renderer-Item-API.md#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/List-API.md#class-list">List</a></dd></dl>
Classs at the end of the list have the highest priority.

This property has a setter, which accepts a string and an array of strings.

##onClassesChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onClassesChange(&#x2A;String&#x2A; added, &#x2A;String&#x2A; removed)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/Renderer-Item-API.md#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>added — <i>String</i></li><li>removed — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/class.litcoffee#onclasseschange)

