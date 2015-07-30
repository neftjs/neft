'use strict'

module.exports = (impl) ->
	{Item} = impl.Types

	{round} = Math

	# TODO: browsers makes borders always visible even
	#       if the size is less than border width

	DATA =
		innerElem: null
		innerElemStyle: null

	COLOR_RESOURCE_REQUEST =
		property: 'color'

	BORDER_COLOR_RESOURCE_REQUEST =
		property: 'borderColor'

	div = do ->
		div = document.createElement 'div'
		div.setAttribute 'class', 'rect'
		div

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		Item.create.call @, data

		innerElem = data.innerElem = div.cloneNode(false)
		impl.utils.prependElement data.elem, innerElem
		data.innerElemStyle = innerElem.style

	setRectangleColor: (val) ->
		val = impl.Renderer.resources?.resolve(val, COLOR_RESOURCE_REQUEST) or val
		@_impl.innerElemStyle.backgroundColor = val

	setRectangleRadius: (val) ->
		val = round val
		@_impl.innerElemStyle.borderRadius = "#{val}px"

	setRectangleBorderColor: (val) ->
		val = impl.Renderer.resources?.resolve(val, BORDER_COLOR_RESOURCE_REQUEST) or val
		@_impl.innerElemStyle.borderColor = val

	setRectangleBorderWidth: (val) ->
		val = round val
		@_impl.innerElemStyle.borderWidth = "#{val}px"
