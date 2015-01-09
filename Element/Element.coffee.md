File.Element @low-level API
===========================

*Element* as a collection of elements.

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	Emitter = require './emitter'

	{isArray} = Array

	assert = assert.scope 'View.Element'

	module.exports = class Element extends Emitter
		@__name__ = 'Element'
		@__path__ = 'File.Element'

*Element* Element.fromHTML(*String* html)
-----------------------------------------

Creates new `Element` instance based on given *html*.

		@fromHTML = (html) ->
			assert.isString html
			assert.notLengthOf html, 0

			unless utils.isNode
				throw "Creating Views from HTML files is allowed only on a server"

			Element.parser.parse html

*Element* Element()
-------------------

**Extends:** `Emitter`

		constructor: ->
			@_parent = null

			super

		Object.defineProperties @::,

*Integer* Element::index
------------------------

			index:
				get: ->
					assert.instanceOf @parent, Element

					@parent.children.indexOf @

				set: (value) ->
					assert.instanceOf @parent, Element
					assert.isInteger value
					assert.operator value, '>=', 0
					assert.operator value, '<', @parent.children.length

					@parent.children.splice @index, 1
					@parent.children.splice value, 0, @

*[Element]* Element::parent
---------------------------

Returns `Element` in which an element is placed.

Change the value to move the element.

			parent:
				enumerable: true
				get: -> @_parent
				set: (value) ->
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

					# trigger event
					Emitter.trigger @, Emitter.PARENT_CHANGED, old

*Boolean* Element::visible
--------------------------

			_visible:
				value: true
				writable: true

			visible:
				enumerable: true
				get: ->
					@_visible
				set: (val) ->
					assert.isBoolean val

					old = @_visible
					return if old is val

					@_visible = val

					if @children
						for child in @children
							child.visible = val

					# trigger event
					Emitter.trigger @, Emitter.VISIBILITY_CHANGED, old

					null

*Element* Element::clone()
--------------------------

Returns new instance of the `Element` with the same properties.

Parent of the returned `Element` is `null`.

			clone:
				enumerable: true
				writable: true
				value: cloneMethod = ->
					clone = Object.create @
					clone._parent = null
					clone.clone = undefined
					clone.cloneDeep = undefined
					clone

*Element* Element::cloneDeep()
------------------------------

			cloneDeep:
				enumerable: true
				writable: true
				value: cloneMethod

		if utils.isNode
			@parser = require('./element/parser') @
		@Tag = require('./element/tag') @
		@Text = require('./element/text') @
