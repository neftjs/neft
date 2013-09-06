Db Collection class
===================

	'use strict'

	Promise = require 'Promise'
	utils = require 'utils'

*class* Collection()
--------------------

	module.exports = class Collection extends Promise

### Constructor

		constructor: (@self) ->

			super

			if self._search then @run()

### Properties

#### self

Link into main `Db` instance

		self: null

### Methods

#### run()

Execute query

		run: ->

			setTimeout => @reject()

#### removeAll()

Remove all documents from the collection.

		removeAll: ->

### updateAll()

Update all documents in the collection.

		updateAll: (doc) ->