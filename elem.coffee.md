View File Elem
==============

Goals
-----

Represents an element placed in the file.

	'use strict'

	assert = require 'assert'

*class* Elem
------------

	module.exports = (File) -> class Elem

### Constructor(*File*, *string*, *HTMLElement*)

		constructor: (@self, @name, @dom) ->

			assert self instanceof File
			assert typeof name is 'string'
			assert name
			assert dom.ownerDocument is File.DOC

### Properties

		name: ''
		self: null
		dom: null

### Methods

		toJSON: ->

			name: @name