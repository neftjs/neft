'use strict'

[utils] = ['utils'].map require

{isArray} = Array

module.exports = (File) -> (file, opts, iterator) ->

	{parentChanges, usedUnits} = file._tmp
	source = opts.source

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
		opts.source = iterator
		usedUnit.render opts

		usedUnits.push usedUnit

		newChild = usedUnit.node

		# replace
		newChild.parent = node
		parentChanges.push node, null, newChild

	# restore opts
	opts.source = source

	null