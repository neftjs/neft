Tag.Attrs @virtual_dom
======================

	'use strict'

	utils = require 'utils'
	signal = require 'signal'
	assert = require 'neft-assert'

	assert = assert.scope 'View.Element.Tag.Attrs'

	{isArray} = Array
	{emitSignal} = signal.Emitter

	module.exports = (Tag) ->
		eventsPool = []

		triggerEvent = (tag, name, value) ->
			event = eventsPool.pop()
			unless event
				event = {}

				# DEPRECATED
				utils.defineProperty event, 'value', null, ->
					log.warn 'Tag::onAttrsChange use oldValue instead of value'
					@oldValue
				, null

			event.name = name
			event.oldValue = value

			emitSignal tag, 'onAttrsChange', event
			eventsPool.push event

		exports =
			tag: null

*Array* item(*Integer* index, [*Array* target])
-----------------------------------------------

			item: (index, target=[]) ->
				assert.isArray target

				target[0] = target[1] = undefined

				i = 0
				for key, val of exports.tag._attrs
					if i is index
						target[0] = key
						target[1] = val
						break
					i++

				target

*Boolean* has(*String* name)
----------------------------

			has: (name) ->
				assert.isString name
				assert.notLengthOf name, 0

				exports.tag._attrs.hasOwnProperty name

*Any* get(*String* name)
------------------------

			get: (name) ->
				assert.isString name
				assert.notLengthOf name, 0

				exports.tag._attrs[name]

*Boolean* set(*String* name, *Any* value)
-----------------------------------------

			set: (name, value) ->
				assert.isString name
				assert.notLengthOf name, 0

				{tag} = exports

				# save change
				old = tag._attrs[name]
				if old is value
					return false

				tag._attrs[name] = value

				# trigger event
				triggerEvent tag, name, old
				Tag.query.checkWatchersDeeply tag

				true
