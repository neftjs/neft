neft:if @html
=============

Special HTML attribute using to create new `File.Condition`s.

```
<span neft:if="1 > 0">1 is greater than 0</span>
```

	'use strict'

	module.exports = (File) ->
		{Condition} = File

		(file) ->

			conditions = file.conditions = []

			nodes = file.node.queryAll "[#{File.HTML_NS}:if]"

			for node in nodes
				attr = node.attrs.get "#{File.HTML_NS}:if"
				continue unless attr

				conditions.push new File.Condition
					self: file
					node: node

			null