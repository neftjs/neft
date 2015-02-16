'use strict'

log = require 'log'

log = log.scope 'Renderer', 'FontLoader'

module.exports = (impl) ->
	{items} = impl

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

	loadFont: (sources, name) ->
		style = if isItalic(sources[0]) then 'italic' else 'normal'
		weight = getFontWeight(sources[0])
		name = impl.DEFAULT_FONTS[name] or name

		urlStr = ''
		for source in sources
			urlStr += "url('#{source}') "

		styles = document.createElement 'style'
		styles.innerHTML = """
			@font-face {
				font-family: "#{name}";
				src: #{urlStr}local(#{name});
				font-style: #{style};
				font-weight: #{weight};
			}
		"""

		append = ->
			document.body.appendChild styles

		if document.readyState isnt 'complete'
			window.addEventListener 'load', append
		else
			append()
