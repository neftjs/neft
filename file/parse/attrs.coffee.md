Attributes evaluating @html
===========================

Attributes in HTML are written as strings. For easiest developing, some of them are
automatically evaluating to the JavaScript objects.

String `[...]` is evaluated to the `Array`.
```
<ul neft:each="[1, 2]"></ul>
<neft:use:list items="[{name: 't-shirt'}]" />
```

String `{...}` is evaluated to the `Object`.
```
<neft:use:user data="{name: 'Johny'}" />
```

String `Dict ...` is evaluated to the `Dict`.
```
<neft:use:user data="Dict({name: 'Johny'})" />
```

String `List ...` is evaluated to the `List`.
```
<ul neft:each="List([1, 2])"></ul>
```

CoffeeScript syntax
-------------------

Using *CoffeeScript* syntax is fully allowed.

```
<ul neft:each="List [1, 2]"></ul>
```

	'use strict'

	utils = require 'utils'
	Dict = require 'dict'
	List = require 'list'
	coffee = require 'coffee-script' if utils.isNode

	attr = [null, null]

	VALUE_TO_EVAL_RE = ///^(\[|\{|Dict|List)///

	forNode = (elem) ->

		i = 0
		loop
			break unless elem.attrs
			elem.attrs.item i, attr

			[name, val] = attr
			break unless name

			if VALUE_TO_EVAL_RE.test val
				try
					code = coffee.compile attr[1], bare: true
					newVal = eval code
					elem.attrs.set attr[0], newVal

			i++

		elem.children?.forEach forNode

	module.exports = (File) -> (file) ->

		forNode file.node
