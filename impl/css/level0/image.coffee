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
		data.elem.appendChild image

	setImageSource: (val, callback) ->
		if DATA_URI_RE.test val
			val = val.replace ///\#///g, encodeURIComponent('#')

		@_impl.image.src = val

		@_impl.image.addEventListener 'error', (err) ->
			callback true

		@_impl.image.addEventListener 'load', ->
			callback null,
				width: @naturalWidth or @width
				height: @naturalHeight or @height
