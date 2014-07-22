'use strict'

[expect, signal] = ['expect', 'signal'].map require

module.exports = (File) -> class ObservableArray extends File.ObservableObject

	constructor: (data) ->
		expect(data).toBe.array()
		super data

	signal.create @::, 'onAdded'
	signal.create @::, 'onRemoved'

	get: (index) ->
		expect(index).toBe.integer()
		expect(index).not().toBe.lessThan 0
		expect(index).toBe.lessThan @data.length

		@data[index]

	set: (index, value) ->
		expect(index).toBe.integer()
		expect(index).not().toBe.lessThan 0
		expect(index).toBe.lessThan @data.length

		old = @data[index]
		if old isnt value
			@data[index] = value
			@onChanged index, old

		@

	insert: (index, value) ->
		expect(index).toBe.integer()
		expect(index).not().toBe.lessThan 0
		expect(index).not().toBe.greaterThan @data.length

		@data.splice index, 0, value
		@onAdded index

		@

	append: (value) ->
		@insert @data.length, value

	remove: (value) ->
		expect().some(@data).toBe value

		@pop @data.indexOf value

	pop: (index) ->
		index ?= @data.length - 1

		expect(index).toBe.integer()
		expect(index).not().toBe.lessThan 0
		expect(index).toBe.lessThan @data.length

		@data.splice index, 1
		@onRemoved index

		@