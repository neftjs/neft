Db Document class
=================

	'use strict'

	Promise = require 'Promise'

*class* Document()
------------------

	module.exports = class Document extends Promise

### Constructor

		constructor: (@self, @id) ->

			super

			@run()

### Properties

#### self

Link into main `Db` instance

		self: null

#### id

Document id

		id: ''

### Methods

#### run()

Get table

		run: ->

			setTimeout => @reject()