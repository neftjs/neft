'use strict'

DATA_URI_RE = ///^data:([a-z+/]+),(.*)$///

module.exports = (impl) ->
	{Item} = impl.Types

	DATA =
		image: null

	DATA: DATA

	createData: impl.utils.createDataCloner Item.DATA, DATA

	create: (data) ->
		Item.create.call @, data

		image = data.image = document.createElement 'img'
		image.style.width = "100%"
		image.style.height = "100%"
		image.style.pointerEvents = 'none'
		data.elem.appendChild image

	setImageSource: do ->
		prepareDataUri = do ->
			if typeof Blob is 'function' and URL?.createObjectURL?
				cache = {}

				(dataUri) ->
					[_, type, data] = dataUri

					if val = cache[data]
						return val

					blob = new Blob [data], type: type
					url = URL.createObjectURL blob
					cache[data] = url
			else
				(dataUri) ->
					# escape data uri for some browsers (e.g. firefox)
					[_, type, data] = dataUri
					"data:#{type},#{escape data}"

		(val, callback) ->
			dataUri = DATA_URI_RE.exec val
			if dataUri?
				val = prepareDataUri dataUri

			@_impl.image.src = val

			@_impl.image.onerror = (err) ->
				callback true

			@_impl.image.onload = ->
				callback null,
					width: @naturalWidth or @width
					height: @naturalHeight or @height
