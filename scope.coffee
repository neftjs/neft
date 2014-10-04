'use strict'

utils = require 'utils'
expect = require 'expect'

Impl = require './impl'

{isArray} = Array

module.exports = class Scope
	@__name__ = 'Scope'

	@ID_RE = ///^([a-z0-9_A-Z]+)$///

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

	constructor: (opts={}) ->
		expect(opts).toBe.simpleObject()

		utils.defProp @, '_mainItem', 'w', null
		utils.defProp @, 'items', 'e', {}

		# types creation shortcuts
		for name, type of Scope.TYPES
			do (name=name) =>
				@[name] = (args...) =>
					@create name, args

		utils.merge @, opts
		@id ?= "u#{utils.uid()}"

		Object.seal @

	utils.defProp @::, 'items', 'e', null

	utils.defProp @::, 'mainItem', 'e', ->
		@_mainItem
	, null

	utils.defProp @::, 'id', 'e', null, (val) ->
		expect(val).toBe.truthy().string()
		expect(val).toMatchRe Scope.ID_RE

		utils.defProp @, 'id', 'e', val

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
			# TODO: assert
			item = new ctor @, opts, children
			@_mainItem ?= item
			@items[item.id or item._uid] = item
		else if children?.length
			; # TODO: assert
		else
			item = new ctor opts

		item