> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Item**

# Item

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#item)

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
    * [parent](#parent)
    * [previousSibling](#previoussibling)
    * [onPreviousSiblingChange](#onprevioussiblingchange)
    * [nextSibling](#nextsibling)
    * [onNextSiblingChange](#onnextsiblingchange)
    * [belowSibling](#belowsibling)
    * [aboveSibling](#abovesibling)
    * [index](#index)
    * [*Boolean* Item::visible = `true`](#boolean-itemvisible--true)
    * [onVisibleChange](#onvisiblechange)
    * [*Boolean* Item::clip = `false`](#boolean-itemclip--false)
    * [*Float* Item::width = `0`](#float-itemwidth--0)
    * [*Float* Item::height = `0`](#float-itemheight--0)
    * [*Float* Item::x = `0`](#float-itemx--0)
    * [*Float* Item::y = `0`](#float-itemy--0)
    * [*Float* Item::z = `0`](#float-itemz--0)
    * [*Float* Item::scale = `1`](#float-itemscale--1)
    * [*Float* Item::rotation = `0`](#float-itemrotation--0)
    * [onRotationChange](#onrotationchange)
    * [*Float* Item::opacity = `1`](#float-itemopacity--1)
    * [linkUri](#linkuri)
    * [onLinkUriChange](#onlinkurichange)
    * [background](#background)
    * [onBackgroundChange](#onbackgroundchange)
    * [overlap](#overlap)
    * [anchors](#anchors)
    * [layout](#layout)
    * [pointer](#pointer)
    * [margin](#margin)
    * [keys](#keys)
    * [document](#document)

## **Class** Item

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#class-item)

###New
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Item.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Item</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#item-itemnewcomponent-component-object-options)

###constructor
<dl><dt>Syntax</dt><dd><code>Item::constructor()</code></dd><dt>Prototype method of</dt><dd><i>Item</i></dd></dl>
This is a base class for everything which is visible.

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#itemconstructor)

#### Custom properties

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

#### Custom signals

```nml
`Item {
`   signal $.onPlayerCollision
`   $.onPlayerCollision: function(){
`       // boom!
`   }
`}
```

###on$Change
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::on$Change(&#x2A;String&#x2A; property, &#x2A;Any&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>property — <i>String</i></li><li>oldValue — <i>Any</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#signal-itemonchangestring-property-any-oldvalue)

###ready
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::ready()</code></dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API.md#class-signal">Signal</a></dd></dl>
Called when the Item is ready, that is, all
properties have been set and it's ready to use.
```nml
Rectangle {
    width: 200
    height: 50
    color: 'green'

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#signal-itemready)

###onAnimationFrame
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onAnimationFrame(&#x2A;Integer&#x2A; miliseconds)</code></dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>miliseconds — <a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value">Integer</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#signal-itemonanimationframeinteger-miliseconds)

###id
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;String&#x2A; Item::id</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#readonly-string-itemid-object-itemchildren)

###onChildrenChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onChildrenChange(&#x2A;Item&#x2A; added, &#x2A;Item&#x2A; removed)</code></dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>added — <i>Item</i></li><li>removed — <i>Item</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#signal-itemonchildrenchangeitem-added-item-removed)

####children.firstChild
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Item&#x2A; Item::children.firstChild</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenfirstchild)

####children.lastChild
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Item&#x2A; Item::children.lastChild</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenlastchild)

####children.bottomChild
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Item&#x2A; Item::children.bottomChild</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenbottomchild)

####children.topChild
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Item&#x2A; Item::children.topChild</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrentopchild)

####children.length
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Integer&#x2A; Item::children.length</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value">Integer</a></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#readonly-integer-itemchildrenlength)

####children.layout
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Item::children.layout</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd></dl>
Item used to position children items.
Can be e.g. *Flow*, *Grid* etc.

####children.onLayoutChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::children.onLayoutChange(&#x2A;Item&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#signal-itemchildrenonlayoutchangeitem-oldvalue)

####children.target
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Item::children.target</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd></dl>
A new child trying to be added into the item with the `children.target` defined
will be added into the `target` item.

####children.onTargetChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::children.onTargetChange(&#x2A;Item&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#signal-itemchildrenontargetchangeitem-oldvalue)

####children.get
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Item::children.get(&#x2A;Integer&#x2A; index)</code></dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>index — <a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value">Integer</a></li></ul></dd><dt>Returns</dt><dd><i>Item</i></dd></dl>
Returns an item with the given index.

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#item-itemchildrengetinteger-index)

####children.index
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; Item::children.index(&#x2A;Item&#x2A; value)</code></dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Item</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value">Integer</a></dd></dl>
Returns an index of the given child in the children array.

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#integer-itemchildrenindexitem-value)

####children.has
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Item::children.has(&#x2A;Item&#x2A; value)</code></dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Item</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
Returns `true` if the given item is an item child.

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#boolean-itemchildrenhasitem-value)

####children.clear
<dl><dt>Syntax</dt><dd><code>Item::children.clear()</code></dd><dt>Prototype method of</dt><dd><i>Item</i></dd></dl>
Removes all children from the item.

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#itemchildrenclear)

###parent
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Item::parent = null</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>Default</dt><dd><code>null</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#item-itemparent--null-signal-itemonparentchangeitem-oldparent)

###previousSibling
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Item::previousSibling</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#item-itemprevioussibling)

###onPreviousSiblingChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onPreviousSiblingChange(&#x2A;Item&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#signal-itemonprevioussiblingchangeitem-oldvalue)

###nextSibling
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Item::nextSibling</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#item-itemnextsibling)

###onNextSiblingChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onNextSiblingChange(&#x2A;Item&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#signal-itemonnextsiblingchangeitem-oldvalue)

###belowSibling
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Item&#x2A; Item::belowSibling</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#readonly-item-itembelowsibling)

###aboveSibling
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Item&#x2A; Item::aboveSibling</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#readonly-item-itemabovesibling)

###index
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; Item::index</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value">Integer</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#integer-itemindex)

### *Boolean* Item::visible = `true`

Determines whether an item is visible or not.
```nml
Item {
    width: 100
    height: 100
    pointer.onClick: function(){
        rect.visible = !rect.visible;
        text.text = rect.visible ? "Click to hide" : "Click to show";
    }

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#boolean-itemvisible--true)

###onVisibleChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onVisibleChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#signal-itemonvisiblechangeboolean-oldvalue)

### *Boolean* Item::clip = `false`
### [Signal](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onClipChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#boolean-itemclip--false-signal-itemonclipchangeboolean-oldvalue)

### [Float](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::width = `0`
### [Signal](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onWidthChange([Float](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#float-itemwidth--0-signal-itemonwidthchangefloat-oldvalue)

### [Float](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::height = `0`
### [Signal](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onHeightChange([Float](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#float-itemheight--0-signal-itemonheightchangefloat-oldvalue)

### [Float](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::x = `0`
### [Signal](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onXChange([Float](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#float-itemx--0-signal-itemonxchangefloat-oldvalue)

### [Float](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::y = `0`
### [Signal](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onYChange([Float](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#float-itemy--0-signal-itemonychangefloat-oldvalue)

### [Float](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::z = `0`
### [Signal](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onZChange([Float](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#float-itemz--0-signal-itemonzchangefloat-oldvalue)

### [Float](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::scale = `1`
### [Signal](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onScaleChange([Float](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#float-itemscale--1-signal-itemonscalechangefloat-oldvalue)

### [Float](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::rotation = `0`

```nml
Rectangle {
    width: 100
    height: 100
    color: 'red'
    rotation: Math.PI / 4
}
```

###onRotationChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onRotationChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#signal-itemonrotationchangefloat-oldvalue)

### [Float](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::opacity = `1`
### [Signal](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onOpacityChange([Float](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#float-itemopacity--1-signal-itemonopacitychangefloat-oldvalue)

###linkUri
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Item::linkUri = ''</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>''</code></dd></dl>
Points to the URI which will be used when user clicks on this item.

###onLinkUriChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onLinkUriChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#signal-itemonlinkurichangestring-oldvalue)

###background
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Item::background</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd></dl>
An item used as a background for the item.
By default, background is filled to his parent.

###onBackgroundChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Item::onBackgroundChange(&#x2A;Item&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#signal-itemonbackgroundchangeitem-oldvalue)

###overlap
<dl><dt>Syntax</dt><dd><code>Item::overlap(&#x2A;Item&#x2A; item)</code></dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>item — <i>Item</i></li></ul></dd></dl>
Returns `true` if two items overlaps.

> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#itemoverlapitem-item)

###anchors
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Anchors&#x2A; Item::anchors</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item.Anchors</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#itemanchors-itemanchors-signal-itemonanchorschangestring-property-array-oldvalue)

###layout
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Layout&#x2A; Item::layout</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item.Layout</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#itemlayout-itemlayout-signal-itemonlayoutchangestring-property-any-oldvalue)

###pointer
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Pointer&#x2A; Item::pointer</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item.Pointer</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#itempointer-itempointer)

###margin
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Margin&#x2A; Item::margin</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item.Margin</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#itemmargin-itemmargin-signal-itemonmarginchangestring-property-any-oldvalue)

###keys
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Keys&#x2A; Item::keys</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item.Keys</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#itemkeys-itemkeys)

###document
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Document&#x2A; Item::document</code></dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item.Document</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/11ce61113abf36cfee4cca0e72112ab5bff468a7/src/renderer/types/basics/item.litcoffee#itemdocument-itemdocument)

