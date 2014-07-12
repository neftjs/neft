'use strict'

[utils, expect] = ['utils', 'expect'].map require

###
Function creates new Event function which can be used to
trigger, connect and disconnect listeners.
###
createEvent = do ->
	useProto = do ->
		try
			func = ->
			proto = func.__proto__ = {a: 1}
			if func.a is 1
				return true
			false

	(node, name) ->
		event = (a, b) ->

			# omit cloned elements with no listeners
			return unless @hasOwnProperty name

			if event.store
				for func in event.store
					func @, a, b
			null

		event.store = null

		if useProto
			event.__proto__ = EventPrototype
		else
			utils.merge event, EventPrototype

		event

###
Event prototype joined into each Event function
###
EventPrototype =
	connect: (listener, opts) ->
		expect(listener).toBe.function()
		expect().defined(opts).toBe.simpleObject()
		expect().some(@store).not().toBe listener if @store

		store = @store ?= []
		store.push listener

	disconnect: (listener) ->
		expect(listener).toBe.function()
		expect().some(@store).toBe listener

		utils.remove @store, listener

###
Returns property descriptor which can be used
to define property
###
exports.getPropertyDesc = (name) ->
	expect(name).toBe.truthy().string()

	enumerable: true
	configurable: true
	get: ->
		expect(Object.getPrototypeOf(@).hasOwnProperty('clone')).toBe.falsy()
		event = createEvent @, name
		utils.defProp @, name, 'cwe', event
		event

###
Define Event getter
###
exports.defineProperty = (obj, name) ->
	expect(obj).toBe.object()
	expect(name).toBe.truthy().name()

	Object.defineProperty obj, name, exports.getPropertyDesc(name)