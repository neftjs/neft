'use strict'

assert = require '../../../assert'
{SignalDispatcher, SignalsEmitter} = require '../../../signal'
log = require '../../../log'
utils = require '../../../util'
Resources = require '../../../resources'

log = log.scope 'Renderer', 'Image'

module.exports = (Renderer, Impl, itemUtils) -> class Image extends Renderer.Item
    @__name__ = 'Image'
    @__path__ = 'Renderer.Image'

    @New = (opts) ->
        item = new Image
        itemUtils.Object.initialize item, opts
        item

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

    @onPixelRatioChange = new SignalDispatcher()

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

    _height: -1
    getter = utils.lookupGetter @::, 'height'
    itemHeightSetter = utils.lookupSetter @::, 'height'
    utils.defineProperty @::, 'height', null, getter, do (_super = itemHeightSetter) -> (val) ->
        @_autoHeight = val is -1
        _super.call @, val
        updateSize.call @
        return

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
                @emit 'onLoadedChange', false
                if err
                    @emit 'onError', err
                else
                    @emit 'onLoad'
                return

            (_super) -> (val) ->
                _super.call @, val
                if @_loaded
                    @_loaded = false
                    @emit 'onLoadedChange', true
                itemUtils.setPropertyValue @, 'sourceWidth', 0
                itemUtils.setPropertyValue @, 'sourceHeight', 0
                itemUtils.setPropertyValue @, 'resolution', 1
                if Resources.testUri(val)
                    if res = Impl.resources?.getResource(val)
                        resolution = Renderer.device.pixelRatio * Image.pixelRatio
                        RESOURCE_REQUEST.resolution = resolution
                        val = res.resolve RESOURCE_REQUEST

                        setSize.call @, res
                    else
                        log.warn "Unknown resource given `#{val}`"
                        val = ''
                if val
                    Impl.setImageSource.call @, val, loadCallback
                else
                    Impl.setImageSource.call @, null, null
                    defaultResult.source = val
                    loadCallback.call @, null, defaultResult
                return

    itemUtils.defineProperty
        constructor: @
        name: 'resolution'
        defaultValue: 1
        setter: (_super) -> ->

    itemUtils.defineProperty
        constructor: @
        name: 'sourceWidth'
        defaultValue: 0
        setter: (_super) -> ->

    itemUtils.defineProperty
        constructor: @
        name: 'sourceHeight'
        defaultValue: 0
        setter: (_super) -> ->

    utils.defineProperty @::, 'loaded', null, ->
        @_loaded
    , null

    SignalsEmitter.createSignal @, 'onLoadedChange'

    SignalsEmitter.createSignal @, 'onLoad'

    SignalsEmitter.createSignal @, 'onError'
