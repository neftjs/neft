'use strict'

utils = require 'utils'
assert = require 'assert'

module.exports = (File) ->
	renderStyles = do ->
		pending = false
		queue = []

		render = (arr) ->
			for style in arr
				unless style.isRendered
					style.render()
			for style in arr
				render style.children
			return

		renderAll = ->
			pending = false
			length = queue.length
			for arr in queue
				render arr
			assert.ok queue.length is length
			utils.clear queue
			return

		(arr) ->
			queue.push arr

			unless pending
				setImmediate renderAll
				pending = true
			return

	File.onBeforeRender (file) ->
		renderStyles file.styles
		return

	revertStyles = (arr) ->
		for style in arr
			style.revert()
		for style in arr
			revertStyles style.children
		return

	File.onBeforeRevert (file) ->
		revertStyles file.styles
		return

	File::_clone = do (_super = File::_clone) -> ->
		clone = _super.call @

		# styles
		for style, i in @styles
			clone.styles.push style.clone @, clone

		clone
