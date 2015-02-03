'use strict'

[log] = ['log'].map require

log = log.scope 'Db'
{assert} = console
{stringify} = JSON

module.exports = (Db) ->

	assert Db is require('db') or (Db::) instanceof require('db')

	unless ~Db.__name__.indexOf('Impl')
		return

	do (Database = Db._subclasses.Database, log = log.scope('Database')) ->

		Database::run = do (_super = Database::run) -> (callback) ->

			logtime = log.time 'prepare'
			log "Create `#{@name}` database if not exists"

			_super.call @, ->
				log.end logtime
				callback arguments...

	do (Table = Db._subclasses.Table, log = log.scope('Table')) ->

		Table::run = do (_super = Table::run) -> (callback) ->

			logtime = log.time 'prepare'
			log "Create `#{@self._database.name}:#{@name}` if not exists"

			_super.call @, ->
				log.end logtime
				callback arguments...

		Table::insertData = do (_super = Table::insertData) -> (doc, callback) ->

			logtime = log.time 'insert'
			log "Insert `#{stringify(doc)}` into `#{@self._database.name}:#{@name}`"

			_super.call @, doc, ->
				log.end logtime
				callback arguments...

	do (Collection = Db._subclasses.Collection, log = log.scope('Collection')) ->

		Collection::run = do (_super=Collection::run) -> (callback) ->

			logtime = log.time 'find'
			log "Find documents (`id: #{@self._id}, commands: #{stringify(@self._commands)}`) in " +
			    "`#{@self._database.name}:#{@self._table.name}`"

			_super.call @, ->
				log.end logtime
				callback arguments...

		Collection::removeAll = do (_super=Collection::removeAll) -> (callback) ->

			logtime = log.time 'remove'

			log "Remove documents (`id: #{@self._id}, commands: #{stringify(@self._commands)}`) " +
			    "from `#{@self._database.name}:#{@self._table.name}`"

			_super.call @, ->
				log.end logtime
				callback arguments...

		Collection::updateAll = do (_super=Collection::updateAll) -> (doc, callback) ->

			logtime = log.time 'update'
			log "Update documents (`id: #{@self._id}, commands: #{stringify(@self._commands)}`) in " +
			    "`#{@self._database.name}:#{@self._table.name}`"

			_super.call @, doc, ->
				log.end logtime
				callback arguments...

	Db