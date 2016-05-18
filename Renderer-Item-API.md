> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Item**

# Item

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item)

## Table of contents
  * [**Class** Item](#class-item)
    * [Item.New([component, options])](#item-itemnewcomponent-component-object-options)
    * [constructor()](#itemconstructor)
      * [Custom properties](#custom-properties)
      * [Custom signals](#custom-signals)
    * [on$Change(property, oldValue)](#signal-itemonchangestring-property-any-oldvalue)
    * [ready()](#signal-itemready)
    * [onAnimationFrame(miliseconds)](#signal-itemonanimationframeinteger-miliseconds)
    * [id](#readonly-string-itemid)
    * [onChildrenChange(added, removed)](#signal-itemonchildrenchangeitem-added-item-removed)
      * [children.firstChild](#readonly-item-itemchildrenfirstchild)
      * [children.lastChild](#readonly-item-itemchildrenlastchild)
      * [children.bottomChild](#readonly-item-itemchildrenbottomchild)
      * [children.topChild](#readonly-item-itemchildrentopchild)
      * [children.length](#readonly-integer-itemchildrenlength)
      * [children.layout](#item-itemchildrenlayout)
      * [children.onLayoutChange(oldValue)](#signal-itemchildrenonlayoutchangeitem-oldvalue)
      * [children.target](#item-itemchildrentarget)
      * [children.onTargetChange(oldValue)](#signal-itemchildrenontargetchangeitem-oldvalue)
      * [children.get(index)](#item-itemchildrengetinteger-index)
      * [children.index(value)](#integer-itemchildrenindexitem-value)
      * [children.has(value)](#boolean-itemchildrenhasitem-value)
      * [children.clear()](#itemchildrenclear)
    * [parent = null](#item-itemparent--null)
    * [previousSibling](#item-itemprevioussibling)
    * [onPreviousSiblingChange(oldValue)](#signal-itemonprevioussiblingchangeitem-oldvalue)
    * [nextSibling](#item-itemnextsibling)
    * [onNextSiblingChange(oldValue)](#signal-itemonnextsiblingchangeitem-oldvalue)
    * [belowSibling](#readonly-item-itembelowsibling)
    * [aboveSibling](#readonly-item-itemabovesibling)
    * [index](#integer-itemindex)
    * [visible = true](#boolean-itemvisible--true)
    * [onVisibleChange(oldValue)](#signal-itemonvisiblechangeboolean-oldvalue)
    * [clip = false](#boolean-itemclip--false)
    * [width = 0](#float-itemwidth--0)
    * [height = 0](#float-itemheight--0)
    * [x = 0](#float-itemx--0)
    * [y = 0](#float-itemy--0)
    * [z = 0](#float-itemz--0)
    * [scale = 1](#float-itemscale--1)
    * [rotation = 0](#float-itemrotation--0)
    * [onRotationChange(oldValue)](#signal-itemonrotationchangefloat-oldvalue)
    * [opacity = 1](#float-itemopacity--1)
    * [linkUri = ''](#string-itemlinkuri--)
  * [onLinkUriChange(oldValue)](#signal-itemonlinkurichangestring-oldvalue)
    * [background](#item-itembackground)
    * [onBackgroundChange(oldValue)](#signal-itemonbackgroundchangeitem-oldvalue)
    * [overlap(item)](#itemoverlapitem-item)
    * [*Item.Anchors* anchors](#itemanchors-itemanchors)
    * [*Item.Layout* layout](#itemlayout-itemlayout)
    * [*Item.Pointer* pointer](#itempointer-itempointer)
    * [*Item.Margin* margin](#itemmargin-itemmargin)
    * [*Item.Keys* keys](#itemkeys-itemkeys)
    * [*Item.Document* document](#itemdocument-itemdocument)

## **Class** Item

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#class-item)

### *Item* Item.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemnewcomponent-component-object-options)

### Item::constructor()

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

### *Signal* Item::on$Change(*String* property, *Any* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonchangestring-property-any-oldvalue)

### *Signal* Item::ready()

Called when the Item is ready, that is, all
properties have been set and it's ready to use.
```nml
Rectangle {
    width: 200
    height: 50
    color: 'green'

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemready)

### *Signal* Item::onAnimationFrame([*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) miliseconds)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonanimationframeinteger-miliseconds)

### ReadOnly *String* Item::id
### [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) Item::children

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-string-itemid-object-itemchildren)

### *Signal* Item::onChildrenChange(*Item* added, *Item* removed)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonchildrenchangeitem-added-item-removed)

#### ReadOnly *Item* Item::children.firstChild

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenfirstchild)

#### ReadOnly *Item* Item::children.lastChild

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenlastchild)

#### ReadOnly *Item* Item::children.bottomChild

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenbottomchild)

#### ReadOnly *Item* Item::children.topChild

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrentopchild)

#### ReadOnly [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) Item::children.length

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-integer-itemchildrenlength)

#### *Item* Item::children.layout

Item used to position children items.
Can be e.g. *Flow*, *Grid* etc.

#### *Signal* Item::children.onLayoutChange(*Item* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemchildrenonlayoutchangeitem-oldvalue)

#### *Item* Item::children.target

A new child trying to be added into the item with the `children.target` defined
will be added into the `target` item.

#### *Signal* Item::children.onTargetChange(*Item* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemchildrenontargetchangeitem-oldvalue)

#### *Item* Item::children.get([*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) index)

Returns an item with the given index.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemchildrengetinteger-index)

#### [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) Item::children.index(*Item* value)

Returns an index of the given child in the children array.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#integer-itemchildrenindexitem-value)

#### *Boolean* Item::children.has(*Item* value)

Returns `true` if the given item is an item child.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#boolean-itemchildrenhasitem-value)

#### Item::children.clear()

Removes all children from the item.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemchildrenclear)

### *Item* Item::parent = null
### *Signal* Item::onParentChange(*Item* oldParent)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemparent--null-signal-itemonparentchangeitem-oldparent)

### *Item* Item::previousSibling

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemprevioussibling)

### *Signal* Item::onPreviousSiblingChange(*Item* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonprevioussiblingchangeitem-oldvalue)

### *Item* Item::nextSibling

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemnextsibling)

### *Signal* Item::onNextSiblingChange(*Item* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonnextsiblingchangeitem-oldvalue)

### ReadOnly *Item* Item::belowSibling

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itembelowsibling)

### ReadOnly *Item* Item::aboveSibling

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemabovesibling)

### [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) Item::index

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#integer-itemindex)

### *Boolean* Item::visible = true

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

### *Signal* Item::onVisibleChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonvisiblechangeboolean-oldvalue)

### *Boolean* Item::clip = false
### *Signal* Item::onClipChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#boolean-itemclip--false-signal-itemonclipchangeboolean-oldvalue)

### [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::width = 0
### *Signal* Item::onWidthChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#float-itemwidth--0-signal-itemonwidthchangefloat-oldvalue)

### [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::height = 0
### *Signal* Item::onHeightChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#float-itemheight--0-signal-itemonheightchangefloat-oldvalue)

### [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::x = 0
### *Signal* Item::onXChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#float-itemx--0-signal-itemonxchangefloat-oldvalue)

### [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::y = 0
### *Signal* Item::onYChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#float-itemy--0-signal-itemonychangefloat-oldvalue)

### [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::z = 0
### *Signal* Item::onZChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#float-itemz--0-signal-itemonzchangefloat-oldvalue)

### [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::scale = 1
### *Signal* Item::onScaleChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#float-itemscale--1-signal-itemonscalechangefloat-oldvalue)

### [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::rotation = 0

```nml
Rectangle {
    width: 100
    height: 100
    color: 'red'
    rotation: Math.PI / 4
}
```

### *Signal* Item::onRotationChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonrotationchangefloat-oldvalue)

### [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::opacity = 1
### *Signal* Item::onOpacityChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#float-itemopacity--1-signal-itemonopacitychangefloat-oldvalue)

### *String* Item::linkUri = ''

Points to the URI which will be used when user clicks on this item.

## *Signal* Item::onLinkUriChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonlinkurichangestring-oldvalue)

### *Item* Item::background

An item used as a background for the item.
By default, background is filled to his parent.

### *Signal* Item::onBackgroundChange(*Item* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonbackgroundchangeitem-oldvalue)

### Item::overlap(*Item* item)

Returns `true` if two items overlaps.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemoverlapitem-item)

### *Item.Anchors* Item::anchors
## *Signal* Item::onAnchorsChange(*String* property, *Array* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemanchors-itemanchors-signal-itemonanchorschangestring-property-array-oldvalue)

### *Item.Layout* Item::layout
## *Signal* Item::onLayoutChange(*String* property, *Any* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemlayout-itemlayout-signal-itemonlayoutchangestring-property-any-oldvalue)

### *Item.Pointer* Item::pointer

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itempointer-itempointer)

### *Item.Margin* Item::margin
## *Signal* Item::onMarginChange(*String* property, *Any* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemmargin-itemmargin-signal-itemonmarginchangestring-property-any-oldvalue)

### *Item.Keys* Item::keys

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemkeys-itemkeys)

### *Item.Document* Item::document

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemdocument-itemdocument)

