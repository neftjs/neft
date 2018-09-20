# FontLoader

Class used to load custom fonts.

You can override default fonts (*sans-serif*, *sans* and *monospace*).

The font weight and the style (italic or normal) is extracted from the font source path.

Access it with:
```javascript
FontLoader {}
```

Example:

```javascript
Item {
    Text {
        font.family: 'myFont'
        text: 'Cool font!'
    }
}
FontLoader {
    name: 'myFont'
    source: 'rsc:/static/fonts/myFont'
}
```

    'use strict'

    assert = require '../../../assert'
    utils = require '../../../util'
    log = require '../../../log'
    signal = require '../../../signal'

    log = log.scope 'Renderer', 'FontLoader'

    module.exports = (Renderer, Impl, itemUtils) -> class FontLoader extends itemUtils.FixedObject
        @__name__ = 'FontLoader'
        @__path__ = 'Renderer.FontLoader'

        # loader.name -> italic -> weight[] -> internal name
        fontsByName = Object.create null

        WEIGHTS = [
            /hairline/i,
            /thin/i,
            /ultra.*light/i,
            /extra.*light/i,
            /light/i,
            /book/i,
            /normal|regular|roman|plain/i,
            /medium/i,
            /demi.*bold|semi.*bold/i,
            /bold/i,
            /extra.*bold|extra/i,
            /heavy/i,
            /black/i,
            /extra.*black/i,
            /ultra.*black|ultra/i
        ]

        loadFont = do ->
            getFontWeight = (source) ->
                for re, i in WEIGHTS
                    if re.test(source)
                        return i / (WEIGHTS.length - 1)

                log.warn "Can't find font weight in the got source; `#{source}` got."
                0.4

            isItalic = (source) ->
                /italic|oblique/i.test source

            (loader) ->
                # get best source
                source = Impl.resources?.resolve(loader.source) or loader.source

                # get all sources
                if rsc = Impl.resources?.getResource(source)
                    sources = []
                    for _, path of rsc.paths
                        sources.push path[1]
                else
                    sources = [source]

                # detect weight and style
                weight = 0.4
                italic = false

                for source, i in sources
                    if weight isnt (weight = getFontWeight(source)) and i > 0
                        log.warn "'#{loader.source}' sources have different weights"
                    if italic isnt (italic = isItalic(source)) and i > 0
                        log.warn "'#{loader.source}' sources have different 'italic' styles"

                # get internal name
                weightInt = Math.round weight * WEIGHTS.length
                italicStr = if italic then 'italic' else 'normal'
                name = "neft-#{loader.name}-#{weightInt}-#{italicStr}"
                obj = fontsByName[loader.name] ?= {}
                obj = obj[italic] ?= new Array WEIGHTS.length
                obj[weightInt] = name

                # load font
                Impl.loadFont name, source, sources, (err) ->
                    loader._loaded = true
                    loader.onLoadedChange.emit false
                    if err
                        loader.onError.emit err
                    else
                        loader.onLoad.emit()
                return

        loadFontIfReady = (loader) ->
            if loader.name and loader.source
                setImmediate ->
                    loadFont loader

        @getInternalFontName = (name, weight, italic) ->
            result = ''
            if obj = fontsByName[name]
                unless obj[italic]
                    log.warn "Font '#{name}' italic style is not loaded"
                if obj = (obj[italic] or obj[not italic])
                    weightInt = Math.round weight * WEIGHTS.length
                    unless result = obj[weightInt]
                        # get closest available weight
                        closestLeft = -1
                        for i in [weightInt - 1..0] by -1
                            if obj[i]
                                closestLeft = i
                                break

                        closestRight = -1
                        for i in [weightInt + 1...WEIGHTS.length] by 1
                            if obj[i]
                                closestRight = i
                                break

                        if closestLeft >= 0 and closestRight >= 0
                            if closestRight - weightInt < weightInt - closestLeft
                                closest = closestRight
                            else
                                closest = closestLeft
                        else if closestLeft >= 0
                            closest = closestLeft
                        else if closestRight >= 0
                            closest = closestRight

                        result = obj[closest]

            result

## *FontLoader* FontLoader.New([*Object* options])

        @New = (opts) ->
            item = new FontLoader
            itemUtils.Object.initialize item, opts
            item

        constructor: ->
            super()
            @_name = ''
            @_source = ''
            @_loaded = false

## *String* FontLoader::name

        utils.defineProperty @::, 'name', null, ->
            @_name
        , (val) ->
            assert.isString val, "FontLoader.name needs to be a string, but #{val} given"
            assert.notLengthOf val, 0, "FontLoader.name cannot be an empty string"
            assert.lengthOf @_source, 0

            @_name = val

            loadFontIfReady @

## *String* FontLoader::source

We recommend using **WOFF** format and **TTF/OTF** for the oldest Android browser.

Must contains one of:
 - hairline *(weight=0)*,
 - thin,
 - ultra.*light,
 - extra.*light,
 - light,
 - book,
 - normal|regular|roman|plain,
 - medium,
 - demi.*bold|semi.*bold,
 - bold,
 - extra.*bold|extra,
 - heavy,
 - black,
 - extra.*black,
 - ultra.*black|ultra *(weight=1)*.

Italic font filename must contains 'italic'.

        utils.defineProperty @::, 'source', null, ->
            @_source
        , (val) ->
            assert.isString val, "FontLoader.source needs to be a string, but #{val} given"
            assert.notLengthOf val, 0, "FontLoader.source cannot be an empty string"
            assert.lengthOf @_source, 0

            @_source = val

            loadFontIfReady @
            return

## ReadOnly *Boolean* FontLoader::loaded = `false`

        utils.defineProperty @::, 'loaded', null, ->
            @_loaded
        , null

## *Signal* FontLoader::onLoadedChange(*Boolean* oldValue)

        signal.Emitter.createSignal @, 'onLoadedChange'

## *Signal* FontLoader::onLoad()

        signal.Emitter.createSignal @, 'onLoad'

## *Signal* FontLoader::onError(*Error* error)

        signal.Emitter.createSignal @, 'onError'
