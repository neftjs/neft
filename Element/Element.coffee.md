View Structure Element
=======================

*Element* as a collection of elements.

	'use strict'

	[utils, expect] = ['utils', 'expect'].map require
	Emitter = require 'emitter'

	{isArray} = Array

*class* Element
----------------

	module.exports = class Element extends Emitter

		@__name__ = 'Element'
		@__path__ = 'File.Element'

### Static

#### *Element* fromHTML(*String*)

Create new *Element* instance based on *HTML*.
The whole structure will be returned.

		@fromHTML = (html) ->

			expect(html).toBe.truthy().string()

			Element.parser.parse html

### Constructor

Constructor is instance of *Events* class, so after every initializing
*INIT* event is triggered.

		constructor: ->

			@_parent = null

			super

### Properties

		Object.defineProperties @::,

#### index

			index:
				get: ->
					expect(@parent).toBe.any Element

					@parent.children.indexOf @

				set: (value) ->
					expect(@parent).toBe.any Element
					expect(value).toBe.integer()
					expect(value).not().toBe.lessThan 0
					expect(value).toBe.lessThan @parent.children.length

					@parent.children.splice @index, 1
					@parent.children.splice value, 0, @

#### *Element* parent

Link to other *Element*.
Value will automatically change `children`.

			parent:

				enumerable: true
				get: -> @_parent
				set: (value) ->

					expect(@).not().toBe value

					old = @_parent
					return if old is value

					# remove element
					if @_parent
						expect().some(@_parent.children).toBe @
						index = @_parent.children.indexOf @
						@_parent.children.splice index, 1

					@_parent = parent = value

					# append element
					if parent
						expect().some(@_parent.children).not().toBe @
						parent.children.push @

					# trigger event
					@trigger 'parentChanged', old

#### *Boolean* visible

			_visible:
				value: true
				writable: true

			visible:

				enumerable: true
				get: -> @_visible
				set: (value) ->

					expect(value).toBe.boolean()

					old = @_visible
					return if old is value

					@_visible = value

					if @children
						for child in @children
							child.visible = value

					# trigger event
					@trigger 'visibilityChanged', old

					null

### Methods

#### *Element* clone()

Returns new instance of *Element* with the same properties.

			clone:
				enumerable: true
				writable: true
				value: cloneMethod = ->

					clone = Object.create @

					clone._parent = null
					clone.clone = undefined
					clone.cloneDeep = undefined

					clone

			cloneDeep:
				enumerable: true
				writable: true
				value: cloneMethod

		if utils.isNode
			@parser = require('./element/parser') @
		@Tag = require('./element/tag') @
		@Text = require('./element/text') @

		# set Element as immutable
		Object.freeze @