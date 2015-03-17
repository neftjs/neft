'use strict'

utils = require 'utils'

queueIndex = 0
queues = [[], []]
queue = queues[queueIndex]
pending = false

updateItem = (item) ->
	{children} = item
	data = item._impl

	unless data.fillWidth
		data.fillWidth = item.fill.width
	unless data.fillHeight
		data.fillHeight = item.fill.height

	if data.fillWidth
		tmp = 0
		size = 0
		for child in children
			if child._visible
				tmp = child._width
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
				tmp = child._height
				if tmp > size
					size = tmp

		oldVal = item.fill.height
		item.height = size
		item.fill.height = oldVal

	if data.fillWidth
		data.fillWidth = item.fill.width
	if data.fillHeight
		data.fillHeight = item.fill.height

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
	queue.push @

	unless pending
		setImmediate updateItems
		pending = true
	return

enableChild = (child) ->
	child.onVisibleChanged update, @
	child.onWidthChanged update, @
	child.onHeightChanged update, @

disableChild = (child) ->
	child.onVisibleChanged.disconnect update, @
	child.onWidthChanged.disconnect update, @
	child.onHeightChanged.disconnect update, @

exports.DATA =
	pending: false
	fillWidth: false
	fillHeight: false

exports.enable = (item) ->
	# update item changes
	item.onChildrenChanged update

	for child in item.children
		enableChild.call item, child

	# update on each children size change
	item.children.onInserted enableChild, item
	item.children.onPopped disableChild, item

	update.call item

exports.disable = (item) ->
	# update item changes
	item.onChildrenChanged.disconnect update

	for child in item.children
		disableChild.call item, child

	# update on each children size change
	item.children.onInserted.disconnect enableChild, item
	item.children.onPopped.disconnect disableChild, item

exports.update = update
