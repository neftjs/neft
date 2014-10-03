'use strict'

utils = require 'utils'
expect = require 'expect'

pool = {}

module.exports = class Management
	@ID_RE = ///^([a-z0-9_A-Z]+)$///

	@open = (id) ->
		name = @__name__
		instance = pool[name]?.pop() or (new @)
		instance._id = id
		instance

	@create = (..., instance, opts) ->
		id = opts.id or "u#{utils.uid()}"
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

	close: ->
		name = @constructor.__name__
		@_id = ''
		(pool[name] ?= []).push @
		null