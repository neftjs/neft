> [Wiki](Home) ▸ [API Reference](API-Reference)

Keys
<dl><dt>Syntax</dt><dd>Keys @extension</dd></dl>
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

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#keys-extension)

focusWindowOnPointerPress
<dl><dt>Syntax</dt><dd>*Boolean* Keys.focusWindowOnPointerPress = true</dd><dt>Static property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#boolean-keysfocuswindowonpointerpress--true)

focusedItem
<dl><dt>Syntax</dt><dd>*Item* Keys.focusedItem</dd><dt>Static property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><i>Item</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#item-keysfocuseditem)

Keys
<dl><dt>Syntax</dt><dd>*Keys* Keys()</dd><dt>Returns</dt><dd><i>Keys</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#keys-keys)

onPress
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Keys::onPress(*KeysEvent* event)</dd><dt>Prototype method of</dt><dd><i>Keys</i></dd><dt>Parameters</dt><dd><ul><li>event — <i>KeysEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#signal-keysonpresskeysevent-eventsignal-keysonholdkeysevent-eventsignal-keysonreleasekeysevent-eventsignal-keysoninputkeysevent-event)

focus
<dl><dt>Syntax</dt><dd>*Boolean* Keys::focus = false</dd><dt>Prototype property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#boolean-keysfocus--false-signal-keysonfocuschangeboolean-oldvalue)

KeysEvent
<dl><dt>Syntax</dt><dd>*KeysEvent* KeysEvent() : *DeviceKeyboardEvent*</dd><dt>Extends</dt><dd><i>DeviceKeyboardEvent</i></dd><dt>Returns</dt><dd><i>KeysEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#keysevent-keysevent--devicekeyboardevent)

event
<dl><dt>Syntax</dt><dd>*KeysEvent* Keys.event</dd><dt>Static property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><i>KeysEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#keysevent-keysevent)

