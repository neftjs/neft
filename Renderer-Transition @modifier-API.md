> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
Transition
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

<dl><dt>Static method of</dt><dd><i>Transition</i></dd><dt>Parameters</dt><dd><ul><li><b>component</b> — <i>Component</i> — <i>optional</i></li><li><b>options</b> — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>Transition</i></dd></dl>
New
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/transition.litcoffee#transition-transitionnewcomponent-component-object-options)

<dl><dt>Returns</dt><dd><i>Transition</i></dd></dl>
Transition
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/transition.litcoffee#transition-transition)

<dl><dt>Prototype property of</dt><dd><i>Transition</i></dd><dt>Type</dt><dd><i>Boolean</i></dd></dl>
when
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/transition.litcoffee#boolean-transitionwhen-signal-transitiononwhenchangeboolean-oldvaluerendereritem-transitiontarget-signal-transitionontargetchangerendereritem-oldvalue)

## Table of contents
    * [Transition](#transition)
    * [New](#new)
    * [Transition](#transition)
    * [when](#when)
  * [*Renderer.Animation* Transition::animation](#rendereranimation-transitionanimation)
  * [*String* Transition::property](#string-transitionproperty)

*Renderer.Animation* Transition::animation
------------------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Transition::onAnimationChange(*Renderer.Animation* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/transition.litcoffee#rendereranimation-transitionanimation-signal-transitiononanimationchangerendereranimation-oldvalue)

*String* Transition::property
-----------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Transition::onPropertyChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/transition.litcoffee#string-transitionproperty-signal-transitiononpropertychangestring-oldvalue)

