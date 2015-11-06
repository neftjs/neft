neft:fragment @xml
=============

This special *XML* tag is used to create separated and repeatable parts of the document
(sometimes called *templates*).

Each `neft:fragment` has to define a unique **neft:name**.

```
<neft:fragment neft:name="user"></neft:fragment>
```

Let's take an example: you want to represent a list of products.
Each product has the same properties, only data changed.
To avoid copying code, we move the common part to the [neft:fragment][] and paste it later
using the [neft:use][] tag. This is fast and clean solution.

```
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

	utils = require 'utils'

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
			forEachNodeRec = (node) ->
				unless children = node.children
					return
				i = -1; n = children.length
				while ++i < n
					child = children[i]

					if child.name isnt 'neft:fragment'
						forEachNodeRec child
						continue

					unless name = child.attrs.get('neft:name')
						continue

					# remove node from file
					node.name = 'neft:blank'
					child.parent = null
					i--; n--

					# get fragment
					fragment = new File.Fragment file, name, child
					fragments[name] = fragment.id
					createdFragments.push fragment

			forEachNodeRec file.node

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

			return
