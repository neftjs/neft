'use strict'

module.exports = (File) -> (file) ->

	conditions = file.conditions = []

	nodes = file.node.queryAll '[if]'

	for node in nodes

		attr = node.attrs.get 'if'
		
		if attr
			conditions.push new File.Condition node