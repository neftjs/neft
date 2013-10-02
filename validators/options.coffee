'use strict'

isArray = Array.isArray
objKeys = Object.keys

module.exports = (row, value, expected) ->

	if typeof expected isnt 'object'
		throw new TypeError "Schema internal: options for #{row} row must be an object or array"

	if isArray expected
		passed = expected.indexOf value
	else
		passed = ~ objKeys(expected).indexOf value + ''

	unless passed
		throw new TypeError "Schema: #{row} value is not provided"