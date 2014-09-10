'use strict'

expect = require 'expect'
utils = require 'utils'

{assert} = console

module.exports = (Element) ->

	Observer =
		PARENT: 1<<0
		VISIBILITY: 1<<1
		ATTR: 1<<2
		TEXT: 1<<3
		ALL: (1<<4) - 1

		_linkElement: (elem) ->
			expect(elem).toBe.any Element

			elem._observed = 0
			elem._observer = null

		_isObserved: (elem, type) ->
			!! (elem._observed & type)

		_report: (elem, type, arg1, arg2) ->
			assert Observer._isObserved elem, type

			store = elem._observer[type]

			i = -1
			n = store.length
			while ++i < n
				func = store[i]
				if func is null
					store.splice i, 1
					i--; n--
					continue

				func.call elem, arg1, arg2

			null

		observe: (elem, type, listener) ->
			expect(elem).toBe.any Element
			expect(type).toBe.integer()
			expect(Observer.ALL & type).toBe.truthy()
			expect(listener).toBe.function()

			elem._observer ?= utils.clone ObserverObject

			unless Observer._isObserved elem, type
				elem._observed |= type

			store = elem._observer[type] ?= []
			store.push listener

			@

		disconnect: (elem, type, listener) ->
			expect(elem).toBe.any Element
			expect(type).toBe.integer()
			expect(Observer.ALL & type).toBe.truthy()
			expect(listener).toBe.function()
			expect(Observer._isObserved elem, type).toBe.truthy()

			store = elem._observer[type]
			index = store.indexOf listener
			store[index] = null

			@

	# prepare object to store listeners
	ObserverObject = {}
	i = 1
	while i & Observer.ALL
		ObserverObject[i] = null
		i <<= 1

	Observer