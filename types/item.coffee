'use strict'

expect = require 'expect'
utils = require 'utils'
signal = require 'signal'

items = {}

module.exports = (Scope, Impl) -> class Item
	@__name__ = 'Item'

	@SIGNALS = ['pointerClicked', 'pointerPressed', 'pointerReleased',
	            'pointerEntered', 'pointerExited', 'pointerWheel', 'pointerMove']

	ALL_HANDLERS = utils.arrayToObject Item.SIGNALS, (_, val) ->
		signal.getHandlerName val
	, -> true
	ALL_HANDLERS.onReady = true

	DEEP_PROPERTIES =
		anchors: true
		animations: true

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

		utils.defProp @, 'animations', 'e', new Animations @

		# register signals
		@ready = null
		for signalName in Item.SIGNALS
			@[signalName] = null

		# fill
		for key, val of opts
			if ALL_HANDLERS[key]
				@[key].connect val
			else if DEEP_PROPERTIES[key]
				utils.mergeDeep @[key], val
			else
				@[key] = val

		# append children
		if children
			for child in children
				child.parent = @

		# animations
		@animations.initialize()

		Object.seal @

	createBindedSetter = (propName, setFunc) ->
		(val) ->
			if typeof val is 'string'
				# TODO: optimize it
				setImmediate =>
					binding = new Binding @, val
					Impl.setItemBinding @_uid, propName, binding
			else
				setFunc.call @, val

	utils.defProp @::, 'id', 'e', ->
		@_uid
	, (val) ->
		expect(val).toBe.truthy().string()
		utils.defProp @, 'id', 'e', val

	utils.defProp @::, 'scope', 'e', null, (val) ->
		expect(val).toBe.any Scope
		utils.defProp @, 'scope', 'e', val

	readyLazySignal = signal.createLazy @::, 'ready'

	readyLazySignal.onInitialized (item) ->
		setImmediate => @ready()

	onLazySignalInitialized = (item, signalName) ->
		Impl.attachItemSignal item._uid, signalName, item[signalName]

	for signalName in Item.SIGNALS
		lazySignal = signal.createLazy @::, signalName
		lazySignal.onInitialized onLazySignalInitialized

	utils.defProp @::, 'parent', 'e', ->
		items[Impl.getItemParent @_uid]
	, (val) ->
		item = val
		if typeof val is 'string'
			item = @scope.getItemById val

		if val?
			expect(item).toBe.any Item

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
	, createBindedSetter 'width', (val) ->
		expect(val).toBe.float()
		expect(val).not().toBe.lessThan 0
		Impl.setItemWidth @_uid, val

	utils.defProp @::, 'height', 'e', ->
		Impl.getItemHeight @_uid
	, createBindedSetter 'height', (val) ->
		expect(val).toBe.float()
		expect(val).not().toBe.lessThan 0
		Impl.setItemHeight @_uid, val

	utils.defProp @::, 'x', 'e', ->
		Impl.getItemX @_uid
	, createBindedSetter 'x', (val) ->
		expect(val).toBe.float()
		Impl.setItemX @_uid, val

	utils.defProp @::, 'y', 'e', ->
		Impl.getItemY @_uid
	, createBindedSetter 'y', (val) ->
		expect(val).toBe.float()
		Impl.setItemY @_uid, val

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

	utils.defProp @::, 'children', 'e', ->
		children = Impl.getItemChildren @_uid

		# TODO: cache array for the optimization
		for child, i in children
			children[i] = items[child]

		children
	, null

	utils.defProp @::, 'animations', 'e', null

	clear: ->
		for child in @children
			child.parent = null
		@

	clone: (scope=@scope) ->
		expect(scope).toBe.any Scope

		clone = scope.create @constructor, @_opts
		clone.parent = if scope is @scope then @parent else null

		clone

	cloneDeep: (scope) ->
		clone = @clone scope

		for child in @children
			child = child.cloneDeep scope
			child.parent = clone

		clone