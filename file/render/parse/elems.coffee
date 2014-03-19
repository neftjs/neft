'use strict'

[utils] = ['utils'].map require

module.exports = (File) -> (file, opts) ->

	{usedUnits, changes} = file._tmp
	{units, elems, texts} = file

	if utils.isEmpty elems then return

	# replace elems by units
	for name, subelems of elems

		unit = units[name]

		for elem in subelems

			oldChild = elem.node
			unless oldChild.visible then continue

			# get unit and parse it
			usedUnit = unit.clone()
			usedUnit.render source: elem
			usedUnits.push usedUnit

			newChild = usedUnit.node

			# replace
			changes.push oldChild.parent, oldChild, newChild
			oldChild.parent.replace oldChild, newChild

	null