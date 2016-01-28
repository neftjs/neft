Attributes evaluating @learn
============================

Some of the attributes are automatically evaluated to the JavaScript objects.

String `[...]` evaluates to the array.
```xml
<items neft:each="[1, 2]"></items>
```xml
```
<neft:use neft:fragment="list" items="[{name: 't-shirt'}]" />
```

String `{...}` evaluates to the object.
```xml
<neft:use neft:fragment="user" data="{name: 'Johny'}" />
```

String `Dict(...` evaluates to the [Dict][dict/Dict].
```xml
<neft:use neft:fragment="user" data="Dict({name: 'Johny'})" />
```

String `List(...` evaluates to the [List][list/List].
```xml
<items neft:each="List([1, 2])"></items>
```

	'use strict'

	utils = require 'utils'
	Dict = require 'dict'
	List = require 'list'

	evalFunc = new Function 'val', 'try { return eval(\'(\'+val+\')\'); } catch(err){}'

	forNode = (elem) ->
		if elem._attrs
			for name, val of elem._attrs
				jsVal = evalFunc val
				if jsVal isnt undefined and not (jsVal instanceof RegExp)
					elem.setAttr name, jsVal

		elem.children?.forEach forNode

	module.exports = (File) -> (file) ->
		forNode file.node
