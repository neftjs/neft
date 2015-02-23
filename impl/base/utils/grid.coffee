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

queue = []
queueItems = Object.create null
pending = false

columnsPositions = new Uint32TypedArray 12
rowsPositions = new Uint32TypedArray 64

updateItem = (item) ->
	{children} = item
	{gridType} = item._impl

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

	maxRowsLen = if rowsLen is Infinity then children.length / columnsLen else rowsLen
	if rowsPositions.length < maxRowsLen
		rowsPositions = new Uint32TypedArray maxRowsLen
	else
		for i in [0...maxRowsLen] by 1
			rowsPositions[i] = 0

	# get sizes
	i = 0
	for child in children
		# omit not visible children
		unless child.visible
			continue

		column = i % columnsLen
		row = Math.floor(i/columnsLen) % rowsLen

		# child
		{width, height, margin} = child

		# right / bottom margins
		if gridType & ROW
			width += margin.left + margin.right + columnSpacing
		if gridType & COLUMN
			height += margin.top + margin.bottom + rowSpacing

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

	# sum rows positions
	last = 0
	for i in [0...maxRowsLen] by 1
		last = rowsPositions[i] += last

	# set positions
	i = 0
	for child in children
		unless child.visible
			continue

		column = i % columnsLen
		row = Math.floor(i/columnsLen) % rowsLen

		if gridType & ROW
			child.x = child.margin.left + (if column > 0 then columnsPositions[column-1] else 0)

		if gridType & COLUMN
			child.y = child.margin.top + (if row > 0 then rowsPositions[row-1] else 0)

		i++

	# set item size
	item._impl.updatePending = true
	if item._impl.autoWidth
		width = columnsPositions[maxColumnsLen-1]
		if width > 0	
			item.width = width
		else
			item.width = 0
	if item._impl.autoHeight
		height = rowsPositions[maxRowsLen-1]
		if height > 0
			item.height = height
		else
			item.height = 0
	item._impl.updatePending = false

updateItems = ->
	pending = false
	while queue.length
		item = queue.pop()
		queueItems[item.__hash__] = false
		updateItem item
	null

update = ->
	if queueItems[@__hash__]
		return

	queueItems[@__hash__] = true
	queue.push @

	unless pending
		setImmediate updateItems
		pending = true

updateParent = ->
	update.call @parent

onWidthChanged = ->
	unless @_impl.updatePending
		@_impl.autoWidth = @width is 0

onHeightChanged = ->
	unless @_impl.updatePending
		@_impl.autoHeight = @height is 0

COLUMN = exports.COLUMN = 1<<0
ROW = exports.ROW = 1<<1
ALL = exports.ALL = (1<<2) - 1

exports.DATA =
	gridType: 0
	autoWidth: true
	autoHeight: true
	updatePending: false

exports.create = (item, type) ->
	item._impl.gridType = type

	# auto size
	item.onWidthChanged onWidthChanged
	item.onHeightChanged onHeightChanged

	# update on children change
	item.onChildrenChanged update

	# update on each children size change
	item.children.onInserted (item, i) ->
		item.onVisibleChanged updateParent
		item.onWidthChanged updateParent
		item.onHeightChanged updateParent
		item.onMarginChanged updateParent

	item.children.onPopped (item, i) ->
		item.onVisibleChanged.disconnect updateParent
		item.onWidthChanged.disconnect updateParent
		item.onHeightChanged.disconnect updateParent
		item.onMarginChanged.disconnect updateParent

exports.update = update
