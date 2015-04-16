'use strict'

utils = require 'utils'
PIXI = require '../pixi.lib.js'

module.exports = (impl) ->
	cssUtils = require('../../css/utils')
	cssImage = require('../../css/level0/image') impl

	if utils.isEmpty PIXI
		return require('../../base/level0/image') impl

	{emptyTexture} = PIXI.Texture

	updateSize = ->
		data = @_impl
		if data.isTiling and data.image
			{tileScale} = data.contentElem
			tileScale.x = (data.width / data.image.width) * (data.sourceWidth / data.image.width)
			tileScale.y = (data.height / data.image.height) * (data.sourceHeight / data.image.height)
		return

	replaceContentElem = (type) ->
		data = @_impl
		data.isTiling = type is 'TilingSprite'
		data.elem.removeChild data.contentElem
		data.contentElem = new PIXI[type] data.contentElem.texture
		data.elem.addChild data.contentElem
		return

	DATA =
		isTiling: false
		image: null
		source: ''
		callback: null
		contentElem: null
		sourceWidth: 0
		sourceHeight: 0

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		impl.Types.Item.create.call @, data

		data.contentElem = new PIXI.Sprite emptyTexture
		data.elem.addChild data.contentElem
		@onWidthChanged updateSize
		@onHeightChanged updateSize
		return

	setImageSource: (val, callback) ->
		val = cssUtils.encodeImageSrc val

		self = @
		data = @_impl
		{contentElem} = data

		data.source = val
		data.callback = ->
			impl._dirty = true

			oldTexture = contentElem.texture
			contentElem.setTexture emptyTexture

			if val?
				unless data.image.texture
					img = data.image.elem

					# svg alpha bug
					if ///^data:image\/svg+|\.svg$///.test(val)
						canv = document.createElement 'canvas'
						ctx = canv.getContext '2d'
						canv.width = img.width
						canv.height = img.height
						ctx.drawImage img, 0, 0
						img = canv

					data.image.texture = new PIXI.Texture(new PIXI.BaseTexture(img))
				contentElem.setTexture data.image.texture
				impl._dirty = true

				contentElem.width = data.width
				contentElem.height = data.height
				updateSize.call @
			callback?.apply @, arguments

		data.image = cssImage._getImage val
		cssImage._callCallback.call @

		unless /^data:/.test(val)
			data.image.elem.crossOrigin = ''

		return

	setImageSourceWidth: (val) ->
		@_impl.sourceWidth = val
		if @_impl.width isnt val
			updateSize.call @
		return

	setImageSourceHeight: (val) ->
		@_impl.sourceHeight = val
		if @_impl.height isnt val
			updateSize.call @
		return

	setImageFillMode: (val) ->
		data = @_impl
		if val is 'Tile'
			replaceContentElem.call @, 'TilingSprite'
		else if data.isTiling
			replaceContentElem.call @, 'Sprite'
		return

	setImageOffsetX: (val) ->
		unless @_impl.isTiling
			replaceContentElem.call @, 'TilingSprite'
		@_impl.contentElem.tilePosition.x = val
		return

	setImageOffsetY: (val) ->
		unless @_impl.isTiling
			replaceContentElem.call @, 'TilingSprite'
		@_impl.contentElem.tilePosition.y = val
		return
