'use strict'

[utils, expect] = ['utils', 'expect'].map require

module.exports = (Element) ->

	EVENTS = ['onAttrChanged', 'onParentChanged', 'onTextChanged', 'onVisibilityChanged']

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

		(node) ->
			event = (a, b) ->
				if event.store
					for func in event.store
						func event.node, a, b
				null

			event.node = node
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

	# add events getters into Element prototype
	for name in EVENTS
		do (name=name) =>
			Object.defineProperty Element::, name,
				enumerable: true
				configurable: true
				get: ->
					event = createEvent(@)
					utils.defProp @, name, 'ce', event
					event