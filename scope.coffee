'use strict'

utils = require 'utils'

Impl = require './impl'
Management = require './utils/management'

{isArray} = Array

mainItems = {}
itemsTypes = {}

module.exports = class Scope extends Management
	@__name__ = 'Scope'

	@TYPES =
		Item: @Item = require('./types/item') @, Impl
		Image: @Image = require('./types/item/types/image') @, Impl
		Text: @Text = require('./types/item/types/text') @, Impl
		Rectangle: @Rectangle = require('./types/item/types/rectangle') @, Impl
		Grid: @Grid = require('./types/item/types/grid') @, Impl
		Column: @Column = require('./types/item/types/column') @, Impl
		Row: @Row = require('./types/item/types/row') @, Impl
		Animation: @Animation = require('./types/animation') @, Impl
		PropertyAnimation: @PropertyAnimation = require('./types/animation/types/property') @, Impl
		NumberAnimation: @NumberAnimation = require('./types/animation/types/property/types/number') @, Impl

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

		# types creation shortcuts
		for name, type of Scope.TYPES
			do (name=name) =>
				@[name] = (args...) =>
					@create name, args

		super

	utils.defProp @::, 'mainItem', 'e', ->
		@_mainItem
	, null

	create: (type, opts, children) ->
		# only children
		if isArray opts
			children = opts

			# opts as first child
			if utils.isObject children[0]
				opts = children.shift()

		opts ?= {}
		ctor = Scope.TYPES[type]

		# check whether type supports children
		if ctor is Scope.Item or (ctor::) instanceof Scope.Item
			; # TODO: assert
		else if children?.length
			; # TODO: assert

		item = ctor.create @_id, opts, children
		itemId = item._id

		itemsTypes[@_id][itemId] = type
		@_mainItem ?= mainItems[@_id] = item

		if item instanceof Management
			item.close()
			itemId
		else
			item

	open: (id) ->
		type = itemsTypes[@_id][id]
		item = Scope.TYPES[type].open @_id, id
		item

	close: ->
		@_mainItem = null
		super
