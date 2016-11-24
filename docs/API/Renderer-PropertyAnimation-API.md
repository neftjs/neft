> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Animation|Renderer-Animation-API]] ▸ **PropertyAnimation**

# PropertyAnimation

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee)

## Nested APIs

* [[NumberAnimation|Renderer-NumberAnimation-API]]

## Table of contents
* [PropertyAnimation](#propertyanimation)
* [**Class** PropertyAnimation](#class-propertyanimation)
  * [property](#property)
  * [onPropertyChange](#onpropertychange)
  * [duration](#duration)
  * [onDurationChange](#ondurationchange)
  * [startDelay](#startdelay)
  * [onStartDelayChange](#onstartdelaychange)
  * [loopDelay](#loopdelay)
  * [onLoopDelayChange](#onloopdelaychange)
  * [delay](#delay)
  * [onDelayChange](#ondelaychange)
  * [updateData](#updatedata)
  * [onUpdateDataChange](#onupdatedatachange)
  * [updateProperty](#updateproperty)
  * [onUpdatePropertyChange](#onupdatepropertychange)
  * [from](#from)
  * [onFromChange](#onfromchange)
  * [to](#to)
  * [onToChange](#ontochange)
  * [progress](#progress)
  * [easing](#easing)
  * [onEasingChange](#oneasingchange)
* [**Class** Easing](#class-easing)
  * [type](#type)
  * [onTypeChange](#ontypechange)
* [Glossary](#glossary)

#**Class** PropertyAnimation
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; PropertyAnimation : &#x2A;Animation&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Animation-API#class-animation">Animation</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#class-propertyanimation--animation)

##property
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; PropertyAnimation::property</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><i>String</i></dd></dl>
##onPropertyChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; PropertyAnimation::onPropertyChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#signal-propertyanimationonpropertychangestring-oldvalue)

##duration
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; PropertyAnimation::duration = `250`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>250</code></dd></dl>
##onDurationChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; PropertyAnimation::onDurationChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#signal-propertyanimationondurationchangefloat-oldvalue)

##startDelay
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; PropertyAnimation::startDelay = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##onStartDelayChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; PropertyAnimation::onStartDelayChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#signal-propertyanimationonstartdelaychangefloat-oldvalue)

##loopDelay
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; PropertyAnimation::loopDelay = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##onLoopDelayChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; PropertyAnimation::onLoopDelayChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#signal-propertyanimationonloopdelaychangefloat-oldvalue)

##delay
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; PropertyAnimation::delay = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##onDelayChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; PropertyAnimation::onDelayChange(&#x2A;Float&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#signal-propertyanimationondelaychangefloat-oldvalue)

##updateData
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; PropertyAnimation::updateData = `false`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
##onUpdateDataChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; PropertyAnimation::onUpdateDataChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#signal-propertyanimationonupdatedatachangeboolean-oldvalue)

##updateProperty
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; PropertyAnimation::updateProperty = `false`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
##onUpdatePropertyChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; PropertyAnimation::onUpdatePropertyChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#signal-propertyanimationonupdatepropertychangeboolean-oldvalue)

##from
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; PropertyAnimation::from</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><i>Any</i></dd></dl>
##onFromChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; PropertyAnimation::onFromChange(&#x2A;Any&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Any</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#signal-propertyanimationonfromchangeany-oldvalue)

##to
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; PropertyAnimation::to</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><i>Any</i></dd></dl>
##onToChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; PropertyAnimation::onToChange(&#x2A;Any&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Any</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#signal-propertyanimationontochangeany-oldvalue)

##progress
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Float&#x2A; PropertyAnimation::progress = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#readonly-float-propertyanimationprogress--0)

##easing
<dl><dt>Syntax</dt><dd><code>&#x2A;Easing&#x2A; PropertyAnimation::easing</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-easing">Easing</a></dd></dl>
##onEasingChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; PropertyAnimation::onEasingChange(&#x2A;Easing&#x2A; value)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Parameters</dt><dd><ul><li>value — <a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-easing">Easing</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#signal-propertyanimationoneasingchangeeasing-value)

# **Class** Easing

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee)

##type
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Easing::type = `'Linear'`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-easing">Easing</a></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>'Linear'</code></dd></dl>
Supported easing functions:
Linear, InQuad, OutQuad, InOutQuad, InCubic, OutCubic,
InOutCubic, InQuart, OutQuart, InOutQuart, InQuint, OutQuint,
InOutQuint, InSine, OutSine, InOutSine, InExpo, OutExpo,
InOutExpo, InCirc, OutCirc, InOutCirc, InElastic, OutElastic,
InOutElastic, InBack, OutBack, InOutBack, InBounce, OutBounce,
InOutBounce.

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#string-easingtype--linear)

##onTypeChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Easing::onTypeChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-easing">Easing</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#signal-easingontypechangestring-oldvalue)

# Glossary

- [PropertyAnimation](#class-propertyanimation)
- [Easing](#class-easing)

