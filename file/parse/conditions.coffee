'use strict'

module.exports = (File) ->

	{Condition} = File

	(file) ->

		conditions = file.conditions = []

		nodes = file.node.queryAll '[if]'

		for node in nodes

			attr = node.attrs.get 'if'
			continue unless attr

			# find input if exists
			for input in file.inputs
				continue unless input.node is node
				continue unless input.attrName is 'if'
				attrInput = input
				break

			unless attrInput
				cond = Condition.getCondFunc attr
				unless cond()
					node.parent = undefined
				continue

			conditions.push new File.Condition
				self: file
				node: node
				input: attrInput

		null