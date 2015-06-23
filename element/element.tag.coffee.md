Tag @virtual_dom
================

	'use strict'

	utils = require 'utils'
	assert = require 'neft-assert'
	signal = require 'signal'
	stringify = require './tag/stringify'

	assert = assert.scope 'View.Element.Tag'

	isDefined = (elem) -> elem?

	CSS_ID_RE = ///\#([^\s]+)///

	module.exports = (Element) ->
		class Tag extends Element
			@Attrs = require('./tag/attrs') Element
			@extensions = Object.create null

			@__name__ = 'Tag'
			@__path__ = 'File.Element.Tag'

*Tag* Tag() : *Element*
-----------------------

			constructor: ->
				@children = []
				@name = ''
				@style = null
				@_documentStyle = null
				@_attrs = {}

				super()

*Signal* Tag::onAttrsChange(*Tag.Attrs* attrs)
----------------------------------------------

			signal.Emitter.createSignal @, 'onAttrsChange'

*Tag.Attrs* Tag::attrs
----------------------

			utils.defineProperty @::, 'attrs', null, ->
				Tag.Attrs.tag = @
				Tag.Attrs
			, null

			clone: ->
				clone = super()
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

			getCopiedElement: (lookForElement, copiedParent) ->
				assert.instanceOf @, Tag
				assert.instanceOf lookForElement, Element
				assert.instanceOf copiedParent, Element

				tmp = []

				# get indexes to parent
				elem = lookForElement
				while parent = elem._parent
					tmp.push parent.children.indexOf elem
					elem = parent
					break if elem is @

				# go by indexes in copied parent
				elem = copiedParent
				while tmp.length
					index = tmp.pop()
					elem = elem.children[index]

				elem

			query = require './tag/query'

*Array* Element::queryAll(*String* query)
-----------------------------------------

			queryAll: query.queryAll

*Element* Element::query(*String* query)
----------------------------------------

			query: query.query

*String* Element::stringify()
-----------------------------

			stringify: ->
				stringify.getOuterHTML @

*String* Element::stringifyChildren()
-------------------------------------

			stringifyChildren: ->
				stringify.getInnerHTML @

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

		Tag
