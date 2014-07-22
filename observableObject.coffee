'use strict'

[expect, signal] = ['expect', 'signal'].map require

module.exports = (File) -> class ObservableObject

	constructor: (@data) ->
		expect(data).toBe.object()

	data: null

	signal.create @::, 'onChanged'

	get: (prop) ->
		expect(prop).toBe.truthy().string()

		@data[prop]

	set: (prop, value) ->
		expect(prop).toBe.truthy().string()

		old = @data[prop]
		return value if old is value

		@data[prop] = value
		@onChanged prop, old
		value