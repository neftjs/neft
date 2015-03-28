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
	{children} = item
	data = item._impl
	{gridType} = data

	data.gridUpdatePending = true

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

		# margins
		if gridType & ROW
			width += columnSpacing
			if column isnt 0
				width += child.margin.left
			if column isnt lastColumn
				width += child.margin.right
		if gridType & COLUMN
			height += rowSpacing
			if row isnt 0
				height += child.margin.top
			if row isnt lastRow
				height += child.margin.bottom

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

	# sum rows positions
	last = 0
	for i in [0...maxRowsLen] by 1
		last = rowsPositions[i] += last
	rowsPositions[i-1] -= rowSpacing

	# set positions
	i = 0
	for child in children
		unless child._visible
			continue

		column = i % columnsLen
		row = Math.floor(i/columnsLen) % rowsLen

		if gridType & ROW
			if column > 0
				child.x = child.margin.left + columnsPositions[column-1]
			else
				child.x = 0

		if gridType & COLUMN
			if row > 0
				child.y = child.margin.top + rowsPositions[row-1]
			else
				child.y = 0

		i++

	# set item size
	if item.fill.width isnt false
		width = columnsPositions[maxColumnsLen-1]
		if width > 0	
			item.width = width
		else
			item.width = 0
		item.fill.width = true

	if item.fill.height isnt false
		height = rowsPositions[maxRowsLen-1]
		if height > 0
			item.height = height
		else
			item.height = 0
		item.fill.height = true
	data.gridUpdatePending = false
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

	if data.gridUpdatePending
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
	if not @_impl.gridUpdatePending and (@_fillWidth or @_fillHeight)
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

COLUMN = exports.COLUMN = 1<<0
ROW = exports.ROW = 1<<1
ALL = exports.ALL = (1<<2) - 1

exports.DATA =
	pending: false
	disableFill: true
	gridType: 0
	gridUpdatePending: false
	gridUpdateLoops: 0

exports.create = (item, type) ->
	item._impl.gridType = type

	# update item changes
	item.onChildrenChanged update
	item.onWidthChanged updateSize
	item.onHeightChanged updateSize

	# update on each children size change
	item.children.onInserted enableChild, item
	item.children.onPopped disableChild, item

exports.update = update
