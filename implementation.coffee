'use strict'

utils = require 'utils'

# list of implementations by the priority
impls = switch true
	when utils.isNode
		rethinkdb: require './implementations/node/rethinkdb'
		mysql: require './implementations/node/mysql'
	else
		{}

impls.memory = require './implementations/all/memory'

module.exports = (Db, type='auto', name, config) ->
	if type is 'auto'
		for k, v of impls
			if typeof v is 'function'
				type = k
				break
		if type is 'auto'
			throw new Error "No database implementation is available"

	impl = impls[type]
	if typeof impl isnt 'function'
		throw new Error "Database '#{type}' can't be initialized; " + impl.error

	Db.implementation = type
	impl Db, name, config