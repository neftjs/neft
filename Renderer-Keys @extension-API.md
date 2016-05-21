> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
Keys
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

<dl><dt>Static property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
focusWindowOnPointerPress
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#boolean-keysfocuswindowonpointerpress--true)

<dl><dt>Static property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><i>Item</i></dd></dl>
focusedItem
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#item-keysfocuseditem)

<dl><dt>Returns</dt><dd><i>Keys</i></dd></dl>
Keys
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#keys-keys)

<dl><dt>Prototype method of</dt><dd><i>Keys</i></dd><dt>Parameters</dt><dd><ul><li><b>event</b> — <i>KeysEvent</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
onPress
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#signal-keysonpresskeysevent-eventsignal-keysonholdkeysevent-eventsignal-keysonreleasekeysevent-eventsignal-keysoninputkeysevent-event)

<dl><dt>Prototype property of</dt><dd><i>Keys</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
focus
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#boolean-keysfocus--false-signal-keysonfocuschangeboolean-oldvalue)

## Table of contents
    * [Keys](#keys)
    * [focusWindowOnPointerPress](#focuswindowonpointerpress)
    * [focusedItem](#focuseditem)
    * [Keys](#keys)
    * [onPress](#onpress)
    * [focus](#focus)
  * [*KeysEvent* KeysEvent() : *DeviceKeyboardEvent*](#keysevent-keysevent--devicekeyboardevent)
  * [*KeysEvent* Keys.event](#keysevent-keysevent)

*KeysEvent* KeysEvent() : *DeviceKeyboardEvent*
-----------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#keysevent-keysevent--devicekeyboardevent)

*KeysEvent* Keys.event
----------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#keysevent-keysevent)

