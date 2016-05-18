> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **PropertyAnimation @modifier**

PropertyAnimation @modifier
===========================

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#propertyanimation-modifier)

## Table of contents
  * [PropertyAnimation() : *Renderer.Animation*](#propertyanimation-propertyanimation--rendereranimation)
  * [*Renderer.Item* target](#rendereritem-propertyanimationtarget)
  * [property](#string-propertyanimationproperty)
  * [duration = 250](#float-propertyanimationduration--250)
  * [startDelay = 0](#float-propertyanimationstartdelay--0)
  * [loopDelay = 0](#float-propertyanimationloopdelay--0)
  * [delay = 0](#float-propertyanimationdelay--0)
  * [updateData = false](#boolean-propertyanimationupdatedata--false)
  * [updateProperty = false](#boolean-propertyanimationupdateproperty--false)
  * [from](#any-propertyanimationfrom)
  * [to](#any-propertyanimationto)
  * [progress = 0](#readonly-float-propertyanimationprogress--0)
  * [easing](#easing-propertyanimationeasing)
  * [Easing()](#easing-easing)
  * [type = 'Linear'](#string-easingtype--linear)
  * [onTypeChange(oldValue)](#signal-easingontypechangestring-oldvalue)

*PropertyAnimation* PropertyAnimation() : *Renderer.Animation*
--------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#propertyanimation-propertyanimation--rendereranimation)

*Renderer.Item* PropertyAnimation::target
-----------------------------------------
## *Signal* PropertyAnimation::onTargetChange(*Renderer.Item* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#rendereritem-propertyanimationtarget-signal-propertyanimationontargetchangerendereritem-oldvalue)

*String* PropertyAnimation::property
------------------------------------
## *Signal* PropertyAnimation::onPropertyChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#string-propertyanimationproperty-signal-propertyanimationonpropertychangestring-oldvalue)

*Float* PropertyAnimation::duration = 250
-----------------------------------------
## *Signal* PropertyAnimation::onDurationChange(*Float* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#float-propertyanimationduration--250-signal-propertyanimationondurationchangefloat-oldvalue)

*Float* PropertyAnimation::startDelay = 0
-----------------------------------------
## *Signal* PropertyAnimation::onStartDelayChange(*Float* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#float-propertyanimationstartdelay--0-signal-propertyanimationonstartdelaychangefloat-oldvalue)

*Float* PropertyAnimation::loopDelay = 0
----------------------------------------
## *Signal* PropertyAnimation::onLoopDelayChange(*Float* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#float-propertyanimationloopdelay--0-signal-propertyanimationonloopdelaychangefloat-oldvalue)

*Float* PropertyAnimation::delay = 0
------------------------------------
## *Signal* PropertyAnimation::onDelayChange(*Float* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#float-propertyanimationdelay--0-signal-propertyanimationondelaychangefloat-oldvalue)

*Boolean* PropertyAnimation::updateData = false
-----------------------------------------------
## *Signal* PropertyAnimation::onUpdateDataChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#boolean-propertyanimationupdatedata--false-signal-propertyanimationonupdatedatachangeboolean-oldvalue)

*Boolean* PropertyAnimation::updateProperty = false
---------------------------------------------------
## *Signal* PropertyAnimation::onUpdatePropertyChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#boolean-propertyanimationupdateproperty--false-signal-propertyanimationonupdatepropertychangeboolean-oldvalue)

*Any* PropertyAnimation::from
-----------------------------
## *Signal* PropertyAnimation::onFromChange(*Any* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#any-propertyanimationfrom-signal-propertyanimationonfromchangeany-oldvalue)

*Any* PropertyAnimation::to
---------------------------
## *Signal* PropertyAnimation::onToChange(*Any* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#any-propertyanimationto-signal-propertyanimationontochangeany-oldvalue)

ReadOnly *Float* PropertyAnimation::progress = 0
------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#readonly-float-propertyanimationprogress--0)

*Easing* PropertyAnimation::easing
----------------------------------
## *Signal* PropertyAnimation::onEasingChange(*Easing* value)

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

## *Signal* Easing::onTypeChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/extensions/animation/types/property.litcoffee#signal-easingontypechangestring-oldvalue)

