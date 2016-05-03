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

*Transition* Transition.New([*Component* component, *Object* options])
----------------------------------------------------------------------

*Transition* Transition()
-------------------------

*Boolean* Transition::when
--------------------------

## *Signal* Transition::onWhenChange(*Boolean* oldValue)

*Renderer.Item* Transition::target
----------------------------------

## *Signal* Transition::onTargetChange([*Renderer.Item* oldValue])

*Renderer.Animation* Transition::animation
------------------------------------------

## *Signal* Transition::onAnimationChange(*Renderer.Animation* oldValue)

*String* Transition::property
-----------------------------

## *Signal* Transition::onPropertyChange(*String* oldValue)

