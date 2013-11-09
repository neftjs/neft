'use strict'

htmlparser = require 'htmlparser2'
domutils = require 'domutils'
utils = require 'utils/index.coffee.md'

forEach = Array::forEach

MAIN_ELEMENT_NAME = 'div'

module.exports = ->

	factory: ->

		node = @_node ?=
			type: 'tag'
			name: MAIN_ELEMENT_NAME
			attribs: null
			children: null
			parent: null
		node._element = @

	parseHTML: parseHTML = (html) ->

		Element = @constructor
		node = @_node

		handler = new htmlparser.DomHandler (err, dom) =>
			
			if err then throw err

			# move all nodes into document
			node.children = dom
			elem.parent = node for elem in dom when elem.parent?

			# for all nodes
			forNode = (node) ->

				# create new Element
				element = node._element = new Element
				element.parent = @
				element._node = node
				element.name = node.name or "##{node.type}"

				# for nodes recursively
				if node.type is 'tag'
					forNodes element, node

			forNodes = (document, node) ->

				forEach.call node.children, forNode, document

			forNodes @, node

		parser = new htmlparser.Parser handler
		parser.write html
		parser.end()

	stringify: ->

		domutils.getInnerHTML @_node

	clone: (clone) ->

		node = clone._node = utils.clone @_node
		
		node._element = clone
		node.attribs = utils.clone @_node.attribs
		node.children = []
		node.parent = null

	child:

		append: (element) ->

			node = element._node
			if node and !~@_node.children.indexOf node
				@_node.children.push node
				node.parent = @_node if node.parent?

		remove: (element) ->

			node = element._node
			index = @_node.children.indexOf node

			if node and ~index
				@_node.children.splice index, 1
				node.parent = null if node.parent?

	index:

		get: ->

			node = @parent?._node

			unless node then return 0

			node.children.indexOf @_node

		set: (index) ->

			node = @parent?._node

			if node
				children = node.children
				oldIndex = children.indexOf @_node

				children.splice index, 0, children.splice(oldIndex, 1)[0]

	text:

		get: ->

			if @_node.hasOwnProperty 'data'
				@_node.data
			else
				domutils.getInnerHTML @_node

		set: do (tmp=null) -> (text) ->

			tmp ?= @constructor.factory()

			# parse html
			parseHTML.call tmp, text

			# move children from parsed
			elem.parent = @ while elem = tmp.children[0]

	queryAll: (selector, target) ->

		selectors = selector.split ' '
		opts = {}
		nodes = []

		# build opts
		recurse = selector[0] isnt '>'

		unless recurse
			selector = selector.slice 1

		opts.tag_name = selector.trim()

		# find elements
		nodes = nodes.concat domutils.getElements opts, @_node.children, recurse, Infinity

		# move nodes into target array
		target.length = nodes.length

		for node, i in nodes
			target[i] = node._element

	replace: (oldElement, newElement) ->

		children = @_node.children
		oldElementNode = oldElement._node
		newElementNode = newElement._node

		oldElementIndex = children.indexOf oldElementNode
		newElementIndex = children.indexOf newElementNode

		if ~newElementIndex
			children.splice newElementIndex, 1

		if ~oldElementIndex
			children[oldElementIndex] = newElementNode
			oldElementNode.parent = null
			newElementNode.parent = @_node