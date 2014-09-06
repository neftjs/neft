'use strict'

utils = require 'utils'

# TODO: replace by language tag
RESERVED_NAMES =
	'x:unit': true
	'x:func': true
	'x:require': true
	'x:link': true
	'x:source': true

module.exports = (File) -> (file) ->

	elems = file.elems = {}

	forNode = (node) ->

		unless node instanceof File.Element.Tag
			return

		if RESERVED_NAMES[node.name] or node.name.indexOf('x:') isnt 0
			return node.children?.forEach forNode

		# get elems
		name = node.name.slice 'x:'.length
		nameElems = elems[name] ?= []
		nameElems.push new File.Elem file, name, node

	forNode file.node

	null