'use strict'

log = require 'log'

log = log.scope 'Renderer', 'FontLoader'

module.exports = (impl) ->
	loadFont: (name, source, sources) ->
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

		impl.utils.loadingFonts[name] ?= 0
		impl.utils.loadingFonts[name]++

		append = ->
			document.body.appendChild styles

			xhr = new XMLHttpRequest
			xhr.open 'get', sources[0], true
			xhr.onload = ->
				if impl.utils.loadingFonts[name] is 1
					# probably
					requestAnimationFrame ->
						impl.utils.onFontLoaded.emit name
					# maybe
					setTimeout ->
						impl.utils.onFontLoaded.emit name
					, 1000
					# empty string
					setTimeout ->
						impl.utils.loadedFonts[name] = true
						impl.utils.loadingFonts[name] = 0
						impl.utils.onFontLoaded.emit name
					, 2000
				else
					impl.utils.loadingFonts[name]--
			xhr.send()

		if document.readyState isnt 'complete'
			window.addEventListener 'load', append
		else
			append()
