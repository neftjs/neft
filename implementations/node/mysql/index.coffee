'use strict'

utils = require 'utils'
log = require 'log'

log = log.scope 'Db', 'MySQL'

try
	mysql = require 'mysql'
catch
	exports.error = "'mysql' module is not installed"
	return;

Table = require './Table.coffee'
Collection = require './Collection.coffee'

# CONFIG
HOST = 'localhost'

module.exports = (Db, name, config={}) ->
	config.host ?= HOST
	config.database ?= name
	pool = mysql.createPool config

	impl =
		mysql: mysql
		pool: pool

	pool.getConnection (err, connection) ->
		if err
			log.error err
			throw err

		log.ok 'Connected'
		connection.release()
		MySqlDb.ready()

	class MySqlDb extends Db
		@mysql = impl

		@Table = Table(@, impl)
		@Collection = Collection(@, impl)
