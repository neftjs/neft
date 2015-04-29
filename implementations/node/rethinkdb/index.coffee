'use strict'

utils = require 'utils'
log = require 'log'

log = log.scope 'Db', 'Rethink'

try
	r = require 'rethinkdb'
catch
	exports.error = "'rethinkdb' module is not installed"
	return;

Table = require './Table.coffee'
Collection = require './Collection.coffee'

# CONFIG
HOST = 'localhost'
PORT = 28015

module.exports = (Db, name, config={}) ->
	impl =
		database: name
		r: r
		conn: null

	exists = (database, callback) ->
		impl.r.dbList().run impl.conn, (err, list) ->
			if err
				return callback err

			result = !!~list.indexOf database
			callback null, result

	create = (database, callback) ->
		impl.r.dbCreate(database).run impl.conn, (err, res) ->
			if err or not res.created
				return callback err or false

			callback null

	prepare = (database, callback) ->
		exists database, (err, exists) =>
			if err
				return callback err
			if exists
				return callback null

			create database, (err) ->
				if err
					return callback err

	class RethinkDb extends Db
		@rethinkdb = impl

		@Table = Table(@, impl)
		@Collection = Collection(@, impl)

		# Connect into db and load sub-files on success
		config.host ?= HOST
		config.port ?= PORT
		r.connect config, (err, conn) =>
			if err
				log.error err
				throw err
			impl.conn = conn

			log.ok 'Connected'
			prepare name, (err) =>
				if err
					log.error err
					throw err
				@ready()
