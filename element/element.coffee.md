Element @virtual_dom
====================

	'use strict'

	utils = require 'utils'
	assert = require 'neft-assert'
	signal = require 'signal'

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
			@_nextSibling = null
			@_previousSibling = null

			super()

			Object.preventExtensions @

*Integer* Element::index
------------------------

		opts = utils.CONFIGURABLE
		utils.defineProperty @::, 'index', opts, ->
			@parent?.children.indexOf(@) or 0
		, (val) ->
			assert.instanceOf @parent, Element
			assert.isInteger val
			assert.operator val, '>=', 0

			parent = @_parent
			if not parent
				return false
			{index} = @
			children = parent.children
			if val > children.length
				val = children.length
			if index is val or index is val-1
				return false

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
			true

*Element* Element::nextSibling
------------------------------

		opts = utils.CONFIGURABLE
		utils.defineProperty @::, 'nextSibling', opts, ->
			@_nextSibling
		, null

*Element* Element::previousSibling
----------------------------------

		opts = utils.CONFIGURABLE
		utils.defineProperty @::, 'previousSibling', opts, ->
			@_previousSibling
		, null

*Element* Element::parent
-------------------------

		opts = utils.CONFIGURABLE
		utils.defineProperty @::, 'parent', opts, ->
			@_parent
		, (val) ->
			assert.instanceOf @, Element
			assert.instanceOf val, Element if val?
			assert.isNot @, val

			old = @_parent
			if old is val
				return false

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

			Tag.query.checkWatchersDeeply @

			true

*Signal* Element::onParentChange(*Element* oldValue)
----------------------------------------------------

		signal.Emitter.createSignal @, 'onParentChange'

*Element* Element::clone()
--------------------------

		clone: ->
			new @constructor

*Element* Element::cloneDeep()
------------------------------

		cloneDeep: ->
			@clone()

		@Tag = Tag = require('./element/tag') Element
		@Text = require('./element/text') Element
		if utils.isNode
			@parser = require('./element/parser') Element

	module.exports = Element
