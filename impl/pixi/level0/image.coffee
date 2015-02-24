'use strict'

utils = require 'utils'
PIXI = require '../pixi.lib.js'

if window+'' is '[object Window]'
	emptyTexture = PIXI.Texture.fromImage 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAC0lEQVQIW2NkAAIAAAoAAggA9GkAAAAASUVORK5CYII='
	# emptyTexture = PIXI.Texture.fromImage 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVQIW2NkYGD4DwABCQEBtxmN7wAAAABJRU5ErkJggg=='

module.exports = (impl) ->
	{Item} = impl.Types
	{items} = impl

	if utils.isEmpty PIXI
		return require('../../base/level0/image') impl

	DATA =
		image: null
		callback: null
		contentElem: null

	DATA: DATA

	createData: impl.utils.createDataCloner Item.DATA, DATA

	create: (data) ->
		self = @
		Item.create.call @, data

		image = data.image = document.createElement 'img'
		data.contentElem = new PIXI.Sprite emptyTexture
		data.elem.addChild data.contentElem

		image.addEventListener 'error', (err) ->
			data.callback?.call self, true

		image.addEventListener 'load', ->
			if self._width is 0 and self._height is 0
				data.callback?.call self, null,
					width: @naturalWidth or @width
					height: @naturalHeight or @height
			else
				data.callback?.call self, null
			impl._dirty = true
		return

	setImageSource: (val, callback) ->
		{contentElem} = @_impl
		{width, height} = contentElem

		@_impl.image.src = val
		@_impl.callback = callback

		texture = new PIXI.Texture(PIXI.BaseTexture.fromImage(val, false))

		# texture = PIXI.Texture.fromImage val
		contentElem.setTexture texture

		# BUG: size for SVG images is changing
		contentElem.width = width
		contentElem.height = height
