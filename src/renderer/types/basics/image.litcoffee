# Image

```javascript
Image {
    source: 'http://lorempixel.com/200/140/'
    onLoad: function(error){
        if (error){
            console.error("Can't load this image");
        } else {
            console.log("Image has been loaded");
        }
    }
}
```

    'use strict'

    assert = require 'src/assert'
    signal = require 'src/signal'
    log = require 'src/log'
    utils = require 'src/utils'

    log = log.scope 'Renderer', 'Image'

    module.exports = (Renderer, Impl, itemUtils) -> class Image extends Renderer.Item
        @__name__ = 'Image'
        @__path__ = 'Renderer.Image'

## *Image* Image.New([*Component* component, *Object* options])

        @New = (component, opts) ->
            item = new Image
            itemUtils.Object.initialize item, component, opts
            item

## *Image* Image::constructor() : *Item*

        constructor: ->
            super()
            @_source = ''
            @_loaded = false
            @_resolution = 1
            @_sourceWidth = 0
            @_sourceHeight = 0
            @_autoWidth = true
            @_autoHeight = true
            @_width = -1
            @_height = -1

## *Float* Image.pixelRatio = `1`

## *Signal* Image.onPixelRatioChange(*Float* oldValue)

        signal.create @, 'onPixelRatioChange'

        pixelRatio = 1
        utils.defineProperty @, 'pixelRatio', utils.CONFIGURABLE, ->
            pixelRatio
        , (val) ->
            assert.isFloat val, "Image.pixelRatio needs to be a float, but #{val} given"
            if val is pixelRatio
                return
            oldVal = pixelRatio
            pixelRatio = val
            @onPixelRatioChange.emit oldVal

## *Float* Image::width = `-1`

        updateSize = ->
            if @_autoHeight is @_autoWidth
                return

            if @_autoHeight
                itemHeightSetter.call @, @_width / @sourceWidth * @sourceHeight or 0

            if @_autoWidth
                itemWidthSetter.call @, @_height / @sourceHeight * @sourceWidth or 0
            return

        _width: -1
        getter = utils.lookupGetter @::, 'width'
        itemWidthSetter = utils.lookupSetter @::, 'width'
        utils.defineProperty @::, 'width', null, getter, do (_super = itemWidthSetter) -> (val) ->
            @_autoWidth = val is -1
            _super.call @, val
            updateSize.call @
            return

## *Float* Image::height = `-1`

        _height: -1
        getter = utils.lookupGetter @::, 'height'
        itemHeightSetter = utils.lookupSetter @::, 'height'
        utils.defineProperty @::, 'height', null, getter, do (_super = itemHeightSetter) -> (val) ->
            @_autoHeight = val is -1
            _super.call @, val
            updateSize.call @
            return

## *String* Image::source

The image source URL or data URI.

## *Signal* Image::onSourceChange(*String* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'source'
            defaultValue: ''
            developmentSetter: (val) ->
                assert.isString val, "Image.source needs to be a string, but #{val} given"
            setter: do ->
                RESOURCE_REQUEST =
                    resolution: 1

                defaultResult =
                    source: ''
                    width: 0
                    height: 0

                setSize = (size) ->
                    assert.isFloat size.width
                    assert.isFloat size.height

                    itemUtils.setPropertyValue @, 'sourceWidth', size.width
                    itemUtils.setPropertyValue @, 'sourceHeight', size.height
                    if @_autoWidth
                        itemWidthSetter.call @, size.width
                    if @_autoHeight
                        itemHeightSetter.call @, size.height
                    updateSize.call @
                    return

                loadCallback = (err = null, opts) ->
                    if err
                        log.warn "Can't load '#{@source}' image at #{@toString()}"
                    else
                        assert.isString opts.source
                        if @sourceWidth is 0 or @sourceHeight is 0
                            setSize.call @, opts
                        else
                            itemUtils.setPropertyValue @, 'resolution', opts.width / @sourceWidth

                    @_loaded = true
                    @onLoadedChange.emit false
                    if err
                        @onError.emit err
                    else
                        @onLoad.emit()
                    return

                (_super) -> (val) ->
                    _super.call @, val
                    if @_loaded
                        @_loaded = false
                        @onLoadedChange.emit true
                    itemUtils.setPropertyValue @, 'sourceWidth', 0
                    itemUtils.setPropertyValue @, 'sourceHeight', 0
                    itemUtils.setPropertyValue @, 'resolution', 1
                    if val
                        if res = Renderer.resources?.getResource(val)
                            RESOURCE_REQUEST.resolution = Renderer.Device.pixelRatio * Image.pixelRatio
                            val = res.resolve RESOURCE_REQUEST
                            setSize.call @, res
                        Impl.setImageSource.call @, val, loadCallback
                    else
                        Impl.setImageSource.call @, null, null
                        defaultResult.source = val
                        loadCallback.call @, null, defaultResult
                    return

## ReadOnly *Float* Image::resolution = `1`

        itemUtils.defineProperty
            constructor: @
            name: 'resolution'
            defaultValue: 1
            setter: (_super) -> ->

## ReadOnly *Float* Image::sourceWidth = `0`

## *Signal* Image::onSourceWidthChange(*Float* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'sourceWidth'
            defaultValue: 0
            setter: (_super) -> ->

## ReadOnly *Float* Image::sourceHeight = `0`

## *Signal* Image::onSourceHeightChange(*Float* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'sourceHeight'
            defaultValue: 0
            setter: (_super) -> ->

## ReadOnly *Boolean* Image::loaded = `false`

        utils.defineProperty @::, 'loaded', null, ->
            @_loaded
        , null

## *Signal* Image::onLoadedChange(*Boolean* oldValue)

        signal.Emitter.createSignal @, 'onLoadedChange'

## *Signal* Image::onLoad()

        signal.Emitter.createSignal @, 'onLoad'

## *Signal* Image::onError(*Error* error)

        signal.Emitter.createSignal @, 'onError'
