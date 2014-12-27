neft:if @xml
============

Special XML attribute used to hide or show tags depends on the condition result.

Considering the example below, the output always will be `<span>1 is greater than 0</span>`,
because the condition (`1 > 0`) is always true, isn't it?

```view,example
<text neft:if="1 > 0">1 is greater than 0</text>
```

If we change the condition to the `0 > 1`, which of course is a false, we will get an empty
output, because the whole tag `<span>` will be omitted.

In pratice, you will use the string interpolation to conditioning the result.

```
<name neft:if="#{user.age} > 18">#{user.login}</name>
```

### See also

- `String Interpolation`
- `Attributes evaluating`

.

	'use strict'

	module.exports = (File) ->
		{Condition} = File

		(file) ->
			conditions = []

			nodes = file.node.queryAll "[#{File.HTML_NS}:if]"

			for node in nodes
				attr = node.attrs.get "#{File.HTML_NS}:if"
				continue unless attr

				conditions.push new File.Condition
					self: file
					node: node

			if conditions.length
				file.conditions = conditions