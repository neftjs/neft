Db Collection class
===================

	'use strict'

*class* Collection()
--------------------

	module.exports = class Collection

### Constructor

		constructor: (@self) ->

### Properties

#### self

Link into main `Db` instance

		self: null

### Methods

#### run()

Execute query

		run: ->

			throw new Error

#### removeAll()

Remove all documents from the collection.

Success callbacks returns object with amount of deleted and errors documents.

		removeAll: ->

			throw new Error

### updateAll()

Update all documents in the collection.

Success callbacks returns object with amount of updated and errors documents.

		updateAll: (doc) ->

			throw new Error