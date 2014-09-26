'use strict'

expect = require 'expect'
utils = require 'utils'

Item = require '../item'
Impl = Item._Impl

self = null

Rectangle = Object.create Item._Item::

utils.defProp Rectangle, 'color', 'e', ->
	Impl.getRectangleColor @_id
, (val) ->
	expect(val).toBe.truthy().string()
	Impl.setRectangleColor @_id, val

utils.defProp Rectangle, 'radius', 'e', ->
	Impl.getRectangleRadius @_id
, (val) ->
	expect(val).toBe.float()
	expect(val).not().toBe.lessThan 0
	Impl.setRectangleRadius @_id, val

utils.defProp Rectangle, 'border', 'e', ->
	self = @
	Border
, null

Object.freeze Rectangle

Border = Object.create null

utils.defProp Border, 'width', 'e', ->
	Impl.getRectangleBorderWidth self._id
, (val) ->
	expect(val).toBe.float()
	expect(val).not().toBe.lessThan 0
	Impl.setRectangleBorderWidth self._id, val

utils.defProp Border, 'color', 'e', ->
	Impl.getRectangleBorderColor self._id
, (val) ->
	expect(val).toBe.truthy().string()
	Impl.setRectangleBorderColor self._id, val

Object.freeze Border

Item._pool.Rectangle = []

exports.create = (opts) ->
	Item._create 'Rectangle', Rectangle, opts

exports.open = (id) ->
	Item._open 'Rectangle', Rectangle, id