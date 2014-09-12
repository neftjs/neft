'use strict'

utils = require 'utils'
expect = require 'expect'

{assert} = console

prefixedNamesCache = {}

exports.create = (obj, name) ->
	expect(obj).not().toBe.primitive()
	expect(name).toBe.truthy().string()

	assert not obj.hasOwnProperty name
	, "Signal `#{name}` can't be created, because object `#{obj}` has already defined such property"

	signal = obj[name] = newSignal()

	# fast connecting
	prefixedName = prefixedNamesCache[name]
	unless prefixedName
		prefixedName = prefixedNamesCache[name] = "on#{utils.capitalize name}"
	obj[prefixedName] = (arg1) -> signal.connect arg1

	exports

newSignal = ->
	args = []

	signal = ->
		n = listeners.length
		return unless n

		for arg, i in arguments
			args[i] = arg
		args.length = arguments.length

		i = -1
		while ++i < n
			func = listeners[i]
			if func is null
				listeners.splice i, 1
				i--; n--
				continue

			func.apply @, args

		null

	listeners = signal.listeners = []

	utils.setPrototypeOf signal, SignalPrototype

	signal

SignalPrototype =
	connect: (listener) ->
		expect(@).toBe.function()
		expect(listener).toBe.function()
		expect().some(@listeners).not().toBe listener

		@listeners.push listener

	disconnect: (listener) ->
		expect(@).toBe.function()
		expect(listener).toBe.function()
		expect().some(@listeners).toBe listener

		index = @listeners.indexOf listener
		@listeners[index] = null