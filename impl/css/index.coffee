'use strict'

utils = require 'utils'

SHEET = "
body {
	margin: 0;
	overflow: hidden;
}
html, body {
	height: 100%;
}
#body {
	position: absolute;
	z-index: 0;
}
div, span, canvas, img {
	position: absolute;
	z-index: inherit;
	-ms-word-break: break-all;
	word-break: break-all;
	word-break: break-word;
	word-wrap: break-word;
	margin: 0;
}
a {
	text-decoration: inherit;
	color: inherit;
}
"

# body
body = document.createElement 'div'
window.addEventListener 'load', ->
	document.body.appendChild body

	styles = document.createElement 'style'
	styles.innerHTML = SHEET
	document.body.appendChild styles

module.exports = (impl) ->
	{items} = impl

	window.addEventListener 'resize', resize = ->
		item = impl.window
		return unless item

		item.width = innerWidth
		item.height = innerHeight

	Types:
		Item: require './level0/item'
		Image: require './level0/image'
		Text: require './level0/text'
		Rectangle: require './level1/rectangle'

	setWindow: setWindow = (item) ->
		if document.readyState isnt 'complete'
			document.onreadystatechange = =>
				setWindow item
		else
			while child = body.firstChild
				body.removeChild child

			resize()
			body.appendChild item._impl.elem