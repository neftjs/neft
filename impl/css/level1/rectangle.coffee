'use strict'

module.exports = (impl) ->
	{Item} = impl.Types

	# TODO: browsers makes borders always visible even
	#       if the size is less than border width

	DATA =
		rect: null

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		Item.create.call @, data

		rect = data.rect = document.createElement 'div'
		data.elem.appendChild rect

		{style} = rect
		style.width = '100%'
		style.height = '100%'
		style.boxSizing = 'border-box'
		style.borderWidth = '0'
		style.borderStyle = 'solid'
		style.borderColor = 'transparent'

	setRectangleColor: (val) ->
		@_impl.rect.style.backgroundColor = val

	setRectangleRadius: (val) ->
		@_impl.rect.style.borderRadius = "#{val}px"

	setRectangleBorderColor: (val) ->
		@_impl.rect.style.borderColor = val

	setRectangleBorderWidth: (val) ->
		@_impl.rect.style.borderWidth = "#{val}px"
