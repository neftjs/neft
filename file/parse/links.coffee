'use strict'

module.exports = (File) -> (file) ->

	# prepare
	links = file.links = []

	# load found files
	{children} = file.node
	i = -1
	n = children.length
	while ++i < n

		node = children[i]

		if node.name isnt 'x:require' or node.attrs.get('rel') isnt 'view'
			continue

		href = node.attrs.get 'href'
		unless href then continue

		namespace = node.attrs.get 'as'

		# remove link element
		node.parent = undefined
		i--; n--

		# get view
		view = File.factory file.pathbase + href
		links.push
			view: view
			namespace: namespace

	null