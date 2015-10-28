neft:function @js
=================

	'use strict'

	utils = require 'utils'
	expect = require 'expect'
	Renderer = require 'renderer'

	# link modules to be possible required by the funcs
	# links = ['db', 'dict', 'emitter', 'expect', 'list', 'log', 'renderer',
	#          'networking', 'schema', 'signal', 'utils', 'document', 'assert']
	# for link in links
	# 	require link

	module.exports = (File) ->

		{Input, Fragment} = File

ReadOnly *Object* globalObject
------------------------------

This object is used as a global namespace in the function bodies.

		FuncGlobalFuncs =

*Function* globalObject.require(*String* moduleName)
----------------------------------------------------

Use this function to require *Neft* modules like in a normal *JavaScript* file.

```
<neft:func neft:name="test">
  var utils = require('utils');
  return utils.arrayToObject([1, 2]);
</neft:func>
```

			require: require

*Function* globalObject.get(*String* propertyName)
--------------------------------------------------

This function is used to find a data.

It's used internally by the string interpolation to find a property in various places
(*HTML* tag attributes, [neft:use][] tag attributes and *global* data).

```
<neft:func neft:name="test">
  return get('user').name;
</neft:func>
```

			get: (prop) ->
				Input.getVal @, prop

		FuncGlobalGetters =

*Arguments* globalObject.arguments
----------------------------------

This object corresponds to the arguments object passed to the function.

```
<neft:func neft:name="followMouse">
  var e = arguments[0]; // Renderer.Item::pointer.onMove comes with event argument
  return [e.x, e.y];
</neft:func>

<button neft:style="mouseArea" neft:style:pointer:onMove="followMouse" />
```

			arguments: (_, args) -> args

*Document* globalObject.view
----------------------------

This variable refers to the current *XML* element [neft:fragment][].

This is a *low-level API* and it's not documented.

Using this attribute you can call other functions.

```
<neft:func neft:name="add">
  return arguments[0] + arguments[1];
</neft:func>

<neft:func neft:name="print">
  return "1 + 3 = " + view.funcs.add(1, 3);
</neft:func>
```

			view: -> @

*Renderer.Item* globalObject.item
---------------------------------

This variable refers to the [Renderer.Item][].

It's available, only if it's a [Renderer.Item][] signal.

```
<neft:func neft:name="test">
  return item.width * item.height;
</neft:func>

<rectangle neft:style="rectangle" neft:style:onPointerClicked="test" />
```

			item: (ctx) ->
				if ctx and ctx._ref
					ctx = ctx._ref
				if ctx instanceof Renderer.Item
					ctx

		funcGlobalProps = Object.keys(FuncGlobalFuncs)
		Array::push.apply funcGlobalProps, Object.keys(FuncGlobalGetters)
		funcGlobalPropsLength = funcGlobalProps.length

		globalContext = {}
		functionsCache = Object.create null

		exports =
		bindFuncIntoGlobal: (opts, file) ->
			expect(file).toBe.any File

			# get function
			unless func = functionsCache[opts.uid]
				args = funcGlobalProps.concat(opts.arguments)
				func = functionsCache[opts.uid] = new Function args, opts.body

			# get arguments array for further calls
			args = new Array funcGlobalPropsLength + opts.arguments.length
			customArgsLength = opts.arguments.length

			for prop, i in funcGlobalProps
				if globalFunc = FuncGlobalFuncs[prop]
					args[i] = globalFunc.bind file
				else
					args[i] = null

			->
				# call getters
				for prop, i in funcGlobalProps
					if globalGetter = FuncGlobalGetters[prop]
						args[i] = globalGetter.call file, @, arguments

				# set function custom arguments
				for i in [0...customArgsLength] by 1
					args[funcGlobalPropsLength + i] = arguments[i]

				# call function
				func.apply globalContext, args
