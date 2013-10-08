'use strict'

module.exports = (row, value, expected) ->

	if typeof expected isnt 'string'
		throw new TypeError "Schema internal: type for #{row} row must be a string"

	if value is NaN or value is null
		value = undefined

	if value? and typeof value isnt expected
		throw new TypeError "Schema: #{row} must be a #{expected}"