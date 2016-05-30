> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Animation|Renderer-Animation-API]] ▸ **PropertyAnimation**

# PropertyAnimation

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#propertyanimation)

## Nested APIs

* [[NumberAnimation|Renderer-NumberAnimation-API]]

## Table of contents
* [PropertyAnimation](#propertyanimation)
* [**Class** PropertyAnimation](#class-propertyanimation)
  * [property](#property)
  * [*Float* PropertyAnimation::duration = `250`](#float-propertyanimationduration--250)
  * [*Float* PropertyAnimation::startDelay = `0`](#float-propertyanimationstartdelay--0)
  * [*Float* PropertyAnimation::loopDelay = `0`](#float-propertyanimationloopdelay--0)
  * [*Float* PropertyAnimation::delay = `0`](#float-propertyanimationdelay--0)
  * [*Boolean* PropertyAnimation::updateData = `false`](#boolean-propertyanimationupdatedata--false)
  * [*Boolean* PropertyAnimation::updateProperty = `false`](#boolean-propertyanimationupdateproperty--false)
  * [from](#from)
  * [to](#to)
  * [ReadOnly *Float* PropertyAnimation::progress = `0`](#readonly-float-propertyanimationprogress--0)
  * [easing](#easing)
* [**Class** Easing](#class-easing)
  * [*String* Easing::type = `'Linear'`](#string-easingtype--linear)
  * [onTypeChange](#ontypechange)
* [Glossary](#glossary)

#*[Class](/Neft-io/neft/wiki/Renderer-Class-API#class-class)* PropertyAnimation
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; PropertyAnimation : &#x2A;Animation&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Animation-API#class-animation">Animation</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#class-propertyanimation)

##property
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; PropertyAnimation::property</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#property)

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) PropertyAnimation::duration = `250`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) PropertyAnimation::onDurationChange([Float](/Neft-io/neft/wiki/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#float-propertyanimationduration--250-signal-propertyanimationondurationchangefloat-oldvalue)

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) PropertyAnimation::startDelay = `0`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) PropertyAnimation::onStartDelayChange([Float](/Neft-io/neft/wiki/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#float-propertyanimationstartdelay--0-signal-propertyanimationonstartdelaychangefloat-oldvalue)

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) PropertyAnimation::loopDelay = `0`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) PropertyAnimation::onLoopDelayChange([Float](/Neft-io/neft/wiki/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#float-propertyanimationloopdelay--0-signal-propertyanimationonloopdelaychangefloat-oldvalue)

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) PropertyAnimation::delay = `0`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) PropertyAnimation::onDelayChange([Float](/Neft-io/neft/wiki/Utils-API#isfloat) oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#float-propertyanimationdelay--0-signal-propertyanimationondelaychangefloat-oldvalue)

## *Boolean* PropertyAnimation::updateData = `false`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) PropertyAnimation::onUpdateDataChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#boolean-propertyanimationupdatedata--false-signal-propertyanimationonupdatedatachangeboolean-oldvalue)

## *Boolean* PropertyAnimation::updateProperty = `false`

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) PropertyAnimation::onUpdatePropertyChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#boolean-propertyanimationupdateproperty--false-signal-propertyanimationonupdatepropertychangeboolean-oldvalue)

##from
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; PropertyAnimation::from</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><i>Any</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#from)

##to
<dl><dt>Syntax</dt><dd><code>&#x2A;Any&#x2A; PropertyAnimation::to</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><i>Any</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#to)

## ReadOnly [Float](/Neft-io/neft/wiki/Utils-API#isfloat) PropertyAnimation::progress = `0`

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#readonly-float-propertyanimationprogress--0)

##easing
<dl><dt>Syntax</dt><dd><code>&#x2A;Easing&#x2A; PropertyAnimation::easing</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-propertyanimation">PropertyAnimation</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-PropertyAnimation-API#class-easing">Easing</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#easing)

# *[Class](/Neft-io/neft/wiki/Renderer-Class-API#class-class)* Easing

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#class-easing)

## *String* Easing::type = `'Linear'`

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
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation/types/property.litcoffee#ontypechange)

# Glossary

- [PropertyAnimation](#class-propertyanimation)
- [Easing](#class-easing)

