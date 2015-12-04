'use strict'

utils = require 'utils'
assert = require 'assert'

if utils.isNode
	styleParseStyles = require('./parse/styles')

module.exports = (File) ->

	if utils.isNode
		File.onParse do ->
			styles = styleParseStyles File
			(file) ->
				styles file

	File::styles = null

	renderStyles = do ->
		pending = false
		queue = []

		render = (arr) ->
			for style in arr
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
		if styles = file.styles
			renderStyles styles
		return

	revertStyles = (arr) ->
		for style in arr
			style.revert()
		for style in arr
			revertStyles style.children
		return

	File.onBeforeRevert (file) ->
		if styles = file.styles
			revertStyles styles
		return

	File::_clone = do (_super = File::_clone) -> ->
		clone = _super.call @

		# styles
		if @styles
			clone.styles = []
			for style, i in @styles
				cloned = clone.styles[i] = style.clone @, clone

		clone
