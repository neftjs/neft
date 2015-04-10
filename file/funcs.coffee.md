neft:func @js
=============

	'use strict'

	utils = require 'utils'
	expect = require 'expect'
	Renderer = require 'renderer'

	if utils.isNode
		stylesParseFuncs = require './parse/funcs'

	# link modules to be possible required by the funcs
	links = ['db', 'db-addons', 'db-schema', 'dict', 'emitter', 'expect', 'list',
	         'log', 'renderer', 'networking', 'schema', 'signal', 'utils', 'document']
	for link in links
		require link

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

This object corresponds to the arguments object passed to a function.

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

*DocumentGlobalData* globalObject.global
----------------------------------------

In most cases this variable refers to the [DocumentGlobalData][] unless you render
a view not using [App.View][].

```
<neft:func neft:name="changePage">
  global.uri.name = item.text;
</neft:func>

<button neft:style="enterName" neft:style:pointer:onClicked="changePage" />
```

			global: -> @storage?.global

*Any* globalObject.data
-----------------------

This variable refers to the *get('data')* value.

			data: -> FuncGlobalFuncs.get.call @, 'data'

		funcGlobalProps = Object.keys(FuncGlobalFuncs)
		Array::push.apply funcGlobalProps, Object.keys(FuncGlobalGetters)

		bindFuncIntoGlobal = (func, file) ->
			if typeof func isnt 'function'
				return func

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
						args[i] = globalGetter.call file, @, arguments

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

		Fragment.fromAssembled = do (_super = Fragment.fromAssembled) -> (file) ->
			_super? file
			parseFuncsFromAssembled file
			null

		File::funcs = null

		if utils.isNode
			linkFragments = (funcs, target) ->
				for name, func of funcs
					for _, fragmentName of target.fragments
						fragment = File._files[fragmentName]
						unless fragment
							continue

						fragmentFuncs = fragment.funcs

						# don't override funcs
						if fragmentFuncs.hasOwnProperty name
							continue

						# save function
						fragmentFuncs[name] = func

						# safe function recursively
						linkFragments funcs, fragment

				null

			File.onParsed do ->
				funcs = stylesParseFuncs File
				(file) ->
					funcs file

					# link local funcs into fragments
					linkFragments file.funcs, file

		File::clone = do (_super = File::clone) -> ->
			clone = _super.call @

			# bind funcs
			if @funcs
				clone.funcs = {}
				for name, func of @funcs
					clone.funcs[name] = bindFuncIntoGlobal func, clone

			clone
