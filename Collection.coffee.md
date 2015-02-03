Db Collection class
===================

	'use strict'

*Collecation* Collection()
--------------------------

	module.exports = class Collection

		constructor: (@self) ->

Collecation::self
-----------------

Link into main `Db` instance

		self: null

Collection::run()
-----------------

Execute query

		run: (callback) ->

			callback new Error

Collection::removeAll()
-----------------------

Remove all documents from the collection.

Success callbacks returns object with amount of deleted and errors documents.

		removeAll: (callback) ->

			callback new Error

Collection::updateAll()
-----------------------

Update all documents in the collection.

Success callbacks returns object with amount of updated and errors documents.

		updateAll: (doc, callback) ->

			callback new Error
