'use strict'

utils = require 'utils'
PIXI = require '../pixi.lib.js'

if window+'' is '[object Window]'
	emptyTexture = PIXI.Texture.fromImage 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAC0lEQVQIW2NkAAIAAAoAAggA9GkAAAAASUVORK5CYII='
	# emptyTexture = PIXI.Texture.fromImage 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVQIW2NkYGD4DwABCQEBtxmN7wAAAABJRU5ErkJggg=='

module.exports = (impl) ->
	cssUtils = require('../../css/utils')
	cssImage = require('../../css/level0/image') impl

	if utils.isEmpty PIXI
		return require('../../base/level0/image') impl

	DATA =
		image: null
		source: ''
		callback: null
		contentElem: null

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		impl.Types.Item.create.call @, data

		data.contentElem = new PIXI.Sprite emptyTexture
		data.elem.addChild data.contentElem
		return

	setImageSource: (val, callback) ->
		val = cssUtils.encodeImageSrc val

		data = @_impl
		data.source = val
		data.callback = ->
			impl._dirty = true
			callback?.apply @, arguments
		data.image = cssImage._getImage val

		cssImage._callCallback.call @



		{contentElem} = @_impl
		{width, height} = contentElem

		if val?
			texture = new PIXI.Texture(PIXI.BaseTexture.fromImage(val, false))
			# texture = PIXI.Texture.fromImage val
			contentElem.setTexture texture
		else
			contentElem.setTexture emptyTexture

		# BUG: size for SVG images is changing
		contentElem.width = width
		contentElem.height = height

		return
