'use strict'

module.exports = (File) -> (file, opts, condition) ->

	{conditions, hidden} = file._tmp

	{node} = condition
	unless node.visible then return

	conditions.push node, node.attrs.get('if')

	unless node.visible = condition.execute()
		hidden.push node

	condition.node.attrs.set 'if', undefined