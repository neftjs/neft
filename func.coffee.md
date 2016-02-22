neft:function @js
=================

	'use strict'

	utils = require 'utils'
	assert = require 'assert'
	Renderer = require 'renderer'

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

*Function* globalObject.get(*String* propertyName)
--------------------------------------------------

Gets property value from the local scope.

It's internally used in the string interpolation.

```xml
<neft:function neft:name="test">
	return get('user').name;
</neft:function>
```

			get: (prop) ->
				Input.getVal @, prop

		FuncGlobalGetters =

*Arguments* globalObject.arguments
----------------------------------

Array-like object with arguments passed to the function.

```xml
<neft:function neft:name="followMouse">
	var e = arguments[0]; // Renderer.Item::pointer.onMove comes with event argument
	return [e.x, e.y];
</neft:function>

<button neft:style:pointer:onMove="${followMouse}" />
```

			arguments: (_, args) -> args

*Document* globalObject.view
----------------------------

Reference to the [File][document/File] where the function is placed.

```xml
<neft:function neft:name="add">
	return arguments[0] + arguments[1];
</neft:function>

<neft:function neft:name="print">
	return "1 + 3 = " + view.funcs.add(1, 3);
</neft:function>
```

			view: -> @

*Renderer.Item* globalObject.item
---------------------------------

Reference to the [Renderer.Item][renderer/Item].

It's available when the function was call on the style signal.

```xml
<neft:function neft:name="test">
	item.width += 10;
</neft:function>

<rectangle neft:style:pointer:onClick="${test}" />
```

			item: (ctx) ->
				if ctx and ctx._ref
					ctx = ctx._ref
				if ctx instanceof Renderer.Item
					ctx

		funcGlobalProps = Object.keys(FuncGlobalFuncs)
		Array::push.apply funcGlobalProps, Object.keys(FuncGlobalGetters)
		funcGlobalPropsLength = funcGlobalProps.length

		functionsCache = Object.create null

		exports =
		bindFuncIntoGlobal: (opts, file) ->
			assert.instanceOf file, File

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
				func.apply this, args
