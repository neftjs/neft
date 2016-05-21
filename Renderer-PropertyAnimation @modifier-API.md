> [Wiki](Home) ▸ [API Reference](API-Reference)

PropertyAnimation
<dl></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#propertyanimation-modifier)

PropertyAnimation
<dl><dt>Extends</dt><dd><i>Renderer.Animation</i></dd><dt>Returns</dt><dd><i>PropertyAnimation</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#propertyanimation-propertyanimation--rendereranimation)

target
<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Renderer.Item</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#rendereritem-propertyanimationtarget-signal-propertyanimationontargetchangerendereritem-oldvalue)

property
<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#string-propertyanimationproperty-signal-propertyanimationonpropertychangestring-oldvalue)

duration
<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>250</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#float-propertyanimationduration--250-signal-propertyanimationondurationchangefloat-oldvalue)

startDelay
<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#float-propertyanimationstartdelay--0-signal-propertyanimationonstartdelaychangefloat-oldvalue)

loopDelay
<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#float-propertyanimationloopdelay--0-signal-propertyanimationonloopdelaychangefloat-oldvalue)

delay
<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#float-propertyanimationdelay--0-signal-propertyanimationondelaychangefloat-oldvalue)

updateData
<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#boolean-propertyanimationupdatedata--false-signal-propertyanimationonupdatedatachangeboolean-oldvalue)

updateProperty
<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#boolean-propertyanimationupdateproperty--false-signal-propertyanimationonupdatepropertychangeboolean-oldvalue)

from
<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Any</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#any-propertyanimationfrom-signal-propertyanimationonfromchangeany-oldvalue)

to
<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Any</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#any-propertyanimationto-signal-propertyanimationontochangeany-oldvalue)

progress
<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Float</i></dd><dt>Default</dt><dd><code>0</code></dd><dt>read only</dt></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#readonly-float-propertyanimationprogress--0)

easing
<dl><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Easing</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#easing-propertyanimationeasing-signal-propertyanimationoneasingchangeeasing-value)

Easing
<dl><dt>Returns</dt><dd><i>Easing</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#easing-easing)

type
<dl><dt>Prototype property of</dt><dd><i>Easing</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'Linear'</code></dd></dl>
Supported easing functions:
Linear, InQuad, OutQuad, InOutQuad, InCubic, OutCubic,
InOutCubic, InQuart, OutQuart, InOutQuart, InQuint, OutQuint,
InOutQuint, InSine, OutSine, InOutSine, InExpo, OutExpo,
InOutExpo, InCirc, OutCirc, InOutCirc, InElastic, OutElastic,
InOutElastic, InBack, OutBack, InOutBack, InBounce, OutBounce,
InOutBounce.

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#string-easingtype--linear)

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
    * [progress](#progress)
    * [easing](#easing)
    * [Easing](#easing)
    * [type](#type)
  * [onTypeChange](#ontypechange)

##onTypeChange
<dl><dt>Prototype method of</dt><dd><i>Easing</i></dd><dt>Parameters</dt><dd><ul><li><b>oldValue</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#signal-easingontypechangestring-oldvalue)

