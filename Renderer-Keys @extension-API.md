> [Wiki](Home) ▸ [API Reference](API-Reference)

Keys
<dl></dl>
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
<dl><dt>Static property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#boolean-keysfocuswindowonpointerpress--true)

focusedItem
<dl><dt>Static property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><i>Item</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#item-keysfocuseditem)

Keys
<dl><dt>Returns</dt><dd><i>Keys</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#keys-keys)

onPress
<dl><dt>Prototype method of</dt><dd><i>Keys</i></dd><dt>Parameters</dt><dd><ul><li><b>event</b> — <i>KeysEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#signal-keysonpresskeysevent-eventsignal-keysonholdkeysevent-eventsignal-keysonreleasekeysevent-eventsignal-keysoninputkeysevent-event)

focus
<dl><dt>Prototype property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#boolean-keysfocus--false-signal-keysonfocuschangeboolean-oldvalue)

KeysEvent
<dl><dt>Extends</dt><dd><i>DeviceKeyboardEvent</i></dd><dt>Returns</dt><dd><i>KeysEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#keysevent-keysevent--devicekeyboardevent)

event
<dl><dt>Static property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><i>KeysEvent</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#keysevent-keysevent)

