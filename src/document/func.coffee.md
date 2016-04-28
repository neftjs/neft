neft:function @js
=================

	'use strict'

	utils = require 'src/utils'
	assert = require 'src/assert'

	module.exports = (File) ->

		{Input} = File

ReadOnly *Object* globalObject
------------------------------

Used as a global namespace in the function body.

		FuncGlobalFuncs =

*Function* globalObject.require(*String* moduleName)
----------------------------------------------------

Requires standard Neft modules.

```xml
<neft:function neft:name="test">
	var utils = require('utils');
	return utils.arrayToObject([1, 2]);
</neft:function>
```

			require: require

		FuncGlobalGetters =

*Arguments* globalObject.arguments
----------------------------------

Array-like object with arguments passed to the function.

```xml
<neft:function neft:name="followMouse">
	var e = arguments[0]; // Renderer.Item::pointer.onMove comes with event argument
	return [e.x, e.y];
</neft:function>

<button style:pointer:onMove="${funcs.followMouse}" />
```

			arguments: (ctx, args) -> args

		funcGlobalProps = Object.keys(FuncGlobalFuncs)
		Array::push.apply funcGlobalProps, Object.keys(FuncGlobalGetters)
		funcGlobalPropsLength = funcGlobalProps.length

		functionsCache = Object.create null

		exports =
		bindFuncIntoGlobal: (opts, file) ->
			assert.instanceOf file, File

			# get bound function from cache
			if boundFunc = functionsCache[opts.uid]
				return boundFunc

			# get function
			argsNames = funcGlobalProps.concat(opts.arguments)
			func = new Function argsNames, opts.body

			# get arguments array for further calls
			args = new Array funcGlobalPropsLength + opts.arguments.length
			customArgsLength = opts.arguments.length

			# set global props
			for prop, i in funcGlobalProps
				args[i] = FuncGlobalFuncs[prop]

			# save into cache
			functionsCache[opts.uid] = (customArgs...) ->
				# call getters
				for prop, i in funcGlobalProps
					if globalGetter = FuncGlobalGetters[prop]
						args[i] = globalGetter @, customArgs

				# set function custom arguments
				for i in [0...customArgsLength] by 1
					args[funcGlobalPropsLength + i] = customArgs[i]

				# call function
				func.apply @, args
