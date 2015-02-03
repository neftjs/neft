Db Table class
==============

	'use strict'

*Table* Table()
---------------

	module.exports = class Table

		constructor: (@self, @name) ->

Table::self
-----------

Link into main `Db` instance

		self: null

Table::name
-----------

Name of table

		name: ''

Table::run()
------------

Get table

		run: (callback) ->

			callback new Error

Table::insertData()
-------------------

Add new object document into table.

Id of created document will be returned.

		insertData: (doc, callback) ->

			callback new Error
