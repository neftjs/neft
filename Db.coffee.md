Db main file
============

	'use strict'

	utils = require 'utils'
	Promise = require 'Promise'

	Database = require './Database.coffee.md'
	Table = require './Table.coffee.md'
	Collection = require './Collection.coffee.md'
	Document = require './Document.coffee.md'

*class* Db()
------------

	class Db extends Promise

### Static protected

#### _Database()

Reference to the `Database` class.

		@_Database = Database

#### _Collection()

Reference to the `Collection` class.

		@_Collection = Collection

#### _Table()

Reference to the `Table` class.

		@_Table = Table

#### _Document()

Reference to the `Document` class.

		@_Document = Document

### Events

		@NOT_IMPLEMENTED_ERROR = 'notimplementederror'

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

			super

			# implement databse
			@then @_implementDatabase.bind @, database

			# implement table
			@then @_implementTable.bind @, table

			# implement collection
			@then @_implementCollection.bind @

			# get document
			if id
				@_search = false
				@then @_implementDocument.bind @, id

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

#### Instances of classes

		_database: null
		_table: null
		_collection: null
		_document: null

#### Behavior

Define if `Collection` should execute query.
It not have place if any documents won't be returned
(e.g. with inserting, updating etc.)

		_search: true

#### Cached needs

		_limit: Infinity
		_offset: 0
		_where: null

#### Methods

		_implementDatabase: (name) ->

			@_database = new Database @, name

		_implementTable: (name) ->

			@_table = new Table @, name

		_implementCollection: ->

			@_collection = new Collection @

		_implementDocument: (id) ->

			@_document = new Document @, id

### Methods

#### run()

Initialize query.

There is a shortcat for this function - constructor and all methods returns
always this function which could be easily called and have special properties
to public class methods.

**Example:** `new Db('db', 'table', 'id')()`

		run: ->

			@reject
				name: Db.NOT_IMPLEMENTED_ERROR

#### limit()

Set limit of documents in collection.

		limit: (value) ->

			if typeof value isnt 'number' or value <= 0
				throw new TypeError "Limit value must be a positive number"

			@_limit = value

#### offset()

Omit documents from the begining.

		offset: (value) ->

			if typeof value isnt 'number' or value < 0 or not isFinite value
				throw new TypeError "Offset value must be a positive and finite number"

			@_offset = value

#### where()

Add comparison for the *row*.
Use extra methods to specify type and expected value.
Use dots in *row* name for namespaces.

**Example:** `new Db('db', 'table').where('products.amount').lt(2).gt(1).remove()()`

		where: (row) ->

			if typeof row isnt 'string' or not row
				throw new TypeError "Row must be a string"

			@_where ?= []

			@_where.push row: row

##### is()

Triple comparison.

		is: (value) ->

			unless where = utils.last @_where
				throw new ReferenceError "is() requires where()"

			if where.lt? or where.gt?
				throw new ReferenceError "is() can't be used with lt() and gt() on the same row"

			where.is = value

##### lt()

Lower than

		lt: (value) ->

			unless where = utils.last @_where
				throw new ReferenceError "lt() requires where()"

			if where.is?
				throw new ReferenceError "lt() can't be used with is() on the same row"

			where.lt = value

##### gt()

Greater than

		gt: (value) ->

			unless where = utils.last @_where
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

			@_search = false

			@then => @_collection.removeAll()

#### insert()

Insert new document into *Table*.

Id of created document will be returned.

**Example:** `new Db('db', 'table').insert(title: 'two')()`

		insert: (doc) ->

			unless utils.isObject doc
				throw new TypeError 'Only simply objects could be inserted'

			@_search = false

			@then => @_table.insertData doc

#### update()

Update all documents in the collection.

**Example:** `new Db('db', 'table').where('name').is('one').update(name: two)()`

		update: (doc) ->

			unless utils.isObject doc
				throw new TypeError 'Only simply objects could be inserted'

			@_search = false

			@then => @_collection.updateAll doc

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