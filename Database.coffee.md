Db Database class
=================

	'use strict'

*class* Database()
------------------

	module.exports = class Database

### Constructor

		constructor: (@self, @name) ->

### Properties

#### self

Link into main `Db` instance

		self: null

#### name

Name of database

		name: ''

### Methods

#### run()

Get database

		run: (callback) ->
			
			callback new Error