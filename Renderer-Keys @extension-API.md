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

*Boolean* Keys.focusWindowOnPointerPress = true
-----------------------------------------------

*Item* Keys.focusedItem
-----------------------

*Keys* Keys()
-------------

*Signal* Keys::onPress(*KeysEvent* event)
-----------------------------------------

*Signal* Keys::onHold(*KeysEvent* event)
----------------------------------------

*Signal* Keys::onRelease(*KeysEvent* event)
-------------------------------------------

*Signal* Keys::onInput(*KeysEvent* event)
-----------------------------------------

*Boolean* Keys::focus = false
-----------------------------

## *Signal* Keys::onFocusChange(*Boolean* oldValue)

*KeysEvent* KeysEvent() : *DeviceKeyboardEvent*
-----------------------------------------------

*KeysEvent* Keys.event
----------------------

