'use strict'

utils = require 'utils'

queueIndex = 0
queues = [[], []]
queue = queues[queueIndex]
queueItems = Object.create null
pending = false

updateItem = (item) ->
	{children} = item
	data = item._impl

	unless data.fillWidth
		data.fillWidth = item._fillWidth
	unless data.fillHeight
		data.fillHeight = item._fillHeight

	if data.fillWidth
		tmp = 0
		size = 0
		for child in children
			if child.visible
				tmp = child.width
				if tmp > size
					size = tmp

		oldVal = item._fillWidth
		item.width = size
		item._fillWidth = oldVal

	if data.fillHeight
		tmp = 0
		size = 0
		for child in children
			if child.visible
				tmp = child.height
				if tmp > size
					size = tmp

		oldVal = item._fillHeight
		item.height = size
		item._fillHeight = oldVal

	if data.fillWidth
		data.fillWidth = item._fillWidth
	if data.fillHeight
		data.fillHeight = item._fillHeight

	return

updateItems = ->
	pending = false
	currentQueue = queue
	queue = queues[++queueIndex % queues.length]

	while currentQueue.length
		item = currentQueue.pop()
		queueItems[item.__hash__] = false
		updateItem item
	return

update = ->
	if queueItems[@__hash__]
		return

	queueItems[@__hash__] = true
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
	fillWidth: false
	fillHeight: false

exports.enable = (item) ->
	# update item changes
	item.onChildrenChanged update

	for child in item.children
		enableChild.call item, child

	# update on each children size change
	item.children.onInserted enableChild
	item.children.onPopped disableChild

	update.call item

exports.disable = (item) ->
	# update item changes
	item.onChildrenChanged.disconnect update

	for child in item.children
		disableChild.call item, child

	# update on each children size change
	item.children.onInserted.disconnect enableChild
	item.children.onPopped.disconnect disableChild

exports.update = update
