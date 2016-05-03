Rectangle @class
================

```nml
`Rectangle {
`   width: 150
`   height: 100
`   color: 'blue'
`   border.color: 'black'
`   border.width: 5
`   radius: 10
`}
```

*Rectangle* Rectangle.New([*Component* component, *Object* options])
--------------------------------------------------------------------

*Rectangle* Rectangle() : *Renderer.Item*
-----------------------------------------

*String* Rectangle::color = 'transparent'
-----------------------------------------

## *Signal* Rectangle::onColorChange(*String* oldValue)

*Float* Rectangle::radius = 0
-----------------------------

## *Signal* Rectangle::onRadiusChange(*Float* oldValue)

*Border* Rectangle::border
--------------------------

## *Signal* Rectangle::onBorderChange(*String* property, *Any* oldValue)

*Float* Rectangle::border.width = 0
-----------------------------------

## *Signal* Rectangle::border.onWidthChange(*Float* oldValue)

*String* Rectangle::border.color = 'transparent'
------------------------------------------------

## *Signal* Rectangle::border.onColorChange(*String* oldValue)

