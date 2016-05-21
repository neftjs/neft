> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Item**

# Item

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item)

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

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#class-item)

###New
<dl><dt>Syntax</dt><dd>*Item* Item.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])</dd><dt>Static method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Item</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemnewcomponent-component-object-options)

###constructor
<dl><dt>Syntax</dt><dd>Item::constructor()</dd><dt>Prototype method of</dt><dd><i>Item</i></dd></dl>
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
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::on$Change(*String* property, *Any* oldValue)</dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>property — <i>String</i></li><li>oldValue — <i>Any</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonchangestring-property-any-oldvalue)

###ready
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::ready()</dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
Called when the Item is ready, that is, all
properties have been set and it's ready to use.
```nml
Rectangle {
    width: 200
    height: 50
    color: 'green'

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemready)

###onAnimationFrame
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onAnimationFrame([*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) miliseconds)</dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>miliseconds — <i>Integer</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonanimationframeinteger-miliseconds)

###id
<dl><dt>Syntax</dt><dd>ReadOnly *String* Item::id</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-string-itemid-object-itemchildren)

###onChildrenChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onChildrenChange(*Item* added, *Item* removed)</dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>added — <i>Item</i></li><li>removed — <i>Item</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonchildrenchangeitem-added-item-removed)

####children.firstChild
<dl><dt>Syntax</dt><dd>ReadOnly *Item* Item::children.firstChild</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenfirstchild)

####children.lastChild
<dl><dt>Syntax</dt><dd>ReadOnly *Item* Item::children.lastChild</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenlastchild)

####children.bottomChild
<dl><dt>Syntax</dt><dd>ReadOnly *Item* Item::children.bottomChild</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenbottomchild)

####children.topChild
<dl><dt>Syntax</dt><dd>ReadOnly *Item* Item::children.topChild</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrentopchild)

####children.length
<dl><dt>Syntax</dt><dd>ReadOnly [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) Item::children.length</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Integer</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-integer-itemchildrenlength)

####children.layout
<dl><dt>Syntax</dt><dd>*Item* Item::children.layout</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd></dl>
Item used to position children items.
Can be e.g. *Flow*, *Grid* etc.

####children.onLayoutChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::children.onLayoutChange(*Item* oldValue)</dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemchildrenonlayoutchangeitem-oldvalue)

####children.target
<dl><dt>Syntax</dt><dd>*Item* Item::children.target</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd></dl>
A new child trying to be added into the item with the `children.target` defined
will be added into the `target` item.

####children.onTargetChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::children.onTargetChange(*Item* oldValue)</dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemchildrenontargetchangeitem-oldvalue)

####children.get
<dl><dt>Syntax</dt><dd>*Item* Item::children.get([*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) index)</dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>index — <i>Integer</i></li></ul></dd><dt>Returns</dt><dd><i>Item</i></dd></dl>
Returns an item with the given index.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemchildrengetinteger-index)

####children.index
<dl><dt>Syntax</dt><dd>[*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) Item::children.index(*Item* value)</dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Item</i></li></ul></dd><dt>Returns</dt><dd><i>Integer</i></dd></dl>
Returns an index of the given child in the children array.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#integer-itemchildrenindexitem-value)

####children.has
<dl><dt>Syntax</dt><dd>*Boolean* Item::children.has(*Item* value)</dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Item</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>
Returns `true` if the given item is an item child.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#boolean-itemchildrenhasitem-value)

####children.clear
<dl><dt>Syntax</dt><dd>Item::children.clear()</dd><dt>Prototype method of</dt><dd><i>Item</i></dd></dl>
Removes all children from the item.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemchildrenclear)

###parent
<dl><dt>Syntax</dt><dd>*Item* Item::parent = null</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>Default</dt><dd><code>null</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemparent--null-signal-itemonparentchangeitem-oldparent)

###previousSibling
<dl><dt>Syntax</dt><dd>*Item* Item::previousSibling</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemprevioussibling)

###onPreviousSiblingChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onPreviousSiblingChange(*Item* oldValue)</dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonprevioussiblingchangeitem-oldvalue)

###nextSibling
<dl><dt>Syntax</dt><dd>*Item* Item::nextSibling</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#item-itemnextsibling)

###onNextSiblingChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onNextSiblingChange(*Item* oldValue)</dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonnextsiblingchangeitem-oldvalue)

###belowSibling
<dl><dt>Syntax</dt><dd>ReadOnly *Item* Item::belowSibling</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itembelowsibling)

###aboveSibling
<dl><dt>Syntax</dt><dd>ReadOnly *Item* Item::aboveSibling</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd><dt>Read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#readonly-item-itemabovesibling)

###index
<dl><dt>Syntax</dt><dd>[*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) Item::index</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Integer</i></dd></dl>
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
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onVisibleChange(*Boolean* oldValue)</dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
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
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onRotationChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)</dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonrotationchangefloat-oldvalue)

### [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) Item::opacity = `1`
### [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onOpacityChange([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#float-itemopacity--1-signal-itemonopacitychangefloat-oldvalue)

###linkUri
<dl><dt>Syntax</dt><dd>*String* Item::linkUri = ''</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>''</code></dd></dl>
Points to the URI which will be used when user clicks on this item.

###onLinkUriChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onLinkUriChange(*String* oldValue)</dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonlinkurichangestring-oldvalue)

###background
<dl><dt>Syntax</dt><dd>*Item* Item::background</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item</i></dd></dl>
An item used as a background for the item.
By default, background is filled to his parent.

###onBackgroundChange
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Item::onBackgroundChange(*Item* oldValue)</dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#signal-itemonbackgroundchangeitem-oldvalue)

###overlap
<dl><dt>Syntax</dt><dd>Item::overlap(*Item* item)</dd><dt>Prototype method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>item — <i>Item</i></li></ul></dd></dl>
Returns `true` if two items overlaps.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemoverlapitem-item)

###anchors
<dl><dt>Syntax</dt><dd>*Item.Anchors* Item::anchors</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item.Anchors</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemanchors-itemanchors-signal-itemonanchorschangestring-property-array-oldvalue)

###layout
<dl><dt>Syntax</dt><dd>*Item.Layout* Item::layout</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item.Layout</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemlayout-itemlayout-signal-itemonlayoutchangestring-property-any-oldvalue)

###pointer
<dl><dt>Syntax</dt><dd>*Item.Pointer* Item::pointer</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item.Pointer</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itempointer-itempointer)

###margin
<dl><dt>Syntax</dt><dd>*Item.Margin* Item::margin</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item.Margin</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemmargin-itemmargin-signal-itemonmarginchangestring-property-any-oldvalue)

###keys
<dl><dt>Syntax</dt><dd>*Item.Keys* Item::keys</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item.Keys</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemkeys-itemkeys)

###document
<dl><dt>Syntax</dt><dd>*Item.Document* Item::document</dd><dt>Prototype property of</dt><dd><i>Item</i></dd><dt>Type</dt><dd><i>Item.Document</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item.litcoffee#itemdocument-itemdocument)

