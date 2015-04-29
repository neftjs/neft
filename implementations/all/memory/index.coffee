'use strict'

utils = require 'utils'
log = require 'log'

Table = require './Table.coffee'
Collection = require './Collection.coffee'

module.exports = (Db, name, config={}) ->
	impl =
		data: Object.create(null)

	class MemoryDb extends Db
		@memory = impl

		@Table = Table(@, impl)
		@Collection = Collection(@, impl)

		setImmediate =>
			@ready()
