# Item

> **API Reference** ▸ [Renderer](/api/renderer.md) ▸ **Item**

<!-- toc -->

> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee)


* * * 

### `Item.New()`

<dl><dt>Static method of</dt><dd><i>Item</i></dd><dt>Parameters</dt><dd><ul><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Item</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#item-itemnewobject-options)


* * * 

### `constructor()`

<dl><dt>Returns</dt><dd><i>Item</i></dd></dl>

This is a base class for everything which is visible.


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#item-itemconstructor)

### Custom properties

```nml
Item {
    id: main
    property $.currentLife: 0.8
    Text {
        text: "Life: " + main.$.currentLife
    }
}
```

### Custom signals

```nml
Item {
    signal $.onPlayerCollision
    $.onPlayerCollision: function(){
        // boom!
    }
}
```


* * * 

### `on$Change()`

<dl><dt>Parameters</dt><dd><ul><li>property — <i>String</i></li><li>oldValue — <i>Any</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonchangestring-property-any-oldvalue)


* * * 

### `query`

<dl><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#readonly-string-itemquery)


* * * 

### `node`

<dl><dt>Type</dt><dd><i>Document.Element</i></dd><dt>Read Only</dt></dl>


* * * 

### `onNodeChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Document.Element</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>

```javascript
Text {
    text: this.node.props.value
}
```

```javascript
Text {
    onNodeChange: function(){
        var inputs = this.node.queryAll('input[type=string]');
    }
}
```


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonnodechangedocumentelement-oldvalue)


* * * 

### `ready()`

<dl><dt>Type</dt><dd><i>Signal</i></dd></dl>

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


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemready)


* * * 

### `onAnimationFrame()`

<dl><dt>Parameters</dt><dd><ul><li>miliseconds — <i>Integer</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonanimationframeinteger-miliseconds)


* * * 

### `id`

<dl><dt>Type</dt><dd><i>String</i></dd><dt>Read Only</dt></dl>


* * * 

### `children`

<dl><dt>Type</dt><dd><i>Object</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#object-itemchildren)


* * * 

### `onChildrenChange()`

<dl><dt>Parameters</dt><dd><ul><li>added — <i>Item</i></li><li>removed — <i>Item</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonchildrenchangeitem-added-item-removed)


* * * 

### `children.firstChild`

<dl><dt>Type</dt><dd><i>Item</i></dd><dt>Read Only</dt></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenfirstchild)


* * * 

### `children.lastChild`

<dl><dt>Type</dt><dd><i>Item</i></dd><dt>Read Only</dt></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenlastchild)


* * * 

### `children.bottomChild`

<dl><dt>Type</dt><dd><i>Item</i></dd><dt>Read Only</dt></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrenbottomchild)


* * * 

### `children.topChild`

<dl><dt>Type</dt><dd><i>Item</i></dd><dt>Read Only</dt></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#readonly-item-itemchildrentopchild)


* * * 

### `children.length`

<dl><dt>Type</dt><dd><i>Integer</i></dd><dt>Read Only</dt></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#readonly-integer-itemchildrenlength)


* * * 

### `children.layout`

<dl><dt>Type</dt><dd><i>Item</i></dd></dl>

Item used to position children items.
Can be e.g. *Flow*, *Grid* etc.


* * * 

### `children.onLayoutChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemchildrenonlayoutchangeitem-oldvalue)


* * * 

### `children.target`

<dl><dt>Type</dt><dd><i>Item</i></dd></dl>

A new child trying to be added into the item with the `children.target` defined
will be added into the `target` item.


* * * 

### `children.onTargetChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemchildrenontargetchangeitem-oldvalue)


* * * 

### `children.get()`

<dl><dt>Parameters</dt><dd><ul><li>index — <i>Integer</i></li></ul></dd><dt>Returns</dt><dd><i>Item</i></dd></dl>

Returns an item with the given index.


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#item-itemchildrengetinteger-index)


* * * 

### `children.index()`

<dl><dt>Parameters</dt><dd><ul><li>value — <i>Item</i></li></ul></dd><dt>Returns</dt><dd><i>Integer</i></dd></dl>

Returns an index of the given child in the children array.


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#integer-itemchildrenindexitem-value)


* * * 

### `children.has()`

<dl><dt>Parameters</dt><dd><ul><li>value — <i>Item</i></li></ul></dd><dt>Returns</dt><dd><i>Boolean</i></dd></dl>

Returns `true` if the given item is an item child.


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#boolean-itemchildrenhasitem-value)


* * * 

### `children.clear()`
Removes all children from the item.


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#itemchildrenclear)


* * * 

### `parent`

<dl><dt>Type</dt><dd><i>Item</i></dd><dt>Default</dt><dd><code>null</code></dd></dl>


* * * 

### `onParentChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldParent — <i>Item</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonparentchangeitem-oldparent)


* * * 

### `previousSibling`

<dl><dt>Type</dt><dd><i>Item</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#item-itemprevioussibling)


* * * 

### `onPreviousSiblingChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonprevioussiblingchangeitem-oldvalue)


* * * 

### `nextSibling`

<dl><dt>Type</dt><dd><i>Item</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#item-itemnextsibling)


* * * 

### `onNextSiblingChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonnextsiblingchangeitem-oldvalue)


* * * 

### `belowSibling`

<dl><dt>Type</dt><dd><i>Item</i></dd><dt>Read Only</dt></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#readonly-item-itembelowsibling)


* * * 

### `aboveSibling`

<dl><dt>Type</dt><dd><i>Item</i></dd><dt>Read Only</dt></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#readonly-item-itemabovesibling)


* * * 

### `index`

<dl><dt>Type</dt><dd><i>Integer</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#integer-itemindex)


* * * 

### `visible`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>

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


* * * 

### `onVisibleChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonvisiblechangeboolean-oldvalue)


* * * 

### `clip`

<dl><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>


* * * 

### `onClipChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonclipchangeboolean-oldvalue)


* * * 

### `width`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>


* * * 

### `onWidthChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonwidthchangefloat-oldvalue)


* * * 

### `height`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>


* * * 

### `onHeightChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonheightchangefloat-oldvalue)


* * * 

### `x`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>


* * * 

### `onXChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonxchangefloat-oldvalue)


* * * 

### `y`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>


* * * 

### `onYChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonychangefloat-oldvalue)


* * * 

### `z`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>


* * * 

### `onZChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonzchangefloat-oldvalue)


* * * 

### `scale`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1</code></dd></dl>


* * * 

### `onScaleChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonscalechangefloat-oldvalue)


* * * 

### `rotation`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>

```nml
Rectangle {
    width: 100
    height: 100
    color: 'red'
    rotation: Math.PI / 4
}
```


* * * 

### `onRotationChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonrotationchangefloat-oldvalue)


* * * 

### `opacity`

<dl><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>1</code></dd></dl>


* * * 

### `onOpacityChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Float</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonopacitychangefloat-oldvalue)


* * * 

### `linkUri`

<dl><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>&#39;&#39;</code></dd></dl>

Points to the URI which will be used when user clicks on this item.


* * * 

### `onLinkUriChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonlinkurichangestring-oldvalue)


* * * 

### `background`

<dl><dt>Type</dt><dd><i>Item</i></dd></dl>

An item used as a background for the item.

By default, background is filled to his parent.


* * * 

### `onBackgroundChange()`

<dl><dt>Parameters</dt><dd><ul><li>oldValue — <i>Item</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonbackgroundchangeitem-oldvalue)


* * * 

### `overlap()`

<dl><dt>Parameters</dt><dd><ul><li>item — <i>Item</i></li></ul></dd></dl>

Returns `true` if two items overlaps.


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#itemoverlapitem-item)


* * * 

### `anchors`

<dl><dt>Type</dt><dd><i>Item.Anchors</i></dd></dl>


* * * 

### `onAnchorsChange()`

<dl><dt>Parameters</dt><dd><ul><li>property — <i>String</i></li><li>oldValue — <i>Array</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonanchorschangestring-property-array-oldvalue)


* * * 

### `layout`

<dl><dt>Type</dt><dd><i>Item.Layout</i></dd></dl>


* * * 

### `onLayoutChange()`

<dl><dt>Parameters</dt><dd><ul><li>property — <i>String</i></li><li>oldValue — <i>Any</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonlayoutchangestring-property-any-oldvalue)


* * * 

### `pointer`

<dl><dt>Type</dt><dd><i>Item.Pointer</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#itempointer-itempointer)


* * * 

### `margin`

<dl><dt>Type</dt><dd><i>Item.Margin</i></dd></dl>


* * * 

### `onMarginChange()`

<dl><dt>Parameters</dt><dd><ul><li>property — <i>String</i></li><li>oldValue — <i>Any</i></li></ul></dd><dt>Type</dt><dd><i>Signal</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#signal-itemonmarginchangestring-property-any-oldvalue)


* * * 

### `keys`

<dl><dt>Type</dt><dd><i>Item.Keys</i></dd></dl>


> [`Source`](https://github.com/Neft-io/neft/blob/88c1d4e83c5a6037666ad9719faf105f21aa5cbe/src/renderer/types/basics/item.litcoffee#itemkeys-itemkeys)

