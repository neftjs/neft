Tag @virtual_dom
================

	'use strict'

	utils = require 'utils'
	assert = require 'neft-assert'
	signal = require 'signal'
	stringify = require './tag/stringify'
	TypedArray = require 'typed-array'
	Renderer = require 'renderer'

	{emitSignal} = signal.Emitter

	assert = assert.scope 'View.Element.Tag'

	isDefined = (elem) -> elem?

	CSS_ID_RE = ///\#([^\s]+)///

	module.exports = (Element) -> class Tag extends Element
		@INTERNAL_TAGS = ['neft:attr', 'neft:fragment', 'neft:function', 'neft:rule',
		'neft:target', 'neft:use', 'neft:require', 'neft:blank', 'neft:log']

		@DEFAULT_STRINGIFY_REPLACEMENTS = Object.create null

		@Attrs = require('./tag/attrs') Tag
		@extensions = Object.create null

		@__name__ = 'Tag'
		@__path__ = 'File.Element.Tag'

*Tag* Tag() : *Element*
-----------------------

		constructor: ->
			Element.call this

			@children = []
			@name = 'neft:blank'
			@_style = null
			@_documentStyle = null
			@_visible = true
			@_attrs = {}

			@_inWatchers = null
			@_checkWatchers = 0

			`//<development>`
			if @constructor is Tag
				Object.preventExtensions @
			`//</development>`

*Array* Tag::children
---------------------

### *Signal* Tag::onChildrenChange(*Element* added, *Element* removed)

		signal.Emitter.createSignal @, 'onChildrenChange'

*Renderer.Item* Tag::style
--------------------------

		opts = utils.CONFIGURABLE
		utils.defineProperty @::, 'style', opts, ->
			@_style
		, (val) ->
			if val?
				assert.instanceOf val, Renderer.Item

			old = @_style
			if old is val
				return false

			@_style = val

			# trigger signal
			emitSignal @, 'onStyleChange', old, val
			true

### *Signal* Tag::onStyleChange(*Renderer.Item* oldValue)

		signal.Emitter.createSignal @, 'onStyleChange'

*Boolean* Tag::visible
----------------------

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

### *Signal* Tag::onVisibleChange(*Boolean* oldValue)

		signal.Emitter.createSignal @, 'onVisibleChange'

*Tag.Attrs* Tag::attrs
----------------------

		utils.defineProperty @::, 'attrs', null, ->
			Tag.Attrs.tag = @
			Tag.Attrs
		, null

### *Signal* Tag::onAttrsChange(*String* name, *Any* oldValue)

		signal.Emitter.createSignal @, 'onAttrsChange'

		clone: ->
			clone = new Tag
			clone.name = @name
			clone._visible = @_visible
			clone._attrs = utils.cloneDeep @_attrs
			clone

		cloneDeep: ->
			clone = @clone()

			prevClonedChild = null
			for child in @children
				clonedChild = child.cloneDeep()
				clone.children.push clonedChild
				clonedChild._parent = clone
				if clonedChild._previousSibling = prevClonedChild
					prevClonedChild._nextSibling = clonedChild
				prevClonedChild = clonedChild

			clone

*Element* Tag::getCopiedElement(*Element* lookForElement, *Element* copiedParent)
---------------------------------------------------------------------------------

		getCopiedElement: do ->
			arr = new TypedArray.Uint16 256
			(lookForElement, copiedParent) ->
				assert.instanceOf @, Tag
				assert.instanceOf lookForElement, Element
				assert.instanceOf copiedParent, Element

				if lookForElement is @
					return copiedParent

				i = 0

				# get indexes to parent
				elem = lookForElement
				while parent = elem._parent
					arr[i++] = parent.children.indexOf elem
					elem = parent
					if elem is @
						break

				# go by indexes in copied parent
				elem = copiedParent
				while i-- > 0
					index = arr[i]
					elem = elem.children[index]

				elem

		@query = query = require('./tag/query') @

*Array* Element::queryAll(*String* query)
-----------------------------------------

		queryAll: query.queryAll

*Element* Element::query(*String* query)
----------------------------------------

		query: query.query

*Array* Element::queryAllParents(*String* query)
------------------------------------------------

		queryAllParents: query.queryAllParents

*Element* Element::queryParents(*String* query)
-----------------------------------------------

		queryParents: query.queryParents

*Watcher* Element::watch(*String* query)
----------------------------------------

```
var watcher = doc.watch('div > * > b[attr]');
watcher.onAdd(function(tag){
});
watcher.onRemove(function(tag){
});
```

		watch: query.watch

*String* Element::stringify([*Object* replacements])
----------------------------------------------------

		stringify: (replacements=Tag.DEFAULT_STRINGIFY_REPLACEMENTS) ->
			stringify.getOuterHTML @, replacements

*String* Element::stringifyChildren([*Object* replacements])
------------------------------------------------------------

		stringifyChildren: (replacements=Tag.DEFAULT_STRINGIFY_REPLACEMENTS) ->
			stringify.getInnerHTML @, replacements

Element::replace(*Element* oldElement, *Element* newElement)
------------------------------------------------------------

		replace: (oldElement, newElement) ->
			assert.instanceOf oldElement, Element
			assert.instanceOf newElement, Element
			assert.is oldElement.parent, @

			index = @children.indexOf oldElement

			oldElement.parent = undefined

			newElement.parent = @
			newElement.index = index

			null
