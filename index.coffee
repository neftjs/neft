'use strict'

[utils, expect] = ['utils', 'expect'].map require

###
Function creates new Signal function which can be used to
trigger, connect and disconnect listeners.
###
createSignal = do ->
	useProto = do ->
		try
			func = ->
			proto = func.__proto__ = {a: 1}
			if func.a is 1
				return true
			false

	(node, name) ->
		signal = (a, b) ->

			# omit cloned elements with no listeners
			return unless @hasOwnProperty name

			if signal.store
				for func in signal.store
					func.call @, a, b
			null

		signal.store = null

		if useProto
			signal.__proto__ = SignalPrototype
		else
			utils.merge signal, SignalPrototype

		signal

###
Signal prototype joined into each Signal function
###
SignalPrototype =
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
		signal = createSignal @, name
		utils.defProp @, name, 'cwe', signal
		signal

###
Define Signal getter
###
exports.create = (obj, name) ->
	expect(obj).toBe.object()
	expect(name).toBe.truthy().string()

	Object.defineProperty obj, name, exports.getPropertyDesc(name)