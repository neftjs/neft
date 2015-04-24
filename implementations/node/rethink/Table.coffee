'use strict'

module.exports = (Db, impl) ->
	exists = (database, table, callback) ->
		impl.r.db(database).tableList().run impl.conn, (err, list) ->
			if err
				callback err

			result = !!~list.indexOf table
			callback null, result

	create = (database, table, callback) ->
		impl.r.db(database).tableCreate(table).run impl.conn, (err, res) ->
			if err or not res.created
				callback err
			callback null

	prepare = (database, table, callback) ->
		exists database, table, (err, exists) =>
			if err
				return callback err
			if exists
				return callback null

			create database, table, callback

	insert = (database, table, doc, callback) ->
		impl.r.db(database).table(table).insert(doc).run impl.conn, (err, result) ->
			if err
				return callback err

			id = result.generated_keys[0]
			callback null, id

	class RethinkTable extends Db.Table
		run: (callback) ->
			prepare impl.database, @name, callback

		insertData: (doc, callback) ->
			insert impl.database, @name, doc, callback
