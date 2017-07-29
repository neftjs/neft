# NumberAnimation

```nml
Rectangle {
    width: 100; height: 100
    color: 'red'
    NumberAnimation {
        running: true
        property: 'x'
        from: 0
        to: 300
        loop: true
        duration: 1700
    }
}
```

    'use strict'

    utils = require 'src/utils'

    module.exports = (Renderer, Impl, itemUtils) -> class NumberAnimation extends Renderer.PropertyAnimation
        @__name__ = 'NumberAnimation'

## *NumberAnimation* NumberAnimation.New([*Object* options])

        @New = (opts) ->
            item = new NumberAnimation
            itemUtils.Object.initialize item, opts
            item

## *NumberAnimation* NumberAnimation::constructor() : *PropertyAnimation*

        constructor: ->
            super()
            @_from = 0
            @_to = 0

## *Float* NumberAnimation::from

## *Float* NumberAnimation::to
