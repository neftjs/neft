neft:func @xml
==============

Special XML tag used to create new functions.

Standard `Renderer.Item` provides some standard `signal`s
(e.g. `Renderer.Item::onPointerClicked`) and gives a possibility to define your own ones
(e.g. `Item { signal activated; }` in `NML`).

Using this *XML* tag you can listen on this signals just from the `view`.

```nml,include(Button)
Text {
  font.pixelSize: 30
  color: 'red'
}
```

```view,example
<neft:func name="increment">
  item.text = parseInt(item.text) + 1 + '';
</neft:func>

<span neft:style="styles.button" neft:style:onPointerClicked="increment">0</span>
```

Functions are scoping in `neft:unit`s, so you can easily use other functions declarated
in the same file.

```view,example
<neft:func name="multiply">
  var a = arguments[0],
      b = arguments[1];
  return a * b;
</neft:func>

<neft:func name="boost">
  item.text = view.funcs.multiply(item.text, item.text);
</neft:func>

<span neft:style="styles.button" neft:style:onPointerClicked="boost">1</span>
```

#### CoffeeScript syntax

Using *CoffeeScript* syntax is fully allowed.

```
<neft:func name="prettyStuff">
  unless get('lunch') is 'Cake'
    item.text = "Omnomnom..."
</neft:func>
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