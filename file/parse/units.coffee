'use strict'

HASH_RE = ///////g

module.exports = (File) -> (file) ->

	units = file.units ?= {}

	# merge units from files
	for link in file.links

		namespace = if link.namespace then "#{link.namespace}-" else ''

		for name, unit of link.view.units

			units[namespace + name] = unit

	# find units in file
	children = file.node.children
	i = -1; n = children.length
	while ++i < n

		node = children[i]

		if node.name isnt 'unit' then continue

		name = node.attrs.get 'name'
		unless name then continue

		node.attrs.set 'name', undefined

		# remove node from file
		node.parent = undefined
		i--; n--

		# get unit
		units[name] = new File.Unit file, name, node

	null