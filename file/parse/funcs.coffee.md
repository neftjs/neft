neft:function @xml
==================

This special *XML* tag is used to create new functions in a view file.

[Renderer.Item][] provides some signals (e.g. [Renderer.Item::pointer.onClicked][])
and gives a possibility to define your own ones
(e.g. *Item { signal activated; }* in **NML**).

Using this *XML* tag you can listen on these signals.

```
// styles/button.js
Text {
  font.pixelSize: 30
  color: 'red'
}

<neft:function name="increment">
  item.text = parseInt(item.text) + 1 + '';
</neft:function>

<span neft:style="styles:button" neft:style:pointer:onClicked="increment">0</span>
```

You can use other functions declared in the same file (considering [neft:fragment][] scopes).

```
<neft:function name="multiply">
  var a = arguments[0],
      b = arguments[1];
  return a * b;
</neft:function>

<neft:function name="boost">
  item.text = view.funcs.multiply(item.text, item.text);
</neft:function>

<span neft:style="styles:button" neft:style:pointer:onClicked="boost">1</span>
```

	'use strict'

	coffee = require 'coffee-script'
	utils = require 'utils'

	parseLinksFile = require('./fragments/links')
	parseLinks = null
	module.exports = (File) ->
		parseLinks ?= parseLinksFile File

		(file) ->
			{Style} = File
			funcs = file.funcs ?= {}

			nodes = file.node.queryAll "neft:function"
			for node in nodes
				name = node.attrs.get('name') or node.attrs.get('neft:name')
				unless name
					throw new Error 'Function name is requried'

				body = node.stringifyChildren()
				if argsAttr = node.attrs.get('arguments')
					args = argsAttr.split(',')
					for arg, i in args
						args[i] = arg.trim()
				else
					args = []
				funcs[name] =
					uid: utils.uid()
					body: body
					arguments: args

				# remove node
				node.parent = null

			# merge funcs from files
			links = parseLinks file
			for link in links
				linkView = File.factory link.path
				linkViewProto = Object.getPrototypeOf linkView
				for externalFuncName of linkView.funcs
					if externalFunc = linkViewProto.funcs[externalFuncName]
						funcs[externalFuncName] ?= externalFunc

			if utils.isEmpty(funcs)
				file.funcs = null

			return
