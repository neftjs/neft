> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Item|Renderer-Item-API]] ▸ **Margin**

#Margin
<dl><dt>Syntax</dt><dd><code>Item.Margin</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/API/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee#margin)

## Table of contents
* [Margin](#margin)
* [**Class** Margin](#class-margin)
  * [*Float* Margin::left = `0`](#float-marginleft--0)
  * [*Float* Margin::top = `0`](#float-margintop--0)
  * [*Float* Margin::right = `0`](#float-marginright--0)
  * [*Float* Margin::bottom = `0`](#float-marginbottom--0)
  * [*Float* Margin::horizontal = `0`](#float-marginhorizontal--0)
  * [onHorizontalChange](#onhorizontalchange)
  * [*Float* Margin::vertical = `0`](#float-marginvertical--0)
  * [onVerticalChange](#onverticalchange)
  * [valueOf](#valueof)
* [Glossary](#glossary)

# **Class** Margin

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee#class-margin)

Margins are used in anchors and within layout items.

```javascript
Rectangle {
    width: 100
    height: 100
    color: 'red'
    Rectangle {
        width: 100
        height: 50
        color: 'yellow'
        anchors.left: parent.right
        margin.left: 20
    }
}
```

```javascript
Column {
    Rectangle { color: 'red'; width: 50; height: 50; }
    Rectangle { color: 'yellow'; width: 50; height: 50; margin.top: 20; }
    Rectangle { color: 'green'; width: 50; height: 50; }
}
```

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee#class-margin)

## [Float](/Neft-io/neft/wiki/API/Utils-API#isfloat) Margin::left = `0`

## [Signal](/Neft-io/neft/wiki/API/Signal-API#class-signal) Margin::onLeftChange([Float](/Neft-io/neft/wiki/API/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee#float-marginleft--0-signal-marginonleftchangefloat-oldvalue)

## [Float](/Neft-io/neft/wiki/API/Utils-API#isfloat) Margin::top = `0`

## [Signal](/Neft-io/neft/wiki/API/Signal-API#class-signal) Margin::onTopChange([Float](/Neft-io/neft/wiki/API/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee#float-margintop--0-signal-marginontopchangefloat-oldvalue)

## [Float](/Neft-io/neft/wiki/API/Utils-API#isfloat) Margin::right = `0`

## [Signal](/Neft-io/neft/wiki/API/Signal-API#class-signal) Margin::onRightChange([Float](/Neft-io/neft/wiki/API/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee#float-marginright--0-signal-marginonrightchangefloat-oldvalue)

## [Float](/Neft-io/neft/wiki/API/Utils-API#isfloat) Margin::bottom = `0`

## [Signal](/Neft-io/neft/wiki/API/Signal-API#class-signal) Margin::onBottomChange([Float](/Neft-io/neft/wiki/API/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee#float-marginbottom--0-signal-marginonbottomchangefloat-oldvalue)

## [Float](/Neft-io/neft/wiki/API/Utils-API#isfloat) Margin::horizontal = `0`

Sum of the left and right margin.

##onHorizontalChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Margin::onHorizontalChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/API/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/API/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee#onhorizontalchange)

## [Float](/Neft-io/neft/wiki/API/Utils-API#isfloat) Margin::vertical = `0`

Sum of the top and bottom margin.

##onVerticalChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Margin::onVerticalChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/API/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/API/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee#onverticalchange)

##valueOf
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Margin::valueOf()</code></dd><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/API/Utils-API#isfloat">Float</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee#valueof)

# Glossary

- [Item.Margin](#class-margin)

