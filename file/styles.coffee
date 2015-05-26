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
		File.onParsed do ->
			styles = styleParseStyles File
			(file) ->
				styles file

	File::styles = null

	File::_render = do (_super = File::_render) -> ->
		r = _super.apply @, arguments

		# styles
		if @styles.length
			for style in @styles
				style.render()

		r

	File::revert = do (_super = File::revert) -> ->
		r = _super.apply @, arguments

		# styles
		if @styles.length
			for style in @styles
				style.revert()

		r

	File::_clone = do (_super = File::_clone) -> ->
		clone = _super.call @

		# styles
		if @styles.length
			clone.styles = []
			for style, i in @styles
				cloned = clone.styles[i] = style.clone @, clone

		clone
