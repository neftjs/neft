'use strict'

utils = require 'src/utils'

SHEET = "
#hatchery {
    visibility: hidden;
}
#hatchery span {
    display: inline-block;
}
* {
    margin: 0;
    padding: 0;
    -webkit-tap-highlight-color: rgba(255, 255, 255, 0) !important;
    -webkit-focus-ring-color: rgba(255, 255, 255, 0) !important;
    outline: none !important;
}
#styles {
    position: absolute;
    width: 100%;
    height: 100%;
    overflow: hidden;
    top: 0;
    left: 0
}
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    -webkit-overflow-scrolling: touch;
}
#body {
    position: absolute;
    z-index: 0;
}
#styles * {
    position: absolute;
}
#styles span span {
    position: static;
}
span * {
    display: inline;
    font-weight: inherit;
    font-size: inherit;
    font-family: inherit;
    font-style: inherit;
    border: 0;
    background: none;
}
span b, span strong {
    font-weight: bolder;
}
span i, span em {
    font-style: italic;
}
code {
    white-space: pre;
}
img {
    width: 100%;
    height: 100%;
    pointer-events: none;
}
.link {
    position: absolute;
    width: 100%;
    height: 100%;
    z-index: 1;
}
.rect {
    width: 100%;
    height: 100%;
    box-sizing: border-box;
    border: 0 solid transparent;
}
.unselectable,
.unselectable:focus {
    -webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    outline-style:none;
}
.layer {
    -moz-perspective: 1px; /* Firefox */
    -webkit-transform-style: preserve-3d; /* Safari */
    -webkit-perspective: 1px; /* Safari */
    -webkit-backface-visibility: hidden; /* Safari, Chrome */
}
"

isTouch = 'ontouchstart' of window

# body
body = document.createElement 'div'
body.setAttribute 'id', 'styles'
hatchery = document.createElement 'div'
hatchery.setAttribute 'id', 'hatchery'
window.addEventListener 'load', ->
    document.body.appendChild hatchery
    document.body.appendChild body

    styles = document.createElement 'style'
    styles.innerHTML = SHEET
    document.body.appendChild styles

    if isTouch
        meta = document.createElement 'meta'
        meta.setAttribute 'name', 'viewport'
        meta.setAttribute 'content', 'width=device-width, initial-scale=1'
        document.head.appendChild meta

module.exports = (impl) ->
    {items} = impl

    impl._hatchery = hatchery

    utils.merge impl.utils, require('./utils')

    window.addEventListener 'resize', resize = ->
        item = impl.window
        return unless item

        pixelRatio = window.devicePixelRatio or 1

        if pixelRatio % 1 isnt 0
            item.width = innerWidth + 1
            item.height = innerHeight + 1
        else
            item.width = innerWidth
            item.height = innerHeight
        return

    body.addEventListener 'scroll', ->
        window.scrollTo 0, 0
        return

    AbstractTypes: utils.clone impl.Types

    Types:
        Item: require './level0/item'
        Image: require './level0/image'
        Text: require './level0/text'
        TextInput: require './level0/textInput'
        Native: require './level0/native'
        FontLoader: require './level0/loader/font'
        ResourcesLoader: require './level0/loader/resources'
        Device: require './level0/device'
        Screen: require './level0/screen'
        Navigator: require './level0/navigator'
        RotationSensor: require './level0/sensor/rotation'

        Rectangle: require './level1/rectangle'

        Scrollable: require './level2/scrollable'

        AmbientSound: require './level0/sound/ambient'

    setWindow: (item) ->
        onLoaded = ->
            if document.readyState is 'complete'
                while child = body.firstChild
                    body.removeChild child

                body.appendChild item._impl.elem

                resize()
                setTimeout resize
                setTimeout resize, 500
                requestAnimationFrame resize
            return

        if document.readyState is 'complete'
            onLoaded()
        else
            document.addEventListener 'readystatechange', onLoaded

        return
