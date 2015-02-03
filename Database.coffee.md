Db Database class
=================

	'use strict'

*Database* Database()
---------------------

	module.exports = class Database

		constructor: (@self, @name) ->

Database::self
--------------

Link into main `Db` instance

		self: null

Database::name
--------------

Name of database

		name: ''

Database::run()
---------------

Get database

		run: (callback) ->
			
			callback new Error