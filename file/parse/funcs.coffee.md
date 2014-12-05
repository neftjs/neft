neft::func @html
================

Special HTML tag used to create new view functions.

```
<neft:func name="increment">
  item.text = parseInt(item.text) + 1 + ''
</neft:func>

<span neft:style="button" neft:style:onPointerClicked="increment">0</span>
```

	'use strict'

	coffee = require 'coffee-script'
	utils = require 'utils'

	module.exports = (File) -> (file) ->

		{Style} = File
		funcs = file.funcs ?= {}

		nodes = file.node.queryAll "#{File.HTML_NS}:func"
		for node in nodes
			name = node.attrs.get 'name'
			unless name
				throw 'Func name is requried'

			if funcs.hasOwnProperty name
				throw "Func `#{name}` already exists"

			body = node.stringifyChildren()
			try
				body = coffee.compile body, bare: true

			funcs[name] = body

			# remove node
			node.parent = null

		null