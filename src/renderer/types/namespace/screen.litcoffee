# Screen

    'use strict'

    utils = require 'src/utils'
    signal = require 'src/signal'
    assert = require 'src/assert'

    module.exports = (Renderer, Impl, itemUtils) ->
        class Screen extends signal.Emitter
            constructor: ->
                super()
                @_impl = bindings: null
                @_touch = false
                @_width = 1024
                @_height = 800
                @_orientation = 'Portrait'

                Object.preventExtensions @

## ReadOnly *Boolean* Screen.touch = `false`

```javascript
Text {
    text: Screen.touch ? 'Touch' : 'Mouse'
    font.pixelSize: 30
}
```

            utils.defineProperty @::, 'touch', null, ->
                @_touch
            , null

## ReadOnly *Float* Screen.width = `1024`

            utils.defineProperty @::, 'width', null, ->
                @_width
            , null

## ReadOnly *Float* Screen.height = `800`

            utils.defineProperty @::, 'height', null, ->
                @_height
            , null

## ReadOnly *String* Screen.orientation = `'Portrait'`

May contains: Portrait, Landscape, InvertedPortrait, InvertedLandscape.

## *Signal* Screen.onOrientationChange(*String* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'orientation'
                developmentSetter: (val) ->
                    assert.isString val

        screen = new Screen
        Impl.initScreenNamespace.call screen, ->
            if Impl.windowItem
                Impl.windowItem.width = screen.width
                Impl.windowItem.height = screen.height
            return

        screen
