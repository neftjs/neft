Using units @html
=================

Declared `File.Unit` can be used in the *HTML* file by using its name as a tag.

```
<neft:unit name="user">123</neft:unit>

<neft:user />
```

	'use strict'

	utils = require 'utils'

	# TODO: replace by language tag
	RESERVED_NAMES =
		'neft:unit': true
		'neft:func': true
		'neft:require': true
		'neft:link': true
		'neft:source': true

	module.exports = (File) -> (file) ->
		uses = {}

		forNode = (node) ->
			unless node instanceof File.Element.Tag
				return

			if RESERVED_NAMES[node.name] or node.name.indexOf("#{File.HTML_NS}:") isnt 0
				return node.children?.forEach forNode

			# get uses
			name = node.name.slice "#{File.HTML_NS}:".length
			nameUses = uses[name] ?= []
			nameUses.push new File.Use file, name, node

		forNode file.node

		unless utils.isEmpty uses
			file.uses = uses
