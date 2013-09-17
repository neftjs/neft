Db main file
============

	'use strict'

	utils = require 'utils'

	Database = require './Database.coffee.md'
	Table = require './Table.coffee.md'
	Collection = require './Collection.coffee.md'

	NOP = ->

*class* Db()
------------

	class Db

### Static protected

#### _subclasses

Namespace of all available *subclasses*.

		@_subclasses =
			Database: Database
			Collection: Collection
			Table: Table

### Constructor

Load collection of database table or specified document.
Don't re-use instance to get different results.

		constructor: (database, table, id) ->

			unless @ instanceof Db
				throw new ReferenceError "Use `new` to init Db query"

			if typeof database isnt 'string' or not database
				throw new TypeError "Database name must be a string"

			if typeof table isnt 'string' or not table
				throw new TypeError "Table name must be a string"

			if id? and (typeof id isnt 'string' or not id)
				throw new TypeError "Id of document must be a string"

			# init properties
			@_stack = new utils.async.Stack
			@_commands = []

			# implement database
			@_implementDatabase database

			# implement table
			@_implementTable table

			# implement collection
			@_implementCollection()

			# get document
			if id
				@_id = id

Function with all public methods will be returned.
Methods are binded and always returns the same function from *constructor*.
Call it, when you wanna initialize your query.

It's just a shortcat. In place of `.run()`, you have just `()`.
You loose access to class context, but it shouldn't be public.

			exec = @run.bind @

			for prop, elem of Db::

				if typeof elem isnt 'function' or prop[0] is '_'
					continue

				do (prop = prop, elem = elem) =>

					exec[prop] = =>
						elem.apply @, arguments
						exec 

			return exec

### Protected

#### Processing

		_stack: null

#### Instances of classes

		_database: null
		_table: null
		_collection: null

#### Behavior

Define if `Collection` should execute query.
It not have place if any documents won't be returned
(e.g. with inserting, updating etc.)

		_search: true

#### Cached commands

		_id: null
		_commands: null

#### Methods

		_implementDatabase: (name) ->

			database = @_database = new Db._subclasses.Database @, name

			@_stack.add database, 'run'

		_implementTable: (name) ->

			table = @_table = new Db._subclasses.Table @, name

			@_stack.add table, 'run'

		_implementCollection: ->

			@_collection = new Db._subclasses.Collection @

			@_stack.add null, (callback) =>

				if @_search then return @_collection.run callback
				callback null

### Methods

#### run()

Initialize query.

All methods and constructor returns this function (binded with public properties).

**Example:** `new Db('db', 'table', 'id')()`

		run: (callback = NOP) ->

			@_stack.runAll callback

			null

#### limit()

Set limit of documents in collection.

		limit: (value) ->

			if @_id?
				throw new ReferenceError "limit() can not be used for document"

			if typeof value isnt 'number' or value <= 0
				throw new TypeError "Limit value must be a positive number"

			@_commands.push limit: value

#### skip()

Omit documents from the begining.

		skip: (value) ->

			if @_id?
				throw new ReferenceError "skip() can not be used for document"

			if typeof value isnt 'number' or value < 0 or not isFinite value
				throw new TypeError "Offset value must be a positive and finite number"

			@_commands.push skip: value

#### where()

Add comparison for the *row*.
Use extra methods to specify type and expected value.
Use dots in *row* name for namespaces.

**Example:** `new Db('db', 'table').where('products.amount').lt(2).gt(1).remove()()`

		where: (row) ->

			if @_id?
				throw new ReferenceError "where() can not be used for document"

			if typeof row isnt 'string' or not row
				throw new TypeError "Row must be a string"

			@_commands.push where: row

##### is()

Triple comparison.

		is: (value) ->

			where = utils.last @_commands

			unless where.where?
				throw new ReferenceError "is() requires where()"

			if where.lt? or where.gt?
				throw new ReferenceError "is() can't be used with lt() and gt() on the same row"

			where.is = value

##### lt()

Lower than

		lt: (value) ->

			where = utils.last @_commands

			unless where.where?
				throw new ReferenceError "lt() requires where()"

			if where.is?
				throw new ReferenceError "lt() can't be used with is() on the same row"

			where.lt = value

##### gt()

Greater than

		gt: (value) ->

			where = utils.last @_commands

			unless where.where?
				throw new ReferenceError "gt() requires where()"

			if where.is?
				throw new ReferenceError "gt() can't be used with is() on the same row"

			where.gt = value

#### remove()

Remove all documents from the collection.

**Examples:**
1.  `new Db('db', 'table').remove()()`
2.  `new Db('db', 'table').limit(1).remove()()`
3.  `new Db('db', 'table').where('title').is('one').remove()()`

		remove: ->

			unless @_search
				throw new ReferenceError "remove() can works only with collection"

			@_search = false

			@_stack.add @_collection, 'removeAll'

#### insert()

Insert new document into *Table*.

Id of created document will be returned.

**Example:** `new Db('db', 'table').insert(title: 'two')()`

		insert: (doc) ->

			if @_id?
				throw new ReferenceError "insert() can not be used for document"

			unless utils.isObject doc
				throw new TypeError "Only simply objects could be inserted"

			unless @_search
				throw new ReferenceError "remove() can works only with collection"

			@_search = false

			@_stack.add @_table, 'insertData', doc

#### update()

Update all documents in the collection.

**Example:** `new Db('db', 'table').where('name').is('one').update(name: two)()`

		update: (doc) ->

			unless utils.isObject doc
				throw new TypeError "Only simply objects could be inserted"

			unless @_search
				throw new ReferenceError "remove() can works only with collection"

			@_search = false

			@_stack.add @_collection, 'updateAll', doc

*Events* emitted
----------------

*Db()* is a class and simultaneously instance of `Events()` *class*.

	Events = require 'Events'

	Db = utils.merge Db, new Events

### Events

#### READY

Event is emitted when *Db* is ready to use.

	Db.READY = 'ready'

Finalization
------------

	module.exports = Db