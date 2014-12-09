Using units @html
=================

Declared `File.Unit` can be used in the *HTML* file by using its name as a tag.

```
<neft:unit name="user">123</neft:unit>

<neft:use:user />
```

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
