'use strict'

[utils, expect, signal] = ['utils', 'expect', 'signal'].map require

module.exports = class Dict

	@__name__ = 'Dict'
	@__path__ = 'Dict'

	KEYS = 1<<0
	VALUES = 1<<1
	ITEMS = 1<<2
	ALL = (ITEMS<<1) - 1

	constructor: (obj={}) ->
		expect(obj).toBe.simpleObject()

		# support no `new` syntax
		unless @ instanceof Dict
			return new Dict obj

		# properties
		utils.defProp @, '_data', 'e', obj
		utils.defProp @, '_keys', 'w', null
		utils.defProp @, '_values', 'w', null
		utils.defProp @, '_items', 'w', null
		utils.defProp @, '_dirty', 'w', ALL

		# signals
		signal.create @, 'changed'

	utils.defProp @::, 'length', 'ce', ->
		@keys().length
	, null

	get: (key) ->
		expect(key).toBe.truthy().string()

		@_data[key]

	set: (key, val) ->
		expect(key).toBe.truthy().string()
		expect(val).not().toBe undefined

		oldVal = @_data[key]
		if oldVal is val
			return val

		@_data[key] = val

		# dirty
		@_dirty |= ALL

		# signal
		@changed key, oldVal

		val

	pop: (key) ->
		expect(key).toBe.truthy().string()
		expect().some().keys(@_data).toBe key

		val = @_data[key]
		delete @_data[key]

		# dirty
		@_dirty |= ALL

		# signal
		@changed key, val

		val

	keys: ->
		if @_dirty & KEYS
			@_dirty ^= KEYS
			arr = @_keys ?= []

			i = 0
			for key of @_data
				arr[i] = key
				i++

			arr.length = i

		@_keys

	values: ->
		if @_dirty & VALUES
			@_dirty ^= VALUES
			arr = @_values ?= []

			i = 0
			for key, val of @_data
				arr[i] = val
				i++

			arr.length = i

		@_values

	items: ->
		if @_dirty & ITEMS
			arr = @_values ?= []

			i = 0
			for key, val of @_data
				arr[i] ?= ['', null]
				arr[i][0] = key
				arr[i][1] = val
				i++

			arr.length = i

		@_values