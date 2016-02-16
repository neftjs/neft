Tag @virtual_dom
================

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	signal = require 'signal'
	stringify = require './tag/stringify'
	TypedArray = require 'typed-array'

	{emitSignal} = signal.Emitter

	assert = assert.scope 'View.Element.Tag'

	isDefined = (elem) -> elem?

	CSS_ID_RE = ///\#([^\s]+)///

	module.exports = (Element) -> class Tag extends Element
		@INTERNAL_TAGS = ['neft:attr', 'neft:fragment', 'neft:function', 'neft:rule',
		'neft:target', 'neft:use', 'neft:require', 'neft:blank', 'neft:log']

		@DEFAULT_STRINGIFY_REPLACEMENTS = Object.create null

		@extensions = Object.create null

		@__name__ = 'Tag'
		@__path__ = 'File.Element.Tag'

		JSON_CTOR_ID = @JSON_CTOR_ID = Element.JSON_CTORS.push(Tag) - 1

		i = Element.JSON_ARGS_LENGTH
		JSON_NAME = i++
		JSON_CHILDREN = i++
		JSON_ATTRS = i++
		JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

		@_fromJSON = (arr, obj=new Tag) ->
			Element._fromJSON arr, obj
			obj.name = arr[JSON_NAME]
			obj.attrs._data = arr[JSON_ATTRS]

			for child in arr[JSON_CHILDREN]
				Element.fromJSON(child).parent = obj

			obj

*Tag* Tag() : *Element*
-----------------------

		constructor: ->
			Element.call this

			@name = 'neft:blank'
			@children = []
			@attrs = new Attrs @

			`//<development>`
			if @constructor is Tag
				Object.preventExtensions @
			`//</development>`

*String* Tag::name
------------------

*Array* Tag::children
---------------------

## *Signal* Tag::onChildrenChange(*Element* added, *Element* removed)

		signal.Emitter.createSignal @, 'onChildrenChange'

*Attrs* Tag::attrs
------------------

## *Signal* Tag::onAttrsChange(*String* attribute, *Any* oldValue)

		signal.Emitter.createSignal @, 'onAttrsChange'

		clone: (clone = new Tag) ->
			super clone
			clone.name = @name
			utils.merge clone.attrs._data, @attrs._data
			clone

*Tag* Tag::cloneDeep()
----------------------

		cloneDeep: ->
			clone = @clone()

			prevClonedChild = null
			for child in @children
				if child instanceof Tag
					clonedChild = child.cloneDeep()
				else
					clonedChild = child.clone()
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

				# walk by indexes in copied parent
				elem = copiedParent
				while i-- > 0
					index = arr[i]
					elem = elem.children[index]

				elem

*Tag* Tag::getChildByAccessPath(*Array* accessPath)
---------------------------------------------------

		getChildByAccessPath: (arr) ->
			assert.isArray arr

			elem = @
			for i in arr by -1
				unless elem = elem.children[i]
					return null

			elem

*Array* Tag::queryAll(*String* query, [*Function* onElement, *Any* onElementContext])
-------------------------------------------------------------------------------------

		@query = query = require('./tag/query') Element, @

		queryAll: query.queryAll

*Element* Tag::query(*String* query)
------------------------------------

		query: query.query

*Watcher* Tag::watch(*String* query)
------------------------------------

```javascript
var watcher = doc.watch('div > * > b[attr]');
watcher.onAdd(function(tag){});
watcher.onRemove(function(tag){});
watcher.disconnect();
```

		watch: query.watch

*String* Tag::stringify([*Object* replacements])
------------------------------------------------

		stringify: (replacements=Tag.DEFAULT_STRINGIFY_REPLACEMENTS) ->
			stringify.getOuterHTML @, replacements

*String* Tag::stringifyChildren([*Object* replacements])
--------------------------------------------------------

		stringifyChildren: (replacements=Tag.DEFAULT_STRINGIFY_REPLACEMENTS) ->
			stringify.getInnerHTML @, replacements

Tag::replace(*Element* oldElement, *Element* newElement)
--------------------------------------------------------

		replace: (oldElement, newElement) ->
			assert.instanceOf oldElement, Element
			assert.instanceOf newElement, Element
			assert.is oldElement.parent, @

			index = @children.indexOf oldElement

			oldElement.parent = undefined

			newElement.parent = @
			newElement.index = index

			null

		toJSON: (arr) ->
			unless arr
				arr = new Array JSON_ARGS_LENGTH
				arr[0] = JSON_CTOR_ID
			super arr
			arr[JSON_NAME] = @name
			children = arr[JSON_CHILDREN] = []
			arr[JSON_ATTRS] = @attrs._data

			for child in @children
				children.push child.toJSON()

			arr

*Attrs* Attrs()
---------------

		class Attrs
			constructor: (@_ref) ->
				@_data = {}
				Object.preventExtensions @

*Array* Attrs::item(*Integer* index, [*Array* target])
------------------------------------------------------

			item: (index, target=[]) ->
				assert.isArray target

				target[0] = target[1] = undefined

				i = 0
				for key, val of @_data
					if i is index
						target[0] = key
						target[1] = val
						break
					i++

				target

*Boolean* Attrs::has(*String* name)
-----------------------------------

			has: (name) ->
				assert.isString name
				assert.notLengthOf name, 0

				@_data.hasOwnProperty name

*Any* Attrs::get(*String* name)
-------------------------------

			get: (name) ->
				assert.isString name
				assert.notLengthOf name, 0

				@_data[name]

*Any* Attrs::set(*String* name, *Any* value)
--------------------------------------------

			set: (name, value) ->
				assert.isString name
				assert.notLengthOf name, 0

				# save change
				old = @_data[name]
				if old isnt value
					@_data[name] = value

					# trigger event
					emitSignal @_ref, 'onAttrsChange', name, old
					query.checkWatchersDeeply @_ref

				value
