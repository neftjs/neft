'use strict'

Schema = require '../index.coffee.md'

describe 'Schema validating', ->

	it 'only provided rows in the schema can be saved', ->

		SCHEMA =
			first:
				required: true

		DOC =
			noProvided: 2

		run = -> new Schema(SCHEMA).validate DOC

		expect(run).toThrow 'Schema::validate(): unexpected noProvided row'

	it 'sub properties are validated properly', ->

		SCHEMA =
			first:
				required: true
				type: 'object'
			'first.second':
				required: true
				type: 'boolean'

		DOC =
			first:
				second: 2

		err = null

		run = -> new Schema(SCHEMA).validate DOC

		expect(run).toThrow 'Schema: first.second must be a boolean'

	it 'sub property arrays are validated properly', ->

		SCHEMA =
			first:
				type: 'object'
				array: true
			'first[]':
				required: true
				type: 'boolean'

		DOC =
			first: [true, 2]

		err = null

		run = -> new Schema(SCHEMA).validate DOC

		expect(run).toThrow 'Schema: first[] must be a boolean'

	it 'sub property array properties are validated properly', ->

		SCHEMA =
			first:
				type: 'object'
				array: true
			'first[]':
				required: true
				type: 'object'
			'first[].second':
				required: true
				type: 'boolean'

		DOC =
			first: [{second: true}, {second: 2}]

		err = null

		run = -> new Schema(SCHEMA).validate DOC

		expect(run).toThrow 'Schema: first[].second must be a boolean'