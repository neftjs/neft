Utils
=====

@author kildyt@gmail.com

@license MIT

	'use strict'

Utils for objects and arrays
----------------------------

### isArguments

Check if specified object is an arguments array.

	do (toString = Object::toString) ->

		module.exports.isArguments = (obj) ->

			throw new RangeError unless arguments.length

			toString.call(obj) is '[object Arguments]'

### isObject

Check if arg is clear object (without any other prototypes).

	do (getPrototypeOf = Object.getPrototypeOf) ->

		module.exports.isObject = (obj) ->

			throw new RangeError unless arguments.length

			if typeof obj isnt 'object'
				return false

			proto = getPrototypeOf obj

			# comes from Object.create
			unless proto
				return true

			# one-proto object
			if (proto is Object::) and not getPrototypeOf(proto)
				return true

			false

### clone

Clone array, object or function.
Prototype is copied (if exists).

	module.exports.clone = do (
		funcToString = Function::toString,
		isArray = Array.isArray,
		createObject = Object.create,
		getPrototypeOf = Object.getPrototypeOf
	) ->

		cloneArray = (arr) ->

			arr.slice()

		cloneObject = (obj) ->

			result = createObject getPrototypeOf obj

			for key, value of obj when obj.hasOwnProperty(key)

				result[key] = value

			result

		cloneFunction = (func) ->

			newFunc = null
			eval "newFunc=#{funcToString.call(func)}"

			newFunc[key] = value for key, value of func

			newFunc

		(arg) ->

			throw new RangeError unless arguments.length

			typeofArg = typeof arg

			return cloneFunction(arg) if typeofArg is 'function'
			return cloneArray(arg) if isArray arg
			return cloneObject(arg) if typeofArg is 'object'
			arg
		
### merge

Merge second object into the first one.
Existed properties will be overriden.

	module.exports.merge = (source, obj) ->

		throw new TypeError if typeof source isnt 'object'
		throw new TypeError if typeof obj isnt 'object'

		for key, value of obj

			source[key] = value

		source