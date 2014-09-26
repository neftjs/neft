'use strict'

PIXI = require '../pixi.lib.js'

if window+'' is '[object Window]'
	emptyTexture = PIXI.Texture.fromImage 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAC0lEQVQIW2NkAAIAAAoAAggA9GkAAAAASUVORK5CYII='

module.exports = (impl) ->
	{items} = impl

	create: (id, target) ->
		elem = target.elem ?= new PIXI.Sprite emptyTexture
		# elem.anchor.x = elem.anchor.y = 0.5
		impl.Types.Item.create id, target
		target.source = ''

	getImageSource: (id) ->
		items[id].source

	setImageSource: (id, val) ->
		item = items[id]
		item.source = val

		{width, height} = item.elem
		texture = PIXI.Texture.fromImage val
		item.elem.setTexture texture

		# BUG: size for SVG images is changing
		item.elem.width = width
		item.elem.height = height