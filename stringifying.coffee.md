	'use strict'

	expect = require 'expect'

	{isArray} = Array

	module.exports = (utils) ->

### TODO: simplify()

Convert passed object into the most simplified format.
Such object can be easily stringified.
Use `assemble()` method to restore into initial structure.

Second optional parameter is an config object.
Possible options to define (all are `false` by default):
  - `properties` - save properties descriptions (getters, config etc.),
  - `protos` - save proto as object,
  - `constructors` - include constructors functions.

If `protos` is `false` and `constructors` is `true` objects will be taken as instances (example 2).

Examples
  1. ```
     obj = {}
     obj.self = obj
     JSON.stringify utils.simplify obj
     ```
  2. ```
     class Sample
     	constructor: -> @fromInst = 1
     	fromProto: 1
     sample = new Sample
     parts = utils.simplify sample, constructors: true
     clone = utils.assemble json
     # it's true because `protos` option is `false` and `constructors` is true
     # won't work for json, because functions are not stringified - do it on your own
     assert(clone instanceof Sample)
     ```

 * * *

		utils.simplify = do ->

			nativeProtos = [Array::, Object::]
			nativeCtors = [Array, Object]

			(obj, opts={}) ->

				expect(obj).toBe.object()
				expect(opts).toBe.simpleObject()

				optsProps = opts.properties ?= false
				optsProtos = opts.protos ?= false
				optsCtors = opts.constructors ?= false
				optsInsts = opts.instances = not optsProtos and optsCtors

				# list of objects
				objs = []

				# list of lists of ids per object
				ids = []

				# lists of keys to references per object
				references = {}

				# objects constructors
				if optsCtors then ctors = {}

				# proto destination to proto object
				if optsProtos then protos = {}

				# get cyclic references in the object
				cyclic = (obj) ->

					len = objs.push obj
					ids.push objIds = []

					for key, value of obj when obj.hasOwnProperty key

						unless value and typeof value is 'object'
							continue

						# don't check getters values
						if optsProps and exports.lookupGetter obj, key
							objIds.push null
							continue

						# check whether obj already exists
						unless ~(i = objs.indexOf value)
							i = cyclic value

						objIds.push i

					# cycle proto
					if optsProtos and proto = getPrototypeOf obj

						# don't save protos for native ones (Array, Object, etc..)
						if ~(nativeProtos.indexOf proto)
							i = null

						# find recursively if it's for first time
						else unless ~(i = objs.indexOf proto)
							i = cyclic proto

						objIds.push i

					len - 1

				# parse object
				parse = (obj, index) ->

					r = if isArray obj then [] else {}
					objIds = ids[index]

					# Create `references` for each object with keys which are a references to others
					# Value of each property will be changed to referenced object id
					obji = 0
					objReferences = null
					for key, value of obj when obj.hasOwnProperty key

						r[key] = value

						isReference = false

						# save as reference
						if value and typeof value is 'object'
							objReferences ?= []

							objId = value = objIds[obji++]

							# with `optsProps` id can be a null when value is an object
							if value isnt null
								isReference = true
								objReferences.push key

						# save as property description
						if optsProps
							desc = getObjOwnPropDesc obj, key
							desc.value = value if isReference
							value = desc

						# override prop value as referenced object id
						r[key] = value

					# save reference to proto
					if optsProtos and getPrototypeOf obj
						protoObjId = objIds[obji++]
						if protoObjId isnt null
							protos[index] = protoObjId

					# save ctor if needed
					if optsCtors and ctor = obj.constructor

						# save for instance or for prototype depend on the flag
						if optsInsts or obj.hasOwnProperty('constructor')

							# omits native constructors (Array, Object etc.)
							unless ~(nativeCtors.indexOf ctor)
								ctors[index] = ctor

					# save object references
					if objReferences then references[index] = objReferences

					r

				# find cycles
				cyclic obj

				# parse all found objects
				for value, i in objs
					objs[i] = parse value, i

				# return
				opts: opts
				objects: objs
				references: references
				protos: protos
				constructors: ctors

### assemble()

Backward `simplify()` operation.

		utils.assemble = do ->

			ctorPropConfig = value: null

			(obj) ->

				expect(obj).toBe.simpleObject()

				{opts, objects, references, protos, constructors} = obj

				optsProps = opts.properties
				optsProtos = opts.protos
				optsCtors = opts.constructors
				optsInsts = opts.instances

				# list of all referenced objects ids
				refsIds = []

				# set references
				if optsProps
					for objI, refs of references
						obj = objects[objI]

						for ref in refs
							refsIds.push obj[ref].value
							obj[ref].value = objects[obj[ref].value]
				else
					for objI, refs of references
						obj = objects[objI]

						for ref in refs
							refsIds.push obj[ref]
							obj[ref] = objects[obj[ref]]

				# set properties
				if optsProps
					for obj in objects
						for key, value of obj when obj.hasOwnProperty key
							defObjProp obj, key, value

				# set protos
				for objI, refI of protos
					objects[objI] = utils.setPrototypeOf objects[objI], objects[refI]

				# set objects as instances
				if optsInsts
					for objI, func of constructors
						object = objects[objI] = utils.setPrototypeOf objects[objI], func::

						# call `fromAssebled` if exists
						func.fromAssembled? object

				# .. or set ctors as properties
				else if optsCtors
					for objI, func of constructors
						ctorPropConfig.value = func
						defObjProp objects[objI], 'constructor', ctorPropConfig

				# update references, because same of them could changed by `setPrototypeOf`
				refId = 0
				for objI, refs of references
					obj = objects[objI]

					for ref in refs
						obj[ref] = objects[refsIds[refId++]]

				objects[0]

