neft:fragment @xml
==================

Special XML tag used to create separated and repeatable parts of the document.

Each `neft:fragment` has to define a unique *name*.

```
<neft:fragment neft:name="user"></neft:fragment>
```

Let's take an example: you wan't to represent database of products.
Each product has the same properties, only data changed.
To avoid copying code, we move the common part to the `neft:fragment` and paste it later
using the `neft:use` tag. This is faster and cleaner.

```view,example
<neft:fragment neft:name="product">
  <type>#{type}</type>
  <name>#{name}</name>
</neft:fragment>

<products>
  <neft:use neft:fragment="product" type="electronics" name="dryer" />
  <neft:use neft:fragment="product" type="painting" name="Lucretia, Paolo Veronese" />
</products>
```

#### See also

- `neft:use`
- `String Interpolation`

.

	'use strict'

	utils = require 'utils'

	HASH_RE = ///////g

	module.exports = (File) ->
		parseLinks = require('./fragments/links') File

		(file) ->
			fragments = file.fragments ?= {}
			createdFragments = []

			# merge fragments from files
			links = parseLinks file
			for link in links
				namespace = if link.namespace then "#{link.namespace}:" else ''
				linkView = File.factory link.path

				for name, fragment of linkView.fragments
					fragments[namespace + name] = fragment

			# find fragments in file
			children = file.node.children
			i = -1; n = children.length
			while ++i < n

				node = children[i]

				if node.name isnt 'neft:fragment' then continue

				name = node.attrs.get 'neft:name'
				unless name then continue

				# remove node from file
				node.parent = undefined
				i--; n--

				# get fragment
				fragment = new File.Fragment file, name, node
				fragments[name] = fragment.id
				createdFragments.push fragment

			# link fragments
			for createdFragment in createdFragments
				for fragmentName, fragmentId of fragments
					# if fragmentId is createdFragment.id
					# 	continue
					if createdFragment.fragments.hasOwnProperty fragmentName
						continue

					createdFragment.fragments[fragmentName] = fragmentId

			# parse fragments
			for createdFragment in createdFragments
				createdFragment.parse()

			# if utils.isEmpty fragments
			# 	file.fragments = null
