> [Wiki](Home) ▸ [API Reference](API-Reference)

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

focusWindowOnPointerPress
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#boolean-keysfocuswindowonpointerpress--true)

focusedItem
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#item-keysfocuseditem)

Keys
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#keys-keys)

onPress
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#signal-keysonpresskeysevent-eventsignal-keysonholdkeysevent-eventsignal-keysonreleasekeysevent-eventsignal-keysoninputkeysevent-event)

focus
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#boolean-keysfocus--false-signal-keysonfocuschangeboolean-oldvalue)

KeysEvent
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#keysevent-keysevent--devicekeyboardevent)

event
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/basics/item/keys.litcoffee#keysevent-keysevent)

