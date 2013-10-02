'use strict'

Schema = require '../index.coffee.md'

utils = require 'utils'

VALIDATORS =
	required:
		ok: 'a'
		fail: undefined
		failOnInsert: true
		error: "Schema: requiredRow is required"
	array:
		ok: [1, 2]
		fail: {}
		error: "Schema: arrayRow must be an array"
	object:
		ok: {a: 1}
		fail: []
		error: "Schema: objectRow must be an object"
	objectProperties:
		name: 'object'
		value: properties: ['a']
		ok: {a: 1}
		fail: {a: 1, b: 2}
		error: "Schema: objectPropertiesRow doesn't provide b property"
	function:
		ok: 'return 1;'
		fail: 'a=;2'
		error: "Schema: functionRow must be a proper function body"
	max:
		value: 2
		ok: 2
		fail: 3
		error: "Schema: Maximum range of maxRow is 2"
	min:
		value: 3
		ok: 3
		fail: 2
		error: "Schema: Minimum range of minRow is 3"
	options:
		value: {a: 1, b: 2}
		ok: 'b'
		fail: 'c'
		error: "Schema: optionsRow value is not provided"
	re:
		value: ///ab///
		ok: 'ab'
		fail: 'bb'
		error: "Schema: reRow doesn't passed regular expression"
	type:
		value: 'string'
		ok: 'a'
		fail: 2
		error: "Schema: typeRow must be a string"

describe "Schema validators", ->

	# default doc used to insert
	schema = {}
	doc = {}
	id = null

	# check inserting
	it "correctly proper data validated", ->

		# fill default doc
		for validator, options of VALIDATORS

			doc[validator + 'Row'] = options.ok

		# register
		for validator, options of VALIDATORS

			opts = schema[validator + 'Row'] = {}
			opts[options.name or validator] = options.value

		run = -> new Schema(schema).validate doc

		expect(run).not.toThrow()

	# check failes
	for validator, options of VALIDATORS

		do (validator = validator, options = options) ->

			describe "`#{validator}` validator", ->

				it "throws correct error on fail data", ->

					done = false
					err = null

					insertDoc = utils.clone doc
					insertDoc[validator + 'Row'] = options.fail

					if options.failOnInsert?

						delete insertDoc[validator + 'Row']

					run = -> new Schema(schema).validate insertDoc

					expect(run).toThrow options.error