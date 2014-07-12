'use strict'

module.exports = (File) -> (file, opts, condition) ->

	{node} = condition
	unless node.visible then return

	unless node.visible = condition.execute()
		file._tmp.visibleChanges.push node