neft:script @xml
================

	'use strict'

	module.exports = (File) -> (file) ->
		scripts = []

		for tag in file.node.queryAll('neft:script')
			tag.parent = null

			# tag body
			str = tag.stringifyChildren()
			func = new Function 'module', str
			func module = exports: {}
			ctor = module.exports
			if typeof ctor isnt 'function'
				throw new Error "<neft:script> must exports a function"
			scripts.push ctor

		switch scripts.length
			when 0
				return
			when 1
				file.storageConstructor = scripts[0]
			else
				# call all constructors
				ctor = ->
					for script in scripts
						script.call @
					return

				# merge multiple constructors prototypes into one
				for script in scripts
					proto = script::
					while proto and proto isnt Object::
						keys = Object.getOwnPropertyNames proto
						for key in keys
							if key is 'constructor'
								continue
							desc = Object.getOwnPropertyDescriptor proto, key

							# methods call from all prototypes
							if typeof desc.value is typeof ctor::[key] is 'function'
								desc.value = do (func1 = ctor::[key], func2 = desc.value) -> ->
									r1 = func1.apply @, arguments
									r2 = func2.apply @, arguments
									r1 or r2

							Object.defineProperty ctor::, key, desc

						proto = proto.__proto__

				file.storageConstructor = ctor

		return
