> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Item|Renderer-Item-API]] ▸ **Keys**

#Keys
<dl><dt>Syntax</dt><dd><code>Item.Keys</code></dd><dt>Static property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
```javascript
Rectangle {
    width: 100
    height: 100
    color: 'green'
    keys.focus: true
    keys.onPressed: function(){
        this.color = 'red';
    }
    keys.onReleased: function(){
        this.color = 'green';
    }
}
```

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/keys.litcoffee#itemkeys)

## Table of contents
* [Keys](#keys)
* [**Class** Keys](#class-keys)
  * [focusWindowOnPointerPress](#focuswindowonpointerpress)
  * [focusedItem](#focuseditem)
  * [**Class** Keys.Event](#class-keysevent)
  * [onPress](#onpress)
  * [onHold](#onhold)
  * [onRelease](#onrelease)
  * [onInput](#oninput)
  * [*Boolean* Keys::focus = false](#boolean-keysfocus--false)
  * [onFocusChange](#onfocuschange)
  * [event](#event)
* [Glossary](#glossary)

# **Class** Keys

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/keys.litcoffee)

##focusWindowOnPointerPress
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Keys.focusWindowOnPointerPress = `true`</code></dd><dt>Static property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/keys.litcoffee#boolean-keysfocuswindowonpointerpress--true)

##focusedItem
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Keys.focusedItem</code></dd><dt>Static property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/keys.litcoffee#item-keysfocuseditem)

##**Class** Keys.Event
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Keys.Event : &#x2A;Device.KeyboardEvent&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Device-API#class-devicekeyboardevent">Device.KeyboardEvent</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/keys.litcoffee#class-keysevent--devicekeyboardevent)

##onPress
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Keys::onPress(&#x2A;Item.Keys.Event&#x2A; event)</code></dd><dt>Prototype method of</dt><dd><i>Keys</i></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Item.Keys-API#class-keysevent">Item.Keys.Event</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
##onHold
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Keys::onHold(&#x2A;Item.Keys.Event&#x2A; event)</code></dd><dt>Prototype method of</dt><dd><i>Keys</i></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Item.Keys-API#class-keysevent">Item.Keys.Event</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
##onRelease
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Keys::onRelease(&#x2A;Item.Keys.Event&#x2A; event)</code></dd><dt>Prototype method of</dt><dd><i>Keys</i></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Item.Keys-API#class-keysevent">Item.Keys.Event</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
##onInput
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Keys::onInput(&#x2A;Item.Keys.Event&#x2A; event)</code></dd><dt>Prototype method of</dt><dd><i>Keys</i></dd><dt>Parameters</dt><dd><ul><li>event — <a href="/Neft-io/neft/wiki/Renderer-Item.Keys-API#class-keysevent">Item.Keys.Event</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/keys.litcoffee#signal-keysoninputitemkeysevent-event)

## *Boolean* Keys::focus = false

##onFocusChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Keys::onFocusChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Keys</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/keys.litcoffee#signal-keysonfocuschangeboolean-oldvalue)

##event
<dl><dt>Syntax</dt><dd><code>&#x2A;Item.Keys.Event&#x2A; Keys.event</code></dd><dt>Static property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item.Keys-API#class-keysevent">Item.Keys.Event</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/renderer/types/basics/item/keys.litcoffee#itemkeysevent-keysevent)

# Glossary

- [Item.Keys](#class-keys)
- [Item.Keys.Event](#class-keysevent)

