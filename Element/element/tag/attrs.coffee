'use strict'

utils = require 'utils'
assert = require 'assert'

assert = assert.scope 'View.Element.Tag.Attrs'

{isArray} = Array

module.exports = (Element) ->
	eventsPool = []

	triggerEvent = (tag, name, value) ->
		event = eventsPool.pop() or {}
		event.name = name
		event.value = value

		tag.attrsChanged event
		eventsPool.push event

	exports =

		tag: null

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

		has: (name) ->
			assert.isString name
			assert.notLengthOf name, 0

			exports.tag._attrs.hasOwnProperty name

		get: (name) ->
			assert.isString name
			assert.notLengthOf name, 0

			exports.tag._attrs[name]

		set: (name, value) ->
			assert.isString name
			assert.notLengthOf name, 0

			{tag} = exports

			# save change
			old = tag._attrs[name]
			if old is value
				return

			tag._attrs[name] = value

			# trigger event
			triggerEvent tag, name, old

			value
