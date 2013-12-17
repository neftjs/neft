'use strict'

utils = require 'utils/index.coffee.md'
assert = require 'assert'

module.exports = class CallList extends Array

	_initArgs: null
	_isModifiable: true

	constructor: ->

		@_initArgs = arguments

	_build: ->

		assert @_isModifiable

		builtFunc = ->

		while @length
			func = @pop()
			@pop()

			builtFunc = func @_initArgs..., builtFunc

		@_isModifiable = false
		@run = builtFunc

	add: (name, func, opts) ->

		assert @_isModifiable
		assert name and typeof name is 'string'
		assert !~@indexOf name
		assert typeof func is 'function'
		assert !~@indexOf func
		opts and assert utils.isObject opts

		index = 0

		opts and switch true
			when !!opts.before
				assert typeof opts.before is 'string'
				index = @indexOf opts.before
				assert ~index
				index += 2
			when !!opts.after
				assert typeof opts.after is 'string'
				index = @indexOf opts.after
				assert ~index

		@splice index, 0, name, func

		@

	run: ->

		@_build()
		@run arguments...