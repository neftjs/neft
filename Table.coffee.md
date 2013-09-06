Db Table class
==============

	'use strict'

	Promise = require 'Promise'

*class* Table()
---------------

	module.exports = class Table extends Promise

### Constructor

		constructor: (@self, @name) ->

			super

			@run()

### Properties

#### self

Link into main `Db` instance

		self: null

#### name

Name of table

		name: ''

### Methods

#### run()

Get table

		run: ->

			setTimeout => @reject()

#### insertData()

Add new object document into table.

Id of created document will be returned.

		insertData: (doc) ->