'use strict'

expect = require 'expect'
utils = require 'utils'

module.exports = (Scope, Impl) ->
	self = null

	Font = Object.create null

	utils.defProp Font, 'family', 'e', ->
		Impl.getTextFontFamily self._globalId
	, (val) ->
		expect(val).toBe.truthy().string()
		Impl.setTextFontFamily self._globalId, val

	utils.defProp Font, 'pixelSize', 'e', ->
		Impl.getTextFontPixelSize self._globalId
	, (val) ->
		expect(val).toBe.truthy().float()
		Impl.setTextFontPixelSize self._globalId, val

	utils.defProp Font, 'weight', 'e', ->
		Impl.getTextFontWeight self._globalId
	, (val) ->
		expect(val).toBe.float()
		expect(val).not().toBe.greaterThan 1
		expect(val).not().toBe.lessThan 0
		Impl.setTextFontWeight self._globalId, val

	utils.defProp Font, 'wordSpacing', 'e', ->
		Impl.getTextFontWordSpacing self._globalId
	, (val) ->
		expect(val).toBe.float()
		Impl.setTextFontWordSpacing self._globalId, val

	utils.defProp Font, 'letterSpacing', 'e', ->
		Impl.getTextFontLetterSpacing self._globalId
	, (val) ->
		expect(val).toBe.float()
		Impl.setTextFontLetterSpacing self._globalId, val

	Object.freeze Font

	class Text extends Scope.Item
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

		utils.defProp @::, 'font', 'e', ->
			self = @
			Font
		, (val) ->
			expect(val).toBe.simpleObject()
			self = @
			utils.merge Font, val

