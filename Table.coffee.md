Db Table class
==============

	'use strict'

*class* Table()
---------------

	module.exports = class Table

### Constructor

		constructor: (@self, @name) ->

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

			throw new Error

#### insertData()

Add new object document into table.

Id of created document will be returned.

		insertData: (doc) ->

			throw new Error