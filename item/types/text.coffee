'use strict'

expect = require 'expect'
utils = require 'utils'

module.exports = (Scope, Impl) -> class Text extends Scope.Item
	@__name__ = 'Text'

	utils.defProp @::, 'text', 'e', ->
		Impl.getText @_globalId
	, (val) ->
		expect(val).toBe.string()
		Impl.setText @_globalId, val

	utils.defProp @::, 'color', 'e', ->
		Impl.getTextColor @_globalId
	, (val) ->
		expect(val).toBe.truthy().string()
		Impl.setTextColor @_globalId, val

	utils.defProp @::, 'lineHeight', 'e', ->
		Impl.getTextLineHeight @_globalId
	, (val) ->
		expect(val).toBe.truthy().float()
		Impl.setTextLineHeight @_globalId, val

	utils.defProp @::, 'fontFamily', 'e', ->
		Impl.getTextFontFamily @_globalId
	, (val) ->
		expect(val).toBe.truthy().string()
		Impl.setTextFontFamily @_globalId, val

	utils.defProp @::, 'fontPixelSize', 'e', ->
		Impl.getTextFontPixelSize @_globalId
	, (val) ->
		expect(val).toBe.truthy().float()
		Impl.setTextFontPixelSize @_globalId, val

	utils.defProp @::, 'fontWeight', 'e', ->
		Impl.getTextFontWeight @_globalId
	, (val) ->
		expect(val).toBe.float()
		expect(val).not().toBe.greatherThan 1
		expect(val).not().toBe.lessThan 0
		Impl.setTextFontWeight @_globalId, val

	utils.defProp @::, 'fontWordSpacing', 'e', ->
		Impl.getTextFontWordSpacing @_globalId
	, (val) ->
		expect(val).toBe.float()
		Impl.setTextFontWordSpacing @_globalId, val

	utils.defProp @::, 'fontLetterSpacing', 'e', ->
		Impl.getTextFontLetterSpacing @_globalId
	, (val) ->
		expect(val).toBe.float()
		Impl.setTextFontLetterSpacing @_globalId, val
