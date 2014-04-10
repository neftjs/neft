'use strict'

[utils] = ['utils'].map require

{isArray} = Array

module.exports = (File) -> (file, opts) ->

	unless file.iterators.length then return null

	{iterators, hidden, changes, usedUnits} = file._tmp
	source = opts.source

	# parse var inputs
	i = 0
	for iterator in file.iterators

		node = iterator.node
		unless node.visible then continue

		each = node.attrs.get 'each'
		iterators.push node, each

		unless isArray each
			node.visible = false
			hidden.push node
			continue

		for elem in each

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