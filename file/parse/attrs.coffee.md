Attributes evaluating @learn
==========================

For easiest developing, some of the *XML* attributes are automatically
evaluated to the JavaScript objects.

String `[...]` evaluates to the `Array`.
```
<items neft:each="[1, 2]"></items>
```
```
<neft:use neft:fragment="list" items="[{name: 't-shirt'}]" />
```

String `{...}` evaluates to the `Object`.
```
<neft:use neft:fragment="user" data="{name: 'Johny'}" />
```

String `Dict(...` evaluates to the [Dict][].
```
<neft:use neft:fragment="user" data="Dict({name: 'Johny'})" />
```

String `List(...` evaluates to the [List][].
```
<items neft:each="List(1, 2)"></items>
```

	'use strict'

	utils = require 'utils'
	Dict = require 'dict'
	List = require 'list'
	coffee = require 'coffee-script' if utils.isNode

	attr = [null, null]

	VALUE_TO_EVAL_RE = ///^(\[|\{|Dict\(|List\()///

	evalFunc = new Function 'val', 'try { return eval(\'(\'+val+\')\'); } catch(err){}'

	forNode = (elem) ->
		if elem._attrs
			for name, val of elem._attrs
				jsVal = evalFunc val
				if jsVal isnt undefined
					elem.setAttr name, jsVal

		elem.children?.forEach forNode

	module.exports = (File) -> (file) ->

		forNode file.node
