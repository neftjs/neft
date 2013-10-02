'use strict'

module.exports = (row, value, expected) ->

	try

		func = new Function value

		eval func

	catch err

		throw new TypeError "Schema: #{row} must be a proper function body"