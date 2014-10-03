'use strict'

utils = require 'utils'

Impl = require './impl'
Management = require './utils/management'

mainItems = {}
itemsTypes = {}

module.exports = class Scope extends Management
	@__name__ = 'Scope'

	@TYPES =
		Item: @Item = require('./item') @, Impl
		Image: @Image = require('./item/types/image') @, Impl
		Text: @Text = require('./item/types/text') @, Impl
		Rectangle: @Rectangle = require('./item/types/rectangle') @, Impl
		Grid: @Grid = require('./item/types/grid') @, Impl

	@open = (id) ->
		scope = super
		scope._mainItem = mainItems[id]
		scope

	@create = (opts) ->
		scope = super
		itemsTypes[scope._id] = {}
		scope

	constructor: ->
		utils.defProp @, '_mainItem', 'w', null
		super

	utils.defProp @::, 'mainItem', 'e', ->
		@_mainItem
	, null

	create: (type, opts) ->
		item = Scope.TYPES[type].create @_id, opts
		itemId = item._id

		itemsTypes[@_id][itemId] = type
		@_mainItem ?= mainItems[@_id] = item

		item.close()
		itemId

	open: (id) ->
		type = itemsTypes[@_id][id]
		item = Scope.TYPES[type].open @_id, id
		item

	close: ->
		@_mainItem = null
		super
