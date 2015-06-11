'use strict'

MAX_LOOPS = 100

utils = require 'utils'
log = require 'log'

log = log.scope 'Renderer'

if typeof Uint32Array is 'undefined'
	Uint32TypedArray = (len) ->
		arr = []
		for i in [0..len]
			arr[i] = 0
		arr
else
	Uint32TypedArray = Uint32Array

queueIndex = 0
queues = [[], []]
queue = queues[queueIndex]
pending = false

columnsPositions = new Uint32TypedArray 12
rowsPositions = new Uint32TypedArray 64

updateItem = (item) ->
	{children, includeBorderMargins} = item
	data = item._impl
	{gridType} = data

	item._updatePending = true

	# get config
	columnSpacing = rowSpacing = 0

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

	# get tmp arrays
	maxColumnsLen = if columnsLen is Infinity then children.length else columnsLen
	lastColumn = maxColumnsLen - 1
	if columnsPositions.length < maxColumnsLen
		columnsPositions = new Uint32TypedArray maxColumnsLen
	else
		for i in [0...maxColumnsLen] by 1
			columnsPositions[i] = 0

	maxRowsLen = if rowsLen is Infinity then Math.ceil(children.length / columnsLen) else rowsLen
	lastRow = maxRowsLen - 1
	if rowsPositions.length < maxRowsLen
		rowsPositions = new Uint32TypedArray maxRowsLen
	else
		for i in [0...maxRowsLen] by 1
			rowsPositions[i] = 0

	# get sizes
	i = 0
	for child in children
		# omit not visible children
		unless child._visible
			continue

		column = i % columnsLen
		row = Math.floor(i/columnsLen) % rowsLen

		# child
		width = child._width
		height = child._height
		margin = child._margin

		# margins
		width += columnSpacing
		if margin
			if includeBorderMargins or column isnt 0
				width += margin._left
			if includeBorderMargins or column isnt lastColumn
				width += margin._right

		height += rowSpacing
		if margin
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

	# sum columns positions
	last = 0
	for i in [0...maxColumnsLen] by 1
		last = columnsPositions[i] += last
	columnsPositions[i-1] -= columnSpacing
	unless item._autoWidth
		columnsPositions[i-1] = Math.max columnsPositions[i-1], item._width

	# sum rows positions
	last = 0
	for i in [0...maxRowsLen] by 1
		last = rowsPositions[i] += last
	rowsPositions[i-1] -= rowSpacing
	unless item._autoHeight
		rowsPositions[i-1] = Math.max rowsPositions[i-1], item._height

	# set positions
	i = 0
	for child in children
		unless child._visible
			continue

		column = i % columnsLen
		row = Math.floor(i/columnsLen) % rowsLen

		margin = child._margin

		if gridType & ROW or alignH isnt 'left' or (margin and (margin._left or margin._right))
			if column > 0
				x = columnsPositions[column-1]
			else
				x = 0
			if margin and (includeBorderMargins or column > 0)
				x += margin._left
			if alignH is 'center'
				x += (columnsPositions[column] - x - child._width) / 2
			else if alignH is 'right'
				x += columnsPositions[column] - x - child._width
			child.x = x

		if gridType & COLUMN or alignV isnt 'top' or (margin and (margin._top or margin._bottom))
			if row > 0
				y = rowsPositions[row-1]
			else
				y = 0
			if margin and (includeBorderMargins or row > 0)
				y += margin._top
			if alignV is 'center'
				y += (rowsPositions[row] - y - child._height) / 2
			else if alignV is 'right'
				y += rowsPositions[row] - y - child._height
			child.y = y

		i++

	# set item size
	if item._autoWidth
		width = columnsPositions[maxColumnsLen-1]
		if width > 0	
			item.width = width
		else
			item.width = 0

	if item._autoHeight
		height = rowsPositions[maxRowsLen-1]
		if height > 0
			item.height = height
		else
			item.height = 0

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
	if data.pending
		return

	data.pending = true

	if @_updatePending
		if data.gridUpdateLoops > MAX_LOOPS
			return

		if ++data.gridUpdateLoops is MAX_LOOPS
			log.warn "Potential Grid/Column/Row loop detected. Recalculating on this item (#{@toString()}) has been disabled."
			return
	else
		data.gridUpdateLoops = 0

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

COLUMN = exports.COLUMN = 1<<0
ROW = exports.ROW = 1<<1
ALL = exports.ALL = (1<<2) - 1

exports.DATA =
	pending: false
	disableFill: true
	gridType: 0
	gridUpdateLoops: 0

exports.create = (item, type) ->
	item._impl.gridType = type

	# update item changes
	item.onChildrenChange update
	item.onWidthChange updateSize
	item.onHeightChange updateSize

	# update on each children size change
	item.children.onInsert enableChild, item
	item.children.onPop disableChild, item

exports.update = update
