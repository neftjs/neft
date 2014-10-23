'use strict'

utils = require 'utils'
expect = require 'expect'

{assert} = console

createSignal = (obj, name) ->
	expect(obj).not().toBe.primitive()
	expect(name).toBe.truthy().string()

	handlerName = exports.getHandlerName name

	assert not obj[name]?
	, "Signal `#{name}` can't be created, because object `#{obj}` " +
	  "has already defined such property"

	obj[name] = createSignalFunction obj

createHandler = (obj, name) ->
	expect(obj).not().toBe.primitive()
	expect(name).toBe.truthy().string()

	handlerName = exports.getHandlerName name

	assert not obj[handlerName]?
	, "Handler `#{handlerName}` can't be created, because object `#{obj}` " +
	  "has already defined such property"

	signal = obj[name]
	obj[handlerName] = createHandlerFunction obj, signal

exports.getHandlerName = do ->
	cache = {}

	(name) ->
		if cache.hasOwnProperty name
			cache[name]
		else
			cache[name] = "on#{utils.capitalize name}"

exports.create = (obj, name) ->
	expect(obj).not().toBe.primitive()
	expect(name).toBe.truthy().string()

	createSignal obj, name
	createHandler obj, name

exports.createLazy = (obj, name) ->
	expect(obj).not().toBe.primitive()
	expect(name).toBe.truthy().string()

	handlerName = exports.getHandlerName name
	handler = createHandler obj, name

	exports.create handler, 'initialized'

	utils.defProp obj, handlerName, 'ec', ->
		signal = @[name]
		unless signal?
			signal = @[name] = createSignalFunction @, handler
			handler.initialized @, name

		handler.listeners = signal.listeners
		handler
	, null

	handler

createSignalFunction = (obj) ->
	signal = ->
		n = listeners.length
		return unless n

		args = []
		for arg, i in arguments
			args[i] = arg

		i = -1
		while ++i < n
			func = listeners[i]
			if func is null
				listeners.splice i, 1
				i--; n--
				continue

			func.apply obj, args

		null

	listeners = signal.listeners = []

	signal

createHandlerFunction = (obj, signal) ->
	handler = (listener) ->
		HandlerPrototype.connect.call handler, listener

	handler.listeners = signal?.listeners
	utils.setPrototypeOf handler, HandlerPrototype

	handler

HandlerPrototype =
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

	disconnectAll: ->
		expect(@).toBe.function()

		for listener in @listeners
			@disconnect listener

		null