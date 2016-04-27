'use strict'

Schema = require '../index.coffee.md'
unit = require 'neft-unit'
utils = require 'neft-utils'
assert = require 'neft-assert'

{describe, it} = unit
SchemaError = Schema.Error

VALIDATORS =
	array:
		value: true
		ok: [1, 2]
		fail: {}
		error: "arrayRow must be an array"
	object:
		value: true
		ok: {a: 1}
		fail: ->
		error: "objectRow must be an object"
	objectProperties:
		name: 'object'
		value: properties: ['a']
		ok: {a: 1}
		fail: {a: 1, b: 2}
		error: "objectPropertiesRow doesn't provide b property"
	max:
		value: 2
		ok: 2
		fail: 3
		error: "Maximum range of maxRow is 2"
	min:
		value: 3
		ok: 3
		fail: 2
		error: "Minimum range of minRow is 3"
	options:
		value: {a: 1, b: 2}
		ok: 'b'
		fail: 'c'
		error: "Passed optionsRow value is not acceptable"
	regexp:
		value: ///ab///
		ok: 'ab'
		fail: 'bb'
		error: "regexpRow doesn't pass the regular expression"
	type:
		value: 'string'
		ok: 'a'
		fail: 2
		error: "typeRow must be a string"

describe "Schema validators", ->
	# check inserting
	it "correctly proper data validated", ->
		schema = {}
		doc = {}

		# fill default doc
		for validator, options of VALIDATORS
			doc[validator + 'Row'] = options.ok

		# register
		for validator, options of VALIDATORS
			opts = schema[validator + 'Row'] = {}
			opts[options.name or validator] = options.value

		try
			new Schema(schema).validate doc
		catch err

		assert.isNotDefined err

	# check failes
	for validator, options of VALIDATORS
		do (validator = validator, options = options) ->
			describe "`#{validator}` validator", ->
				it "throws correct error on fail data", ->
					schema = {}
					doc = {}

					opts = schema[validator + 'Row'] = {}
					opts[options.name or validator] = options.value

					doc[validator + 'Row'] = options.fail

					try
						new Schema(schema).validate doc
					catch err

					assert.instanceOf err, Schema.Error
					assert.is err.message, options.error
