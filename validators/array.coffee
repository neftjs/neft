'use strict'

isArray = Array.isArray

module.exports = (row, value, expected) ->

	unless isArray value
		throw new TypeError "Schema: #{row} must be an array"