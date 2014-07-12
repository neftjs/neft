'use strict'

[utils] = ['utils'].map require

module.exports = (File) -> (file) ->

	nodes = file.nodes = []

	search = (node) ->
		for child in node.children
			nodes.push child
			search child if child.children
		null

	nodes.push file.node
	search file.node

	null