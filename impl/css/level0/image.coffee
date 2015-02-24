'use strict'

DATA_URI_RE = ///^data:([a-z+/]+),(.*)$///

module.exports = (impl) ->
	{Item} = impl.Types

	DATA =
		image: null
		callback: null

	DATA: DATA

	createData: impl.utils.createDataCloner Item.DATA, DATA

	create: (data) ->
		self = @
		Item.create.call @, data

		image = data.image = document.createElement 'img'
		data.elem.appendChild image

		image.addEventListener 'error', (err) ->
			data.callback?.call self, true

		image.addEventListener 'load', ->
			if self._width is 0 and self._height is 0
				data.callback?.call self, null,
					width: @naturalWidth or @width
					height: @naturalHeight or @height
			else
				data.callback?.call self, null
		return

	setImageSource: (val, callback) ->
		if DATA_URI_RE.test val
			val = val.replace ///\#///g, encodeURIComponent('#')

		@_impl.image.src = val
		@_impl.callback = callback
		return
