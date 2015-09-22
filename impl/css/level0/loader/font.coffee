'use strict'

log = require 'log'
signal = require 'signal'

log = log.scope 'Renderer', 'FontLoader'

module.exports = (impl) ->
	signal.create impl.utils, 'onFontLoaded'
	impl.utils.loadingFonts = Object.create null
	impl.utils.loadedFonts = Object.create null

	WEIGHTS = [
		///hairline///i,
		///thin///i,
		///ultra.*light///i,
		///extra.*light///i,
		///light///i,
		///book///i,
		///normal|regular|roman|plain///i,
		///medium///i,
		///demi.*bold|semi.*bold///i,
		///bold///i,
		///extra.*bold|extra///i,
		///heavy///i,
		///black///i,
		///extra.*black///i,
		///ultra.*black|ultra///i
	]

	getFontWeight = (source) ->
		for re, i in WEIGHTS
			if re.test source
				return impl.utils.getFontWeight i/(WEIGHTS.length-1)

		log.warn "Can't find font weight in the got source; `#{source}` got."
		400

	isItalic = (source) ->
		///italic///i.test source

	loadFont: (source, name) ->
		if rsc = impl.Renderer.resources?.getResource(source)
			sources = []
			for _, path of rsc.paths
				sources.push path[1]
		else
			sources = [source]

		style = if isItalic(sources[0]) then 'italic' else 'normal'
		weight = getFontWeight(sources[0])
		cssName = impl.utils.DEFAULT_FONTS[name] or name

		urlStr = ''
		for source in sources
			urlStr += "url('#{source}'), "
		urlStr = urlStr.slice 0, -2

		styles = document.createElement 'style'
		styles.innerHTML = """
			@font-face {
				font-family: "#{cssName}";
				src: #{urlStr};
				font-style: #{style};
				font-weight: #{weight};
			}
		"""

		impl.utils.loadingFonts[name] ?= 0
		impl.utils.loadingFonts[name]++

		append = ->
			document.body.appendChild styles

			fontLoader = new impl.utils.FontLoader [cssName],
				fontLoaded: ->
					impl.utils.loadingFonts[name]--
					impl.utils.loadedFonts[name] = true
					impl.utils.onFontLoaded.emit name
			fontLoader.loadFonts()

		if document.readyState isnt 'complete'
			window.addEventListener 'load', append
		else
			append()
