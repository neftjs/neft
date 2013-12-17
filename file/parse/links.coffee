'use strict'

module.exports = (File) -> (_super) -> (file) ->

	_super.call null, file

	# prepare
	links = file.links = []

	# load found files
	for node in file.node.children

		if node.name isnt 'link' or node.attrs.get('rel') isnt 'require'
			continue

		href = node.attrs.get 'href'
		unless href then continue

		namespace = node.attrs.get 'as'

		# remove link element
		node.parent = undefined

		# get view
		view = File.factory file.pathbase + href
		view and links.push
			view: view
			namespace: namespace