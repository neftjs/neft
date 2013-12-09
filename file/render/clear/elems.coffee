'use strict'

module.exports = (File, _super) -> (file) ->

	{changes, usedUnits} = file.render._tmp

	# back changes
	while changes.length

		newChild = changes.pop()
		oldChild = changes.pop()
		node = changes.pop()

		unless newChild
			oldChild.parent = node
			continue

		unless oldChild
			newChild.parent = undefined
			continue

		node.replace newChild, oldChild

	# clear and destroy used units
	while usedUnits.length

		usedUnit = usedUnits.pop()
		usedUnit.render.clear()
		usedUnit.destroy()

	_super arguments...