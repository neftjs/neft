View File Text
==============

	'use strict'

	assert = require 'assert'
	utils = require 'utils/index.coffee.md'

*class* Text
------------

	module.exports = (File) -> class Text

### Constructor(*File*, *string*, *HTMLElement*)

		constructor: (@self, @prop, @dom, @valueDom) ->

			assert self instanceof File
			assert prop and typeof prop is 'string'
			assert dom instanceof File.Element
			assert valueDom instanceof File.Element

### Properties

		prop: ''
		self: null # File, parent of dom
		dom: null # dom where valueDom is placed
		valueDom: null

### Methods

		clone: (self) ->

			proto = utils.clone @

			proto.self = self
			proto.dom = @self.dom.getCopiedElement @dom, self.dom
			proto.valueDom = @dom.getCopiedElement @valueDom, proto.dom

			proto

		toJSON: ->

			prop: @prop