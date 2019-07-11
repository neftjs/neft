'use strict'

assert = require '../../../assert'
utils = require '../../../util'
signal = require '../../../signal'
log = require '../../../log'

log = log.scope 'Renderer', 'Text'

module.exports = (Renderer, Impl, itemUtils) ->
    class Text extends Renderer.Item
        @__name__ = 'Text'

        @SUPPORTED_HTML_TAGS =
            b: true
            strong: true
            em: true
            br: true
            font: true
            i: true
            s: true
            u: true
            a: true

        @New = (opts) ->
            item = new Text
            itemUtils.Object.initialize item, opts

            # set default font family
            if name = Renderer.FontLoader.getInternalFontName('sans-serif', 0.4, false)
                Impl.setTextFontFamily.call item, name

            item

        constructor: ->
            super()
            @_text = ''
            @_color = 'black'
            @_linkColor = 'blue'
            @_lineHeight = 1
            @_contentWidth = 0
            @_contentHeight = 0
            @_font = null
            @_alignment = null
            @_autoWidth = true
            @_autoHeight = true
            @_width = -1
            @_height = -1

        _width: -1
        getter = utils.lookupGetter @::, 'width'
        itemWidthSetter = utils.lookupSetter @::, 'width'
        utils.defineProperty @::, 'width', null, getter, do (_super = itemWidthSetter) -> (val) ->
            oldAutoWidth = @_autoWidth
            if @_autoWidth = val is -1
                _super.call @, @_contentWidth
            else
                _super.call @, val
            if @_autoWidth or @_autoHeight
                Impl.updateTextContentSize.call @
            if oldAutoWidth isnt @_autoWidth
                Impl.setTextWrap.call @, not @_autoWidth
            return

        _height: -1
        getter = utils.lookupGetter @::, 'height'
        itemHeightSetter = utils.lookupSetter @::, 'height'
        utils.defineProperty @::, 'height', null, getter, do (_super = itemHeightSetter) -> (val) ->
            if @_autoHeight = val is -1
                _super.call @, @_contentHeight
                Impl.updateTextContentSize.call @
            else
                _super.call @, val
            return

        itemUtils.defineProperty
            constructor: @
            name: 'text'
            defaultValue: ''
            implementation: Impl.setText
            setter: (_super) -> (val) ->
                _super.call @, val+''

        itemUtils.defineProperty
            constructor: @
            name: 'color'
            defaultValue: 'black'
            implementation: Impl.setTextColor
            implementationValue: do ->
                RESOURCE_REQUEST =
                    property: 'color'
                (val) ->
                    Impl.resources?.resolve(val, RESOURCE_REQUEST) or val
            developmentSetter: (val) ->
                assert.isString val, "Text.color needs to be a string, but #{val} given"

        # DEPRECATED
        itemUtils.defineProperty
            constructor: @
            name: 'linkColor'
            defaultValue: 'blue'
            implementation: Impl.setTextLinkColor
            implementationValue: do ->
                RESOURCE_REQUEST =
                    property: 'color'
                (val) ->
                    Impl.resources?.resolve(val, RESOURCE_REQUEST) or val
            developmentSetter: (val) ->
                assert.isString val

        itemUtils.defineProperty
            constructor: @
            name: 'lineHeight'
            defaultValue: 1
            implementation: Impl.setTextLineHeight
            developmentSetter: (val) ->
                assert.isFloat val, "Text.lineHeight needs to be a float, but #{val} given"

        itemUtils.defineProperty
            constructor: @
            name: 'contentWidth'
            defaultValue: 0
            developmentSetter: (val) ->
                assert.isFloat val
            setter: (_super) -> (val) ->
                _super.call @, val
                if @_autoWidth
                    itemWidthSetter.call @, val
                return

        itemUtils.defineProperty
            constructor: @
            name: 'contentHeight'
            defaultValue: 0
            developmentSetter: (val) ->
                assert.isFloat val
            setter: (_super) -> (val) ->
                _super.call @, val
                if @_autoHeight
                    itemHeightSetter.call @, val
                return

        Renderer.Item.createAlignment Text

        @createFont = require('./text/font') Renderer, Impl, itemUtils
        @createFont Text

    Text
