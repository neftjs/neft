> [Wiki](Home) ▸ [API Reference](API-Reference)

Keys
<dl><dt>Syntax</dt><dd><code>Keys @extension</code></dd></dl>
```nml
`Rectangle {
`   width: 100
`   height: 100
`   color: 'green'
`   keys.focus: true
`   keys.onPressed: function(){
`       this.color = 'red';
`   }
`   keys.onReleased: function(){
`       this.color = 'green';
`   }
`}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/keys.litcoffee#keys-extension)

focusWindowOnPointerPress
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Keys.focusWindowOnPointerPress = true</code></dd><dt>Static property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/keys.litcoffee#boolean-keysfocuswindowonpointerpress--true)

focusedItem
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Keys.focusedItem</code></dd><dt>Static property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><i>Item</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/keys.litcoffee#item-keysfocuseditem)

Keys
<dl><dt>Syntax</dt><dd><code>&#x2A;Keys&#x2A; Keys()</code></dd><dt>Returns</dt><dd><i>Keys</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/keys.litcoffee#keys-keys)

onPress
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Keys::onPress(&#x2A;KeysEvent&#x2A; event)</code></dd><dt>Prototype method of</dt><dd><i>Keys</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>KeysEvent</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/keys.litcoffee#signal-keysonpresskeysevent-eventsignal-keysonholdkeysevent-eventsignal-keysonreleasekeysevent-eventsignal-keysoninputkeysevent-event)

focus
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Keys::focus = false</code></dd><dt>Prototype property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/keys.litcoffee#boolean-keysfocus--false-signal-keysonfocuschangeboolean-oldvalue)

KeysEvent
<dl><dt>Syntax</dt><dd><code>&#x2A;KeysEvent&#x2A; KeysEvent() : &#x2A;DeviceKeyboardEvent&#x2A;</code></dd><dt>Extends</dt><dd><i>DeviceKeyboardEvent</i></dd><dt>Returns</dt><dd><i>KeysEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/keys.litcoffee#keysevent-keysevent--devicekeyboardevent)

event
<dl><dt>Syntax</dt><dd><code>&#x2A;KeysEvent&#x2A; Keys.event</code></dd><dt>Static property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><i>KeysEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/basics/item/keys.litcoffee#keysevent-keysevent)

