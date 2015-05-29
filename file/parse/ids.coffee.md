id @xml
=======

	'use strict'

	utils = require 'utils'
	log = require 'log'

	log = log.scope 'Document'

	module.exports = (File) -> (file) ->
		ids = {}

		nodes = file.node.queryAll '[id]'
		for node in nodes
			id = node.attrs.get 'id'
			if ids.hasOwnProperty(id)
				log.warn "Id must be unique; '#{id}' duplicated"
				continue
			ids[id] = node

		unless utils.isEmpty(ids)
			file.ids = ids
