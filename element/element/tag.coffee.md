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
			obj._attrs = arr[JSON_ATTRS]

			for child in arr[JSON_CHILDREN]
				Element.fromJSON(child).parent = obj

			obj

*Tag* Tag() : *Element*
-----------------------

		constructor: ->
			Element.call this

			@name = 'neft:blank'
			@children = []
			@_attrs = {}

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

## *Signal* Tag::onAttrsChange(*String* name, *Any* oldValue)

		signal.Emitter.createSignal @, 'onAttrsChange'

*Array* Tag::getAttrByIndex(*Integer* index, [*Array* target])
--------------------------------------------------------------

		getAttrByIndex: (index, target=[]) ->
			assert.isArray target

			target[0] = target[1] = undefined

			i = 0
			for key, val of @_attrs
				if i is index
					target[0] = key
					target[1] = val
					break
				i++

			target

*Boolean* Tag::hasAttr(*String* name)
-------------------------------------

		hasAttr: (name) ->
			assert.isString name
			assert.notLengthOf name, 0

			@_attrs.hasOwnProperty name

*Any* Tag::getAttr(*String* name)
---------------------------------

		getAttr: (name) ->
			assert.isString name
			assert.notLengthOf name, 0

			@_attrs[name]

*Boolean* Tag::setAttr(*String* name, *Any* value)
--------------------------------------------------

		setAttr: (name, value) ->
			assert.isString name
			assert.notLengthOf name, 0

			# save change
			old = @_attrs[name]
			if old is value
				return false

			@_attrs[name] = value

			# trigger event
			emitSignal @, 'onAttrsChange', name, old
			query.checkWatchersDeeply @

			true

		clone: (clone = new Tag) ->
			super clone
			clone.name = @name
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
			arr[JSON_ATTRS] = @_attrs

			for child in @children
				children.push child.toJSON()

			arr
