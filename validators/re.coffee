'use strict'

module.exports = (row, value, expected) ->

	if expected.constructor isnt RegExp
		throw new TypeError "Schema internal: re for #{row} row must be a regular expression"

	unless expected.test value
		throw new TypeError "Schema: #{row} doesn't passed regular expression"