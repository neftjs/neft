Element @virtual_dom
====================

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	signal = require 'signal'

	{isArray} = Array
	{Emitter} = signal
	{emitSignal} = Emitter

	assert = assert.scope 'View.Element'

	class Element extends Emitter
		@__name__ = 'Element'
		@__path__ = 'File.Element'

		@JSON_CTORS = []
		JSON_CTOR_ID = @JSON_CTOR_ID = @JSON_CTORS.push(Element) - 1

		i = 1
		JSON_VISIBLE = i++
		JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

*Element* Element.fromHTML(*String* html)
-----------------------------------------

		@fromHTML = (html) ->
			assert.isString html

			unless utils.isNode
				throw "Creating Views from HTML files is allowed only on a server"

			Element.parser.parse html

*Element* Element.fromJSON(*Array|String* json)
-----------------------------------------------

		@fromJSON = (json) ->
			if typeof json is 'string'
				json = JSON.parse json

			assert.isArray json
			Element.JSON_CTORS[json[0]]._fromJSON json

		@_fromJSON = (arr, obj=new Element) ->
			obj.visible = arr[JSON_VISIBLE] is 1
			obj

		@Text = require('./element/text') Element
		@Tag = Tag = require('./element/tag') Element

*Element* Element()
-------------------

		constructor: ->
			Emitter.call this

			@_parent = null
			@_nextSibling = null
			@_previousSibling = null
			@_style = null
			@_documentStyle = null
			@_visible = true

			@_inWatchers = null
			@_checkWatchers = 0

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

## *Signal* Element::onParentChange(*Element* oldValue)

		signal.Emitter.createSignal @, 'onParentChange'

*Renderer.Item* Element::style
------------------------------

		opts = utils.CONFIGURABLE
		utils.defineProperty @::, 'style', opts, ->
			@_style
		, (val) ->
			old = @_style
			if old is val
				return false

			@_style = val

			# trigger signal
			emitSignal @, 'onStyleChange', old, val
			true

## *Signal* Element::onStyleChange(*Renderer.Item* oldValue)

		signal.Emitter.createSignal @, 'onStyleChange'

*Boolean* Element::visible
--------------------------

		opts = utils.CONFIGURABLE
		utils.defineProperty @::, 'visible', opts, ->
			@_visible
		, (val) ->
			assert.isBoolean val

			old = @_visible
			if old is val
				return false

			@_visible = val

			# trigger signal
			emitSignal @, 'onVisibleChange', old
			true

## *Signal* Element::onVisibleChange(*Boolean* oldValue)

		signal.Emitter.createSignal @, 'onVisibleChange'

*Array* Element::queryAllParents(*String* query)
------------------------------------------------

		queryAllParents: Tag.query.queryAllParents

*Element* Element::queryParents(*String* query)
-----------------------------------------------

		queryParents: Tag.query.queryParents

*Array* Element::getAccessPath([*Tag* toParent])
------------------------------------------------

		getAccessPath: (toParent) ->
			if toParent?
				assert.instanceOf toParent, Tag

			arr = []

			i = 0
			elem = @
			parent = @
			while parent = elem._parent
				arr.push parent.children.indexOf(elem)
				elem = parent
				if parent is toParent
					break

			arr

*Element* Element::clone()
--------------------------

		clone: (clone = new Element) ->
			clone._visible = @_visible
			clone

*Array* Element::toJSON()
-------------------------

		toJSON: (arr) ->
			unless arr
				arr = new Array JSON_ARGS_LENGTH
				arr[0] = JSON_CTOR_ID
			arr[JSON_VISIBLE] = if @visible then 1 else 0
			arr

		if utils.isNode
			@parser = require('./element/parser') Element

	module.exports = Element
