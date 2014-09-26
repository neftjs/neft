'use strict'

expect = require 'expect'
utils = require 'utils'

Item = require '../item'
Impl = Item._Impl

Image = Object.create Item._Item::

utils.defProp Image, 'source', 'e', ->
	Impl.getImageSource @_id
, (val) ->
	expect(val).toBe.truthy().string()
	Impl.setImageSource @_id, val

Object.freeze Image

Item._pool.Image = []

exports._Image = Image

exports.create = (opts) ->
	Item._create 'Image', Image, opts

exports.open = (id) ->
	Item._open 'Image', Image, id