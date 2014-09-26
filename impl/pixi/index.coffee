'use strict'

utils = require 'utils'
PIXI = require './pixi.lib.js'

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

if window+'' is '[object Window]'
	stage = new PIXI.Stage 0xFFFFFF
	renderer = PIXI.autoDetectRenderer innerWidth, innerHeight, null, false, true

window.addEventListener 'resize', ->
	renderer.resize innerWidth, innerHeight

# body
window.addEventListener 'load', ->
	document.body.appendChild renderer.view

	styles = document.createElement 'style'
	styles.innerHTML = SHEET
	document.body.appendChild styles

	vsync = ->
		renderer.render stage
		requestAnimationFrame vsync

	requestAnimationFrame vsync

module.exports = (impl) ->
	{items} = impl

	Types:
		Item: require './level0/item'
		Image: require './level0/image'

	setWindow: (id) ->
		if stage.children.length
			stage.removeChildren()

		stage.addChild items[id].elem