neft:unit @html
===============

Special HTML tag used to create new `File.Unit`s.

```
<neft:unit name="user"></neft:unit>
```

	'use strict'

	utils = require 'utils'

	HASH_RE = ///////g

	module.exports = (File) -> (file) ->

		units = file.units ?= {}
		createdUnits = []

		# merge units from files
		if file.links
			for link in file.links
				namespace = if link.namespace then "#{link.namespace}-" else ''

				for name, unit of link.view.units
					units[namespace + name] = unit

		# find units in file
		children = file.node.children
		i = -1; n = children.length
		while ++i < n

			node = children[i]

			if node.name isnt "#{File.HTML_NS}:unit" then continue

			name = node.attrs.get 'name'
			unless name then continue

			node.attrs.set 'name', undefined

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
