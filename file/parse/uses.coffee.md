neft:use @xml
=============

Special XML tag used to place `neft:unit`.

```view,example
<neft:unit name="user">This is user</neft:unit>

<neft:use unit="user" />
```

#### See also

- `neft:unit`
- `neft:source`

.

	'use strict'

	utils = require 'utils'

	module.exports = (File) -> (file) ->
		uses = []

		forNode = (node) ->
			unless node instanceof File.Element.Tag
				return

			if node.name isnt "#{File.HTML_NS}:use"
				return node.children?.forEach forNode

			# get uses
			uses.push new File.Use file, node

		forNode file.node

		unless utils.isEmpty uses
			file.uses = uses
