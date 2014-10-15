'use strict'

expect = require 'expect'
utils = require 'utils'
signal = require 'signal'

items = {}

module.exports = (Scope, Impl) -> class Item
	@__name__ = 'Item'

	@SIGNALS = ['pointerClicked', 'pointerPressed', 'pointerReleased',
	            'pointerEntered', 'pointerExited', 'pointerWheel', 'pointerMove']

	Binding = require './item/binding'
	Anchors = require './item/anchors'
	Animations = require('./item/animations') Scope

	constructor: (@scope, opts, children) ->
		expect(opts).toBe.simpleObject()
		expect().defined(children).toBe.array()

		utils.defProp @, '_opts', '', utils.clone(opts)

		utils.defProp @, '_uid', '', uid = utils.uid()
		items[uid] = @

		Impl.createItem @constructor.__name__, uid

		utils.defProp @, 'children', 'e', []
		utils.defProp @, 'animations', 'e', new Animations @

		# create signals
		Item.SIGNALS.forEach (signalName) =>
			signalFunc = signal.createOnlySignal @, signalName

			# initialize
			handler = (listener) =>
				signalFunc.connected.disconnect handler
				signalToCall = =>
					Function.apply.call signalFunc, @, arguments
				Impl.attachItemSignal uid, signalName, signalToCall

			signalFunc.connected.connect handler

		signal.createOnlySignal @, 'ready'

		utils.mergeDeep @, opts

		# append children
		if children
			for child in children
				child.parent = @

		# animations
		@animations.initialize()

		# call `ready` signal
		setImmediate => @ready()

		Object.seal @

	utils.defProp @::, 'id', 'e', ->
		@_uid
	, (val) ->
		expect(val).toBe.truthy().string()
		utils.defProp @, 'id', 'e', val

	utils.defProp @::, 'scope', 'e', null, (val) ->
		expect(val).toBe.any Scope
		utils.defProp @, 'scope', 'e', val

	signal.createHandler @::, 'ready'

	for signalName in Item.SIGNALS
		signal.createHandler @::, signalName

	utils.defProp @::, 'parent', 'e', ->
		items[Impl.getItemParent @_uid]
	, (val) ->
		item = val
		if typeof val is 'string'
			item = @scope.getItemById val

		if val?
			expect(item).toBe.any Item

		# break on no change
		old = @parent
		if item is old
			return

		# remove from the old one
		if old
			utils.remove old.children, @

		# append into the new one
		if item?
			item.children.push @

		Impl.setItemParent @_uid, item?._uid

	utils.defProp @::, 'visible', 'e', ->
		Impl.getItemVisible @_uid
	, (val) ->
		expect(val).toBe.boolean()
		Impl.setItemVisible @_uid, val

	utils.defProp @::, 'clip', 'e', ->
		Impl.getItemClip @_uid
	, (val) ->
		expect(val).toBe.boolean()
		Impl.setItemClip @_uid, val

	utils.defProp @::, 'width', 'e', ->
		Impl.getItemWidth @_uid
	, (val) ->
		if typeof val is 'number'
			expect(val).toBe.float()
			expect(val).not().toBe.lessThan 0
			Impl.setItemWidth @_uid, val
		else
			binding = new Binding @, val
			Impl.setItemBinding @_uid, 'width', binding

	utils.defProp @::, 'height', 'e', ->
		Impl.getItemHeight @_uid
	, (val) ->
		if typeof val is 'number'
			expect(val).toBe.float()
			expect(val).not().toBe.lessThan 0
			Impl.setItemHeight @_uid, val
		else
			binding = new Binding @, val
			Impl.setItemBinding @_uid, 'height', binding

	utils.defProp @::, 'x', 'e', ->
		Impl.getItemX @_uid
	, (val) ->
		if typeof val is 'number'
			expect(val).toBe.float()
			Impl.setItemX @_uid, val
		else
			binding = new Binding @, val
			Impl.setItemBinding @_uid, 'x', binding

	utils.defProp @::, 'y', 'e', ->
		Impl.getItemY @_uid
	, (val) ->
		if typeof val is 'number'
			expect(val).toBe.float()
			Impl.setItemY @_uid, val
		else
			binding = new Binding @, val
			Impl.setItemBinding @_uid, 'y', binding

	utils.defProp @::, 'z', 'e', ->
		Impl.getItemZ @_uid
	, (val) ->
		expect(val).toBe.float()
		Impl.setItemZ @_uid, val

	utils.defProp @::, 'scale', 'e', ->
		Impl.getItemScale @_uid
	, (val) ->
		expect(val).toBe.float()
		Impl.setItemScale @_uid, val

	utils.defProp @::, 'rotation', 'e', ->
		Impl.getItemRotation @_uid
	, (val) ->
		expect(val).toBe.float()
		Impl.setItemRotation @_uid, val

	utils.defProp @::, 'opacity', 'e', ->
		Impl.getItemOpacity @_uid
	, (val) ->
		expect(val).toBe.float()
		Impl.setItemOpacity @_uid, val

	utils.defProp @::, 'anchors', 'e', ->
		Anchors.currentItem = @
		Anchors.Anchors
	, null

	utils.defProp @::, 'children', 'e', null

	utils.defProp @::, 'animations', 'e', null

	clear: ->
		for child in @children
			child.parent = null
		@

	clone: (scope=@scope) ->
		expect(scope).toBe.any Scope

		clone = scope.create @constructor, @_opts

		if scope is @scope
			clone.parent = @parent

		clone

	cloneDeep: (scope) ->
		clone = @clone scope

		for child in @children
			child = child.cloneDeep scope
			child.parent = clone

		clone