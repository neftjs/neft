'use strict'

module.exports = (impl) ->
	{Item} = impl.Types

	{round} = Math

	# TODO: browsers makes borders always visible even
	#       if the size is less than border width

	DATA =
		rect: null
		rectStyle: null

	div = do ->
		div = document.createElement 'div'
		div.setAttribute 'class', 'rect'
		div

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		Item.create.call @, data

		rect = data.rect = div.cloneNode(false)
		data.elem.appendChild rect
		data.rectStyle = rect.style

	setRectangleColor: (val) ->
		@_impl.rectStyle.backgroundColor = val

	setRectangleRadius: (val) ->
		val = round val
		@_impl.rectStyle.borderRadius = "#{val}px"

	setRectangleBorderColor: (val) ->
		@_impl.rectStyle.borderColor = val

	setRectangleBorderWidth: (val) ->
		val = round val
		@_impl.rectStyle.borderWidth = "#{val}px"
