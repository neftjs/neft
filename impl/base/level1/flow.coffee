'use strict'

utils = require 'utils'
log = require 'log'

log = log.scope 'Renderer', 'Flow'

if typeof Uint32Array is 'undefined'
	Uint32TypedArray = (len) ->
		arr = []
		for i in [0..len]
			arr[i] = 0
		arr
else
	Uint32TypedArray = Uint32Array

MAX_LOOPS = 50

queueIndex = 0
queues = [[], []]
queue = queues[queueIndex]
pending = false

cellsWidth = new Uint32TypedArray 64
cellsHeight = new Uint32TypedArray 64
elementsX = new Uint32TypedArray 64
elementsY = new Uint32TypedArray 64
elementsCell = new Uint32TypedArray 64

updateItem = (item) ->
	{children, includeBorderMargins} = item
	data = item._impl

	if data.loops is MAX_LOOPS
		log.error "Potential Flow loop detected. Recalculating on this item (#{item.toString()}) has been disabled."
		data.loops++
		return
	else if data.loops > MAX_LOOPS
		return

	item._updatePending = true

	# get config
	maxColumn = if item._autoWidth then Infinity else item.width
	columnSpacing = item.spacing.column
	rowSpacing = item.spacing.row

	if item._alignment
		alignH = item._alignment._horizontal
		alignV = item._alignment._vertical
		align = alignH isnt 'left' or alignV isnt 'top'
	else
		alignH = 'left'
		alignV = 'top'
		align = false

	# get tmp arrays
	maxLen = children.length
	if align and elementsX.length < maxLen
		maxLen *= 1.5
		cellsWidth = new Uint32TypedArray maxLen
		cellsHeight = new Uint32TypedArray maxLen
		elementsX = new Uint32TypedArray maxLen
		elementsY = new Uint32TypedArray maxLen
		elementsCell = new Uint32TypedArray maxLen

	# tmp vars
	width = height = column = row = x = y = right = rowSpan = maxCell = 0

	# calculate children positions
	for child, i in children
		# omit not visible children
		unless child._visible
			continue

		margin = child._margin

		if column is 0
			x = 0
		else if column + child.width + (if margin then margin._left else 0) >= maxColumn
			column = 0
			row = height
			x = 0
			maxCell++
		else
			x = column
		if margin and (includeBorderMargins or (x isnt 0 and column isnt 0))
			x += margin._left

		if row > 0
			y = row + rowSpan
		else
			y = 0
		if margin and (includeBorderMargins or row > 0)
			y += margin._top

		right = x + child.width

		if align
			elementsX[i] = x
			elementsY[i] = y
			elementsCell[i] = maxCell
		else
			child.x = x
			child.y = y

		column = right
		if column > width
			width = column
		if margin
			column += margin._right
			if includeBorderMargins and column > width
				width = column
		column += columnSpacing

		y += child._height
		rowSpan = rowSpacing
		if margin
			rowSpan += margin._bottom
			if includeBorderMargins
				y += margin._bottom
		if y > height
			height = y

		if align
			cellsWidth[maxCell] = column
			cellsHeight[maxCell] = y - row

	# set children positions
	if align
		switch alignH
			when 'left'
				multiplierX = 0
			when 'center'
				multiplierX = 0.5
			when 'right'
				multiplierX = 1
		switch alignV
			when 'top'
				multiplierY = 0
			when 'center'
				multiplierY = 0.5
			when 'bottom'
				multiplierY = 1
		if not item._autoWidth
			width = item._width
		if not item._autoHeight
			height = item._height
		if item._autoHeight or alignV is 'top'
			plusY = 0
		else
			plusY = (item._height - height) * multiplierY
		for child, i in children
			# omit not visible children
			unless child._visible
				continue
			cell = elementsCell[i]
			bottom = child._height
			if child._margin
				if includeBorderMargins or cell > 0
					bottom += child._margin._top
				if includeBorderMargins or cell < maxCell
					bottom += child._margin._bottom

			child.x = elementsX[i] + (width - cellsWidth[cell]) * multiplierX
			child.y = elementsY[i] + plusY + (cellsHeight[cell] - bottom) * multiplierY

	# set item size
	if item._autoWidth
		item.width = width

	if item._autoHeight
		item.height = height

	item._updatePending = false

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
	if not @_updatePending and (@_autoWidth or @_autoHeight)
		update.call @
	return

enableChild = (child) ->
	child.onVisibleChange update, @
	child.onWidthChange update, @
	child.onHeightChange update, @
	child.onMarginChange update, @

disableChild = (child) ->
	child.onVisibleChange.disconnect update, @
	child.onWidthChange.disconnect update, @
	child.onHeightChange.disconnect update, @
	child.onMarginChange.disconnect update, @

module.exports = (impl) ->
	DATA =
		loops: 0
		pending: false

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		impl.Types.Item.create.call @, data

		# update item changes
		@onChildrenChange update
		@onWidthChange updateSize
		@onHeightChange updateSize

		# update on each children size change
		@children.onInsert enableChild, @
		@children.onPop disableChild, @

	setFlowColumnSpacing: update
	setFlowRowSpacing: update
	setFlowIncludeBorderMargins: update
