'use strict'

module.exports = (impl) ->
	{items} = impl
	{Item, Image} = impl.Types

	getRectangleSource = (id) ->
		item = items[id]
		width = Item.getItemWidth id
		height = Item.getItemHeight id
		strokeWidth = Math.min item.borderWidth*2, width, height

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
				"stroke='#{item.borderColor}' " +
				"stroke-width='#{strokeWidth}' " +
				"rx='#{item.radius}' " +
				"width='#{width}' height='#{height}' />" +
		"</svg>"

	updateImage = (id) ->
		item = items[id]
		return if item.rectangleUpdatePending

		item.rectangleUpdatePending = true
		setImmediate ->
			item.rectangleUpdatePending = false
			Image.setImageSource id, getRectangleSource(id)

	impl.setItemWidth = do (_super = impl.setItemWidth) -> (id, val) ->
		_super id, val

		if items[id].type is 'Rectangle'
			updateImage id

	impl.setItemHeight = do (_super = impl.setItemHeight) -> (id, val) ->
		_super id, val

		if items[id].type is 'Rectangle'
			updateImage id

	create: (id, target) ->
		Image.create id, target

		target.rectangleUpdatePending = false
		target.color = 'transparent'
		target.radius = 0
		target.borderColor = 'transparent'
		target.borderWidth = 0

	getRectangleColor: (id) ->
		items[id].color

	setRectangleColor: (id, val) ->
		items[id].color = val
		updateImage id

	getRectangleRadius: (id) ->
		items[id].radius

	setRectangleRadius: (id, val) ->
		items[id].radius = val
		updateImage id

	getRectangleBorderColor: (id) ->
		items[id].borderColor

	setRectangleBorderColor: (id, val) ->
		items[id].borderColor = val
		updateImage id

	getRectangleBorderWidth: (id) ->
		items[id].borderWidth

	setRectangleBorderWidth: (id, val) ->
		items[id].borderWidth = val
		updateImage id
