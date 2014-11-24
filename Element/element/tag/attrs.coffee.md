File.Element.Tag.Attrs
======================

	'use strict'

	utils = require 'utils'
	expect = require 'expect'

	{isArray} = Array

	module.exports = (Element) ->

		eventsPool = []

		triggerEvent = (tag, name, value) ->
			event = eventsPool.pop() or {}
			event.name = name
			event.value = value

			tag.trigger 'attrChanged', event
			eventsPool.push event

		exports =

			tag: null

*Array* item(*Integer* index, [*Array* target])
-----------------------------------------------

			item: (i, target=[]) ->
				expect(target).toBe.array()

				keys = exports.tag.attrsKeys
				values = exports.tag.attrsValues

				target[0] = target[1] = undefined

				unless values
					return target

				while target[1] is undefined and keys.length >= i
					target[0] = keys[i]
					target[1] = values[i]
					i++

				target

*Any* get(*String* name)
------------------------

			get: (name) ->
				expect(name).toBe.truthy().string()

				i = exports.tag.attrsNames?[name]
				return if i is undefined

				exports.tag.attrsValues[i]

*Any* set(*String* name, *Any* value)
-------------------------------------

			set: (name, value) ->
				expect(name).toBe.truthy().string()

				{tag} = exports

				i = tag.attrsNames?[name]
				return if i is undefined

				old = tag.attrsValues[i]
				return if old is value

				# save change
				tag.attrsValues[i] = value

				# trigger event
				triggerEvent tag, name, old

				value

			backChanges: ->

				expect(exports.tag.clone).toBe undefined

				{tag} = exports

				keys = tag.attrsKeys
				return unless keys

				original = Object.getPrototypeOf tag
				valuesA = tag.attrsValues
				valuesB = original.attrsValues

				for value, i in valuesA
					continue if value is valuesB[i]

					valuesA[i] = utils.cloneDeep valuesB[i]

					# trigger event
					triggerEvent tag, keys[i], value

				@