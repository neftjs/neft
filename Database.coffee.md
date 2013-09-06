Db Database class
=================

	'use strict'

	Promise = require 'Promise'

*class* Database()
------------------

	module.exports = class Database extends Promise

### Constructor

		constructor: (@self, @name) ->

			super

			@run()

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

		run: ->
			setTimeout => @reject()