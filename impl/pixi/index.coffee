'use strict'

utils = require 'utils'
PIXI = require './pixi.lib.js'

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

unless window.isFake
	SuperDisplayObject = PIXI.DisplayObject
	PIXI.DisplayObject = ->
		SuperDisplayObject.call @
		@matrix = new Matrix2d
	utils.merge PIXI.DisplayObject, SuperDisplayObject

	PIXI.DisplayObject:: = SuperDisplayObject::

	PIXI.DisplayObject.prototype.updateTransform = ->
		{matrix} = @

		# if @rotation isnt @rotationCache
		# 	@rotationCache = @rotation
		# 	@_sr = Math.sin @rotation
		# 	@_cr = Math.cos @rotation

		matrix.identity()

		# multiply by parent
		matrix.multiply @parent.matrix

		# translate
		matrix.translate @position.x, @position.y

		# size
		matrix.scale @scale.x, @scale.y

		# translate to origin
		width = @width / @scale.x
		height = @height / @scale.y
		matrix.translate width/2, height/2

		# scale
		matrix.scale @sizeScale, @sizeScale

		# rotate
		matrix.rotate @rotation

		# translate to position
		matrix.translate -width/2, -height/2

		# set matrix to pixijs format
		worldTransform = @worldTransform

		worldTransform.a = matrix.arr[0]
		worldTransform.b = matrix.arr[1]

		worldTransform.c = matrix.arr[2]
		worldTransform.d = matrix.arr[3]

		worldTransform.tx = matrix.arr[4]
		worldTransform.ty = matrix.arr[5]

		# calculate alpha
		@worldAlpha = @alpha * @parent.worldAlpha


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

unless window.isFake
	stage = new PIXI.Stage 0xFFFFFF, true # bgColor, interactive
	renderer = PIXI.autoDetectRenderer innerWidth, innerHeight, null, false, true

	# tex = PIXI.Texture.fromImage 'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="510.15494480606117 680.999968662737 66.84503476481814 81.30406151133161" width="66.84503476481814" height="81.30406151133161" ><g><path fill="#0DFF7E" d="M556.727,729.177l5.682-3.28v-34.024L543.576,681l-18.828,10.873v34.024l5.68,3.28l-20.273,11.706v21.421H577v-21.421L556.727,729.177z M528.748,696.65l12.654,7.306l4.025-2.294l-14.818-8.555l4.721-2.726l14.848,8.574l4.025-2.294l-14.873-8.589l4.246-2.452l14.832,8.563v29.405l-14.832,8.562l-14.828-8.562V696.65z M573,758.304h-10.234v-8.049h-4v8.049h-30.375v-8.049h-4v8.049h-10.236v-15.111l20.273-11.706l9.148,5.282l9.148-5.282L573,743.192V758.304z"></path><path fill="#0DFF7E" d="M553.881,717.505l-3.09-2.54c-0.988,1.203-4.215,4.326-7.215,4.326c-2.973,0-6.215-3.125-7.211-4.327l-3.09,2.541c0.195,0.236,4.822,5.786,10.301,5.786C549.061,723.292,553.688,717.742,553.881,717.505z"></path></g></svg>'
	# emptyTexture = PIXI.Texture.fromImage 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVQIW2NkYGD4DwABCQEBtxmN7wAAAABJRU5ErkJggg=='
	# elem = new PIXI.Sprite emptyTexture
	# elem.setTexture tex
	# stage.addChild elem

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

module.exports = (impl) ->
	{items} = impl

	impl._dirty = true
	impl._hatchery = hatchery

	# render loop
	window.addEventListener 'load', ->
		vsync = ->
			if impl._dirty
				impl._dirty = false
				renderer.render stage
			requestAnimationFrame vsync

		requestAnimationFrame vsync

	window.addEventListener 'resize', resize = ->
		item = impl.window
		return unless item

		item.width = innerWidth
		item.height = innerHeight

	Types:
		Item: require './level0/item'
		Image: require './level0/image'
		Text: require './level0/text'

	setWindow: (item) ->
		unless window.isFake
			if stage.children.length
				stage.removeChildren()

			resize()
			stage.addChild item._impl.elem