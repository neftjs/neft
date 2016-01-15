neft:function @xml
==================

Tag used to create functions in the view.

```
<neft:function name="multiply" arguments="a, b">
  return a * b;
</neft:function>

<neft:function name="boost">
  item.text = view.funcs.multiply(item.text, item.text);
</neft:function>

<button neft:style:pointer:onClick="${boost}">1</button>
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
			{funcs} = file

			nodes = file.node.queryAll "neft:function"
			for node in nodes
				name = node.getAttr('name') or node.getAttr('neft:name')
				unless name
					throw new Error 'Function name is requried'

				body = node.stringifyChildren()
				if argsAttr = node.getAttr('arguments')
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

			return
