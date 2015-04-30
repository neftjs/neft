Database @engine
================

	'use strict'

	utils = require 'utils'
	signal = require 'signal'
	assert = require 'neft-assert'

	Table = require './Table'
	Collection = require './Collection'

	NOP = ->

*Db* Db()
---------

	module.exports = class Db
		@__name__ = 'Db'

Db.create(*Object* options)
---------------------------

		@create = do ->
			dbImplementation = require './implementation'
			dbLog = require 'log'
			dbSchema = require './schema'
			dbAddons = require './addons'

			(opts={}) ->
				assert.isPlainObject opts

				opts.name ?= 'neft_app'

				r = class ReadyDb extends Db
				signal.create r, 'ready'
				r.Collection = class ReadyCollection extends Collection
				r.Table = class ReadyTable extends Table

				# implementation
				r = dbImplementation r, opts.type, opts.name, opts.config

				# log
				`//<development>`
				# if opts.log isnt false
				# 	r = dbLog r
				`//</development>`

				# schema
				if opts.schema?
					r = dbSchema r, opts.schema

				# addons
				if utils.isObject(opts.addons)
					for type, addonOptsof of opts.addons
						r = dbAddons[type] r, addonOpts

				r

		@Collection = Collection
		@Table = Table

		constructor: (table, id) ->
			assert.instanceOf @, Db, "Use `new` to init Db query"
			assert.isString table, "Table name must be a string"
			assert.isPrimitive id, "Id of document must be primitive" if id?

			# Define if `Collection` should execute query.
			# It not have place if any documents won't be returned
			# (e.g. with inserting, updating etc.)
			@_search = true

			# init properties
			@_stack = new utils.async.Stack
			@_commands = []

			# implement table
			@_table = new @constructor.Table @, table
			@_stack.add 'run', @_table

			# implement collection
			@_collection = new @constructor.Collection @
			@_stack.add runCollectionIfNeeded, @

			# get document
			@_id = id

			Object.preventExtensions @

		runCollectionIfNeeded = (callback) ->
			if @_search
				@_collection.run callback
			else
				callback null
			return

Db::run()
---------

Initialize query.

All methods and constructor returns this function (binded with public properties).

```
new Db('db', 'table', 'id').run()
```

		run: (callback = NOP) ->
			@_stack.runAll callback
			return

Db::limit(*Integer* value)
--------------------------

Set limit of documents in collection.

		limit: (value) ->
			assert.notOk @_id?, "limit() can not be used for document"
			assert.isInteger value, "Limit value must be a positive number"
			assert.operator value, '>', 0, "Limit value must be a positive number"

			@_commands.push limit: value
			@

Db::skip(*Integer* value)
-------------------------

Omit documents from the begining.

		skip: (value) ->
			assert.notOk @_id?, "skip() can not be used for document"
			assert.isInteger value, "Offset value must be a positive and finite number"
			assert.operator value, '>', 0, "Offset value must be a positive and finite number"

			@_commands.push skip: value
			@

Db::where(*String* row)
-----------------------

Add comparison for the *row*.
Use extra methods to specify type and expected value.
Use dots in *row* name for namespaces.

```
new Db('db', 'table').where('products.amount').lt(2).gt(1).remove().run()
```

		where: (row) ->
			assert.notOk @_id?, "where() can not be used for document"
			assert.isString row, "Row must be a string"

			@_commands.push where: row
			@

Db::is(*Any* value)
-------------------

Triple comparison.

		is: (value) ->
			where = utils.last @_commands

			assert where?.where?, "is() requires where()"
			assert.notOk where?.lt, "is() can't be used with lt() on the same row"
			assert.notOk where?.gt, "is() can't be used with gt() on the same row"

			where.is = value
			@

Db::lt(*Float* value)
---------------------

Lower than

		lt: (value) ->
			where = utils.last @_commands

			assert where?.where?, "lt() requires where()"
			assert.notOk where?.is?, "lt() can't be used with is() on the same row"

			where.lt = value
			@

Db::gt(*Float* value)
---------------------

Greater than

		gt: (value) ->
			where = utils.last @_commands

			assert where?.where?, "gt() requires where()"
			assert.notOk where?.is?, "gt() can't be used with is() on the same row"

			where.gt = value
			@

Db::remove()
------------

Remove all documents from the collection.

```
new Db('db', 'table').remove().run();
new Db('db', 'table').limit(1).remove().run();
new Db('db', 'table').where('title').is('one').remove().run();
new Db('db', 'table', 'id').remove().run();
```

		remove: ->
			assert @_search, "remove() can works only with collection"

			@_search = false
			@_stack.add 'removeAll', @_collection
			@

Db::insert(*Object* document)
-----------------------------

Insert new document into *Table*.

Id of created document will be returned.

```
new Db('db', 'table').insert({title: 'two'}).run();
```

		insert: (doc) ->
			assert.notOk @_id?, "insert() can not be used for document"
			assert.isPlainObject doc, "Only plain objects can be inserted"
			assert @_search, "remove() can works only with collection"

			@_search = false
			@_stack.add 'insertData', @_table, [doc]
			@

Db::update(*Object* document)
-----------------------------

Update all documents in the collection.

```
new Db('db', 'table').where('name').is('one').update({name: two}).run();
new Db('db', 'table', 'id').update({name: two}).run();
```

		update: (doc) ->
			assert.isPlainObject doc, "Only plain objects can be inserted"
			assert @_search, "remove() can works only with collection"

			@_search = false
			@_stack.add 'updateAll', @_collection, [doc]
			@
