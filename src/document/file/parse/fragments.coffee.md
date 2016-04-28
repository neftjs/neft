neft:fragment @xml
==================

Tag used to create separated and repeatable parts of the document.

Each neft:fragment has to define a `neft:name` unique in the file where it's defined.

neft:fragment can be rendered by the [neft:use][document/neft:use@xml] tag.

```xml
<neft:fragment neft:name="product">
  <h2>${name}</h2>
  <span>Type: ${type}</span>
</neft:fragment>

<section>
  <neft:use neft:fragment="product" type="electronics" name="dryer" />
  <neft:use neft:fragment="product" type="painting" name="Lucretia, Paolo Veronese" />
</section>
```

	'use strict'

	utils = require 'src/utils'

	module.exports = (File) ->
		parseLinks = require('./fragments/links') File

		(file) ->
			{fragments} = file
			createdFragments = []

			# merge fragments from files
			links = parseLinks file
			for link in links
				namespace = if link.namespace then "#{link.namespace}:" else ''
				linkView = File.factory link.path

				for name, fragment of linkView.fragments
					fragments[namespace + name] = fragment

			# find fragments in file
			forEachNodeRec = (node) ->
				unless children = node.children
					return
				i = -1; n = children.length
				while ++i < n
					child = children[i]

					if child.name isnt 'neft:fragment'
						forEachNodeRec child
						continue

					unless name = child.attrs['neft:name']
						continue

					# remove node from file
					child.name = 'neft:blank'
					child.parent = null
					i--; n--

					# get fragment
					path = "#{file.path}##{name}"
					fragment = new File path, child
					fragments[name] = path
					createdFragments.push fragment

			forEachNodeRec file.node

			# link fragments
			for createdFragment in createdFragments
				for fragmentName, fragmentId of fragments
					createdFragment.fragments[fragmentName] ?= fragmentId

			# parse fragments
			for createdFragment in createdFragments
				File.parse createdFragment

			return
