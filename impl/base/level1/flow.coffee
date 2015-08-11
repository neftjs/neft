'use strict'

utils = require 'utils'
log = require 'log'
TypedArray = require 'typed-array'

log = log.scope 'Renderer', 'Flow'

MAX_LOOPS = 50

queueIndex = 0
queues = [[], []]
queue = queues[queueIndex]
pending = false

cellsWidth = new TypedArray.Uint32 64
cellsHeight = new TypedArray.Uint32 64
elementsX = new TypedArray.Uint32 64
elementsY = new TypedArray.Uint32 64
elementsCell = new TypedArray.Uint32 64

updateItem = (item) ->
	{includeBorderMargins} = item
	effectItem = item._effectItem
	{children} = effectItem
	data = item._impl

	if data.loops is MAX_LOOPS
		log.error "Potential Flow loop detected. Recalculating on this item (#{item.toString()}) has been disabled."
		data.loops++
		return
	else if data.loops > MAX_LOOPS
		return

	# get config
	maxColumn = if data.autoWidth then Infinity else effectItem.width
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
		cellsWidth = new TypedArray.Uint32 maxLen
		cellsHeight = new TypedArray.Uint32 maxLen
		elementsX = new TypedArray.Uint32 maxLen
		elementsY = new TypedArray.Uint32 maxLen
		elementsCell = new TypedArray.Uint32 maxLen

	# tmp vars
	width = height = column = row = x = y = right = rowSpan = maxCell = 0

	# calculate children positions
	for child, i in children
		# omit not visible and auto positioned children
		if not child._visible
			continue
		if (anchors = child._anchors) and anchors._autoY
			continue

		margin = child._margin

		if column is 0
			x = 0
		else if column + child.width + (if margin then margin._left else 0) > maxColumn
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
		if not data.autoWidth
			width = item._width
		if not data.autoHeight
			height = item._height
		if data.autoHeight or alignV is 'top'
			plusY = 0
		else
			plusY = (item._height - height) * multiplierY
		for child, i in children
			# omit not visible and auto positioned children
			if not child._visible
				continue
			if (anchors = child._anchors) and anchors._autoY
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
	if data.autoWidth
		item._effectItem.width = width

	if data.autoHeight
		item._effectItem.height = height

	return

updateItems = ->
	pending = false
	currentQueue = queue
	queue = queues[++queueIndex % queues.length]

	while currentQueue.length
		item = currentQueue.pop()
		item._impl.pending = false
		item._impl.updatePending = true
		updateItem item
		item._impl.updatePending = false
	return

update = ->
	data = @_impl

	if data.updatePending
		data.loops++
	else
		data.loops = 0

	unless data.pending
		data.pending = true
		queue.push @

		unless pending
			setImmediate updateItems
			pending = true
	return

updateSize = ->
	if not @_impl.updatePending and (@_impl.autoWidth or @_impl.autoHeight)
		update.call @
	return

onWidthChange = (oldVal) ->
	if not @_impl.updatePending
		@_impl.autoWidth = @_width is 0 and oldVal isnt -1
	updateSize.call @

onHeightChange = (oldVal) ->
	if not @_impl.updatePending
		@_impl.autoHeight = @_height is 0 and oldVal isnt -1
	updateSize.call @

enableChild = (child) ->
	child.onVisibleChange update, @
	child.onWidthChange update, @
	child.onHeightChange update, @
	child.onMarginChange update, @
	child.onAnchorsChange update, @

disableChild = (child) ->
	child.onVisibleChange.disconnect update, @
	child.onWidthChange.disconnect update, @
	child.onHeightChange.disconnect update, @
	child.onMarginChange.disconnect update, @
	child.onAnchorsChange.disconnect update, @

module.exports = (impl) ->
	DATA =
		loops: 0
		pending: false
		updatePending: false
		autoWidth: true
		autoHeight: true

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		impl.Types.Item.create.call @, data
		@onAlignmentChange updateSize

	setFlowEffectItem: (item, oldItem) ->
		if oldItem
			oldItem.onChildrenChange.disconnect update, @
			oldItem.onWidthChange.disconnect onWidthChange, @
			oldItem.onHeightChange.disconnect onHeightChange, @
			oldItem.children.onInsert.disconnect enableChild, @
			oldItem.children.onPop.disconnect disableChild, @

			if @_impl.autoWidth
				oldItem.width = 0
			if @_impl.autoHeight
				oldItem.height = 0

			for child in oldItem.children
				disableChild.call @, child

		if item
			if @_impl.autoWidth = item.width is 0
				item.width = -1
			if @_impl.autoHeight = item.height is 0
				item.height = -1

			item.onChildrenChange update, @
			item.onWidthChange onWidthChange, @
			item.onHeightChange onHeightChange, @
			item.children.onInsert enableChild, @
			item.children.onPop disableChild, @

			for child in item.children
				enableChild.call @, child

			update.call @

		return

	setFlowColumnSpacing: update
	setFlowRowSpacing: update
	setFlowIncludeBorderMargins: update
