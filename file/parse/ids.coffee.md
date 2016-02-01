id @xml
=======

[Tag][document/Tag] with the id attribute is saved in the local scope
(file, [neft:fragment][document/neft:fragment@xml], [neft:each][document/neft:each@xml] etc.)
and it's available in the string interpolation.

Id must be unique in the scope.

```xml
<h1 id="heading">Heading</h1>
<span>${heading.stringify()}</span>
```

	'use strict'

	utils = require 'utils'
	log = require 'log'

	log = log.scope 'Document'

	module.exports = (File) -> (file) ->
		{ids} = file

		forEachNodeRec = (node) ->
			for child in node.children
				unless child.children
					continue

				forEachNodeRec child

				unless id = child.attrs.get('id')
					continue

				if ids.hasOwnProperty(id)
					log.warn "Id must be unique; '#{id}' duplicated"
					continue
				ids[id] = child
			return

		forEachNodeRec file.node
