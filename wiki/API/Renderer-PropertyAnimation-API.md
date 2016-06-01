> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Animation|Renderer-Animation-API]] ▸ **PropertyAnimation**

# PropertyAnimation

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#propertyanimation)

## Nested APIs

* [[NumberAnimation|Renderer-NumberAnimation-API]]

## Table of contents
* [PropertyAnimation](#propertyanimation)
* [**Class** PropertyAnimation](#class-propertyanimation)
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
* [**Class** Easing](#class-easing)
  * [type](#type)
  * [onTypeChange](#ontypechange)
* [Glossary](#glossary)

#**Class** PropertyAnimation
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; PropertyAnimation : &#x2A;Animation&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Animation-API#class-animation">Animation</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#class-propertyanimation)

##property
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; PropertyAnimation::property</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#property)

##duration
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; PropertyAnimation::duration = `250`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>250</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#duration)

##startDelay
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; PropertyAnimation::startDelay = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#startdelay)

##loopDelay
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; PropertyAnimation::loopDelay = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#loopdelay)

##delay
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; PropertyAnimation::delay = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#delay)

##updateData
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; PropertyAnimation::updateData = `false`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#updatedata)

##updateProperty
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; PropertyAnimation::updateProperty = `false`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#updateproperty)

##from
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; PropertyAnimation::from</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><i>Any</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#from)

##to
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; PropertyAnimation::to</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><i>Any</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#to)

##progress
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; PropertyAnimation::progress = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#progress)

##easing
<dl><dt>Syntax</dt><dd><code>&#x2A;Easing&#x2A; PropertyAnimation::easing</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-easing">Easing</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#easing)

# **Class** Easing

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#class-easing)

##type
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Easing::type = `'Linear'`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-easing">Easing</a></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'Linear'</code></dd></dl>
Supported easing functions:
Linear, InQuad, OutQuad, InOutQuad, InCubic, OutCubic,
InOutCubic, InQuart, OutQuart, InOutQuart, InQuint, OutQuint,
InOutQuint, InSine, OutSine, InOutSine, InExpo, OutExpo,
InOutExpo, InCirc, OutCirc, InOutCirc, InElastic, OutElastic,
InOutElastic, InBack, OutBack, InOutBack, InBounce, OutBounce,
InOutBounce.

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#type)

##onTypeChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Easing::onTypeChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-easing">Easing</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#ontypechange)

# Glossary

- [PropertyAnimation](#class-propertyanimation)
- [Easing](#class-easing)

