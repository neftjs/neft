'use strict'

utils = require 'utils'
expect = require 'expect'

Impl = require './impl'

{isArray} = Array

class Scope
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
		Scrollable: @Scrollable = require('./types/item/types/scrollable') @, Impl

		Animation: @Animation = require('./types/animation') @, Impl
		PropertyAnimation: @PropertyAnimation = require('./types/animation/types/property') @, Impl
		NumberAnimation: @NumberAnimation = require('./types/animation/types/property/types/number') @, Impl

	constructor: (opts={}) ->
		expect(opts).toBe.simpleObject()

		utils.defProp @, '_mainItem', 'w', null
		utils.defProp @, 'items', 'e', {}

		# types creation shortcuts
		for name, type of Scope.TYPES
			do (type=type) =>
				utils.defProp @, name, '', (args...) =>
					@create type, args

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

	create: (ctor, opts, children) ->
		expect(ctor).toBe.function()

		# only children
		if isArray opts
			children = opts
			opts = null

			# opts as first child
			if utils.isObject children[0]
				children = utils.clone children
				opts = children.shift()

		opts ?= {}

		# check whether type supports children
		if ctor is Scope.Item or (ctor::) instanceof Scope.Item
			# TODO: assert
			item = new ctor @, opts, children
		else unless utils.hasValue Scope.TYPES, ctor
			item = ctor opts, children
		else if children?.length
			; # TODO: assert
		else
			child = new ctor opts

		if item
			@_mainItem ?= item
			@items[item.id] = item

		item or child

history = {}
module.exports = class CloneableScope extends Scope

	constructor: ->
		super
		history[@id] = []

	create: (type, opts, children) ->
		history[@id].push [type, utils.clone(opts), utils.clone(children)]

		super

	clone: ->
		new Scope
			id: "#{@id}_#{utils.uid()}"

	toItemCtor: ->
		(opts, children) =>
			scope = @clone()

			calls = history[@id]
			for call in calls
				scope.create.apply scope, call

			# custom opts
			if opts?
				utils.merge scope.mainItem, opts

			# extra children
			if children?
				for child in children
					child.parent = scope.mainItem

			# main item
			scope.mainItem
