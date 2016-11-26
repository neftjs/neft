> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Item|Renderer-Item-API]] ▸ **Margin**

#Margin
<dl><dt>Syntax</dt><dd><code>Item.Margin</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee#itemmargin)

## Table of contents
* [Margin](#margin)
* [**Class** Margin](#class-margin)
  * [left](#left)
  * [onLeftChange](#onleftchange)
  * [top](#top)
  * [onTopChange](#ontopchange)
  * [right](#right)
  * [onRightChange](#onrightchange)
  * [bottom](#bottom)
  * [onBottomChange](#onbottomchange)
  * [horizontal](#horizontal)
  * [onHorizontalChange](#onhorizontalchange)
  * [vertical](#vertical)
  * [onVerticalChange](#onverticalchange)
  * [valueOf](#valueof)
* [Glossary](#glossary)

# **Class** Margin

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee)

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

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee)

##left
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Margin::left = `0`</code></dd><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##onLeftChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Margin::onLeftChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee#signal-marginonleftchangefloat-oldvalue)

##top
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Margin::top = `0`</code></dd><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##onTopChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Margin::onTopChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee#signal-marginontopchangefloat-oldvalue)

##right
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Margin::right = `0`</code></dd><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##onRightChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Margin::onRightChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee#signal-marginonrightchangefloat-oldvalue)

##bottom
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Margin::bottom = `0`</code></dd><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##onBottomChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Margin::onBottomChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee#signal-marginonbottomchangefloat-oldvalue)

##horizontal
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Margin::horizontal = `0`</code></dd><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
Sum of the left and right margin.

##onHorizontalChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Margin::onHorizontalChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee#signal-marginonhorizontalchangefloat-oldvalue)

##vertical
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Margin::vertical = `0`</code></dd><dt>Prototype property of</dt><dd><i>Margin</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
Sum of the top and bottom margin.

##onVerticalChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Margin::onVerticalChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee#signal-marginonverticalchangefloat-oldvalue)

##valueOf
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Margin::valueOf()</code></dd><dt>Prototype method of</dt><dd><i>Margin</i></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/margin.litcoffee#float-marginvalueof)

# Glossary

- [Item.Margin](#class-margin)
