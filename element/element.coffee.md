Element @virtual_dom
====================

	'use strict'

	utils = require 'utils'
	assert = require 'neft-assert'
	signal = require 'signal'

	{isArray} = Array
	SignalsEmitter = signal.Emitter

	assert = assert.scope 'View.Element'

	class Element extends SignalsEmitter
		@__name__ = 'Element'
		@__path__ = 'File.Element'

*Element* Element.fromHTML(*String* html)
-----------------------------------------

		@fromHTML = (html) ->
			assert.isString html

			unless utils.isNode
				throw "Creating Views from HTML files is allowed only on a server"

			Element.parser.parse html

*Element* Element()
-------------------

		constructor: ->
			@_parent = null
			@_visible = true
			@_nextSibling = null
			@_previousSibling = null

			super()

			Object.preventExtensions @

*Signal* Element::parentChanged(*Element* oldValue)
---------------------------------------------------

		SignalsEmitter.createSignal @, 'parentChanged'

*Signal* Element::visibilityChanged(*Boolean* oldValue)
-------------------------------------------------------

		SignalsEmitter.createSignal @, 'visibilityChanged'

		Object.defineProperties @::,

*Integer* Element::index
------------------------

			index:
				get: ->
					@parent?.children.indexOf(@) or 0
				set: (value) ->
					assert.instanceOf @parent, Element
					assert.isInteger value
					assert.operator value, '>=', 0
					assert.operator value, '<', @parent.children.length

					{index} = @
					if index is value or not @_parent
						return
					children = @_parent.children
					if children.length <= value
						value = children.length - 1

					@_previousSibling?._nextSibling = @_nextSibling
					@_nextSibling?._previousSibling = @_previousSibling

					@_previousSibling = children[value-1]
					@_nextSibling = children[value]
					@_previousSibling?._nextSibling = @
					@_nextSibling?._previousSibling = @

					children.splice index, 1
					if value > index
						value--

					children.splice value, 0, @
					return

*Element* Element::nextSibling
------------------------------

			nextSibling:
				get: ->
					@_nextSibling

*Element* Element::previousSibling
----------------------------------

			previousSibling:
				get: ->
					@_previousSibling

*Element* Element::parent
-------------------------

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
						if not @_nextSibling
							assert.ok @_parent.children[@_parent.children.length - 1] is @
							@_parent.children.pop()
						else if not @_previousSibling
							assert.ok @_parent.children[0] is @
							@_parent.children.shift()
						else
							index = @_parent.children.indexOf @
							@_parent.children.splice index, 1

						@_previousSibling?._nextSibling = @_nextSibling
						@_nextSibling?._previousSibling = @_previousSibling
						@_previousSibling = null
						@_nextSibling = null

					@_parent = parent = value

					# append element
					if parent
						assert.notOk utils.has(@_parent.children, @)
						index = parent.children.push(@)
						if index > 2
							@_previousSibling = parent.children[parent.children.length - 2]
							@_previousSibling._nextSibling = @

					# trigger signal
					@parentChanged old

*Boolean* Element::visible
--------------------------

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

*Element* Element::clone()
--------------------------

		clone: ->
			clone = new @constructor
			clone._visible = @visible
			clone

*Element* Element::cloneDeep()
------------------------------

		cloneDeep: ->
			@clone()

	if utils.isNode
		Element.parser = require('./element/parser') Element
	Element.Tag = require('./element/tag') Element
	Element.Text = require('./element/text') Element

	module.exports = Element
