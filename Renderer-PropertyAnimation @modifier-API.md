PropertyAnimation @modifier
===========================

*PropertyAnimation* PropertyAnimation() : *Renderer.Animation*
--------------------------------------------------------------

*Renderer.Item* PropertyAnimation::target
-----------------------------------------

## *Signal* PropertyAnimation::onTargetChange(*Renderer.Item* oldValue)

*String* PropertyAnimation::property
------------------------------------

## *Signal* PropertyAnimation::onPropertyChange(*String* oldValue)

*Float* PropertyAnimation::duration = 250
-----------------------------------------

## *Signal* PropertyAnimation::onDurationChange(*Float* oldValue)

*Float* PropertyAnimation::startDelay = 0
-----------------------------------------

## *Signal* PropertyAnimation::onStartDelayChange(*Float* oldValue)

*Float* PropertyAnimation::loopDelay = 0
----------------------------------------

## *Signal* PropertyAnimation::onLoopDelayChange(*Float* oldValue)

*Float* PropertyAnimation::delay = 0
------------------------------------

## *Signal* PropertyAnimation::onDelayChange(*Float* oldValue)

*Boolean* PropertyAnimation::updateData = false
-----------------------------------------------

## *Signal* PropertyAnimation::onUpdateDataChange(*Boolean* oldValue)

*Boolean* PropertyAnimation::updateProperty = false
---------------------------------------------------

## *Signal* PropertyAnimation::onUpdatePropertyChange(*Boolean* oldValue)

*Any* PropertyAnimation::from
-----------------------------

## *Signal* PropertyAnimation::onFromChange(*Any* oldValue)

*Any* PropertyAnimation::to
---------------------------

## *Signal* PropertyAnimation::onToChange(*Any* oldValue)

ReadOnly *Float* PropertyAnimation::progress = 0
------------------------------------------------

*Easing* PropertyAnimation::easing
----------------------------------

## *Signal* PropertyAnimation::onEasingChange(*Easing* value)

*Easing* Easing()
-----------------

*String* Easing::type = 'Linear'
--------------------------------

Supported easing functions:
Linear, InQuad, OutQuad, InOutQuad, InCubic, OutCubic,
InOutCubic, InQuart, OutQuart, InOutQuart, InQuint, OutQuint,
InOutQuint, InSine, OutSine, InOutSine, InExpo, OutExpo,
InOutExpo, InCirc, OutCirc, InOutCirc, InElastic, OutElastic,
InOutElastic, InBack, OutBack, InOutBack, InBounce, OutBounce,
InOutBounce.

## *Signal* Easing::onTypeChange(*String* oldValue)

