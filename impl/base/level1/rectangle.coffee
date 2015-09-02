'use strict'

module.exports = (impl) ->
	{items} = impl
	{round} = Math

	COLOR_RESOURCE_REQUEST =
		property: 'color'

	NOP = ->

	getRectangleSource = (item) ->
		{pixelRatio} = impl
		width = round item.width * pixelRatio
		height = round item.height * pixelRatio
		radius = round item.radius * pixelRatio
		strokeWidth = round Math.min(item.border.width * 2 * pixelRatio, width, height)
		color = impl.Renderer.resources?.resolve(item.color, COLOR_RESOURCE_REQUEST) or item.color
		borderColor = impl.Renderer.resources?.resolve(item.border.color, COLOR_RESOURCE_REQUEST) or item.border.color

		if width <= 0 or height <= 0
			item._impl.isRectVisible = false
			return null
		else
			item._impl.isRectVisible = true

		"data:image/svg+xml;utf8," +
		"<svg width='#{width}' height='#{height}' xmlns='http://www.w3.org/2000/svg'>" +
			"<clipPath id='clip'>" +
				"<rect " +
					"rx='#{radius}' " +
					"width='#{width}' height='#{height}' />" +
			"</clipPath>" +
			"<rect " +
				"clip-path='url(#clip)' " +
				"fill='#{color}' " +
				"stroke='#{borderColor}' " +
				"stroke-width='#{strokeWidth}' " +
				"rx='#{radius}' " +
				"width='#{width}' height='#{height}' />" +
		"</svg>"

	updateImage = ->
		impl.setImageSource.call @, getRectangleSource(@), NOP
		return

	updateImageIfNeeded = ->
		if not @_impl.isRectVisible or @radius > 0 or @border.width > 0
			updateImage.call @
		return

	DATA =
		isRectVisible: false

	DATA: DATA

	createData: impl.utils.createDataCloner 'Image', DATA

	create: (data) ->
		impl.Types.Image.create.call @, data

		@onWidthChange updateImageIfNeeded
		@onHeightChange updateImageIfNeeded

	setRectangleColor: updateImage
	setRectangleRadius: updateImage
	setRectangleBorderColor: updateImage
	setRectangleBorderWidth: updateImage
