'use strict'

MAX_LOOPS = 100

utils = require 'utils'
log = require 'log'

log = log.scope 'Renderer'

queueIndex = 0
queues = [[], []]
queue = queues[queueIndex]
pending = false

updateItem = (item) ->
	{children} = item
	data = item._impl

	data.fillUpdatePending = true

	unless data.fillWidth
		data.fillWidth = item.fill.width
	unless data.fillHeight
		data.fillHeight = item.fill.height

	if data.fillWidth
		tmp = 0
		size = 0
		for child in children
			if child._visible
				tmp = child._x + child._width
				if tmp > size
					size = tmp

		oldVal = item.fill.width
		item.width = size
		item.fill.width = oldVal

	if data.fillHeight
		tmp = 0
		size = 0
		for child in children
			if child._visible
				tmp = child._y + child._height
				if tmp > size
					size = tmp

		oldVal = item.fill.height
		item.height = size
		item.fill.height = oldVal

	if data.fillWidth
		data.fillWidth = item.fill.width
	if data.fillHeight
		data.fillHeight = item.fill.height

	data.fillUpdatePending = false

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

	if data.fillUpdatePending
		if data.fillUpdateLoops > MAX_LOOPS
			return

		if ++data.fillUpdateLoops is MAX_LOOPS
			log.warn "Potential Item::fill.* loop detected. Recalculating on this item (#{@toString()}) has been disabled."
			return
	else
		data.fillUpdateLoops = 0

	queue.push @

	unless pending
		setImmediate updateItems
		pending = true
	return

enableChild = (child) ->
	child.onVisibleChange update, @
	child.onWidthChange update, @
	child.onHeightChange update, @
	child.onXChange update, @
	child.onYChange update, @

disableChild = (child) ->
	child.onVisibleChange.disconnect update, @
	child.onWidthChange.disconnect update, @
	child.onHeightChange.disconnect update, @
	child.onXChange.disconnect update, @
	child.onYChange.disconnect update, @

exports.DATA =
	pending: false
	fillWidth: false
	fillHeight: false
	fillUpdatePending: false
	fillUpdateLoops: 0

exports.enable = (item) ->
	# update item changes
	item.onChildrenChange update

	for child in item.children
		enableChild.call item, child

	# update on each children size change
	item.children.onInsert enableChild, item
	item.children.onPop disableChild, item

	update.call item

exports.disable = (item) ->
	# update item changes
	item.onChildrenChange.disconnect update

	for child in item.children
		disableChild.call item, child

	# update on each children size change
	item.children.onInsert.disconnect enableChild, item
	item.children.onPop.disconnect disableChild, item

exports.update = update
