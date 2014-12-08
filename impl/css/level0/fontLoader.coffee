'use strict'

module.exports = (impl) ->
	{items} = impl

	loadFont: (source, name) ->
		styles = document.createElement 'style'
		styles.innerHTML = """
			@font-face {
				font-family: '#{name}';
				src: url('#{source}');
			}
		"""

		append = ->
			document.body.appendChild styles

		if document.readyState isnt 'complete'
			window.addEventListener 'load', append
		else
			append()