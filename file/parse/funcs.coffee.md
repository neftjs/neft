neft:func @xml
==============

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

<neft:func name="increment">
  item.text = parseInt(item.text) + 1 + '';
</neft:func>

<span neft:style="styles:button" neft:style:pointer:onClicked="increment">0</span>
```

You can use other functions declared in the same file (considering [neft:fragment][] scopes).

```
<neft:func name="multiply">
  var a = arguments[0],
      b = arguments[1];
  return a * b;
</neft:func>

<neft:func name="boost">
  item.text = view.funcs.multiply(item.text, item.text);
</neft:func>

<span neft:style="styles:button" neft:style:pointer:onClicked="boost">1</span>
```

	'use strict'

	coffee = require 'coffee-script'
	utils = require 'utils'

	parseLinksFile = require('document/file/parse/fragments/links')
	parseLinks = null
	module.exports = (File) ->
		parseLinks ?= parseLinksFile File

		(file) ->
			{Style} = File
			funcs = file.funcs ?= {}

			nodes = file.node.queryAll "#{File.HTML_NS}:func"
			for node in nodes
				name = node.attrs.get('name') or node.attrs.get('neft:name')
				unless name
					throw new Error 'Func name is requried'

				if funcs.hasOwnProperty name
					throw new Error "Func `#{name}` already exists"

				body = node.stringifyChildren()

				funcs[name] = body

				# remove node
				node.parent = null

			# merge funcs from files
			links = parseLinks file
			for link in links
				linkView = File.factory link.path
				for externalFuncName, externalFunc of linkView.funcs
					funcs[externalFuncName] ?= externalFunc

			return
