> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Item**

# Item

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item)

## Table of contents
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
      * [firstChild](#firstchild)
      * [lastChild](#lastchild)
      * [bottomChild](#bottomchild)
      * [topChild](#topchild)
      * [length](#length)
      * [layout](#layout)
      * [onLayoutChange](#onlayoutchange)
      * [target](#target)
      * [onTargetChange](#ontargetchange)
      * [get](#get)
      * [index](#index)
      * [has](#has)
      * [clear](#clear)
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
    * [*Signal* Item::onRotationChange(*Float* oldValue)](#signal-itemonrotationchangefloat-oldvalue)
    * [*Float* Item::opacity = `1`](#float-itemopacity--1)
    * [*String* Item::linkUri = ''](#string-itemlinkuri--)
    * [*Signal* Item::onLinkUriChange(*String* oldValue)](#signal-itemonlinkurichangestring-oldvalue)
    * [*Item* Item::background](#item-itembackground)
    * [*Signal* Item::onBackgroundChange(*Item* oldValue)](#signal-itemonbackgroundchangeitem-oldvalue)
    * [Item::overlap(*Item* item)](#itemoverlapitem-item)
    * [*Item.Anchors* Item::anchors](#itemanchors-itemanchors)
    * [*Item.Layout* Item::layout](#itemlayout-itemlayout)
    * [*Item.Pointer* Item::pointer](#itempointer-itempointer)
    * [*Item.Margin* Item::margin](#itemmargin-itemmargin)
    * [*Item.Keys* Item::keys](#itemkeys-itemkeys)
    * [*Item.Document* Item::document](#itemdocument-itemdocument)

## **Class** Item

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#class-item)

<dl><dt>Static method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li><b>component</b> — <i>Component</i> — <i>optional</i></li><li><b>options</b> — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Item</i></dd></dl>
###New
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemnewcomponent-component-object-options)

<dl><dt>Prototype method of</dt><dd><i>Item</i></dd></dl>
###constructor
This is a base class for everything which is visible.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemconstructor)

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

<dl><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li><b>property</b> — <i>String</i></li><li><b>oldValue</b> — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
###on$Change
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonchangestring-property-any-oldvalue)

<dl><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
###ready
Called when the Item is ready, that is, all
properties have been set and it's ready to use.
```nml
Rectangle {
    width: 200
    height: 50
    color: 'green'

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemready)

<dl><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li><b>miliseconds</b> — <i>Integer</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
###onAnimationFrame
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonanimationframeinteger-miliseconds)

<dl><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>read only</dt></dl>
###id
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-string-itemid-object-itemchildren)

<dl><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li><b>added</b> — <i>Item</i></li><li><b>removed</b> — <i>Item</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
###onChildrenChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonchildrenchangeitem-added-item-removed)

<dl><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>read only</dt></dl>
<dl><dt>Static property of</dt><dd><i>children</i></dd></dl>
####firstChild
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenfirstchild)

<dl><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>read only</dt></dl>
<dl><dt>Static property of</dt><dd><i>children</i></dd></dl>
####lastChild
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenlastchild)

<dl><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>read only</dt></dl>
<dl><dt>Static property of</dt><dd><i>children</i></dd></dl>
####bottomChild
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenbottomchild)

<dl><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>read only</dt></dl>
<dl><dt>Static property of</dt><dd><i>children</i></dd></dl>
####topChild
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrentopchild)

<dl><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Integer</i></dd><dt>read only</dt></dl>
<dl><dt>Static property of</dt><dd><i>children</i></dd></dl>
####length
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-integer-itemchildrenlength)

<dl><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd></dl>
<dl><dt>Static property of</dt><dd><i>children</i></dd></dl>
####layout
Item used to position children items.
Can be e.g. *Flow*, *Grid* etc.

<dl><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Item</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
<dl><dt>Static property of</dt><dd><i>children</i></dd></dl>
####onLayoutChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemchildrenonlayoutchangeitem-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd></dl>
<dl><dt>Static property of</dt><dd><i>children</i></dd></dl>
####target
A new child trying to be added into the item with the `children.target` defined
will be added into the `target` item.

<dl><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Item</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
<dl><dt>Static property of</dt><dd><i>children</i></dd></dl>
####onTargetChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemchildrenontargetchangeitem-oldvalue)

<dl><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li><b>index</b> — <i>Integer</i></li></ul></dd><dt>Returns</dt><dd><i>Item</i></dd></dl>
<dl><dt>Static property of</dt><dd><i>children</i></dd></dl>
####get
Returns an item with the given index.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemchildrengetinteger-index)

<dl><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Item</i></li></ul></dd><dt>Returns</dt><dd><i>Integer</i></dd></dl>
<dl><dt>Static property of</dt><dd><i>children</i></dd></dl>
####index
Returns an index of the given child in the children array.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#integer-itemchildrenindexitem-value)

<dl><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Item</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
<dl><dt>Static property of</dt><dd><i>children</i></dd></dl>
####has
Returns `true` if the given item is an item child.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#boolean-itemchildrenhasitem-value)

<dl><dt>Prototype method of</dt><dd><i>Item</i></dd></dl>
<dl><dt>Static property of</dt><dd><i>children</i></dd></dl>
####clear
Removes all children from the item.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemchildrenclear)

<dl><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>Default</dt><dd><code>null</code></dd></dl>
###parent
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemparent--null-signal-itemonparentchangeitem-oldparent)

<dl><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd></dl>
###previousSibling
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemprevioussibling)

<dl><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Item</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
###onPreviousSiblingChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonprevioussiblingchangeitem-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd></dl>
###nextSibling
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemnextsibling)

<dl><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Item</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
###onNextSiblingChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonnextsiblingchangeitem-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>read only</dt></dl>
###belowSibling
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itembelowsibling)

<dl><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>read only</dt></dl>
###aboveSibling
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemabovesibling)

<dl><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Integer</i></dd></dl>
###index
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#integer-itemindex)

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

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#boolean-itemvisible--true)

<dl><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>Boolean</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
###onVisibleChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonvisiblechangeboolean-oldvalue)

### *Boolean* Item::clip = `false`
### [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onClipChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#boolean-itemclip--false-signal-itemonclipchangeboolean-oldvalue)

### [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::width = `0`
### [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onWidthChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#float-itemwidth--0-signal-itemonwidthchangefloat-oldvalue)

### [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::height = `0`
### [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onHeightChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#float-itemheight--0-signal-itemonheightchangefloat-oldvalue)

### [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::x = `0`
### [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onXChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#float-itemx--0-signal-itemonxchangefloat-oldvalue)

### [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::y = `0`
### [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onYChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#float-itemy--0-signal-itemonychangefloat-oldvalue)

### [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::z = `0`
### [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onZChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#float-itemz--0-signal-itemonzchangefloat-oldvalue)

### [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::scale = `1`
### [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onScaleChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#float-itemscale--1-signal-itemonscalechangefloat-oldvalue)

### [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::rotation = `0`

```nml
Rectangle {
    width: 100
    height: 100
    color: 'red'
    rotation: Math.PI / 4
}
```

### [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onRotationChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonrotationchangefloat-oldvalue)

### [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::opacity = `1`
### [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onOpacityChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#float-itemopacity--1-signal-itemonopacitychangefloat-oldvalue)

### *String* Item::linkUri = ''

Points to the URI which will be used when user clicks on this item.

### [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onLinkUriChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonlinkurichangestring-oldvalue)

### *Item* Item::background

An item used as a background for the item.
By default, background is filled to his parent.

### [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onBackgroundChange(*Item* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonbackgroundchangeitem-oldvalue)

### Item::overlap(*Item* item)

Returns `true` if two items overlaps.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemoverlapitem-item)

### *Item.Anchors* Item::anchors
### [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onAnchorsChange(*String* property, *Array* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemanchors-itemanchors-signal-itemonanchorschangestring-property-array-oldvalue)

### *Item.Layout* Item::layout
### [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onLayoutChange(*String* property, *Any* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemlayout-itemlayout-signal-itemonlayoutchangestring-property-any-oldvalue)

### *Item.Pointer* Item::pointer

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itempointer-itempointer)

### *Item.Margin* Item::margin
### [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onMarginChange(*String* property, *Any* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemmargin-itemmargin-signal-itemonmarginchangestring-property-any-oldvalue)

### *Item.Keys* Item::keys

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemkeys-itemkeys)

### *Item.Document* Item::document

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemdocument-itemdocument)

