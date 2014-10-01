'use strict'

expect = require 'expect'
utils = require 'utils'

Item = require '../../item'
Impl = Item._Impl

Text = Object.create Item._Item::

utils.defProp Text, 'text', 'e', ->
	Impl.getText @_id
, (val) ->
	expect(val).toBe.string()
	Impl.setText @_id, val

utils.defProp Text, 'color', 'e', ->
	Impl.getTextColor @_id
, (val) ->
	expect(val).toBe.truthy().string()
	Impl.setTextColor @_id, val

utils.defProp Text, 'lineHeight', 'e', ->
	Impl.getTextLineHeight @_id
, (val) ->
	expect(val).toBe.truthy().float()
	Impl.setTextLineHeight @_id, val

utils.defProp Text, 'fontFamily', 'e', ->
	Impl.getTextFontFamily @_id
, (val) ->
	expect(val).toBe.truthy().string()
	Impl.setTextFontFamily @_id, val

utils.defProp Text, 'fontPixelSize', 'e', ->
	Impl.getTextFontPixelSize @_id
, (val) ->
	expect(val).toBe.truthy().float()
	Impl.setTextFontPixelSize @_id, val

utils.defProp Text, 'fontWeight', 'e', ->
	Impl.getTextFontWeight @_id
, (val) ->
	expect(val).toBe.float()
	expect(val).not().toBe.greatherThan 1
	expect(val).not().toBe.lessThan 0
	Impl.setTextFontWeight @_id, val

utils.defProp Text, 'fontWordSpacing', 'e', ->
	Impl.getTextFontWordSpacing @_id
, (val) ->
	expect(val).toBe.float()
	Impl.setTextFontWordSpacing @_id, val

utils.defProp Text, 'fontLetterSpacing', 'e', ->
	Impl.getTextFontLetterSpacing @_id
, (val) ->
	expect(val).toBe.float()
	Impl.setTextFontLetterSpacing @_id, val

Object.freeze Text

Item._pool.Text = []

exports.create = (opts) ->
	Item._create 'Text', Text, opts

exports.open = (id) ->
	Item._open 'Text', Text, id