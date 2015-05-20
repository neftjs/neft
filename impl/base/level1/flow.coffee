'use strict'

utils = require 'utils'
log = require 'log'

log = log.scope 'Renderer', 'Flow'

MAX_LOOPS = 50

queueIndex = 0
queues = [[], []]
queue = queues[queueIndex]
pending = false

updateItem = (item) ->
	{children} = item
	data = item._impl

	if data.loops is MAX_LOOPS
		log.error "Potential Flow loop detected. Recalculating on this item (#{item.toString()}) has been disabled."
		data.loops++
		return
	else if data.loops > MAX_LOOPS
		return

	data.updatePending = true

	# get config
	maxColumn = if item.fill.width then Infinity else item.width
	columnSpacing = item.spacing.column
	rowSpacing = item.spacing.row

	# tmp vars
	width = height = column = row = x = y = right = rowSpan = 0

	# set children positions
	for child in children
		# omit not visible children
		unless child._visible
			continue

		margin = child._margin

		if column is 0
			x = 0
		else if column + child.width + (if margin then margin._left else 0) >= maxColumn
			column = 0
			row = height
			x = column
		else
			x = column
			if margin
				x += margin._left

		if row > 0
			y = row + rowSpan
			if margin
				y += margin._top
		else
			y = 0

		right = x + child.width

		child.x = x
		child.y = y

		column = right
		if column > width
			width = column
		column += columnSpacing
		if margin
			column += margin._right

		y += child._height
		if y > height
			height = y
		rowSpan = rowSpacing
		if margin
			rowSpan += margin._bottom

	# set item size
	if item.fill.width
		item.width = width
		item.fill.width = true

	if item.fill.height
		item.height = height
		item.fill.height = true

	data.updatePending = false

	return

updateItems = ->
	pending = false
	currentQueue = queue
	queue = queues[++queueIndex % queues.length]

	while currentQueue.length
		item = currentQueue.pop()
		item._impl.pending = false
		updateItem item
	return

update = ->
	data = @_impl
	unless data.pending
		data.pending = true
		queue.push @

		unless pending
			setImmediate updateItems
			pending = true
	return

updateSize = ->
	if not @_impl.updatePending and (@fill.width or @fill.height)
		update.call @
	return

module.exports = (impl) ->
	DATA =
		loops: 0
		disableFill: true
		pending: false
		updatePending: false

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		impl.Types.Item.create.call @, data
		data.update = update

	setFlowColumnSpacing: update
	setFlowRowSpacing: update
