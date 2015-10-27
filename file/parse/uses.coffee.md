neft:use @xml
========

This special *XML* tag is used to place the [neft:fragment][].

```
<neft:fragment neft:name="user">
  This is user
</neft:fragment>

<neft:use neft:fragment="user" />
```

**neft:fragment** attribute can be dynamic and determined by the string interpolation.

```
<neft:fragment neft:name="h1">
  <h1>H1: ${data}</h1>
</neft:fragment>

<neft:fragment neft:name="h2">
  <h2>H2: ${data}</h2>
</neft:fragment>

<neft:use neft:fragment="h${data.level}" data="${data.text}" />
```

	'use strict'

	utils = require 'utils'

	module.exports = (File) -> (file) ->
		uses = []

		forNode = (node) ->
			unless node instanceof File.Element.Tag
				return

			node.children.forEach forNode

			# get uses
			if node.name is "neft:use"
				uses.push new File.Use file, node

		forNode file.node

		unless utils.isEmpty uses
			file.uses = uses
