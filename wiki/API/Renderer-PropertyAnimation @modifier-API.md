> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Animation|Renderer-Animation @modifier-API]]

PropertyAnimation
<dl><dt>Syntax</dt><dd><code>PropertyAnimation @modifier</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property.litcoffee#propertyanimation)

## Nested APIs

* [[NumberAnimation|Renderer-NumberAnimation @modifier-API]]

PropertyAnimation
<dl><dt>Syntax</dt><dd><code>&#x2A;PropertyAnimation&#x2A; PropertyAnimation() : &#x2A;Renderer.Animation&#x2A;</code></dd><dt>Extends</dt><dd><i>Renderer.Animation</i></dd><dt>Returns</dt><dd><i>PropertyAnimation</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property.litcoffee#propertyanimation)

target
<dl><dt>Syntax</dt><dd><code>&#x2A;Renderer.Item&#x2A; PropertyAnimation::target</code></dd><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Renderer.Item</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property.litcoffee#target)

property
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; PropertyAnimation::property</code></dd><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property.litcoffee#property)

duration
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; PropertyAnimation::duration = 250</code></dd><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Utils-API.md#isfloat">Float</a></dd><dt>Default</dt><dd><code>250</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property.litcoffee#duration)

startDelay
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; PropertyAnimation::startDelay = 0</code></dd><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Utils-API.md#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property.litcoffee#startdelay)

loopDelay
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; PropertyAnimation::loopDelay = 0</code></dd><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Utils-API.md#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property.litcoffee#loopdelay)

delay
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; PropertyAnimation::delay = 0</code></dd><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Utils-API.md#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property.litcoffee#delay)

updateData
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; PropertyAnimation::updateData = false</code></dd><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property.litcoffee#updatedata)

updateProperty
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; PropertyAnimation::updateProperty = false</code></dd><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property.litcoffee#updateproperty)

from
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; PropertyAnimation::from</code></dd><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Any</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property.litcoffee#from)

to
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; PropertyAnimation::to</code></dd><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Any</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property.litcoffee#to)

progress
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; PropertyAnimation::progress = 0</code></dd><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Utils-API.md#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property.litcoffee#progress)

easing
<dl><dt>Syntax</dt><dd><code>&#x2A;Easing&#x2A; PropertyAnimation::easing</code></dd><dt>Prototype property of</dt><dd><i>PropertyAnimation</i></dd><dt>Type</dt><dd><i>Easing</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property.litcoffee#easing)

Easing
<dl><dt>Syntax</dt><dd><code>&#x2A;Easing&#x2A; Easing()</code></dd><dt>Returns</dt><dd><i>Easing</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property.litcoffee#easing)

type
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Easing::type = 'Linear'</code></dd><dt>Prototype property of</dt><dd><i>Easing</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'Linear'</code></dd></dl>
Supported easing functions:
Linear, InQuad, OutQuad, InOutQuad, InCubic, OutCubic,
InOutCubic, InQuart, OutQuart, InOutQuart, InQuint, OutQuint,
InOutQuint, InSine, OutSine, InOutSine, InExpo, OutExpo,
InOutExpo, InCirc, OutCirc, InOutCirc, InElastic, OutElastic,
InOutElastic, InBack, OutBack, InOutBack, InBounce, OutBounce,
InOutBounce.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property.litcoffee#type)

##onTypeChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Easing::onTypeChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Easing</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/Signal-API.md#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/extensions/animation/types/property.litcoffee#ontypechange)

