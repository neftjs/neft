'use strict'

[utils, expect, signal] = ['utils', 'expect', 'signal'].map require

module.exports = class List

	@__name__ = 'List'
	@__path__ = 'List'

	constructor: ->
		# array
		arr = arguments[0]
		if arguments.length > 1 or not Array.isArray arr
			arr = []
			arr[i] = arg for arg, i in arguments
		
		# support no `new` syntax
		unless @ instanceof List
			return new List arr

		# properties
		utils.defProp @, '_data', 'e', arr

		# signals
		signal.create @, 'changed'
		signal.create @, 'inserted'
		signal.create @, 'popped'

	utils.defProp @::, 'length', 'ce', ->
		@_data.length
	, null

	get: (i) ->
		expect(i).not().toBe.lessThan 0

		@_data[i]

	set: (i, val) ->
		expect(i).not().toBe.lessThan 0
		expect(i).toBe.lessThan @length
		expect(val).not().toBe undefined

		oldVal = @_data[i]
		if oldVal is val
			return val

		@_data[i] = val

		# signal
		@changed i, oldVal

		val

	items: ->
		@_data

	append: (val) ->
		expect(val).not().toBe undefined

		@_data.push val

		# signal
		@inserted @length - 1

		@

	insert: (i, val) ->
		expect(i).not().toBe.lessThan 0
		expect(i).toBe.lessThan @length
		expect(val).not().toBe undefined

		@_data.splice i, 0, val

		# signal
		@inserted i

		@

	remove: (val) ->
		expect().some(@_data).toBe val

		i = @index val
		if i isnt -1
			@pop i

		@

	pop: (i) ->
		if i isnt undefined
			expect(i).not().toBe.lessThan 0
			expect(i).toBe.lessThan @length

		i ?= @length - 1
		oldVal = @_data[i]

		@_data.splice i, 1

		# signal
		@popped i, oldVal

		@

	clear: ->
		while @_data.length 
			@pop()

		@

	index: (val) ->
		expect(val).not().toBe undefined

		@_data.indexOf val