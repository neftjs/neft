'use strict'

module.exports = (File) ->

	{Condition} = File

	(file) ->

		conditions = file.conditions = []

		nodes = file.node.queryAll '[x:if]'

		for node in nodes

			attr = node.attrs.get 'x:if'
			continue unless attr

			conditions.push new File.Condition
				self: file
				node: node

		null