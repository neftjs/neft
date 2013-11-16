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

		constructor: (@self, @name, @dom) ->

			assert self instanceof File
			assert name and typeof name is 'string'

### Properties

		name: ''
		self: null
		dom: null

### Methods

		clone: (self) ->

			proto = utils.clone @

			proto.self = self
			proto.dom = @self.dom.getCopiedElement @dom, self.dom

			proto

		toJSON: ->

			name: @name