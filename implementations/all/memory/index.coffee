'use strict'

utils = require 'utils'
log = require 'log'

module.exports = (Db, name, config={}) ->
	impl =
		data: Object.create(null)

	class MemoryDb extends Db
		@memory = impl

		@Table = require('./Table.coffee')(@, impl)
		@Collection = require('./Collection.coffee')(@, impl)

		setImmediate =>
			@ready()
