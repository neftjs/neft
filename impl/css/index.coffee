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
"

# body
body = document.createElement 'div'
body.id = 'body'
window.addEventListener 'load', ->
	document.body.appendChild body

	styles = document.createElement 'style'
	styles.innerHTML = SHEET
	document.body.appendChild styles

module.exports = (impl) ->
	{items} = impl

	Types:
		Item: require './level0/item'
		Image: require './level0/image'

	setWindow: (id) ->
		if document.readyState isnt 'complete'
			document.onreadystatechange = =>
				@setWindow id
		else
			while child = body.firstChild
				body.removeChild child

			body.appendChild items[id].elem