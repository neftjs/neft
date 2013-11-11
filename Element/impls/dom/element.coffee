'use strict'

forEach = Array::forEach

MAIN_ELEMENT_NAME = 'fragment'

module.exports = (DOC) ->

	BODY = DOC.body

	factory: ->

		node = @_node ?= DOC.createElement MAIN_ELEMENT_NAME
		node._element = @

	parseHTML: parseHTML = (html) ->

		Element = @constructor

		# parse html into DocumentFragment
		BODY.innerHTML = html

		# move all nodes into document
		node = @_node
		node.appendChild elem while elem = BODY.firstChild

		# for all nodes
		forNode = (node) ->

			# create new Element
			element = node._element = new Element
			element.parent = @
			element._node = node
			element.name = node.nodeName.toLowerCase()

			# for nodes recursively
			forNodes element, node

		forNodes = (document, node) ->

			forEach.call node.childNodes, forNode, document

		forNodes @, node

	stringify: ->

		@_node.innerHTML

	clone: (clone) ->

		clone._node = @_node.cloneNode false
		clone._node._element = clone

	child:

		append: (element) ->

			node = element._node
			node and node.parentNode isnt @_node and @_node.appendChild node

		remove: (element) ->

			node = element._node
			node and node.parentNode is @_node and @_node.removeChild node

	index:

		get: ->

			elem = @_node
			k = 0
			while (elem = elem.previousSibling) and ++k then

			k

		set: (index) ->

			@parent._node.insertBefore @_node, @parent._node.children[index]

	text:

		get: ->

			if 'innerHTML' of @_node
				@_node.innerHTML
			else
				@_node.textContent

		set: do (tmp=null) -> (text) ->

			if @_node.nodeType is document.TEXT_NODE
				@_node.textContent = text
				return

			tmp ?= @constructor.factory()

			# parse html
			parseHTML.call tmp, text

			# move children from parsed
			elem.parent = @ while elem = tmp.children[0]

	queryAll: (selector, target) ->

		if selector[0] is '>'
			selector = MAIN_ELEMENT_NAME + selector

		nodes = @_node.querySelectorAll selector

		target.length = nodes.length

		for node, i in nodes
			target[i] = node._element

	replace: (oldElement, newElement) ->

		@_node.replaceChild newElement._node, oldElement._node