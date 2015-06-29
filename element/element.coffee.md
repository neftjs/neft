Element @virtual_dom
====================

	'use strict'

	utils = require 'utils'
	assert = require 'neft-assert'
	signal = require 'signal'
	tagQuery = require './element/tag/query'

	{isArray} = Array
	{emitSignal} = signal.Emitter

	assert = assert.scope 'View.Element'

	class Element extends signal.Emitter
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

*Signal* Element::onParentChange(*Element* oldValue)
----------------------------------------------------

		signal.Emitter.createSignal @, 'onParentChange'

*Signal* Element::onVisibleChange(*Boolean* oldValue)
--------------------------------------------------------

		signal.Emitter.createSignal @, 'onVisibleChange'

		Object.defineProperties @::,

*Integer* Element::index
------------------------

			index:
				get: ->
					@parent?.children.indexOf(@) or 0
				set: (val) ->
					assert.instanceOf @parent, Element
					assert.isInteger val
					assert.operator val, '>=', 0

					parent = @_parent
					if not parent
						return
					{index} = @
					children = parent.children
					if val > children.length
						val = children.length
					if index is val or index is val-1
						return

					# current siblings
					@_previousSibling?._nextSibling = @_nextSibling
					@_nextSibling?._previousSibling = @_previousSibling

					# children array
					children.splice index, 1
					if val > index
						val--
					children.splice val, 0, @

					# new siblings
					@_previousSibling = children[val-1] or null
					@_nextSibling = children[val+1] or null
					@_previousSibling?._nextSibling = @
					@_nextSibling?._previousSibling = @

					assert.is @index, val
					assert.is children[val], @
					assert.is @_previousSibling, children[val-1] or null
					assert.is @_nextSibling, children[val+1] or null
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
				set: (val) ->
					assert.instanceOf @, Element
					assert.instanceOf val, Element if val?
					assert.isNot @, val

					old = @_parent
					return if old is val

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

					@_parent = parent = val

					# append element
					if parent
						assert.notOk utils.has(@_parent.children, @)
						index = parent.children.push(@) - 1
						if index is 0
							@_previousSibling = null
						else
							@_previousSibling = parent.children[index - 1]
							@_previousSibling._nextSibling = @

					assert.is @_parent, val
					assert.is @_nextSibling, null
					assert.is @_previousSibling, val?.children[val.children.length - 2] or null
					if @_previousSibling
						assert.is @_previousSibling._nextSibling, @

					# trigger signal
					emitSignal @, 'onParentChange', old

					tagQuery.checkWatchersDeeply @

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
					emitSignal @, 'onVisibleChange', old

					null

*Element* Element::clone()
--------------------------

		clone: ->
			clone = new @constructor
			clone._visible = @_visible
			clone

*Element* Element::cloneDeep()
------------------------------

		cloneDeep: ->
			@clone()

	Element.Tag = require('./element/tag') Element
	Element.Text = require('./element/text') Element
	if utils.isNode
		Element.parser = require('./element/parser') Element

	module.exports = Element
