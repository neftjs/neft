'use strict'

utils = require 'utils'
window.PIXI = PIXI = require './pixi.lib.js'



# thanks to: https://github.com/toji/gl-matrix/blob/master/src/gl-matrix/mat2d.js
class Matrix2d

	constructor: ->
		@arr = new (Float64Array or Array)(6)
		@identity()

	arr: null

	identity: ->
		{arr} = @
		arr[0] = 1
		arr[1] = 0
		arr[2] = 0
		arr[3] = 1
		arr[4] = 0
		arr[5] = 0
		@

	rotate: (rad) ->
		{arr} = @
		[a0, a1, a2, a3] = arr
		s = Math.sin rad
		c = Math.cos rad

		arr[0] = a0 *  c + a2 * s;
		arr[1] = a1 *  c + a3 * s;
		arr[2] = a0 * -s + a2 * c;
		arr[3] = a1 * -s + a3 * c;
		@

	scale: (v0, v1) ->
		{arr} = @
		arr[0] *= v0;
		arr[1] *= v0;
		arr[2] *= v1;
		arr[3] *= v1;
		@

	translate: (v0, v1) ->
		{arr} = @
		arr[4] += arr[0] * v0 + arr[2] * v1;
		arr[5] += arr[1] * v0 + arr[3] * v1;
		@

	multiply: (b) ->
		{arr} = @
		bArr = b.arr
		[a0, a1, a2, a3, a4, a5] = arr
		[b0, b1, b2, b3, b4, b5] = bArr

		arr[0] = a0 * b0 + a2 * b1
		arr[1] = a1 * b0 + a3 * b1
		arr[2] = a0 * b2 + a2 * b3
		arr[3] = a1 * b2 + a3 * b3
		arr[4] = a0 * b4 + a2 * b5 + a4
		arr[5] = a1 * b4 + a3 * b5 + a5
		@

if window+'' is '[object Window]'
	SuperDisplayObject = PIXI.DisplayObject
	PIXI.DisplayObject = ->
		SuperDisplayObject.call @
		@matrix = new Matrix2d
	utils.merge PIXI.DisplayObject, SuperDisplayObject

	PIXI.DisplayObject:: = SuperDisplayObject::

	PIXI.DisplayObject.prototype.updateTransform = ->
		{matrix} = @
		matrix.identity()

		# multiply by parent
		matrix.multiply this.parent.matrix

		# translate
		matrix.translate this.position.x, this.position.y

		# size
		matrix.scale this.scale.x, this.scale.y

		# translate to origin
		width = this.width * this.scale.x
		height = this.height * this.scale.y
		matrix.translate width/2, height/2

		# scale
		matrix.scale this.sizeScale, this.sizeScale

		# rotate
		matrix.rotate this.rotation

		# translate to position
		matrix.translate -width/2, -height/2

		# set matrix to pixijs format
		worldTransform = this.worldTransform

		worldTransform.a = matrix.arr[0]
		worldTransform.b = matrix.arr[2] # LOL

		worldTransform.c = matrix.arr[1]
		worldTransform.d = matrix.arr[3]

		worldTransform.tx = matrix.arr[4]
		worldTransform.ty = matrix.arr[5]

		# calculate alpha
		this.worldAlpha = this.alpha * this.parent.worldAlpha


SHEET = "
body {
	margin: 0;
	overflow: hidden;
}
html, body {
	height: 100%;
}
canvas {
	position: absolute;
	left: 0;
	top: 0;
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
	stage = new PIXI.Stage 0xFFFFFF, true # bgColor, interactive
	renderer = PIXI.autoDetectRenderer innerWidth, innerHeight, null, false, true

window.addEventListener 'resize', ->
	renderer.resize innerWidth, innerHeight

# body
hatchery = document.createElement 'div'
hatchery.style.visibility = 'hidden'
window.addEventListener 'load', ->
	document.body.appendChild hatchery
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

	impl._hatchery = hatchery

	Types:
		Item: require './level0/item'
		Image: require './level0/image'
		Text: require './level0/text'

	setWindow: (id) ->
		if stage.children.length
			stage.removeChildren()

		stage.addChild items[id].elem