'use strict'

utils = require 'utils'

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

	data.updatePending = true

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
	if columnsPositions.length < maxColumnsLen
		columnsPositions = new Uint32TypedArray maxColumnsLen
	else
		for i in [0...maxColumnsLen] by 1
			columnsPositions[i] = 0

	maxRowsLen = if rowsLen is Infinity then Math.ceil(children.length / columnsLen) else rowsLen
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

		# right / bottom margins
		if gridType & ROW
			width += child.margin.left + child.margin.right + columnSpacing
		if gridType & COLUMN
			height += child.margin.top + child.margin.bottom + rowSpacing

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
			child.x = child.margin.left + (if column > 0 then columnsPositions[column-1] else 0)

		if gridType & COLUMN
			child.y = child.margin.top + (if row > 0 then rowsPositions[row-1] else 0)

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
	if @_impl.pending
		return

	@_impl.pending = true
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

COLUMN = exports.COLUMN = 1<<0
ROW = exports.ROW = 1<<1
ALL = exports.ALL = (1<<2) - 1

exports.DATA =
	pending: false
	disableFill: true
	gridType: 0
	updatePending: false

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
