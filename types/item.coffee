'use strict'

expect = require 'expect'
utils = require 'utils'
signal = require 'signal'

Management = require '../utils/management'

signals = {}
animations = {}

module.exports = (Scope, Impl) -> class Item extends Management
	@__name__ = 'Item'

	@GLOBAL_ID_RE = ///^([a-z0-9_A-Z]+)\$([a-z0-9_A-Z]+)$///
	@GLOBAL_ID_FORMAT = (scopeId, id) ->
		"#{scopeId}$#{id}"

	@SIGNALS = ['pointerClicked', 'pointerPressed', 'pointerReleased',
	            'pointerEntered', 'pointerExited', 'pointerWheel']

	Binding = require './item/binding'
	Anchors = require './item/anchors'
	Animations = require('./item/animations') Scope

	@create = (scopeId, opts, children) ->
		id = opts.id or "u#{utils.uid()}"
		item = @open scopeId, id
		globalId = item._globalId
		Impl.createItem @__name__, globalId

		itemSignals = signals[globalId] = {}
		animations[globalId] = new Animations
		animations[globalId].item = globalId

		# create signals
		Item.SIGNALS.forEach (signalName) ->
			signalFunc = signal.createOnlySignal item, signalName
			itemSignals[signalName] = signalFunc

			# initialize
			handler = (listener) ->
				signalFunc.connected.disconnect handler

				# call signal with opened item instance,
				# so all listeners will have easy access to it
				bindSignalFunc = ->
					scope = Scope.open scopeId
					item = scope.open id
					Function.apply.call signalFunc, item, arguments
					item.close()
					scope.close()

				Impl.attachItemSignal item._globalId, signalName, bindSignalFunc

			signalFunc.connected.connect handler

		signal.createOnlySignal item, 'ready'
		super item, opts

		# append children
		if children
			scope = Scope.open scopeId
			for childId in children
				child = scope.open childId
				child.parent = item
				child.close()
			scope.close()

		# animations
		item.animations.initialize()

		# call `ready` signal
		item.ready()

		item

	@open = (scopeId, id) ->
		item = super id

		item._scopeId = scopeId
		globalId = item._globalId = Item.GLOBAL_ID_FORMAT scopeId, id

		# move signals
		item.ready = null
		itemSignals = signals[globalId]
		for signalName in Item.SIGNALS
			item[signalName] = itemSignals?[signalName]

		item

	constructor: ->
		utils.defProp @, '_scopeId', 'w', ''
		utils.defProp @, '_globalId', 'w', ''

		# register signals properties
		@ready = null
		for signalName in Item.SIGNALS
			@[signalName] = null

		super

	signal.createHandler @::, 'ready'

	for signalName in Item.SIGNALS
		signal.createHandler @::, signalName

	utils.defProp @::, 'parent', 'e', ->
		Impl.getItemParent @_globalId
	, (val) ->
		parentId = if val instanceof Item then val._globalId else val
		expect(parentId).toBe.truthy().string()

		# use current scope
		unless Item.GLOBAL_ID_RE.test parentId
			parentId = Item.GLOBAL_ID_FORMAT @_scopeId, parentId

		Impl.setItemParent @_globalId, parentId

	utils.defProp @::, 'visible', 'e', ->
		Impl.getItemVisible @_globalId
	, (val) ->
		expect(val).toBe.boolean()
		Impl.setItemVisible @_globalId, val

	utils.defProp @::, 'clip', 'e', ->
		Impl.getItemClip @_globalId
	, (val) ->
		expect(val).toBe.boolean()
		Impl.setItemClip @_globalId, val

	utils.defProp @::, 'width', 'e', ->
		Impl.getItemWidth @_globalId
	, (val) ->
		if typeof val is 'number'
			expect(val).toBe.float()
			expect(val).not().toBe.lessThan 0
			Impl.setItemWidth @_globalId, val
		else
			binding = Binding.factory val
			Impl.setItemBinding @_globalId, 'width', binding

	utils.defProp @::, 'height', 'e', ->
		Impl.getItemHeight @_globalId
	, (val) ->
		if typeof val is 'number'
			expect(val).toBe.float()
			expect(val).not().toBe.lessThan 0
			Impl.setItemHeight @_globalId, val
		else
			binding = Binding.factory val
			Impl.setItemBinding @_globalId, 'height', binding

	utils.defProp @::, 'x', 'e', ->
		Impl.getItemX @_globalId
	, (val) ->
		if typeof val is 'number'
			expect(val).toBe.float()
			Impl.setItemX @_globalId, val
		else
			binding = Binding.factory val
			Impl.setItemBinding @_globalId, 'x', binding

	utils.defProp @::, 'y', 'e', ->
		Impl.getItemY @_globalId
	, (val) ->
		if typeof val is 'number'
			expect(val).toBe.float()
			Impl.setItemY @_globalId, val
		else
			binding = Binding.factory val
			Impl.setItemBinding @_globalId, 'y', binding

	utils.defProp @::, 'z', 'e', ->
		Impl.getItemZ @_globalId
	, (val) ->
		expect(val).toBe.float()
		Impl.setItemZ @_globalId, val

	utils.defProp @::, 'scale', 'e', ->
		Impl.getItemScale @_globalId
	, (val) ->
		expect(val).toBe.float()
		Impl.setItemScale @_globalId, val

	utils.defProp @::, 'rotation', 'e', ->
		Impl.getItemRotation @_globalId
	, (val) ->
		expect(val).toBe.float()
		Impl.setItemRotation @_globalId, val

	utils.defProp @::, 'opacity', 'e', ->
		Impl.getItemOpacity @_globalId
	, (val) ->
		expect(val).toBe.float()
		Impl.setItemOpacity @_globalId, val

	utils.defProp @::, 'anchors', 'e', ->
		Anchors.currentItem = @
		Anchors.Anchors
	, null

	utils.defProp @::, 'animations', 'e', ->
		animations[@_globalId]
	, (val) ->
		# TODO
		{animations} = @
		for animation in val
			animations.append animation, animation.name
		null

	close: ->
		@_scopeId = ''
		@_globalId = ''
		super