'use strict'

expect = require 'expect'
utils = require 'utils'
signal = require 'signal'

Impl = require './impl'

pool =
	Item: []
signals = {}

class Item
	@ID_RE = ///^([a-z0-9_A-Z]+)$///
	@SIGNALS = ['pointerClicked', 'pointerPressed', 'pointerReleased',
	            'pointerEntered', 'pointerExited', 'pointerWheel']

	@Binding = require './item/binding'

	constructor: (type) ->
		expect(type).toBe.truthy().string()

		utils.defProp @, 'type', '', type
		utils.defProp @, '_id', 'w', ''

		# register signals properties
		for signalName in Item.SIGNALS
			@[signalName] = null

		Object.seal @

	utils.defProp @::, 'id', 'e', ->
		@_id
	, null

	for signalName in Item.SIGNALS
		signal.createHandler @::, signalName

	utils.defProp @::, 'parent', 'e', ->
		Impl.getItemParent @_id
	, (val) ->
		parentId = if val instanceof Item then val._id else val
		expect(parentId).toBe.truthy().string()
		Impl.setItemParent @_id, parentId

	utils.defProp @::, 'visible', 'e', ->
		Impl.getItemVisible @_id
	, (val) ->
		expect(val).toBe.boolean()
		Impl.setItemVisible @_id, val

	utils.defProp @::, 'clip', 'e', ->
		Impl.getItemClip @_id
	, (val) ->
		expect(val).toBe.boolean()
		Impl.setItemClip @_id, val

	utils.defProp @::, 'width', 'e', ->
		Impl.getItemWidth @_id
	, (val) ->
		if typeof val is 'number'
			expect(val).toBe.float()
			expect(val).not().toBe.lessThan 0
			Impl.setItemWidth @_id, val
		else
			binding = Item.Binding.factory val
			Impl.setItemBinding @_id, 'width', binding

	utils.defProp @::, 'height', 'e', ->
		Impl.getItemHeight @_id
	, (val) ->
		if typeof val is 'number'
			expect(val).toBe.float()
			expect(val).not().toBe.lessThan 0
			Impl.setItemHeight @_id, val
		else
			binding = Item.Binding.factory val
			Impl.setItemBinding @_id, 'height', binding

	utils.defProp @::, 'x', 'e', ->
		Impl.getItemX @_id
	, (val) ->
		if typeof val is 'number'
			expect(val).toBe.float()
			Impl.setItemX @_id, val
		else
			binding = Item.Binding.factory val
			Impl.setItemBinding @_id, 'x', binding

	utils.defProp @::, 'y', 'e', ->
		Impl.getItemY @_id
	, (val) ->
		if typeof val is 'number'
			expect(val).toBe.float()
			Impl.setItemY @_id, val
		else
			binding = Item.Binding.factory val
			Impl.setItemBinding @_id, 'y', binding

	utils.defProp @::, 'z', 'e', ->
		Impl.getItemZ @_id
	, (val) ->
		expect(val).toBe.float()
		Impl.setItemZ @_id, val

	utils.defProp @::, 'scale', 'e', ->
		Impl.getItemScale @_id
	, (val) ->
		expect(val).toBe.float()
		Impl.setItemScale @_id, val

	utils.defProp @::, 'rotation', 'e', ->
		Impl.getItemRotation @_id
	, (val) ->
		expect(val).toBe.float()
		Impl.setItemRotation @_id, val

	utils.defProp @::, 'opacity', 'e', ->
		Impl.getItemOpacity @_id
	, (val) ->
		expect(val).toBe.float()
		Impl.setItemOpacity @_id, val

	close: ->
		@_id = ''
		pool[@type].push @
		null

	Object.freeze @::

exports._pool = pool
exports._Item = Item
exports._Impl = Impl

exports._create = (type, proto, opts) ->
	expect(type).toBe.truthy().string()
	expect(proto).toBe.object()
	expect(opts).toBe.simpleObject()

	id = opts.id
	id ?= "u#{utils.uid()}"

	expect(id).toMatchRe Item.ID_RE

	# create signals object
	itemSignals = signals[id] = {}

	# get item instance
	item = exports._open type, proto, id
	Impl.createItem type, id

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
				item = exports._open type, proto, id
				Function.apply.call signalFunc, item, arguments
				item.close()

			Impl.attachItemSignal id, signalName, bindSignalFunc

		signalFunc.connected.connect handler

	# fill item
	customOpts = utils.clone opts
	delete customOpts.id
	utils.mergeDeep item, customOpts

	# close modification
	item.close()

	id

exports._open = (type, proto, id) ->
	expect(type).toBe.truthy().string()
	expect(proto).toBe.object()
	expect(id).toBe.truthy().string()

	item = pool[type].pop()

	unless item
		item = Object.create(proto)
		Item.call item, type

	item._id = id

	# move signals
	itemSignals = signals[id]
	for signalName in Item.SIGNALS
		item[signalName] = itemSignals[signalName]

	item

exports.create = (opts) ->
	exports._create 'Item', Item::, opts

exports.open = (id) ->
	exports._open 'Item', Item::, id