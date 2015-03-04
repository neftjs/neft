'use strict'

utils = require 'utils'

SHEET = "
#hatchery {
	visibility: hidden;
	width: 0;
	height: 0;
}
#hatchery * {
	position: absolute;
}
* {
	margin: 0;
	padding: 0;
	-webkit-tap-highlight-color: rgba(255, 255, 255, 0) !important; 
	-webkit-focus-ring-color: rgba(255, 255, 255, 0) !important; 
	outline: none !important;
}
#styles {
	height: 100%;
	overflow: hidden;
}
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
	overflow: hidden;
}
#body {
	position: absolute;
	z-index: 0;
}
#styles div, #styles span, #styles canvas, #styles img {
	position: absolute;
}
span span {
	position: static;
}
span * {
	display: inline;
	font-weight: inherit;
	font-size: inherit;
	font-family: inherit;
	font-style: inherit;
}
span b, span strong {
	font-weight: bolder;
}
span i, span em {
	font-style: italic;
}
code {
	white-space: pre;
}
img {
	width: 100%;
	height: 100%;
	pointer-events: none;
}
.link {
	position: absolute;
	width: 100%;
	height: 100%;
	z-index: 1;
}
.unselectable,
.unselectable:focus {
	-webkit-touch-callout: none;
	-webkit-user-select: none;
	-khtml-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	outline-style:none;
}
"

isTouch = 'ontouchstart' of window

# body
body = document.createElement 'div'
body.setAttribute 'id', 'styles'
hatchery = document.createElement 'div'
hatchery.setAttribute 'id', 'hatchery'
window.addEventListener 'load', ->
	document.body.appendChild hatchery
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

	impl._hatchery = hatchery

	utils.merge impl.utils, require('./utils')

	unless isTouch
		impl._scrollableUsePointer = false

	window.addEventListener 'resize', resize = ->
		item = impl.window
		return unless item

		item.width = innerWidth
		item.height = innerHeight

	body.addEventListener 'scroll', ->
		window.scrollTo 0, 0

	AbstractTypes: utils.clone impl.Types

	Types:
		Item: require './level0/item'
		Image: require './level0/image'
		Text: require './level0/text'
		FontLoader: require './level0/fontLoader'
		Rectangle: require './level1/rectangle'
		Scrollable: require './level2/scrollable'

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
