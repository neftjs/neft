'use strict'

DATA_URI_RE = ///^data:([a-z+/]+),(.*)$///

signal = require 'signal'

module.exports = (impl) ->
	{Item} = impl.Types

	cache = Object.create null

	createImage = (src) ->
		img = document.createElement 'img'
		img.src = src

		img.addEventListener 'error', ->
			obj.status = 'error'
			obj.loaded()

		img.addEventListener 'load', ->
			obj.status = 'ready'
			obj.width = @naturalWidth or @width
			obj.height = @naturalHeight or @height
			obj.loaded()

		obj =
			source: src
			status: 'loading'
			width: 0
			height: 0
			elem: img
		signal.create obj, 'loaded'
		obj

	getImage = (src) ->
		cache[src] ?= createImage(src)

	onImageLoaded = ->
		data = @_impl
		img = data.image
		img.onLoaded.disconnect onImageLoaded, @

		if img.source is data.source
			callCallback.call @
		return

	callCallback = ->
		data = @_impl
		img = data.image
		{callback} = data

		if img.status is 'ready'
			callback?.call @, null, img
		else if img.status is 'error'
			callback?.call @, true
		else
			img.onLoaded onImageLoaded, @
		return

	DATA =
		imgElem: null
		callback: null
		source: ''
		image: null

	DATA: DATA

	createData: impl.utils.createDataCloner Item.DATA, DATA

	create: (data) ->
		self = @
		Item.create.call @, data

		imgElem = data.imgElem = document.createElement 'img'
		data.elem.appendChild imgElem
		return

	setImageSource: (val, callback) ->
		if DATA_URI_RE.test val
			val = val.replace ///\#///g, encodeURIComponent('#')

		data = @_impl
		data.imgElem.src = val
		data.source = val
		data.callback = callback
		data.image = getImage val

		callCallback.call @
		return
