'use strict'

utils = require 'utils'
if utils.isNode
	htmlparser = require 'htmlparser2'
	DomHandler = require './domhandler.js'
stringify = require './stringify.js'
domutils = require 'domutils'

{forEach} = Array::
{min} = Math

isDefined = (elem) -> elem?

MAIN_ELEMENT_NAME = 'g'
CSS_ID_RE = ///\#([^\s]+)///

stringify.omit = [MAIN_ELEMENT_NAME]

updateIndexes = (nodes, from=0, to=nodes.length) ->

	if from >= to then return

	i = to
	while i-- - from
		nodes[i].index = i

module.exports = ->

	factory: ->

		node = @_node ?=
			index: -1
			type: 'tag'
			name: MAIN_ELEMENT_NAME
			attribs: null
			children: []
			visible: true
			_element: null
		node._element = @

	parseHTML: parseHTML = (html) ->

		Element = @constructor
		node = @_node

		handler = new DomHandler (err, dom) =>
			
			if err then throw err

			# move all nodes into document
			node.children = dom

			# for all nodes
			forNode = (node) ->

				# create new Element
				element = node._element = new Element
				element.parent = @
				element._node = node
				element.name = node.name or "##{node.type}"

				# for nodes recursively
				if node.children?
					forNodes element, node

			forNodes = (document, node) ->

				updateIndexes node.children
				forEach.call node.children, forNode, document

			forNodes @, node

		parser = new htmlparser.Parser handler
		parser.write html
		parser.end()

	stringify: ->

		stringify.getOuterHTML @_node

	stringifyChildren: ->

		stringify.getInnerHTML @_node

	clone: (clone) ->

		node = clone._node = utils.clone @_node

		node._element = clone
		node.attribs = node.attribs and utils.clone @_node.attribs
		node.children = []

	child:

		append: (element) ->

			node = element._node
			if node and !~@_node.children.indexOf node
				node.index = @_node.children.push(node) - 1

		remove: (element) ->

			children = @_node.children
			node = element._node
			index = node.index

			if children[index] is node
				children.splice index, 1
				updateIndexes children, index

	visible:

		get: ->

			@_node.visible

		set: (visible) ->

			@_node.visible = visible

	index:

		get: ->

			@_node.index

		set: (index) ->

			node = @parent?._node

			if node
				children = node.children
				oldIndex = @_node.index

				return if index is oldIndex

				children.splice index, 0, children.splice(oldIndex, 1)[0]
				updateIndexes children, min(index, oldIndex)

	text:

		get: ->

			@_node.data

		set: do (tmp=null, LESS_THAN_RE = ///<///g, GREATER_THAN_RE = ///>///g) -> (text) ->

			if @_node.type is 'text'
				@_node.data = text
					.replace(LESS_THAN_RE, '&#60;')
					.replace(GREATER_THAN_RE, '&#62;')
				return;

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

		# get id
		id = CSS_ID_RE.exec selector
		if id?
			opts['id'] = id[1]

		# get attrs
		attrs = selector.split '['
		selector = attrs.shift().trim()

		for attr in attrs
			attr = attr.slice 0, -1
			[name, value] = attr.split '='
			value ?= isDefined
			opts[name] = value

		# save opts
		if selector then opts.tag_name = selector

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

		oldElementIndex = oldElementNode.index
		newElementIndex = newElementNode.index

		# remove new element if exists
		if children[newElementIndex] is newElementNode
			children.splice newElementIndex, 1
			newElementNode.index = -1
			updateIndexes children, newElementIndex

		# update elements
		if ~oldElementIndex
			children[oldElementIndex] = newElementNode
			newElementNode.index = oldElementNode.index
			oldElementNode.index = -1