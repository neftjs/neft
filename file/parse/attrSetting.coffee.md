Setting attributes @learn
=========================

[Element][document/Element] properties can be changed using attributes.

```xml
<div visible="false"></div>
```

Supports listening on signals as well.

Potentially it's more useful with more specific [Element][document/Element]s from extensions.

	'use strict'

	module.exports = (File) ->
		{AttrsToSet} = File
		{Tag} = File.Element

		(file) ->
			{attrsToSet} = file

			forEachNodeRec = (node) ->
				for child in node.children
					unless child instanceof Tag
						continue

					forEachNodeRec child

					nodeProps = null
					for prop of child._attrs
						if prop in ['name', 'children', 'attrs', 'style']
							continue
						unless prop of child
							continue
						nodeProps ?= {}
						nodeProps[prop] = true

					if nodeProps
						attrsToSet.push new AttrsToSet file, child, nodeProps
				return

			forEachNodeRec file.node

			return
