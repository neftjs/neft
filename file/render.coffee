'use strict'

utils = require 'utils'
log = require 'log'

log = log.scope 'Styles'

module.exports = (File) ->

	queue = []
	pending = false

	updateItems = ->
		pending = false
		for style in queue
			style.findItemParent()
		utils.clear queue
		return

	File::render = do (_super = File::render) -> ->
		r = _super.apply @, arguments

		if @styles
			Array::push.apply queue, @styles
			unless pending
				setImmediate updateItems
				pending = true

		r
