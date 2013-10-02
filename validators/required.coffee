'use strict'

module.exports = (row, value, expected) ->

	unless value?
		throw new TypeError "Schema: #{row} is required"