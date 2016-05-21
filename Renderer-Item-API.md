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

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#class-item)

###New
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemnewcomponent-component-object-options)

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

###on$Change
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonchangestring-property-any-oldvalue)

###ready
Called when the Item is ready, that is, all
properties have been set and it's ready to use.
```nml
Rectangle {
    width: 200
    height: 50
    color: 'green'

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemready)

###onAnimationFrame
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonanimationframeinteger-miliseconds)

###id
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-string-itemid-object-itemchildren)

###onChildrenChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonchildrenchangeitem-added-item-removed)

####children.firstChild
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenfirstchild)

####children.lastChild
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenlastchild)

####children.bottomChild
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenbottomchild)

####children.topChild
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrentopchild)

####children.length
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-integer-itemchildrenlength)

####children.layout
Item used to position children items.
Can be e.g. *Flow*, *Grid* etc.

####children.onLayoutChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemchildrenonlayoutchangeitem-oldvalue)

####children.target
A new child trying to be added into the item with the `children.target` defined
will be added into the `target` item.

####children.onTargetChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemchildrenontargetchangeitem-oldvalue)

####children.get
Returns an item with the given index.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemchildrengetinteger-index)

####children.index
Returns an index of the given child in the children array.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#integer-itemchildrenindexitem-value)

####children.has
Returns `true` if the given item is an item child.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#boolean-itemchildrenhasitem-value)

####children.clear
Removes all children from the item.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemchildrenclear)

###parent
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemparent--null-signal-itemonparentchangeitem-oldparent)

###previousSibling
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemprevioussibling)

###onPreviousSiblingChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonprevioussiblingchangeitem-oldvalue)

###nextSibling
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemnextsibling)

###onNextSiblingChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonnextsiblingchangeitem-oldvalue)

###belowSibling
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itembelowsibling)

###aboveSibling
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemabovesibling)

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

###onRotationChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonrotationchangefloat-oldvalue)

### [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::opacity = `1`
### [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onOpacityChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#float-itemopacity--1-signal-itemonopacitychangefloat-oldvalue)

###linkUri
Points to the URI which will be used when user clicks on this item.

###onLinkUriChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonlinkurichangestring-oldvalue)

###background
An item used as a background for the item.
By default, background is filled to his parent.

###onBackgroundChange
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonbackgroundchangeitem-oldvalue)

###overlap
Returns `true` if two items overlaps.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemoverlapitem-item)

###anchors
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemanchors-itemanchors-signal-itemonanchorschangestring-property-array-oldvalue)

###layout
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemlayout-itemlayout-signal-itemonlayoutchangestring-property-any-oldvalue)

###pointer
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itempointer-itempointer)

###margin
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemmargin-itemmargin-signal-itemonmarginchangestring-property-any-oldvalue)

###keys
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemkeys-itemkeys)

###document
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemdocument-itemdocument)

