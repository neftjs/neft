'use strict'

[utils] = ['utils'].map require

{isArray} = Array

module.exports = (File) -> (file, source, iterator) ->

	{parentChanges, usedUnits} = file._tmp

	node = iterator.node
	unless node.visible then return

	each = node.attrs.get 'each'

	unless isArray each
		node.visible = false
		file._tmp.visibleChanges.push node
		return

	for elem, i in each

		usedUnit = File.factory iterator.unit

		iterator.storage.i = i++
		usedUnit.render iterator

		usedUnits.push usedUnit

		newChild = usedUnit.node

		# replace
		newChild.parent = node
		parentChanges.push node, null, newChild

	null