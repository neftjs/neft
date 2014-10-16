'use strict'

[utils, expect, log, View] = ['utils', 'expect', 'log', 'view'].map require

{isArray} = Array
{Element} = View
{Tag} = Element

log = log.scope 'Styles'

module.exports = (File, scopes) ->

	if utils.isNode
		File.onParsed do ->
			styles = require('./parse/styles') File
			(file) ->
				styles file

	File::styles = null

	File::render = do (_super = File::render) -> ->
		r = _super.call @

		# styles
		if @styles.length
			for style in @styles
				style.render()

		r

	File::revert = do (_super = File::revert) -> ->
		r = _super.call @

		# styles
		if @styles.length
			for style in @styles
				style.revert()

		r

	File::clone = do (_super = File::clone) -> ->
		clone = _super.call @

		# styles
		if @styles.length
			clone.styles = []
			for style, i in @styles
				cloned = clone.styles[i] = style.clone @, clone

		clone

	File.Style = require('../style') File, scopes