'use strict'

utils = require 'utils'

module.exports = (File) -> class Log
	@__name__ = 'Log'
	@__path__ = 'File.Log'

	constructor: (@node) ->
		@self = null
		Object.preventExtensions @

	render: ->
		if utils.isEmpty(@node._attrs)
			console.log @node.stringifyChildren()
		else
			log = [@node.stringifyChildren()]
			for key, val of @node._attrs
				log.push "#{key}=", val
			console.log.apply console, log
		return

	log: ->
		if @self.isRendered
			@render()

	listenOnTextChange = (node, log) ->
		if node instanceof File.Element.Text
			node.onTextChange log.log, log
		else
			for child in node.children
				listenOnTextChange child, log
		return

	clone: (original, self) ->
		node = original.node.getCopiedElement @node, self.node

		clone = new @constructor node
		clone.self = self

		node.onAttrsChange @log, clone
		listenOnTextChange node, clone

		clone
