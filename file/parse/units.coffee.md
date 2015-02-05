neft:unit @xml
==============

Special XML tag used to create separated and repeatable parts of the document.

Each `neft:unit` has to define a unique *name*.

```
<neft:unit neft:name="user"></neft:unit>
```

Let's take an example: you wan't to represent database of products.
Each product has the same properties, only data changed.
To avoid copying code, we move the common part to the `neft:unit` and paste it later
using the `neft:use` tag. This is faster and cleaner.

```view,example
<neft:unit neft:name="product">
  <type>#{type}</type>
  <name>#{name}</name>
</neft:unit>

<products>
  <neft:use neft:unit="product" type="electronics" name="dryer" />
  <neft:use neft:unit="product" type="painting" name="Lucretia, Paolo Veronese" />
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
		parseLinks = require('./units/links') File

		(file) ->
			units = file.units ?= {}
			createdUnits = []

			# merge units from files
			links = parseLinks file
			for link in links
				namespace = if link.namespace then "#{link.namespace}:" else ''
				linkView = File.factory link.path

				for name, unit of linkView.units
					units[namespace + name] = unit

			# find units in file
			children = file.node.children
			i = -1; n = children.length
			while ++i < n

				node = children[i]

				if node.name isnt "#{File.HTML_NS}:unit" then continue

				name = node.attrs.get 'neft:name'
				unless name then continue

				# remove node from file
				node.parent = undefined
				i--; n--

				# get unit
				unit = new File.Unit file, name, node
				units[name] = unit.id
				createdUnits.push unit

			# link units
			for createdUnit in createdUnits
				for unitName, unitId of units
					# if unitId is createdUnit.id
					# 	continue
					if createdUnit.units.hasOwnProperty unitName
						continue

					createdUnit.units[unitName] = unitId

			# parse units
			for createdUnit in createdUnits
				createdUnit.parse()

			# if utils.isEmpty units
			# 	file.units = null
