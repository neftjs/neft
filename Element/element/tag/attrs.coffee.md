File.Element.Tag.Attrs
======================

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

			tag.trigger 'attrChanged', event
			eventsPool.push event

		exports =

			tag: null

*Array* item(*Integer* index, [*Array* target])
-----------------------------------------------

			item: (i, target=[]) ->
				assert.isArray target

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
				assert.isString name
				assert.notLengthOf name, 0

				i = exports.tag.attrsNames?[name]
				return if i is undefined

				exports.tag.attrsValues[i]

*Any* set(*String* name, *Any* value)
-------------------------------------

			set: (name, value) ->
				assert.isString name
				assert.notLengthOf name, 0

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

add(*String* name[, *Any* val]) @low-level
------------------------------------------

			add: (name, val) ->
				assert.isString name
				assert.notLengthOf name, 0
				assert.notOk utils.has(exports.tag.attrsNames, name)

				{tag} = exports

				tag.attrsKeys.push name
				tag.attrsNames[name] = tag.attrsKeys.length - 1
				tag.attrsValues.push val
				return

			backChanges: ->
				assert.is exports.tag.clone, undefined

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