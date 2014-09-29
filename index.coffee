'use strict'

utils = require 'utils'
expect = require 'expect'

{assert} = console

prefixedNamesCache = {}

exports.create = (obj, name) ->
	expect(obj).not().toBe.primitive()
	expect(name).toBe.truthy().string()

	signal = exports.createOnlySignal obj, name
	exports.createHandler obj, name

	signal

exports.createOnlySignal = (obj, name) ->
	expect(obj).not().toBe.primitive()
	expect(name).toBe.truthy().string()

	assert not obj[name]?
	, "Signal `#{name}` can't be created, because object `#{obj}` has already defined such property"

	signal = obj[name] = newSignal()
	signal.connected = newSignal()
	signal.disconnected = newSignal()

	signal

exports.createHandler = (obj, name) ->
	expect(obj).not().toBe.primitive()
	expect(name).toBe.truthy().string()

	# fast connecting
	prefixedName = exports.getHandlerName name
	connect = (arg1) -> @[name].connect arg1
	utils.defProp obj, prefixedName, 'c', ->
		connect
	, (listener) ->
		@[name].disconnectAll()
		if listener?
			@[name].connect listener

exports.getHandlerName = (name) ->
	prefixedName = prefixedNamesCache[name]
	unless prefixedName
		prefixedName = prefixedNamesCache[name] = "on#{utils.capitalize name}"
	prefixedName

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
		@connected? listener

	disconnect: (listener) ->
		expect(@).toBe.function()
		expect(listener).toBe.function()
		expect().some(@listeners).toBe listener

		index = @listeners.indexOf listener
		@listeners[index] = null
		@disconnected? listener

	disconnectAll: ->
		expect(@).toBe.function()

		for listener in @listeners
			@disconnect listener

		null