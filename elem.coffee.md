View File Elem
==============

Goals
-----

Represents an element placed in the file.

	'use strict'

	assert = require 'assert'
	utils = require 'utils/index.coffee.md'

*class* Elem
------------

	module.exports = (File) -> class Elem

### Constructor(*File*, *string*, *HTMLElement*)

		constructor: (@self, @name, @node) ->

			assert self instanceof File
			assert name and typeof name is 'string'

			# call init
			@init()

### Properties

		name: ''
		self: null
		node: null

### Methods

		init: ->

		clone: (self) ->

			proto = utils.clone @

			proto.self = self
			proto.node = @self.node.getCopiedElement @node, self.node

			proto

		toJSON: ->

			name: @name