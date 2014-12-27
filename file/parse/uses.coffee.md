neft:use @xml
=============

Special XML tag used to place `neft:unit`.

```view,example
<neft:unit name="user">This is user</neft:unit>

<neft:use:user />
```

### See also

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

			if node.name.indexOf("#{File.HTML_NS}:use:") isnt 0
				return node.children?.forEach forNode

			# get uses
			name = node.name.slice "#{File.HTML_NS}:use:".length
			uses.push new File.Use file, name, node

		forNode file.node

		unless utils.isEmpty uses
			file.uses = uses
