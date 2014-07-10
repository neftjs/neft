'use strict'

[utils] = ['utils'].map require

{isArray} = Array

module.exports = (File) -> (file, opts, iterator) ->

	{iterators, hidden, changes, usedUnits} = file._tmp
	source = opts.source

	node = iterator.node
	unless node.visible then return

	each = node.attrs.get 'each'
	iterators.push node, each

	unless isArray each
		node.visible = false
		hidden.push node
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
		changes.push node, null, newChild

	# remove `if` attrs
	node.attrs.set 'each', undefined

	# restore opts
	opts.source = source

	null