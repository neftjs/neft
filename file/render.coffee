'use strict'

utils = require 'utils'
log = require 'log'
Renderer = require 'renderer'

log = log.scope 'Styles'

module.exports = (File) ->

	unless utils.isClient
		return

	queue = []
	pending = false

	updateItems = ->
		pending = false

		i = 0
		while i < queue.length
			queue[i].findItemParent()
			i++

		utils.clear queue

		return

	File::_render = do (_super = File::_render) -> ->
		r = _super.apply @, arguments

		if @styles
			Array::push.apply queue, @styles
			unless pending
				setImmediate updateItems
				pending = true

		r
