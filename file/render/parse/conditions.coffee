'use strict'

module.exports = (File) -> (file, opts) ->

	{conditions, hidden} = file._tmp

	# parse data inputs
	for condition in file.conditions

		node = condition.node
		unless node.visible then continue

		conditions.push node, node.attrs.get('if')

		unless node.visible = condition.execute()
			hidden.push node

	# remove `if` attrs
	for condition in conditions by 2
		condition.attrs.set 'if', undefined

	null