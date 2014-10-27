'use strict'

[utils, expect, signal] = ['utils', 'expect', 'signal'].map require

module.exports = class Dict

	@__name__ = 'Dict'
	@__path__ = 'Dict'

	KEYS = 1<<0
	VALUES = 1<<1
	ITEMS = 1<<2
	ALL = (ITEMS<<1) - 1

	@fromJSON = (json) ->
		json = utils.tryFunc JSON.parse, JSON, [json], json
		expect(json).toBe.simpleObject()

		new Dict json

	@getPropertySignalName = do (cache = {}) -> (propName) ->
		expect(propName).toBe.truthy().string()

		if cache.hasOwnProperty propName
			cache[propName]
		else
			cache[propName] = "#{propName}Changed"

	@defineProperty = do ->
		createGetter = (propName) ->
			->
				Dict::get.call @, propName

		createSetter = (propName) ->
			signalName = Dict.getPropertySignalName propName

			(val) ->
				oldVal = @_data[propName]

				Dict::set.call @, propName, val

				# signal
				@[signalName]? oldVal

		(prototype, propName) ->
			expect(prototype).not().toBe.primitive()
			expect(propName).toBe.truthy().string()

			# handler
			signalName = Dict.getPropertySignalName propName
			signal.createLazy prototype, signalName

			# getter/setter
			getter = createGetter propName
			setter = createSetter propName
			utils.defProp prototype, propName, 'ec', getter, setter

	constructor: (obj={}) ->
		expect(obj).toBe.object()

		# support no `new` syntax
		unless @ instanceof Dict
			return new Dict obj

		# properties
		utils.defProp @, '__hash__', '', utils.uid()
		utils.defProp @, '_data', '', obj
		utils.defProp @, '_keys', 'w', null
		utils.defProp @, '_values', 'w', null
		utils.defProp @, '_items', 'w', null
		utils.defProp @, '_dirty', 'w', ALL

		# signals
		@changed = null

	utils.defProp @::, 'length', 'ce', ->
		@keys().length
	, null

	signal.createLazy @::, 'changed'

	get: (key) ->
		expect(key).toBe.truthy().string()

		@_data[key]

	set: (key, val) ->
		expect(key).toBe.truthy().string()
		expect(val).not().toBe undefined

		oldVal = @_data[key]

		# update value
		@_data[key] = val

		# dirty
		@_dirty |= ALL

		# signal
		@changed? key, oldVal

		@

	pop: (key) ->
		expect(key).toBe.truthy().string()
		expect().some().keys(@_data).toBe key

		oldVal = @_data[key]
		delete @_data[key]

		# dirty
		@_dirty |= ALL

		# signal
		@changed? key, oldVal

		@

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

	toJSON: ->
		@_data

	toString: ->
		@__hash__