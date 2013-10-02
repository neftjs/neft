'use strict'

module.exports = (row, value, expected) ->

	if typeof expected isnt 'number'
		throw new TypeError "Schema internal: max for #{row} row must be a number"

	if value > expected
		throw new RangeError "Schema: Maximum range of #{row} is #{expected}"