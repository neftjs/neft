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

    module.exports = (Renderer, Impl, itemUtils) -> class FontLoader
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

        getFontWeight = (source) ->
            found = -1
            for re, i in WEIGHTS
                if re.test(source)
                    # regex negative lookbehind may not be supported yet, so we are choosing
                    # first occurence for first half, and last occurence for second half
                    found = i
                    if i <= WEIGHTS.length / 2
                        break
            if found >= 0
                return found / (WEIGHTS.length - 1)

            log.warn "Can't find font weight in the got source; `#{source}` got"
            0.4

        isItalic = (source) ->
            /italic|oblique/i.test source

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

        constructor: (@name, @source) ->
            assert.isString @name, "FontLoader.name needs to be a string, but #{@name} given"
            assert.notLengthOf @name, 0, "FontLoader.name cannot be an empty string"

            assert.isString @source, "FontLoader.source needs to be a string, but #{@source} given"
            assert.notLengthOf @source, 0, "FontLoader.source cannot be an empty string"

            Object.freeze @

## *String* FontLoader::name

Use `sans-serif` to make the given font a default one.

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

## FontLoader::load()

        load: (callback) ->
            # get best source
            source = Impl.resources?.resolve(@source) or @source

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
                    log.warn "'#{@source}' sources have different weights"
                if italic isnt (italic = isItalic(source)) and i > 0
                    log.warn "'#{@source}' sources have different 'italic' styles"

            # get internal name
            weightInt = Math.round weight * WEIGHTS.length
            italicStr = if italic then 'italic' else 'normal'
            name = "neft-#{@name}-#{weightInt}-#{italicStr}"
            obj = fontsByName[@name] ?= {}
            obj = obj[italic] ?= new Array WEIGHTS.length
            obj[weightInt] = name

            # load font
            Impl.loadFont name, source, sources, callback
            return
