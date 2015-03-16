'use strict'

utils = require 'utils'

queueIndex = 0
queues = [[], []]
queue = queues[queueIndex]
queueItems = Object.create null
pending = false

updateItem = (item) ->
	{children} = item
	data = item._impl

	data.updatePending = true

	# get config
	maxColumn = if item._fillWidth then Infinity else item._width
	columnSpacing = item._spacingColumn
	rowSpacing = item._spacingRow

	# tmp vars
	width = height = column = row = x = y = right = rowSpan = 0

	# set children positions
	for child in children
		# omit not visible children
		unless child._visible
			continue

		if column + child._marginLeft + child._width >= maxColumn
			column = 0
			row = height
			x = column
		else
			x = column + child._marginLeft

		if row > 0
			y = row + rowSpan + child._marginTop
		else
			y = row

		right = x + child._width

		child.x = x
		child.y = y

		column = right
		if column > width
			width = column
		column += columnSpacing + child._marginRight

		y += child._height
		if y > height
			height = y
		rowSpan = rowSpacing + child._marginBottom

	# set item size
	if item._fillWidth
		item.width = width
		item._fillWidth = true

	if item._fillHeight
		item.height = height
		item._fillHeight = true

	data.updatePending = false
	return

updateItems = ->
	pending = false
	currentQueue = queue
	queue = queues[++queueIndex % queues.length]

	while currentQueue.length
		item = currentQueue.pop()
		queueItems[item.__hash__] = false
		updateItem item
	return

update = ->
	if queueItems[@__hash__]
		return

	queueItems[@__hash__] = true
	queue.push @

	unless pending
		setImmediate updateItems
		pending = true
	return

updateSize = ->
	if not @_impl.updatePending and (@_fillWidth or @_fillHeight)
		update.call @
	return

enableChild = (child) ->
	child.onVisibleChanged update, @
	child.onWidthChanged update, @
	child.onHeightChanged update, @
	child.onMarginChanged update, @

disableChild = (child) ->
	child.onVisibleChanged.disconnect update, @
	child.onWidthChanged.disconnect update, @
	child.onHeightChanged.disconnect update, @
	child.onMarginChanged.disconnect update, @

module.exports = (impl) ->
	DATA =
		disableFill: true
		updatePending: false

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		impl.Types.Item.create.call @, data

		# update item changes
		@onChildrenChanged update
		@onWidthChanged updateSize
		@onHeightChanged updateSize

		# update on each children size change
		@children.onInserted enableChild
		@children.onPopped disableChild

	setFlowColumnSpacing: update
	setFlowRowSpacing: update
