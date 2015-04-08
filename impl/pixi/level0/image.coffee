'use strict'

utils = require 'utils'
PIXI = require '../pixi.lib.js'

module.exports = (impl) ->
	cssUtils = require('../../css/utils')
	cssImage = require('../../css/level0/image') impl

	if utils.isEmpty PIXI
		return require('../../base/level0/image') impl

	emptyTexture = PIXI.Texture.emptyTexture

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

		self = @
		data = @_impl
		{contentElem} = data

		data.source = val
		data.callback = ->
			impl._dirty = true

			if val?
				texture = new PIXI.Texture(new PIXI.BaseTexture(data.image.elem))
				contentElem.setTexture texture
			else
				contentElem.setTexture emptyTexture

			contentElem.width = self.width
			contentElem.height = self.height
			callback?.apply @, arguments
		data.image = cssImage._getImage val

		cssImage._callCallback.call @

		return
