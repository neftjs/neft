'use strict'

module.exports = (Db, impl) ->
	buildQuery = (table, id, commands) ->
		q = "`#{table}` "

		# id
		if id?
			id = impl.pool.escape id
			q += "where `id`=#{id}"
			return q

		# commands
		for command in commands then switch true
			# skip
			when command.skip?
				q += "offset #{command.skip} "

			# limit
			when command.limit?
				q += "limit #{command.limit} "

			# where
			when command.where?
				q += "where `#{command.where}` "

				if command.is? then q += "= " + impl.pool.escape(command.is) + " "
				if command.lt? then q += "< " + impl.pool.escape(command.lt) + " "
				if command.gt? then q += "> " + impl.pool.escape(command.gt) + " "

		q

	find = (database, table, id, commands, callback) ->
		q = buildQuery database, table, id, commands

		q.run impl.conn, (err, cursor) ->
			if err
				return callback err

			# on no result
			unless cursor
				return callback null

			# for no cursor
			if typeof cursor.toArray isnt 'function'
				return callback null, cursor

			# get result from the cursor
			cursor.toArray (err, result) ->
				if err
					return callback err
				callback null, result

	remove = (database, table, id, commands, callback) ->
		q = buildQuery database, table, id, commands

		q.delete().run impl.conn, (err, result) ->
			if err
				return callback err

			callback null,
				deleted: result.deleted
				errors: result.errors

	update = (database, table, id, commands, changes, callback) ->
		q = buildQuery database, table, id, commands

		q.update(changes).run impl.conn, (err, result) ->
			if err
				return callback err

			callback null,
				replaced: result.replaced
				errors: result.errors

	class MySqlCollection extends Db.Collection
		run: (callback) ->
			query = 'select * from '
			query += buildQuery @self._table.name, @self._id, @self._commands
			impl.pool.query query, (err, arr) =>
				if @self._id? and arr
					arr = arr[0]
				callback err, arr

		removeAll: (callback) ->
			query = 'delete from '
			query += buildQuery @self._table.name, @self._id, @self._commands
			impl.pool.query query, callback

		updateAll: (doc, callback) ->
			query = 'update '
			query += buildQuery @self._table.name, @self._id, @self._commands
			query += 'set ? '
			impl.pool.query query, doc, callback
