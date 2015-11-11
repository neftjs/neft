Element @virtual_dom
====================

	'use strict'

	utils = require 'utils'
	assert = require 'neft-assert'
	signal = require 'signal'

	{isArray} = Array
	{Emitter} = signal
	{emitSignal} = Emitter

	assert = assert.scope 'View.Element'

	class Element extends Emitter
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
			Emitter.call this

			@_parent = null
			@_nextSibling = null
			@_previousSibling = null

			`//<development>`
			if @constructor is Element
				Object.preventExtensions @
			`//</development>`

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
				oldChildren = @_parent.children
				assert.ok utils.has(oldChildren, @)
				if not @_nextSibling
					assert.ok oldChildren[oldChildren.length - 1] is @
					oldChildren.pop()
				else if not @_previousSibling
					assert.ok oldChildren[0] is @
					oldChildren.shift()
				else
					index = oldChildren.indexOf @
					oldChildren.splice index, 1
				emitSignal @_parent, 'onChildrenChange', null, @

				@_previousSibling?._nextSibling = @_nextSibling
				@_nextSibling?._previousSibling = @_previousSibling
				@_previousSibling = null
				@_nextSibling = null

			@_parent = parent = val

			# append element
			if parent
				assert.notOk utils.has(@_parent.children, @)
				newChildren = @_parent.children
				index = newChildren.push(@) - 1
				emitSignal parent, 'onChildrenChange', @
				if index is 0
					@_previousSibling = null
				else
					@_previousSibling = newChildren[index - 1]
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

### *Signal* Element::onParentChange(*Element* oldValue)

		signal.Emitter.createSignal @, 'onParentChange'

*Element* Element::clone()
--------------------------

		clone: ->
			new Element

*Element* Element::cloneDeep()
------------------------------

		cloneDeep: ->
			@clone()

		@Tag = Tag = require('./element/tag') Element
		@Text = require('./element/text') Element
		if utils.isNode
			@parser = require('./element/parser') Element

	module.exports = Element
