'use strict'

module.exports = (impl) ->
	{items} = impl
	{Item, Image} = impl.Types

	getRectangleSource = (item) ->
		{width, height} = item
		strokeWidth = Math.min item.border.width*2, width, height

		"data:image/svg+xml;utf8," +
		"<svg width='#{width}' height='#{height}' xmlns='http://www.w3.org/2000/svg'>" +
			"<clipPath id='clip'>" +
				"<rect " +
					"rx='#{item.radius}' " +
					"width='#{width}' height='#{height}' />" +
			"</clipPath>" +
			"<rect " +
				"clip-path='url(#clip)' " +
				"fill='#{item.color}' " +
				"stroke='#{item.border.color}' " +
				"stroke-width='#{strokeWidth}' " +
				"rx='#{item.radius}' " +
				"width='#{width}' height='#{height}' />" +
		"</svg>"

	updateImage = ->
		return if @_impl.rectangleUpdatePending

		@_impl.rectangleUpdatePending = true
		setImmediate =>
			@_impl.rectangleUpdatePending = false
			Image.setImageSource.call @, getRectangleSource(@)

	DATA =
		rectangleUpdatePending: false

	DATA: DATA

	createData: impl.utils.createDataCloner Image.DATA, DATA

	create: (data) ->
		Image.create.call @, data

		@onWidthChanged updateImage
		@onHeightChanged updateImage

	setRectangleColor: updateImage
	setRectangleRadius: updateImage
	setRectangleBorderColor: updateImage
	setRectangleBorderWidth: updateImage
