'use strict'

DATA_URI_RE = ///^(data:[a-z+/]+,)(.*)$///

module.exports = (impl) ->
	{Item} = impl.Types

	create: (item) ->
		data = item._impl

		Item.create item

		image = data.image = document.createElement 'img'
		image.style.width = "100%"
		image.style.height = "100%"
		image.style.pointerEvents = 'none'
		data.elem.appendChild image

	setImageSource: (val) ->
		# escape data uri for some browsers (e.g. firefox)
		dataUri = DATA_URI_RE.exec val
		if dataUri?
			[_, dec, data] = dataUri
			val = "#{dec}#{escape data}"

		@_impl.image.src = val