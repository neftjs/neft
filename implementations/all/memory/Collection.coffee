'use strict'

utils = require 'utils'

module.exports = (Db, impl) ->
	find = (database, table, id, commands, callback) ->
		data = impl.data[table]

		# id
		if id
			for row in data
				if row.id is id
					return callback null, row
			return callback null

		r = utils.clone data

		# commands
		for command in commands then switch true
			# skip
			when command.skip?
				{skip} = command
				while skip--
					r.shift()

			# limit
			when command.limit?
				{limit} = command
				while r.length > limit
					r.pop()

			# where
			when command.where?
				{where} = command
				cis = command.is
				clt = command.lt
				cgt = command.gt

				if cis?
					i = 0
					while i < r.length
						if r[i][where] isnt cis
							r.splice i, 1
						else
							i++
				if clt?
					i = 0
					while i < r.length
						if r[i][where] >= clt
							r.splice i, 1
						else
							i++
				if cgt?
					i = 0
					while i < r.length
						if r[i][where] <= cgt
							r.splice i, 1
						else
							i++

		arr = []
		for row in r
			arr.push utils.cloneDeep(row)

		callback null, arr

	remove = (database, table, id, commands, callback) ->
		find database, table, id, commands, (err, r) ->
			data = impl.data[table]
			deleted = 0
			if r.id?
				{id} = r
				deleted++
				for row, i in data
					if row.id is id
						data.splice i, 1
						break
			else
				for row in r
					{id} = row
					for row, i in data
						if row.id is id
							deleted++
							data.splice i, 1
							break

			callback null,
				deleted: i
				errors: 0

	update = (database, table, id, commands, changes, callback) ->
		find database, table, id, commands, (err, r) ->
			data = impl.data[table]
			replaced = 0
			for row in r
				{id} = row
				for row, i in data
					if row.id is id
						replaced++
						utils.merge row, changes
			callback null,
				replaced: i
				errors: 0

	class RethinkCollection extends Db.Collection
		run: (callback) ->
			find impl.database, @self._table.name, @self._id, @self._commands, callback

		removeAll: (callback) ->
			remove impl.database, @self._table.name, @self._id, @self._commands, callback

		updateAll: (doc, callback) ->
			update impl.database, @self._table.name, @self._id, @self._commands, doc, callback
