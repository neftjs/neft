'use strict'

utils = require 'utils'
expect = require 'expect'

module.exports = class Management
	

	@create = (..., instance, opts) ->
		id = opts.id or 
		expect(id).toMatchRe Management.ID_RE

		instance ?= @open id
		utils.mergeDeep instance, opts
		instance

	constructor: ->
		utils.defProp @, '_id', 'w', ''

		Object.seal @

	utils.defProp @::, 'id', 'e', ->
		@_id
	, (val) ->
		if @_id is val
			return

		id = @_id
		@close()
		@constructor.open id