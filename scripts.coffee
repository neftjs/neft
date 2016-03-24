'use strict'

utils = require 'neft-utils'
assert = require 'neft-assert'

assert = assert.scope 'View.Scripts'

module.exports = (File) -> class Scripts
	@__name__ = 'Scripts'
	@__path__ = 'File.Scripts'

	JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(Scripts) - 1

	i = 1
	JSON_PATHS = i++
	JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

	@_fromJSON = (file, arr, obj) ->
		unless obj
			obj = new Scripts file, arr[JSON_PATHS]
		obj

	constructor: (@file, @paths) ->
		assert.instanceOf @file, File
		assert.isArray @paths

		@_ctor = null

		`//<development>`
		if @constructor is Scripts
			Object.seal @
		`//</development>`

	getCtor: ->
		if @_ctor
			return @_ctor

		{paths} = @
		if paths.length is 1
			ctor = require paths[0]
		else
			ctor = @createCtorFromScripts()

		@_ctor = ctor

	createCtorFromScripts: (scripts) ->
		{paths} = @

		# require all scripts
		ctors = []
		for path in paths
			ctors.push require(path)

		# call all constructors
		masterCtor = ->
			for ctor in ctors
				ctor.call @
			return

		# merge multiple constructors prototypes into one
		for ctor in ctors
			proto = ctor::
			while proto and proto isnt Object::
				keys = Object.getOwnPropertyNames proto
				for key in keys
					if key is 'constructor'
						continue
					desc = Object.getOwnPropertyDescriptor proto, key

					# methods call from all prototypes
					if typeof desc.value is typeof masterCtor::[key] is 'function'
						desc.value = do (func1 = masterCtor::[key], func2 = desc.value) -> ->
							r1 = func1.apply @, arguments
							r2 = func2.apply @, arguments
							r1 or r2

					Object.defineProperty masterCtor::, key, desc

				proto = proto.__proto__

		masterCtor

	createStorageForFile: (file) ->
		{paths} = @

		ctor = @getCtor()

		if typeof ctor isnt 'function'
			throw new Error "<neft:script> must exports a function"

		obj = Object.create ctor::
		obj.node = file.node
		obj.attrs = file.inputAttrs
		obj.ids = file.inputIds
		obj.funcs = file.inputFuncs
		ctor.call obj
		obj

	toJSON: (key, arr) ->
		unless arr
			arr = new Array JSON_ARGS_LENGTH
			arr[0] = JSON_CTOR_ID
		arr[JSON_PATHS] = @paths
		arr
