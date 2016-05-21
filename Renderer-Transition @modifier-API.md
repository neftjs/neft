> [Wiki](Home) ▸ [API Reference](API-Reference)

Transition
<dl></dl>
```nml
`Rectangle {
`   width: 100; height: 100;
`   color: 'red'
`   pointer.onClick: function(){
`       this.x = Math.random()*300;
`   }
`
`   Transition {
`       property: 'x'
`       animation: NumberAnimation {
`           duration: 1500
`       }
`   }
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/transition.litcoffee#transition-modifier)

New
<dl><dt>Static method of</dt><dd><i>Transition</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Transition</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/transition.litcoffee#transition-transitionnewcomponent-component-object-options)

Transition
<dl><dt>Returns</dt><dd><i>Transition</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/transition.litcoffee#transition-transition)

when
<dl><dt>Prototype property of</dt><dd><i>Transition</i></dd><dt>Type</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/transition.litcoffee#boolean-transitionwhen-signal-transitiononwhenchangeboolean-oldvaluerendereritem-transitiontarget-signal-transitionontargetchangerendereritem-oldvalue)

animation
<dl><dt>Prototype property of</dt><dd><i>Transition</i></dd><dt>Type</dt><dd><i>Renderer.Animation</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/transition.litcoffee#rendereranimation-transitionanimation-signal-transitiononanimationchangerendereranimation-oldvalue)

property
<dl><dt>Prototype property of</dt><dd><i>Transition</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/transition.litcoffee#string-transitionproperty-signal-transitiononpropertychangestring-oldvalue)

