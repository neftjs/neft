'use strict'

module.exports = (Db, impl) ->
	buildQuery = (database, table, id, commands) ->
		q = impl.r.db(database).table(table)

		# id
		if id
			return q.get id

		# commands
		for command in commands then switch true
			# skip
			when command.skip?
				q = q.skip command.skip

			# limit
			when command.limit?
				q = q.limit command.limit

			# where
			when command.where?
				filter = impl.r.row(command.where)

				if command.is? then q = q.filter filter.eq command.is
				if command.lt? then q = q.filter filter.lt command.lt
				if command.gt? then q = q.filter filter.gt command.gt

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

	class RethinkCollection extends Db.Collection
		run: (callback) ->
			find impl.database, @self._table.name, @self._id, @self._commands, callback

		removeAll: (callback) ->
			remove impl.database, @self._table.name, @self._id, @self._commands, callback

		updateAll: (doc, callback) ->
			update impl.database, @self._table.name, @self._id, @self._commands, doc, callback
