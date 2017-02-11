# Font

    'use strict'

    assert = require 'src/assert'
    utils = require 'src/utils'
    log = require 'src/log'

    log = log.scope 'Renderer', 'Font'

    module.exports = (Renderer, Impl, itemUtils) -> (ctor) -> class Font extends itemUtils.DeepObject
        @__name__ = 'Font'

        itemUtils.defineProperty
            constructor: ctor
            name: 'font'
            defaultValue: null
            valueConstructor: Font
            developmentSetter: (val) ->
                if val?
                    assert.isObject val
            setter: (_super) -> (val) ->
                _super.call @, val

                if utils.isObject(val)
                    {font} = @
                    font.family = val.family if val.family?
                    font.pixelSize = val.pixelSize if val.pixelSize?
                    font.weight = val.weight if val.weight?
                    font.wordSpacing = val.wordSpacing if val.wordSpacing?
                    font.letterSpacing = val.letterSpacing if val.letterSpacing?
                    font.italic = val.italic if val.italic?
                return

        constructor: (ref) ->
            super ref
            @_family = 'sans-serif'
            @_pixelSize = 14
            @_weight = 0.4
            @_wordSpacing = 0
            @_letterSpacing = 0
            @_italic = false

            Object.preventExtensions @

        setFontFamilyImpl = Impl["set#{ctor.__name__}FontFamily"]
        reloadFontFamily = (font) ->
            name = Renderer.FontLoader.getInternalFontName font._family, font._weight, font._italic
            name ||= 'sans-serif'
            setFontFamilyImpl.call font._ref, name

## *String* Font.family = `'sans-serif'`

## *Signal* Font.onFamilyChange(*String* oldValue)

        `//<development>`
        checkingFamily = {}
        `//</development>`
        itemUtils.defineProperty
            constructor: @
            name: 'family'
            defaultValue: 'sans-serif'
            namespace: 'font'
            parentConstructor: ctor
            developmentSetter: (val) ->
                assert.isString val, "Font.family needs to be a string, but #{val} given"
            setter: (_super) -> (val) ->
                _super.call @, val
                reloadFontFamily @

## *Float* Font.pixelSize = `14`

## *Signal* Font.onPixelSizeChange(*Float* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'pixelSize'
            defaultValue: 14
            namespace: 'font'
            parentConstructor: ctor
            implementation: Impl["set#{ctor.__name__}FontPixelSize"]
            developmentSetter: (val) ->
                assert.isFloat val, "Font.pixelSize needs to be a float, but #{val} given"

## *Float* Font.weight = `0.4`

In range from 0 to 1.

## *Signal* Font.onWeightChange(*Float* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'weight'
            defaultValue: 0.4
            namespace: 'font'
            parentConstructor: ctor
            developmentSetter: (val) ->
                assert.isFloat val, "Font.weight needs to be a float, but #{val} given"
                assert.operator val, '>=', 0, "Font.weight needs to be in range 0-1, #{val} given"
                assert.operator val, '<=', 1, "Font.weight needs to be in range 0-1, #{val} given"
            setter: (_super) -> (val) ->
                _super.call @, val
                reloadFontFamily @

## Hidden *Float* Font.wordSpacing = `0`

## Hidden *Signal* Font.onWordSpacingChange(*Float* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'wordSpacing'
            defaultValue: 0
            namespace: 'font'
            parentConstructor: ctor
            implementation: Impl["set#{ctor.__name__}FontWordSpacing"]
            developmentSetter: (val) ->
                assert.isFloat val, "Font.wordSpacing needs to be a float, but #{val} given"

## Hidden *Float* Font.letterSpacing = `0`

## Hidden *Signal* Font.onLetterSpacingChange(*Float* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'letterSpacing'
            defaultValue: 0
            namespace: 'font'
            parentConstructor: ctor
            implementation: Impl["set#{ctor.__name__}FontLetterSpacing"]
            developmentSetter: (val) ->
                assert.isFloat val, "Font.letterSpacing needs to be a float, but #{val} given"

## *Boolean* Font.italic = `false`

## *Signal* Font.onItalicChange(*Boolean* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'italic'
            defaultValue: false
            namespace: 'font'
            parentConstructor: ctor
            developmentSetter: (val) ->
                assert.isBoolean val, "Font.italic needs to be a boolean, but #{val} given"
            setter: (_super) -> (val) ->
                _super.call @, val
                reloadFontFamily @

        toJSON: ->
            family: @family
            pixelSize: @pixelSize
            weight: @weight
            wordSpacing: @wordSpacing
            letterSpacing: @letterSpacing
            italic: @italic
