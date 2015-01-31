'use strict'

utils = require 'utils'

unless Uint32Array?
	Uint32Array = (len) ->
		arr = []
		for i in [0..len]
			arr[i] = 0
		arr

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
		if gridType & exports.ROW
			width += margin.left + margin.right + columnSpacing
		if gridType & exports.COLUMN
			height += margin.top + margin.bottom + rowSpacing

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
	i = 0
	for child in children
		unless child.visible
			continue

		column = i % columnsLen
		row = Math.floor(i/columnsLen) % rowsLen

		if gridType & exports.ROW
			child.x = child.margin.left + (if column > 0 then columnsPositions[column-1] else 0)

		if gridType & exports.COLUMN
			child.y = child.margin.top + (if row > 0 then rowsPositions[row-1] else 0)

		i++

	# set item size
	item._impl.updatePending = true
	if item._impl.autoWidth
		item.width = Math.max 0, (utils.last(columnsPositions) or 0)
	if item._impl.autoHeight
		item.height = Math.max 0, (utils.last(rowsPositions) or 0)
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

exports.COLUMN = 1<<0
exports.ROW = 1<<1
exports.ALL = (1<<2) - 1

exports.DATA =
	gridType: ''
	autoWidth: true
	autoHeight: true
	updatePending: false

exports.create = (item, type) ->
	storage = item._impl

	storage.gridType = type

	# auto size
	item.onWidthChanged ->
		unless @_impl.updatePending
			@_impl.autoWidth = @width is 0

	item.onHeightChanged ->
		unless @_impl.updatePending
			@_impl.autoHeight = @height is 0

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