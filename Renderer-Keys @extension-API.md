> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Keys @extension**

Keys @extension
===============

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

## Table of contents
  * [Keys.focusWindowOnPointerPress = true](#boolean-keysfocuswindowonpointerpress--true)
  * [Keys.focusedItem](#item-keysfocuseditem)
  * [Keys()](#keys-keys)
  * [onPress(event)](#signal-keysonpresskeysevent-event)
  * [focus = false](#boolean-keysfocus--false)
  * [KeysEvent() : *DeviceKeyboardEvent*](#keysevent-keysevent--devicekeyboardevent)
  * [Keys.event](#keysevent-keysevent)

*Boolean* Keys.focusWindowOnPointerPress = true
-----------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#boolean-keysfocuswindowonpointerpress--true)

*Item* Keys.focusedItem
-----------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#item-keysfocuseditem)

*Keys* Keys()
-------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#keys-keys)

*Signal* Keys::onPress(*KeysEvent* event)
-----------------------------------------
*Signal* Keys::onHold(*KeysEvent* event)
----------------------------------------
*Signal* Keys::onRelease(*KeysEvent* event)
-------------------------------------------
*Signal* Keys::onInput(*KeysEvent* event)
-----------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#signal-keysonpresskeysevent-eventsignal-keysonholdkeysevent-eventsignal-keysonreleasekeysevent-eventsignal-keysoninputkeysevent-event)

*Boolean* Keys::focus = false
-----------------------------
## *Signal* Keys::onFocusChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#boolean-keysfocus--false-signal-keysonfocuschangeboolean-oldvalue)

*KeysEvent* KeysEvent() : *DeviceKeyboardEvent*
-----------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#keysevent-keysevent--devicekeyboardevent)

*KeysEvent* Keys.event
----------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#keysevent-keysevent)

