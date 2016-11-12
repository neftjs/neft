> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **Item**

# Item

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee)

## Nested APIs

* [[Alignment|Renderer-Item.Alignment-API]]
* [[Anchors|Renderer-Item.Anchors-API]]
* [[Document|Renderer-Item.Document-API]]
* [[Image|Renderer-Image-API]]
* [[Keys|Renderer-Item.Keys-API]]
* [[Layout|Renderer-Item.Layout-API]]
* [[Margin|Renderer-Item.Margin-API]]
* [[Native|Renderer-Native-API]]
* [[Pointer|Renderer-Item.Pointer-API]]
* [[Spacing|Renderer-Item.Spacing-API]]
* [[Text|Renderer-Text-API]]
  * [[Text.Font|Renderer-Item.Text.Font-API]]
* [[TextInput|Renderer-TextInput-API]]

## Table of contents
* [Item](#item)
* [**Class** Item](#class-item)
  * [New](#new)
  * [constructor](#constructor)
    * [Custom properties](#custom-properties)
    * [Custom signals](#custom-signals)
  * [on$Change](#onchange)
  * [ready](#ready)
  * [onAnimationFrame](#onanimationframe)
  * [id](#id)
  * [children](#children)
  * [onChildrenChange](#onchildrenchange)
    * [children.firstChild](#childrenfirstchild)
    * [children.lastChild](#childrenlastchild)
    * [children.bottomChild](#childrenbottomchild)
    * [children.topChild](#childrentopchild)
    * [children.length](#childrenlength)
    * [children.layout](#childrenlayout)
    * [children.onLayoutChange](#childrenonlayoutchange)
    * [children.target](#childrentarget)
    * [children.onTargetChange](#childrenontargetchange)
    * [children.get](#childrenget)
    * [children.index](#childrenindex)
    * [children.has](#childrenhas)
    * [children.clear](#childrenclear)
  * [*Item* Item::parent = null](#item-itemparent--null)
  * [onParentChange](#onparentchange)
  * [previousSibling](#previoussibling)
  * [onPreviousSiblingChange](#onprevioussiblingchange)
  * [nextSibling](#nextsibling)
  * [onNextSiblingChange](#onnextsiblingchange)
  * [belowSibling](#belowsibling)
  * [aboveSibling](#abovesibling)
  * [index](#index)
  * [visible](#visible)
  * [onVisibleChange](#onvisiblechange)
  * [clip](#clip)
  * [onClipChange](#onclipchange)
  * [width](#width)
  * [onWidthChange](#onwidthchange)
  * [height](#height)
  * [onHeightChange](#onheightchange)
  * [x](#x)
  * [onXChange](#onxchange)
  * [y](#y)
  * [onYChange](#onychange)
  * [z](#z)
  * [onZChange](#onzchange)
  * [scale](#scale)
  * [onScaleChange](#onscalechange)
  * [rotation](#rotation)
  * [onRotationChange](#onrotationchange)
  * [opacity](#opacity)
  * [onOpacityChange](#onopacitychange)
  * [*String* Item::linkUri = ''](#string-itemlinkuri--)
  * [onLinkUriChange](#onlinkurichange)
  * [background](#background)
  * [onBackgroundChange](#onbackgroundchange)
  * [overlap](#overlap)
  * [anchors](#anchors)
  * [onAnchorsChange](#onanchorschange)
  * [layout](#layout)
  * [onLayoutChange](#onlayoutchange)
  * [pointer](#pointer)
  * [margin](#margin)
  * [onMarginChange](#onmarginchange)
  * [keys](#keys)
  * [document](#document)
* [Glossary](#glossary)

# **Class** Item

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Item.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#item-itemnewcomponent-component-object-options)

##constructor
<dl><dt>Syntax</dt><dd><code>Item::constructor()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
This is a base class for everything which is visible.

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#itemconstructor)

### Custom properties

```nml
`Item {
`   id: main
`   property $.currentLife: 0.8
`
`   Text {
`     text: "Life: " + main.$.currentLife
`   }
`}
```

### Custom signals

```nml
`Item {
`   signal $.onPlayerCollision
`   $.onPlayerCollision: function(){
`       // boom!
`   }
`}
```

##on$Change
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::on$Change(&#x2A;String&#x2A; property, &#x2A;Any&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>property — <i>String</i></li><li>oldValue — <i>Any</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonchangestring-property-any-oldvalue)

##ready
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::ready()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
Called when the Item is ready, that is, all
properties have been set and it's ready to use.

```nml
Rectangle {
    width: 200
    height: 50
    color: 'green'
    Rectangle {
        width: parent.width / 2
        height: parent.height / 2
        color: 'yellow'
        onReady: function(){
            console.log(this.width, this.height);
            // 100, 25
        }
    }
}
```

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemready)

##onAnimationFrame
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onAnimationFrame(&#x2A;Integer&#x2A; miliseconds)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>miliseconds — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonanimationframeinteger-miliseconds)

##id
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; Item::id</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>
##children
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Item::children</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#object-itemchildren)

##onChildrenChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onChildrenChange(&#x2A;Item&#x2A; added, &#x2A;Item&#x2A; removed)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>added — <a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></li><li>removed — <a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonchildrenchangeitem-added-item-removed)

###children.firstChild
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Item&#x2A; Item::children.firstChild</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenfirstchild)

###children.lastChild
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Item&#x2A; Item::children.lastChild</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenlastchild)

###children.bottomChild
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Item&#x2A; Item::children.bottomChild</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenbottomchild)

###children.topChild
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Item&#x2A; Item::children.topChild</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrentopchild)

###children.length
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Integer&#x2A; Item::children.length</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#readonly-integer-itemchildrenlength)

###children.layout
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Item::children.layout</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
Item used to position children items.
Can be e.g. [Flow](/Neft-io/neft/wiki/Renderer-Flow-API#class-flow), [Grid](/Neft-io/neft/wiki/Renderer-Grid-API#class-grid) etc.

###children.onLayoutChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::children.onLayoutChange(&#x2A;Item&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemchildrenonlayoutchangeitem-oldvalue)

###children.target
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Item::children.target</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
A new child trying to be added into the item with the `children.target` defined
will be added into the `target` item.

###children.onTargetChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::children.onTargetChange(&#x2A;Item&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemchildrenontargetchangeitem-oldvalue)

###children.get
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Item::children.get(&#x2A;Integer&#x2A; index)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>index — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
Returns an item with the given index.

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#item-itemchildrengetinteger-index)

###children.index
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; Item::children.index(&#x2A;Item&#x2A; value)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>value — <a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></dd></dl>
Returns an index of the given child in the children array.

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#integer-itemchildrenindexitem-value)

###children.has
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Item::children.has(&#x2A;Item&#x2A; value)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>value — <a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
Returns `true` if the given item is an item child.

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#boolean-itemchildrenhasitem-value)

###children.clear
<dl><dt>Syntax</dt><dd><code>Item::children.clear()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
Removes all children from the item.

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#itemchildrenclear)

## [Item](/Neft-io/neft/wiki/Renderer-Item-API#class-item) Item::parent = null

##onParentChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onParentChange(&#x2A;Item&#x2A; oldParent)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>oldParent — <a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonparentchangeitem-oldparent)

##previousSibling
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Item::previousSibling</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#item-itemprevioussibling)

##onPreviousSiblingChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onPreviousSiblingChange(&#x2A;Item&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonprevioussiblingchangeitem-oldvalue)

##nextSibling
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Item::nextSibling</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#item-itemnextsibling)

##onNextSiblingChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onNextSiblingChange(&#x2A;Item&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonnextsiblingchangeitem-oldvalue)

##belowSibling
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Item&#x2A; Item::belowSibling</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#readonly-item-itembelowsibling)

##aboveSibling
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Item&#x2A; Item::aboveSibling</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#readonly-item-itemabovesibling)

##index
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; Item::index</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#integer-itemindex)

##visible
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Item::visible = `true`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
Determines whether an item is visible or not.

```nml
Item {
    width: 100
    height: 100
    pointer.onClick: function(){
        rect.visible = !rect.visible;
        text.text = rect.visible ? "Click to hide" : "Click to show";
    }
    Rectangle {
        id: rect
        anchors.fill: parent
        color: 'blue'
    }
    Text {
        id: text
        text: "Click to hide"
        anchors.centerIn: parent
    }
}
```

##onVisibleChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onVisibleChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonvisiblechangeboolean-oldvalue)

##clip
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Item::clip = `false`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
##onClipChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onClipChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonclipchangeboolean-oldvalue)

##width
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Item::width = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##onWidthChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onWidthChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonwidthchangefloat-oldvalue)

##height
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Item::height = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##onHeightChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onHeightChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonheightchangefloat-oldvalue)

##x
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Item::x = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##onXChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onXChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonxchangefloat-oldvalue)

##y
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Item::y = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##onYChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onYChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonychangefloat-oldvalue)

##z
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Item::z = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##onZChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onZChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonzchangefloat-oldvalue)

##scale
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Item::scale = `1`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>1</code></dd></dl>
##onScaleChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onScaleChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonscalechangefloat-oldvalue)

##rotation
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Item::rotation = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
```nml
Rectangle {
    width: 100
    height: 100
    color: 'red'
    rotation: Math.PI / 4
}
```

##onRotationChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onRotationChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonrotationchangefloat-oldvalue)

##opacity
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Item::opacity = `1`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>1</code></dd></dl>
##onOpacityChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onOpacityChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonopacitychangefloat-oldvalue)

## *String* Item::linkUri = ''

Points to the URI which will be used when user clicks on this item.

##onLinkUriChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onLinkUriChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonlinkurichangestring-oldvalue)

##background
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Item::background</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
An item used as a background for the item.

By default, background is filled to his parent.

##onBackgroundChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onBackgroundChange(&#x2A;Item&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonbackgroundchangeitem-oldvalue)

##overlap
<dl><dt>Syntax</dt><dd><code>Item::overlap(&#x2A;Item&#x2A; item)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>item — <a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></li></ul></dd></dl>
Returns `true` if two items overlaps.

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#itemoverlapitem-item)

##anchors
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Anchors&#x2A; Item::anchors</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Anchors-API#class-anchors">Item.Anchors</a></dd></dl>
##onAnchorsChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onAnchorsChange(&#x2A;String&#x2A; property, &#x2A;Array&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>property — <i>String</i></li><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonanchorschangestring-property-array-oldvalue)

##layout
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Layout&#x2A; Item::layout</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Layout-API#class-layout">Item.Layout</a></dd></dl>
##onLayoutChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onLayoutChange(&#x2A;String&#x2A; property, &#x2A;Any&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>property — <i>String</i></li><li>oldValue — <i>Any</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonlayoutchangestring-property-any-oldvalue)

##pointer
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Pointer&#x2A; Item::pointer</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Pointer-API#class-pointer">Item.Pointer</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#itempointer-itempointer)

##margin
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Margin&#x2A; Item::margin</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Margin-API#class-margin">Item.Margin</a></dd></dl>
##onMarginChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onMarginChange(&#x2A;String&#x2A; property, &#x2A;Any&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Parameters</dt><dd><ul><li>property — <i>String</i></li><li>oldValue — <i>Any</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#signal-itemonmarginchangestring-property-any-oldvalue)

##keys
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Keys&#x2A; Item::keys</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Keys-API#class-keys">Item.Keys</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#itemkeys-itemkeys)

##document
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Document&#x2A; Item::document</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Document-API#class-document">Item.Document</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item.litcoffee#itemdocument-itemdocument)

# Glossary

- [Item](#class-item)

