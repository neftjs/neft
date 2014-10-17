'use strict'

[utils, expect] = ['utils', 'expect'].map require
Renderer = require 'renderer'

module.exports = (File) ->

	{Input, Unit} = File

	FuncGlobalFuncs =
		get: (prop) ->
			Input.getVal @, prop

	FuncGlobalGetters =
		item: (ctx) ->
			if ctx instanceof Renderer.Scope.Item
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
		File.onParsed do ->
			funcs = require('./parse/funcs') File
			(file) ->
				funcs file

	File::clone = do (_super = File::clone) -> ->
		clone = _super.call @

		# bind funcs
		if @funcs
			clone.funcs = {}
			for name, func of @funcs
				clone.funcs[name] = bindFuncIntoGlobal func, clone

		clone