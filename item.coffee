'use strict'

expect = require 'expect'
utils = require 'utils'

Impl = require './impl'

pool =
	Item: []

class Item
	@ID_RE = ///^([a-z0-9_A-Z]+)$///

	constructor: (type) ->
		expect(type).toBe.truthy().string()

		utils.defProp @, 'type', '', type
		utils.defProp @, '_id', 'w', ''

		Object.seal @

	utils.defProp @::, 'id', 'e', ->
		@_id
	, null

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
		expect(val).toBe.float()
		expect(val).not().toBe.lessThan 0
		Impl.setItemWidth @_id, val

	utils.defProp @::, 'height', 'e', ->
		Impl.getItemHeight @_id
	, (val) ->
		expect(val).toBe.float()
		expect(val).not().toBe.lessThan 0
		Impl.setItemHeight @_id, val

	utils.defProp @::, 'x', 'e', ->
		Impl.getItemX @_id
	, (val) ->
		expect(val).toBe.float()
		Impl.setItemX @_id, val

	utils.defProp @::, 'y', 'e', ->
		Impl.getItemY @_id
	, (val) ->
		expect(val).toBe.float()
		Impl.setItemY @_id, val

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

	item = exports._open type, proto, id
	Impl.createItem type, id
	utils.mergeDeep item, opts
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

	item

exports.create = (opts) ->
	exports._create 'Item', Item::, opts

exports.open = (id) ->
	exports._open 'Item', Item::, id