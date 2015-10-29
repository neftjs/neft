'use strict'

utils = require 'utils'
expect = require 'expect'
log = require 'log'
Document = require 'document'

if utils.isNode
	styleParseStyles = require('./parse/styles')

{isArray} = Array
{Element} = Document
{Tag} = Element

log = log.scope 'Styles'

module.exports = (File) ->

	if utils.isNode
		File.onParse do ->
			styles = styleParseStyles File
			(file) ->
				styles file

	File::styles = null

	renderStyles = (arr) ->
		for style in arr
			style.render()
		for style in arr
			renderStyles style.children
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
