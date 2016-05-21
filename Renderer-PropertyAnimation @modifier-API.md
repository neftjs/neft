> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
PropertyAnimation
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#propertyanimation-modifier)

<dl><dt>Extends</dt><dd><i>Renderer.Animation</i></dd><dt>Returns</dt><dd><i>PropertyAnimation</i></dd></dl>
PropertyAnimation
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#propertyanimation-propertyanimation--rendereranimation)

<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Renderer.Item</i></dd></dl>
target
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#rendereritem-propertyanimationtarget-signal-propertyanimationontargetchangerendereritem-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
property
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#string-propertyanimationproperty-signal-propertyanimationonpropertychangestring-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>250</code></dd></dl>
duration
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#float-propertyanimationduration--250-signal-propertyanimationondurationchangefloat-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
startDelay
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#float-propertyanimationstartdelay--0-signal-propertyanimationonstartdelaychangefloat-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
loopDelay
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#float-propertyanimationloopdelay--0-signal-propertyanimationonloopdelaychangefloat-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
delay
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#float-propertyanimationdelay--0-signal-propertyanimationondelaychangefloat-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
updateData
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#boolean-propertyanimationupdatedata--false-signal-propertyanimationonupdatedatachangeboolean-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
updateProperty
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#boolean-propertyanimationupdateproperty--false-signal-propertyanimationonupdatepropertychangeboolean-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Any</i></dd></dl>
from
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#any-propertyanimationfrom-signal-propertyanimationonfromchangeany-oldvalue)

<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Any</i></dd></dl>
to
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#any-propertyanimationto-signal-propertyanimationontochangeany-oldvalue)

## Table of contents
    * [PropertyAnimation](#propertyanimation)
    * [PropertyAnimation](#propertyanimation)
    * [target](#target)
    * [property](#property)
    * [duration](#duration)
    * [startDelay](#startdelay)
    * [loopDelay](#loopdelay)
    * [delay](#delay)
    * [updateData](#updatedata)
    * [updateProperty](#updateproperty)
    * [from](#from)
    * [to](#to)
  * [ReadOnly *Float* PropertyAnimation::progress = 0](#readonly-float-propertyanimationprogress--0)
  * [*Easing* PropertyAnimation::easing](#easing-propertyanimationeasing)
  * [*Easing* Easing()](#easing-easing)
  * [*String* Easing::type = 'Linear'](#string-easingtype--linear)
  * [*Signal* Easing::onTypeChange(*String* oldValue)](#signal-easingontypechangestring-oldvalue)

ReadOnly [*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) PropertyAnimation::progress = 0
------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#readonly-float-propertyanimationprogress--0)

*Easing* PropertyAnimation::easing
----------------------------------
## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) PropertyAnimation::onEasingChange(*Easing* value)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#easing-propertyanimationeasing-signal-propertyanimationoneasingchangeeasing-value)

*Easing* Easing()
-----------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#easing-easing)

*String* Easing::type = 'Linear'
--------------------------------

Supported easing functions:
Linear, InQuad, OutQuad, InOutQuad, InCubic, OutCubic,
InOutCubic, InQuart, OutQuart, InOutQuart, InQuint, OutQuint,
InOutQuint, InSine, OutSine, InOutSine, InExpo, OutExpo,
InOutExpo, InCirc, OutCirc, InOutCirc, InElastic, OutElastic,
InOutElastic, InBack, OutBack, InOutBack, InBounce, OutBounce,
InOutBounce.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#string-easingtype--linear)

## [*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) Easing::onTypeChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#signal-easingontypechangestring-oldvalue)

