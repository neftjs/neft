'use strict'

module.exports = (Db, impl) ->
	class MySqlTable extends Db.Table
		run: (callback) ->
			callback()

		insertData: (doc, callback) ->
			impl.pool.query "insert into `#{@name}` SET ?", doc, (err, result) ->
				callback err, result?.insertId
