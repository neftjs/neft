'use strict'

utils = require 'utils'
assert = require 'assert'

module.exports = (File) ->
	renderStyles = (arr) ->
		for style in arr
			style.render()
		for style in arr
			renderStyles style.children
		return

	File.onRender (file) ->
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
