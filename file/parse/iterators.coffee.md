neft:each @xml
=========

This special *XML* attribute is used for repeating. It's called *iterator*.

Tag children (let's call them *iterator body*) will be duplicated for each
element defined in the [neft:each][] attribute.
Only *Array* and [List][] instances are supported.

```
<ul neft:each="[1, 2]">
  <li>ping</li>
</ul>
```

In the *iterator body* you have access to the three special variables:
**each**, **item** and **i**:

- **each** refers to the *neft:each* attribute,
- **item** refers to the current element,
- **i** refers to the current element index.

```
<ul neft:each="List('New York', 'Paris', 'Warsaw')">
  <li>Index: ${i}; Current: ${item}; Next: ${each.get(i+1)}</li>
</ul>
```

#### Runtime updates

It's recommended to use the [List][] module to iterate on it, because
all changes made on the [List][] automatically refreshes your view.

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
			fragment = new File.Fragment name, bodyNode

			# get iterator
			iterator = new File.Iterator file, elem, name
			iterators.push iterator
			`//<development>`
			iterator.text = attrVal
			`//</development>`

		forNode file.node
