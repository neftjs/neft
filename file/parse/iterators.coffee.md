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

	utils = require 'utils'

	module.exports = (File) -> (file) ->
		{iterators} = file

		forNode = (elem) ->
			unless attrVal = elem.attrs?.get("#{File.HTML_NS}:each")
				return elem.children?.forEach forNode

			prefix = if file.name then "#{file.name}-" else ''
			name = "#{prefix}each[#{utils.uid()}]"

			# get fragment
			bodyNode = new File.Element.Tag
			for child in elem.children
				child.parent = bodyNode
			fragment = new File name, bodyNode

			# get iterator
			iterator = new File.Iterator file, elem, name
			iterators.push iterator
			`//<development>`
			iterator.text = attrVal
			`//</development>`

		forNode file.node
