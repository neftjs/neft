'use strict'

utils = require 'utils'
assert = require 'assert'
signal = require 'signal'
stringify = require './tag/stringify'

SignalsEmitter = signal.Emitter

assert = assert.scope 'View.Element.Tag'

isDefined = (elem) -> elem?

CSS_ID_RE = ///\#([^\s]+)///

module.exports = (Element) ->
	class Tag extends Element
		@Attrs = require('./tag/attrs') Element

		@__name__ = 'Tag'
		@__path__ = 'File.Element.Tag'

		constructor: ->
			@children = []
			@name = ''
			@_attrs = {}

			super()

		SignalsEmitter.createSignal @, 'attrsChanged'

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

			for child in @children
				clonedChild = child.cloneDeep()
				clone.children.push clonedChild
				clonedChild._parent = clone

			clone

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

		queryAll: do ->
			byName = (node, data) ->
				node.name is data

			byAttr = (node, data) ->
				node.attrs?.get(data) isnt undefined

			forChild = (node, testFunc, testFuncData, target) ->

				for child in node.children
					if testFunc child, testFuncData
						target.push child

					if child.children
						forChild child, testFunc, testFuncData, target

				null

			(selector, target=[]) ->
				assert.isString selector
				assert.notLengthOf selector, 0
				assert.isArray target

				utils.clear target
				return target unless @children

				# find by attr
				if attr = /^\[([^\]]+)\]$/.exec selector
					forChild @, byAttr, attr[1], target
				else
					# find by name
					forChild @, byName, selector, target

				target

		stringify: ->
			stringify.getOuterHTML @

		stringifyChildren: ->
			stringify.getInnerHTML @

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
