'use strict'

utils = require 'utils'

queue = []
queueItems = {}
pending = false

updateItem = (item) ->
	{children} = item
	{gridType} = item._impl

	# get config
	columnSpacing = rowSpacing = 0

	switch gridType
		when exports.ALL
			columnsLen = item.columns
			rowsLen = item.rows
			columnSpacing = item.spacing.column
			rowSpacing = item.spacing.row
		when exports.COLUMN
			rowSpacing = item.spacing
			columnsLen = 1
			rowsLen = Infinity
		when exports.ROW
			columnSpacing = item.spacing
			columnsLen = Infinity
			rowsLen = 1

	# get tmp arrays
	maxColumnsLen = if columnsLen is Infinity then children.length else columnsLen
	columnsPositions = new Uint32Array maxColumnsLen

	maxRowsLen = if rowsLen is Infinity then children.length / columnsLen else rowsLen
	rowsPositions = new Uint32Array maxRowsLen

	maxColumn = 0
	maxRow = 0
	rightMargin = 0
	bottomMargin = 0

	# get sizes
	i = 0
	for child in children
		# omit not visible children
		unless child.visible
			continue

		column = i % columnsLen
		row = Math.floor(i/columnsLen) % rowsLen

		# max column / row
		if column > maxColumn
			maxColumn = column
			rightMargin = 0
		if row > maxRow
			maxRow = row
			bottomMargin = 0

		# child
		{width, height, margin} = child

		# right / bottom margins
		rightMargin = Math.max rightMargin, margin.right + columnSpacing
		width += rightMargin
		bottomMargin = Math.max bottomMargin, margin.bottom + rowSpacing
		height += bottomMargin

		# left / top margins
		if column > 0
			width += margin.left
		if row > 0
			height += margin.top

		# save
		if width > columnsPositions[column]
			columnsPositions[column] = width
		if height > rowsPositions[row]
			rowsPositions[row] = height

		i++

	# sum columns positions
	last = 0
	for column, i in columnsPositions
		last = columnsPositions[i] += last

	# sum rows positions
	last = 0
	for row, i in rowsPositions
		last = rowsPositions[i] += last

	# set positions
	for child, i in children
		column = i % columnsLen
		row = Math.floor(i/columnsLen) % rowsLen

		if column > 0 and gridType & exports.ROW
			child.x = columnsPositions[column-1] + child.margin.left

		if row > 0 and gridType & exports.COLUMN
			child.y = rowsPositions[row-1] + child.margin.top

	# set item size
	item.width = Math.max 0, (utils.last(columnsPositions) or 0) - rightMargin
	item.height = Math.max 0, (utils.last(rowsPositions) or 0) - bottomMargin

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

exports.COLUMN = 1<<0
exports.ROW = 1<<1
exports.ALL = (1<<2) - 1

exports.create = (item, type) ->
	storage = item._impl

	storage.gridType = type

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