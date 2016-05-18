> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Transition @modifier**

Transition @modifier
====================

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

## Table of contents
  * [Transition.New([component, options])](#transition-transitionnewcomponent-component-object-options)
  * [Transition()](#transition-transition)
  * [when](#boolean-transitionwhen)
  * [*Renderer.Animation* animation](#rendereranimation-transitionanimation)
  * [property](#string-transitionproperty)

*Transition* Transition.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])
----------------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/transition.litcoffee#transition-transitionnewcomponent-component-object-options)

*Transition* Transition()
-------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/transition.litcoffee#transition-transition)

*Boolean* Transition::when
--------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Transition::onWhenChange(*Boolean* oldValue)
*Renderer.Item* Transition::target
----------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Transition::onTargetChange([*Renderer.Item* oldValue])

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/transition.litcoffee#boolean-transitionwhen-signal-transitiononwhenchangeboolean-oldvaluerendereritem-transitiontarget-signal-transitionontargetchangerendereritem-oldvalue)

*Renderer.Animation* Transition::animation
------------------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Transition::onAnimationChange(*Renderer.Animation* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/transition.litcoffee#rendereranimation-transitionanimation-signal-transitiononanimationchangerendereranimation-oldvalue)

*String* Transition::property
-----------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Transition::onPropertyChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/transition.litcoffee#string-transitionproperty-signal-transitiononpropertychangestring-oldvalue)

