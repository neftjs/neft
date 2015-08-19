id @xml
=======

	'use strict'

	utils = require 'utils'
	log = require 'log'

	log = log.scope 'Document'

	module.exports = (File) -> (file) ->
		ids = {}

		forEachNodeRec = (node) ->
			for child in node.children
				unless child.children
					continue

				forEachNodeRec child

				unless id = child.attrs.get('id')
					continue

				if ids.hasOwnProperty(id)
					log.warn "Id must be unique; '#{id}' duplicated"
					continue
				ids[id] = child
			return

		forEachNodeRec file.node

		unless utils.isEmpty(ids)
			file.ids = ids
