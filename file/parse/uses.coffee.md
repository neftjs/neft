neft:use @xml
=============

Tag used to place a [neft:fragment][document/neft:fragment@xml].

```xml
<neft:fragment neft:name="user">
  This is a user
</neft:fragment>

<neft:use neft:fragment="user" />
```

`neft:fragment` attribute can be changed in runtime.

```xml
<neft:fragment neft:name="h1">
  <h1>H1 heading</h1>
</neft:fragment>

<neft:use neft:fragment="h${data.level}" />
```

`neft:use` attributes are available in the [neft:fragment][document/neft:fragment@xml] scope.

```xml
<neft:fragment neft:name="h1">
  <h1>H1: ${data}</h1>
</neft:fragment>

<neft:use neft:fragment="h1" data="Test heading" />
```

## neft:async

Renders fragment on the first free animation frame.

Use this attribute to render less important elements.

```xml
<neft:use neft:fragment="body" neft:async />
```

	'use strict'

	utils = require 'neft-utils'

	module.exports = (File) -> (file) ->
		uses = []

		forNode = (node) ->
			unless node instanceof File.Element.Tag
				return

			node.children.forEach forNode

			# get uses
			if node.name is "neft:use"
				node.name = 'neft:blank'
				uses.push new File.Use file, node

		forNode file.node

		unless utils.isEmpty uses
			file.uses = uses
