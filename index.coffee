'use strict'

[utils, expect, signal] = ['utils', 'expect', 'signal'].map require

module.exports = class List

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
		utils.defProp @, '_data', '', arr

	utils.defProp @::, 'length', 'ce', ->
		@_data.length
	, null

	signal.defineGetter @::, 'onChange'
	signal.defineGetter @::, 'onInsert'
	signal.defineGetter @::, 'onPop'

	get: (i) ->
		expect(i).not().toBe.lessThan 0

		@_data[i]

	set: (i, val) ->
		expect(i).not().toBe.lessThan 0
		expect(i).toBe.lessThan @length
		expect(val).not().toBe undefined

		if @_data[i] is val
			return val

		# signal
		if @hasOwnProperty 'onChange'
			@onChange i, val

		@_data[i] = val

	items: ->
		@_data

	append: (val) ->
		expect(val).not().toBe undefined

		# signal
		if @hasOwnProperty 'onInsert'
			@onInsert @length, val

		@_data.push val

		@

	insert: (i, val) ->
		expect(i).not().toBe.lessThan 0
		expect(i).toBe.lessThan @length
		expect(val).not().toBe undefined

		# signal
		if @hasOwnProperty 'onInsert'
			@onInsert i, val

		@_data.splice i, 0, val

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

		# signal
		if @hasOwnProperty 'onPop'
			@onPop i ? @length - 1

		if i is undefined
			@_data.pop()
		else
			@_data.splice i, 1

		@

	clear: ->
		while @_data.length 
			@pop()

		@

	index: (val) ->
		expect(val).not().toBe undefined

		@_data.indexOf val