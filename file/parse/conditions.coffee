'use strict'

module.exports = (File) ->

	{Condition} = File

	(file) ->

		conditions = file.conditions = []

		nodes = file.node.queryAll '[if]'

		for node in nodes

			attr = node.attrs.get 'if'
			continue unless attr

			conditions.push new File.Condition
				self: file
				node: node

		null