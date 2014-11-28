'use strict'

utils = require 'utils'
expect = require 'expect'
Renderer = require 'renderer'

# link modules to be possible required by the funcs
links = ['db', 'db-addons', 'db-schema', 'dict', 'emitter', 'expect', 'list',
         'log', 'renderer', 'routing', 'schema', 'signal', 'utils', 'view']
for link in links
	require link

module.exports = (File) ->

	{Input, Unit} = File

	FuncGlobalFuncs =
		require: require
		get: (prop) ->
			Input.getVal @, prop

	FuncGlobalGetters =
		view: -> @
		global: -> @storage?.global
		data: -> FuncGlobalFuncs.get.call @, 'data'
		item: (ctx) ->
			if ctx instanceof Renderer.Item
				ctx

	funcGlobalProps = Object.keys(FuncGlobalFuncs)
	Array::push.apply funcGlobalProps, Object.keys(FuncGlobalGetters)

	bindFuncIntoGlobal = (func, file) ->
		expect(func).toBe.function()
		expect(file).toBe.any File

		args = []

		for prop, i in funcGlobalProps
			if globalFunc = FuncGlobalFuncs[prop]
				args[i] = globalFunc.bind file
			else
				args[i] = null

		->
			# call getters
			for prop, i in funcGlobalProps
				if globalGetter = FuncGlobalGetters[prop]
					args[i] = globalGetter.call file, @

			func.apply {}, args

	parseFuncsFromAssembled = (file) ->
		{funcs} = file
		if funcs
			for name, body of funcs
				funcs[name] = new Function funcGlobalProps, body
		null

	File.fromAssembled = do (_super = File.fromAssembled) -> (file) ->
		_super? file
		parseFuncsFromAssembled file
		null

	Unit.fromAssembled = do (_super = Unit.fromAssembled) -> (file) ->
		_super? file
		parseFuncsFromAssembled file
		null

	File::funcs = null

	if utils.isNode
		linkUnits = (funcs, target) ->
			for name, func of funcs
				for _, unitName of target.units
					unit = File._files[unitName]
					unitFuncs = unit.funcs

					# don't override funcs
					if unitFuncs.hasOwnProperty name
						continue

					# save function
					unitFuncs[name] = func

					# safe function recursively
					linkUnits funcs, unit

			null

		File.onParsed do ->
			funcs = require('./parse/funcs') File
			(file) ->
				funcs file

				# link local funcs into units
				linkUnits file.funcs, file

	File::clone = do (_super = File::clone) -> ->
		clone = _super.call @

		# bind funcs
		if @funcs
			clone.funcs = {}
			for name, func of @funcs
				clone.funcs[name] = bindFuncIntoGlobal func, clone

		clone