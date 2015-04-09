'use strict'

utils = require 'utils'
PIXI = require './pixi.lib.js'

unless window.isFake
	PI_2 = Math.PI * 2

	PIXI.DisplayObject::displayObjectUpdateTransform = PIXI.DisplayObject::updateTransform = ->
		pt = @parent.worldTransform
		wt = @worldTransform
		data = @_data

		# size
		a = @scale.x
		d = @scale.y

		if data isnt undefined
			# translate to origin
			originX = data.width / a / 2
			originY = data.height / d / 2
			tx = data.x + a * originX
			ty = data.y + d * originY

			# scale
			a *= data.scale
			d *= data.scale

			# rotation
			if @rotation % PI_2
				if @rotation isnt @rotationCache
					@rotationCache = @rotation
					@_sr = Math.sin @rotation
					@_cr = Math.cos @rotation

				# rotate
				ac = a
				dc = d

				a = ac * @_cr
				b = dc * @_sr
				c = ac * -@_sr
				d = dc * @_cr

				# translate to position
				tx += a * -originX + c * -originY
				ty += b * -originX + d * -originY

				# multiply by parent
				wt.a = a * pt.a + b * pt.c
				wt.b = a * pt.b + b * pt.d
				wt.c = c * pt.a + d * pt.c
				wt.d = c * pt.b + d * pt.d
				wt.tx = tx * pt.a + ty * pt.c + pt.tx
				wt.ty = tx * pt.b + ty * pt.d + pt.ty
			else
				# translate to position
				tx += a * -originX
				ty += d * -originY

				# multiply by parent
				wt.a = a * pt.a
				wt.b = a * pt.b
				wt.c = d * pt.c
				wt.d = d * pt.d
				wt.tx = tx * pt.a + ty * pt.c + pt.tx
				wt.ty = tx * pt.b + ty * pt.d + pt.ty

			# calculate alpha
			@worldAlpha = @alpha * @parent.worldAlpha
		else
			# multiply by parent
			wt.a = pt.a * a
			wt.b = pt.b * a
			wt.c = pt.c * d
			wt.d = pt.d * d
			wt.tx = pt.tx
			wt.ty = pt.ty

			# calculate alpha
			@worldAlpha = @parent.worldAlpha

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
	width: 100%;
	height: 100%;
}
"

pixelRatio = window.devicePixelRatio or 1

unless window.isFake
	stage = new PIXI.Stage 0xFFFFFF, true # bgColor, interactive
	renderer = PIXI.autoDetectRecommendedRenderer innerWidth, innerHeight,
		resolution: pixelRatio
		antialias: false

window.addEventListener 'resize', ->
	renderer.resize innerWidth, innerHeight

# body
window.addEventListener 'load', ->
	document.body.appendChild renderer.view

	styles = document.createElement 'style'
	styles.innerHTML = SHEET
	document.body.appendChild styles

module.exports = (impl) ->
	{items} = impl

	impl._dirty = true
	impl._pixiStage = stage
	impl.pixelRatio = pixelRatio

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

		AmbientSound: require '../css/level0/sound/ambient'

	setWindow: (item) ->
		unless window.isFake
			if stage.children.length
				stage.removeChildren()

			resize()
			stage.addChild item._impl.elem
		return