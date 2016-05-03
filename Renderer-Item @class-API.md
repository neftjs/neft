Item @class
===========

*Item* Item.New([*Component* component, *Object* options])
----------------------------------------------------------

*Item* Item()
-------------

This is a base class for everything which is visible.

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

## *Signal* Item::on$Change(*String* property, *Any* oldValue)

*Signal* Item::ready()
----------------------

Called when the Item is ready, that is, all
properties have been set and it's ready to use.

```nml
`Rectangle {
`   width: 200
`   height: 50
`   color: 'green'
`
`   Rectangle {
`       width: parent.width / 2
`       height: parent.height / 2
`       color: 'yellow'
`       onReady: function(){
`           console.log(this.width, this.height);
`           // 100, 25
`       }
`   }
`}
```

*Signal* Item::onAnimationFrame(*Integer* miliseconds)
------------------------------------------------------

ReadOnly *String* Item::id
--------------------------

*Object* Item::children
-----------------------

## *Signal* Item::onChildrenChange(*Item* added, *Item* removed)

ReadOnly *Item* Item::children.firstChild
-----------------------------------------

ReadOnly *Item* Item::children.lastChild
----------------------------------------

ReadOnly *Item* Item::children.bottomChild
------------------------------------------

ReadOnly *Item* Item::children.topChild
---------------------------------------

ReadOnly *Integer* Item::children.length
----------------------------------------

*Item* Item::children.layout
----------------------------

Item used to position children items.
Can be e.g. [Flow][renderer/Flow], [Grid][renderer/Grid] etc.

## *Signal* Item::children.onLayoutChange(*Item* oldValue)

*Item* Item::children.target
----------------------------

A new child trying to be added into the item with the `children.target` defined
will be added into the `target` item.

## *Signal* Item::children.onTargetChange(*Item* oldValue)

*Item* Item::children.get(*Integer* index)
------------------------------------------

Returns an item with the given index.

*Integer* Item::children.index(*Item* value)
--------------------------------------------

Returns an index of the given child in the children array.

*Boolean* Item::children.has(*Item* value)
------------------------------------------

Returns `true` if the given item is an item child.

Item::children.clear()
----------------------

Removes all children from the item.

*Item* Item::parent = null
--------------------------

## *Signal* Item::onParentChange(*Item* oldParent)

*Item* Item::previousSibling
----------------------------

## *Signal* Item::onPreviousSiblingChange(*Item* oldValue)

*Item* Item::nextSibling
------------------------

## *Signal* Item::onNextSiblingChange(*Item* oldValue)

ReadOnly *Item* Item::belowSibling
----------------------------------

ReadOnly *Item* Item::aboveSibling
----------------------------------

*Integer* Item::index
---------------------

*Boolean* Item::visible = true
------------------------------

Determines whether an item is visible or not.

```nml
`Item {
`   width: 100
`   height: 100
`   pointer.onClick: function(){
`       rect.visible = !rect.visible;
`       text.text = rect.visible ? "Click to hide" : "Click to show";
`   }
`
`   Rectangle {
`       id: rect
`       anchors.fill: parent
`       color: 'blue'
`   }
`
`   Text {
`       id: text
`       text: "Click to hide"
`       anchors.centerIn: parent
`   }
`}
```

## *Signal* Item::onVisibleChange(*Boolean* oldValue)

*Boolean* Item::clip = false
----------------------------

## *Signal* Item::onClipChange(*Boolean* oldValue)

*Float* Item::width = 0
-----------------------

## *Signal* Item::onWidthChange(*Float* oldValue)

*Float* Item::height = 0
------------------------

## *Signal* Item::onHeightChange(*Float* oldValue)

*Float* Item::x = 0
-------------------

## *Signal* Item::onXChange(*Float* oldValue)

*Float* Item::y = 0
-------------------

## *Signal* Item::onYChange(*Float* oldValue)

*Float* Item::z = 0
-------------------

## *Signal* Item::onZChange(*Float* oldValue)

*Float* Item::scale = 1
-----------------------

## *Signal* Item::onScaleChange(*Float* oldValue)

*Float* Item::rotation = 0
--------------------------

```nml
`Rectangle {
`   width: 100
`   height: 100
`   color: 'red'
`   rotation: Math.PI / 4
`}
```

## *Signal* Item::onRotationChange(*Float* oldValue)

*Float* Item::opacity = 1
-------------------------

## *Signal* Item::onOpacityChange(*Float* oldValue)

*String* Item::linkUri = ''
---------------------------

Points to the URI which will be used when user clicks on this item.

## *Signal* Item::onLinkUriChange(*String* oldValue)

*Item* Item::background = *Rectangle*
-------------------------------------

An item used as a background for the item.

By default, background is filled to his parent.

## *Signal* Item::onBackgroundChange(*Item* oldValue)

Item::overlap(*Renderer.Item* item)
-----------------------------------

Returns `true` if two items overlaps.

*Anchors* Item::anchors
-----------------------

## *Signal* Item::onAnchorsChange(*String* property, *Array* oldValue)

*Layout* Item::layout
---------------------

## *Signal* Item::onLayoutChange(*String* property, *Any* oldValue)

*Pointer* Item::pointer
-----------------------

*Margin* Item::margin
---------------------

## *Signal* Item::onMarginChange(*String* property, *Any* oldValue)

*Keys* Item::keys
-----------------

*Document* Item::document
-------------------------

