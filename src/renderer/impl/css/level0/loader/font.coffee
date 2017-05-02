'use strict'

log = require 'src/log'

log = log.scope 'Renderer', 'FontLoader'

SAMPLE_TEXT = 'ABC¬Ō∑ę†ī¨^óĻ„‚ąś∂ń©ķ∆Żł…ĺ«żźć√ļńĶ≤≥÷Ń™€ßį§¶•Ľľ–≠ŕŘ‹›řŖŗ°Š‚—Īő'

module.exports = (impl) ->
    implUtils = impl.utils

    detectLoad = (name) ->
        elem1 = document.createElement 'span'
        elem1.textContent = SAMPLE_TEXT
        elem1.style.fontFamily = "sans-serif"
        impl._hatchery.appendChild elem1

        elem2 = document.createElement 'span'
        elem2.textContent = SAMPLE_TEXT
        elem2.style.fontFamily = "#{name}, sans-serif"
        impl._hatchery.appendChild elem2

        sync = ->
            if elem1.offsetWidth isnt elem2.offsetWidth or implUtils.loadedFonts[name]
                impl._hatchery.removeChild elem1
                impl._hatchery.removeChild elem2
                markAsLoaded name
            else
                requestAnimationFrame sync

        requestAnimationFrame sync

    emitLoadedSignal = (name) ->
        unless implUtils.loadedFonts[name]
            implUtils.onFontLoaded.emit name

    markAsLoaded = (name) ->
        unless implUtils.loadedFonts[name]
            implUtils.loadedFonts[name] = true
            implUtils.loadingFonts[name] = 0
            implUtils.onFontLoaded.emit name
        return

    loadFont: (name, source, sources, callback) ->
        urlStr = ''
        for source in sources
            urlStr += "url('#{source}'), "
        urlStr = urlStr.slice 0, -2

        styles = document.createElement 'style'
        styles.innerHTML = """
            @font-face {
                font-family: "#{name}";
                src: #{urlStr};
                font-style: normal;
                font-weight: 400;
            }
        """

        implUtils.loadingFonts[name] ?= 0
        implUtils.loadingFonts[name]++

        append = ->
            document.body.appendChild styles
            detectLoad name

            xhr = new XMLHttpRequest
            xhr.open 'get', sources[0], true
            xhr.onerror = ->
                callback new Error "Cannot load font #{sources[0]}"
            xhr.onload = ->
                callback()
                if implUtils.loadingFonts[name] is 1
                    emitFontLoadedSignal = ->
                        emitLoadedSignal name
                    setTimeout emitFontLoadedSignal, 50
                    # probably
                    setTimeout emitFontLoadedSignal, 500
                    # maybe
                    setTimeout emitFontLoadedSignal, 1000
                    # empty string
                    setTimeout ->
                        markAsLoaded name
                    , 2000
                else
                    implUtils.loadingFonts[name]--
            xhr.send()

        if document.readyState isnt 'complete'
            window.addEventListener 'load', append
        else
            append()
