View Structure Element
=======================

*Element* as a collection of elements.

	'use strict'

	[utils, expect] = ['utils', 'expect'].map require
	[observer] = ['./observer'].map require

	{isArray} = Array

*class* Element
----------------

	module.exports = class Element

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

### Proeprties

		Object.defineProperties @::,

#### *Element* parent

Link to other *Element*.
Value will automatically change `children`.

			parent:

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

					# call observers
					@onParentChanged old

#### *Boolean* visible

			_visible:
				value: true
				writable: true

			visible:

				get: -> @_visible

				set: (value) ->

					expect(value).toBe.boolean()

					old = @_visible
					return if old is value

					@_visible = value

					if @children
						for child in @children
							child.visible = value

					# call observers
					@onVisibilityChanged old

					null

#### onParentChanged

			onParentChanged: observer.getPropertyDesc('onParentChanged')

#### onVisibilityChanged

			onVisibilityChanged: observer.getPropertyDesc('onVisibilityChanged')

### Methods

#### *Element* clone()

Returns new instance of *Element* with the same properties.

			clone: value: clone = ->

				clone = Object.create @

				clone._parent = null

				clone

			cloneDeep: value: clone

		if utils.isNode
			@parser = require('./element/parser') @
		@Tag = require('./element/tag') @
		@Text = require('./element/text') @