neft:each @xml
==============

Special XML attribute used for repeating. It's called *iterator*.

Tag children (let's call it *iterator body*) will be duplicated for each
element defined in the [neft:each][] attribute.
Only *Array* and [List][] instances are supported.

```
<ul neft:each="[1, 2]">
  <li>ping</li>
</ul>
```

In the *iterator body* you have access to the three special variables:
***each***, ***item*** and ***i***.

***each*** refers to the *neft:each* attribute,
***item*** refers to the current element and
***i*** refers to the current element index.

```
<ul neft:each="List('New York', 'Paris', 'Warsaw')">
  <li>Index: ${i}; Current: ${item}; Next: ${each.get(i+1)}</li>
</ul>
```

#### Runtime updates

It's recommended to use the `List` module to iterate.
All changes made on the `List` will automatically refresh your view, so
feel free to append and remove elements from the list - *iterator body* will be synchronized.

	'use strict'

	module.exports = (File) -> (file) ->
		# get iterators
		iterators = []

		forNode = (elem) ->
			unless elem.attrs?.get "#{File.HTML_NS}:each"
				return elem.children?.forEach forNode

			# get iterator
			iterators.push new File.Iterator file, elem

		forNode file.node

		if iterators.length
			file.iterators = iterators
