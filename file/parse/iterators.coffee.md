neft:each @xml
==============

Attribute used for repeating.

Tag children will be duplicated for each
element defined in the `neft:each` attribute.

Supports arrays and [List][list/List] instances.

```xml
<ul neft:each="[1, 2]">
  <li>ping</li>
</ul>
```

In the tag children you have access to the three special variables:
- **each** - `neft:each` attribute,
- **item** - current element,
- **i** - current element index.

```xml
<ul neft:each="List(['New York', 'Paris', 'Warsaw'])">
  <li>Index: ${i}; Current: ${item}; Next: ${each.get(i+1)}</li>
</ul>
```

## Runtime changes

Use [List][list/List] to bind changes made in the array.

	'use strict'

	utils = require 'neft-utils'

	module.exports = (File) -> (file) ->
		{iterators} = file
		createdFragments = []

		forNode = (elem) ->
			unless attrVal = elem.attrs.get("neft:each")
				for child in elem.children
					if child instanceof File.Element.Tag
						forNode child
				return

			path = "#{file.path}:each[#{utils.uid()}]"

			# get fragment
			bodyNode = new File.Element.Tag
			while child = elem.children[0]
				child.parent = bodyNode
			fragment = new File path, bodyNode
			utils.merge fragment.fragments, file.fragments
			createdFragments.push fragment

			# get iterator
			iterator = new File.Iterator file, elem, path
			iterators.push iterator
			`//<development>`
			iterator.text = attrVal
			`//</development>`

		forNode file.node

		# parse created fragments
		for fragment in createdFragments
			File.parse fragment

		return
