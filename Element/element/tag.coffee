'use strict'

[utils, expect, signal] = ['utils', 'expect', 'signal'].map require
[stringify] = ['./tag/stringify'].map require

isDefined = (elem) -> elem?

CSS_ID_RE = ///\#([^\s]+)///

module.exports = (Element) -> class Tag extends Element

	attrs = require('./tag/attrs') Element

	@__name__ = 'Tag'
	@__path__ = 'File.Element.Tag'

	constructor: ->

		super()

		@children = []
		@name = ''

	Object.defineProperties @::,

		clone: value: do (_super = @::clone) -> ->

			clone = _super.call @

			clone.children = []
			clone.attrsValues &&= utils.clone @attrsValues

			clone

		cloneDeep: value: ->

			clone = @clone()

			for child in @children
				clonedChild = child.cloneDeep()
				clonedChild.parent = clone

			clone

		attrs:

			get: ->

				attrs.tag = @
				attrs

		queryAll: value: do ->

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

				expect(selector).toBe.truthy().string()
				expect(target).toBe.array()

				utils.clear target
				return target unless @children

				# find by attr
				if attr = /^\[([^\]]+)\]$/.exec selector
					forChild @, byAttr, attr[1], target
				else
					# find by name
					forChild @, byName, selector, target

				target

		stringify: value: ->

			stringify.getOuterHTML @

		stringifyChildren: value: ->

			stringify.getInnerHTML @

		replace: value: (oldElement, newElement) ->

			expect(oldElement).toBe.any Element
			expect(newElement).toBe.any Element
			expect(oldElement.parent).toBe @

			index = @children.indexOf oldElement

			oldElement.parent = undefined
			newElement.parent = @

			@children.pop()
			@children.splice index, 0, newElement

			null

		getCopiedElement: value: do (tmp = []) -> (lookForElement, copiedParent) ->

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


	signal.create @::, 'onAttrChanged'
