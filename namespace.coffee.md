	'use strict'

	expect = require 'expect'

	module.exports = (utils) ->

*Any* utils.get(*Object* object, *String* path, [*OptionsArray* target])
------------------------------------------------------------------------

Get needed value from the object. Arrays are supported.
If path can't be resolved, new get.OptionsArray is returned with
all possible results.
Separate properties in path by dots ('.').
For arrays add to property name two brackets ('[]')
- look at isStringArray method to check it in other way.

		get = utils.get = (obj, path='', target) ->

			expect(obj).not().toBe.primitive()

			switch typeof path

				when 'object'

					path = exports.clone path

				when 'string'

					# split path by dot's
					path = path.split '.'

				else

					throw new TypeError

			# check chunks
			for key, i in path

				# empty props are not supported
				if not key.length and i
					throw new ReferenceError "utils.get(): empty properties are not supported"

				# support array elements by `[]` chars
				if isStringArray key

					# get array key name
					key = key.substring 0, key.indexOf('[]')

					# cut path removing checked elements
					path = path.splice i

					# update current path elem without array brackets
					path[0] = path[0].substring key.length + 2

					# if current path is empty, remove it
					unless path[0].length then path.shift()

					# create target array if no exists
					target ?= new OptionsArray()

					# move to the key value if needed
					if key.length
						obj = obj[key]

					# return `undefined` if no value exists
					if typeof obj is 'undefined'
						return undefined

					# call this func recursive on all array elements
					# found results will be saved in the `target` array
					for elem in obj
						get elem, path.join('.'), target

					# return `undefined` if nothing has been found
					unless target.length
						return undefined

					# return found elements
					return target

				# move to the next object value
				if key.length then obj = obj[key]

				# break if no way exists
				if typeof obj isnt 'object' and typeof obj isnt 'function'

					# if it is no end of path, return undefined
					if i isnt path.length - 1
						obj = undefined

					break

			# save obj into target array
			if target and typeof obj isnt 'undefined' then target.push obj

			obj

*OptionsArray* utils.get.OptionsArray()
---------------------------------------

Special version of Array, returned if result of the `get` method is a list
of possible values and not a proper value.

		get.OptionsArray = class OptionsArray extends Array

			constructor: -> super

*boolean* utils.isStringArray(*String* value)
---------------------------------------------

Check if string references into array (according to notation in `get` method).

		isStringArray = utils.isStringArray = (arg) ->

			expect(arg).toBe.string()

			arg.slice(-2) is '[]'
