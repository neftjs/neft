'use strict'

MAX_LOOPS = 100

utils = require 'utils'
log = require 'log'
TypedArray = require 'typed-array'

log = log.scope 'Renderer'

queueIndex = 0
queues = [[], []]
queue = queues[queueIndex]
pending = false

columnsPositions = new TypedArray.Uint32 64
columnsFills = new TypedArray.Uint8 64
rowsPositions = new TypedArray.Uint32 64
rowsFills = new TypedArray.Uint8 64

getArray = (arr, len) ->
	if arr.length < len
		arr = new arr.constructor len * 1.5
	else
		for i in [0...len] by 1
			arr[i] = 0
	arr

updateItem = (item) ->
	unless effectItem = item._effectItem
		return

	{includeBorderMargins} = item
	{children} = effectItem
	data = item._impl
	{gridType} = data

	# get config
	{autoWidth, autoHeight} = data
	columnSpacing = rowSpacing = 0

	if layout = effectItem._layout
		autoWidth &&= !layout._fillWidth
		autoHeight &&= !layout._fillHeight

	if gridType is ALL
		columnsLen = item.columns
		rowsLen = item.rows
		columnSpacing = item.spacing.column
		rowSpacing = item.spacing.row
	else if gridType is COLUMN
		rowSpacing = item.spacing
		columnsLen = 1
		rowsLen = Infinity
	else if gridType is ROW
		columnSpacing = item.spacing
		columnsLen = Infinity
		rowsLen = 1

	if item._alignment
		alignH = item._alignment._horizontal
		alignV = item._alignment._vertical
	else
		alignH = 'left'
		alignV = 'top'

	# get tmp variables
	maxColumnsLen = if columnsLen is Infinity then children.length else columnsLen
	lastColumn = maxColumnsLen - 1
	columnsPositions = getArray columnsPositions, maxColumnsLen
	columnsFills = getArray columnsFills, maxColumnsLen

	maxRowsLen = if rowsLen is Infinity then Math.ceil(children.length / columnsLen) else rowsLen
	lastRow = maxRowsLen - 1
	rowsPositions = getArray rowsPositions, maxRowsLen
	rowsFills = getArray rowsFills, maxRowsLen

	columnsFillsSum = 0
	rowsFillsSum = 0

	# get columns and rows positions
	i = 0
	for child in children
		# omit not visible
		if not child._visible
			continue

		column = i % columnsLen
		row = Math.floor(i/columnsLen) % rowsLen

		# child
		layout = child._layout
		width = child._width
		height = child._height
		margin = child._margin

		if layout and not layout._enabled
			continue

		if layout and layout._fillWidth and not autoWidth
			width = 0
			unless columnsFills[column]
				columnsFills[column] = 1
				columnsFillsSum++
		if column isnt lastColumn
			width += columnSpacing

		if layout and layout._fillWidth and not autoHeight
			height = 0
			unless rowsFills[row]
				rowsFills[row] = 1
				rowsFillsSum++
		if row isnt lastRow
			height += rowSpacing

		# margins
		if margin
			if includeBorderMargins or column isnt 0
				width += margin._left
			if includeBorderMargins or column isnt lastColumn
				width += margin._right
			if includeBorderMargins or row isnt 0
				height += margin._top
			if includeBorderMargins or row isnt lastRow
				height += margin._bottom

		# save
		if width > columnsPositions[column]
			columnsPositions[column] = width
		if height > rowsPositions[row]
			rowsPositions[row] = height

		i++

	# expand filled columns
	if columnsFillsSum > 0 and not autoWidth
		staticWidth = 0
		for i in [0...maxColumnsLen] by 1
			unless columnsFills[i]
				staticWidth += columnsPositions[i]
		freeSpace = effectItem._width - staticWidth
		if freeSpace > 0
			freeSpacePerColumn = freeSpace / columnsFillsSum
			for i in [0...maxColumnsLen] by 1
				if columnsFills[i] and columnsPositions[i] < freeSpacePerColumn
					columnsPositions[i] += freeSpacePerColumn - columnsPositions[i]

	# expand filled rows
	if rowsFillsSum > 0 and not autoHeight
		staticHeight = 0
		for i in [0...maxRowsLen] by 1
			unless rowsFills[i]
				staticHeight += rowsPositions[i]
		freeSpace = effectItem._height - staticHeight
		if freeSpace > 0
			freeSpacePerRow = freeSpace / rowsFillsSum
			for i in [0...maxRowsLen] by 1
				if rowsFills[i] and rowsPositions[i] < freeSpacePerRow
					rowsPositions[i] += freeSpacePerRow - rowsPositions[i]

	# sum columns positions
	last = 0
	for i in [0...maxColumnsLen] by 1
		last = columnsPositions[i] += last
	unless autoWidth
		columnsPositions[lastColumn] = Math.max columnsPositions[lastColumn], effectItem._width

	# sum rows positions
	last = 0
	for i in [0...maxRowsLen] by 1
		last = rowsPositions[i] += last
	unless autoHeight
		rowsPositions[lastRow] = Math.max rowsPositions[lastRow], effectItem._height

	# set children positions
	i = 0
	for child in children
		# omit not visible children
		if not child._visible
			continue

		column = i % columnsLen
		row = Math.floor(i/columnsLen) % rowsLen

		margin = child._margin
		layout = child._layout
		anchors = child._anchors

		if layout and not layout._enabled
			continue

		# get column position
		columnX = if column > 0 then columnsPositions[column-1] else 0
		if margin and (includeBorderMargins or (column > 0 and column < columnsLen))
			leftMargin = margin._left
			rightMargin = margin._right
		else
			leftMargin = rightMargin = 0

		# get row position
		rowY = if row > 0 then rowsPositions[row-1] else 0
		if margin and (includeBorderMargins or (row > 0 and row < rowsLen))
			topMargin = margin._top
			bottomMargin = margin._bottom
		else
			topMargin = bottomMargin = 0

		# set sizes
		if layout
			# set width
			if layout._fillWidth and not autoWidth
				width = columnsPositions[column] - columnX - leftMargin - rightMargin
				child.width = width

			# set height
			if layout._fillHeight and not autoHeight
				height = rowsPositions[row] - rowY - topMargin - bottomMargin
				child.height = height

		# set x
		if (gridType & ROW or alignH isnt 'left' or (margin and (margin._left or margin._right))) and not anchors?._autoX
			x = columnX + leftMargin
			if alignH is 'center'
				x += (columnsPositions[column] - x - columnsPositions[lastColumn]) / 2 - rightMargin / 2
			else if alignH is 'right'
				x += columnsPositions[column] - x - columnsPositions[lastColumn] - rightMargin
			child.x = x

		# set y
		if (gridType & COLUMN or alignV isnt 'top' or (margin and (margin._top or margin._bottom))) and not anchors?._autoY
			y = rowY + topMargin
			if alignV is 'center'
				y += (rowsPositions[row] - y - rowsPositions[lastRow]) / 2 - bottomMargin / 2
			else if alignV is 'right'
				y += rowsPositions[row] - y - rowsPositions[lastRow1] - bottomMargin
			child.y = y

		i++

	# set item size
	if autoWidth
		width = columnsPositions[maxColumnsLen-1]
		if width > 0	
			effectItem.width = width
		else
			effectItem.width = 0

	if autoHeight
		height = rowsPositions[maxRowsLen-1]
		if height > 0
			effectItem.height = height
		else
			effectItem.height = 0
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
	if data.pending or not @_effectItem?._visible
		return

	data.pending = true

	if data.updatePending
		if data.gridUpdateLoops > MAX_LOOPS
			return

		if ++data.gridUpdateLoops is MAX_LOOPS
			log.error "Potential Grid/Column/Row loop detected. Recalculating on this item (#{@toString()}) has been disabled."
			return
	else
		data.gridUpdateLoops = 0

	queue.push @

	unless pending
		setImmediate updateItems
		pending = true
	return

updateSize = ->
	if not @_impl.updatePending
		update.call @
	return

onWidthChange = (oldVal) ->
	if @_effectItem and not @_impl.updatePending and (not (layout = @_effectItem._layout) or not layout._fillWidth)
		@_impl.autoWidth = @_effectItem._width is 0 and oldVal isnt -1
	updateSize.call @

onHeightChange = (oldVal) ->
	if @_effectItem and not @_impl.updatePending and (not (layout = @_effectItem._layout) or not layout._fillHeight)
		@_impl.autoHeight = @_effectItem._height is 0 and oldVal isnt -1
	updateSize.call @

enableChild = (child) ->
	child.onVisibleChange update, @
	child.onWidthChange update, @
	child.onHeightChange update, @
	child.onMarginChange update, @
	child.onAnchorsChange update, @
	child.onLayoutChange update, @

disableChild = (child) ->
	child.onVisibleChange.disconnect update, @
	child.onWidthChange.disconnect update, @
	child.onHeightChange.disconnect update, @
	child.onMarginChange.disconnect update, @
	child.onAnchorsChange.disconnect update, @
	child.onLayoutChange.disconnect update, @

COLUMN = exports.COLUMN = 1<<0
ROW = exports.ROW = 1<<1
ALL = exports.ALL = (1<<2) - 1

exports.DATA =
	pending: false
	updatePending: false
	disableFill: true
	gridType: 0
	gridUpdateLoops: 0
	autoWidth: true
	autoHeight: true

exports.create = (item, type) ->
	item._impl.gridType = type
	item.onAlignmentChange updateSize

exports.update = update

exports.setEffectItem = (item, oldItem) ->
	if oldItem
		oldItem.onVisibleChange.disconnect update, @
		oldItem.onChildrenChange.disconnect update, @
		oldItem.onLayoutChange.disconnect update, @
		oldItem.onWidthChange.disconnect onWidthChange, @
		oldItem.onHeightChange.disconnect onHeightChange, @
		oldItem.children.onInsert.disconnect enableChild, @
		oldItem.children.onPop.disconnect disableChild, @

		for child in oldItem.children
			disableChild.call @, child

	if item
		if @_impl.autoWidth = item.width is 0
			item.width = -1
		if @_impl.autoHeight = item.height is 0
			item.height = -1

		item.onVisibleChange update, @
		item.onChildrenChange update, @
		item.onLayoutChange update, @
		item.onWidthChange onWidthChange, @
		item.onHeightChange onHeightChange, @
		item.children.onInsert enableChild, @
		item.children.onPop disableChild, @

		for child in item.children
			enableChild.call @, child

		update.call @

	return
