'use strict'

utils = require 'utils'

isArray = Array.isArray

module.exports = (row, value, expected) ->

	unless utils.isObject value
		throw new TypeError "Schema: #{row} must be an object"

	# available properties
	if props = expected?.properties

		unless isArray props
			throw new TypeError "Schema internal: object validator requires that `properties` is an array"

		for prop of value
			unless ~props.indexOf prop
				throw new TypeError "Schema: #{row} doesn't provide #{prop} property"