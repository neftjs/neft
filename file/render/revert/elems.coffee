'use strict'

module.exports = (File) -> (file) ->

	{usedUnits} = file._tmp

	# clear and destroy used units
	while usedUnits.length

		usedUnit = usedUnits.pop()
		usedUnit.revert()
		usedUnit.destroy()

	null