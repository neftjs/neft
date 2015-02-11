'use strict'

utils = require 'utils'
assert = require 'assert'
signal = require 'signal'

{isArray} = Array
SignalsEmitter = signal.Emitter

assert = assert.scope 'View.Element'

class Element extends SignalsEmitter
	@__name__ = 'Element'
	@__path__ = 'File.Element'

	@fromHTML = (html) ->
		assert.isString html
		assert.notLengthOf html, 0

		unless utils.isNode
			throw "Creating Views from HTML files is allowed only on a server"

		Element.parser.parse html

	constructor: ->
		@_parent = null
		@_visible = true

		super()

		Object.preventExtensions @

	SignalsEmitter.createSignal @, 'parentChanged'
	SignalsEmitter.createSignal @, 'visibilityChanged'

	Object.defineProperties @::,

		index:
			get: ->
				@parent?.children.indexOf(@) or 0

			set: (value) ->
				assert.instanceOf @parent, Element
				assert.isInteger value
				assert.operator value, '>=', 0
				assert.operator value, '<', @parent.children.length

				@parent.children.splice @index, 1
				@parent.children.splice value, 0, @

		parent:
			get: ->
				@_parent
			set: (value) ->
				assert.instanceOf @, Element
				assert.instanceOf value, Element if value?
				assert.isNot @, value

				old = @_parent
				return if old is value

				# remove element
				if @_parent
					assert.ok utils.has(@_parent.children, @)
					index = @_parent.children.indexOf @
					@_parent.children.splice index, 1

				@_parent = parent = value

				# append element
				if parent
					assert.notOk utils.has(@_parent.children, @)
					parent.children.push @

				# trigger signal
				@parentChanged old

		visible:
			get: ->
				@_visible
			set: (val) ->
				assert.isBoolean val

				old = @_visible
				return if old is val

				@_visible = val

				# trigger signal
				@visibilityChanged old

				null

	clone: ->
		clone = new @constructor
		clone._visible = @visible
		clone

	cloneDeep: ->
		@clone()

if utils.isNode
	Element.parser = require('./element/parser') Element
Element.Tag = require('./element/tag') Element
Element.Text = require('./element/text') Element

module.exports = Element
