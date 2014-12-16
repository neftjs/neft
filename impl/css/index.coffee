'use strict'

utils = require 'utils'

SHEET = "
* {
	margin: 0;
	padding: 0;
	-webkit-tap-highlight-color: rgba(255, 255, 255, 0) !important; 
	-webkit-focus-ring-color: rgba(255, 255, 255, 0) !important; 
	outline: none !important;
}
body {
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
}
span {
	-ms-word-break: break-all;
	word-break: break-all;
	word-break: break-word;
	word-wrap: break-word;
}
span * {
	font-weight: inherit;
}
span b, span strong {
	font-weight: bolder;
}
a {
	text-decoration: inherit;
	color: inherit;
}
code {
	white-space: pre;
}
"

isTouch = 'ontouchstart' of window

# body
body = document.createElement 'div'
window.addEventListener 'load', ->
	document.body.appendChild body

	styles = document.createElement 'style'
	styles.innerHTML = SHEET
	document.body.appendChild styles

	if isTouch
		meta = document.createElement 'meta'
		meta.setAttribute 'name', 'viewport'
		meta.setAttribute 'content', 'width=device-width, initial-scale=1'
		document.head.appendChild meta

module.exports = (impl) ->
	{items} = impl

	utils.merge impl.utils, require('./utils')

	window.addEventListener 'resize', resize = ->
		item = impl.window
		return unless item

		item.width = innerWidth
		item.height = innerHeight

	window.addEventListener 'scroll', ->
		window.scrollTo 0, 0

	Types:
		Item: require './level0/item'
		Image: require './level0/image'
		Text: require './level0/text'
		FontLoader: require './level0/fontLoader'
		Rectangle: require './level1/rectangle'

	setWindow: setWindow = (item) ->
		if document.readyState isnt 'complete'
			document.onreadystatechange = =>
				setWindow item
		else
			while child = body.firstChild
				body.removeChild child

			body.appendChild item._impl.elem

			resize()
			requestAnimationFrame resize