neft:func @js
=============

	'use strict'

	utils = require 'utils'
	expect = require 'expect'
	Renderer = require 'renderer'

	stylesParseFuncs = require './parse/funcs'

	# link modules to be possible required by the funcs
	links = ['db', 'db-addons', 'db-schema', 'dict', 'emitter', 'expect', 'list',
	         'log', 'renderer', 'routing', 'schema', 'signal', 'utils', 'view']
	for link in links
		require link

	module.exports = (File) ->

		{Input, Unit} = File

*ReadOnly* *Object* globalObject
--------------------------------

Functions are created in their private scope.

Each function and property defined in this object comes global in the function body.

		FuncGlobalFuncs =

*Function* globalObject.require(*String* moduleName)
----------------------------------------------------

Require *Neft* modules like in normal *JavaScript* file.

```
<neft:func name="test">
  var utils = require('utils');
  return utils.arrayToObject([1, 2]);
</neft:func>
```

			require: require

*Function* globalObject.get(*String* propertyName)
--------------------------------------------------

Function used to find data with given name in the storage, that is: `neft:use` attributes
or global storage got from `App Route` etc.

```
<neft:func name="test">
  return get('user').name;
</neft:func>
```

			get: (prop) ->
				Input.getVal @, prop

		FuncGlobalGetters =

*Arguments* globalObject.arguments
----------------------------------

Object corresponding to the arguments passed to a function.

```
<neft:func name="followMouse">
  var e = arguments[0]; // Renderer.Item::onPointerMove comes with event argument
  return [e.x, e.y];
</neft:func>

<button neft:style="mouseArea" neft:style:onPointerMove="followMouse" />
```

			arguments: (_, args) -> args

*View* globalObject.view
------------------------

Global attribute which references to the current *XML* element `view` unit.

This is *low-level API*.

Using this attribute you can call other functions.

```
<neft:func name="add">
  return arguments[0] + arguments[1];
</neft:func>

<neft:func name="test">
  return "1 + 3 = " + view.funcs.add(1, 3);
</neft:func>
```

			view: -> @

[*Renderer.Item*] globalObject.item
-----------------------------------

Reference to the *low-level* `Renderer.Item` *API*.

This attribute is available, only if it's a `Renderer.Item` signal.

```
<neft:func name="test">
  return item.width * item.height;
</neft:func>

<rectangle neft:style="rectangle" neft:style:onPointerClicked="test" />
```

			item: (ctx) ->
				if ctx instanceof Renderer.Item
					ctx

[*App.View.GlobalStorage*] globalObject.global
----------------------------------------------

In most cases this attribute references to the `App.View.GlobalStorage` unless you render
`view` in a custom way (not using `App View`).

```
<neft:func name="changePage">
  global.uri.name = item.text;
</neft:func>

<button neft:style="enterName" neft:style:onPointerClicked="changePage" />
```

			global: -> @storage?.global

[*Any*] globalObject.data
-------------------------

Just a shortcut for `get('data')`.

			data: -> FuncGlobalFuncs.get.call @, 'data'

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
						unless unit
							continue

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
				funcs = stylesParseFuncs File
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