'use strict'

expect = require 'expect'
utils = require 'utils'

module.exports = (Scope, Impl) ->
	self = null

	Font = Object.create null

	utils.defProp Font, 'family', 'e', ->
		Impl.getTextFontFamily self._uid
	, (val) ->
		expect(val).toBe.truthy().string()
		Impl.setTextFontFamily self._uid, val

	utils.defProp Font, 'pixelSize', 'e', ->
		Impl.getTextFontPixelSize self._uid
	, (val) ->
		expect(val).toBe.truthy().float()
		Impl.setTextFontPixelSize self._uid, val

	utils.defProp Font, 'weight', 'e', ->
		Impl.getTextFontWeight self._uid
	, (val) ->
		expect(val).toBe.float()
		expect(val).not().toBe.greaterThan 1
		expect(val).not().toBe.lessThan 0
		Impl.setTextFontWeight self._uid, val

	utils.defProp Font, 'wordSpacing', 'e', ->
		Impl.getTextFontWordSpacing self._uid
	, (val) ->
		expect(val).toBe.float()
		Impl.setTextFontWordSpacing self._uid, val

	utils.defProp Font, 'letterSpacing', 'e', ->
		Impl.getTextFontLetterSpacing self._uid
	, (val) ->
		expect(val).toBe.float()
		Impl.setTextFontLetterSpacing self._uid, val

	Object.freeze Font

	class Text extends Scope.Item
		@__name__ = 'Text'

		utils.defProp @::, 'text', 'e', ->
			Impl.getText @_uid
		, (val) ->
			expect(val).toBe.string()
			Impl.setText @_uid, val

		utils.defProp @::, 'color', 'e', ->
			Impl.getTextColor @_uid
		, (val) ->
			expect(val).toBe.truthy().string()
			Impl.setTextColor @_uid, val

		utils.defProp @::, 'lineHeight', 'e', ->
			Impl.getTextLineHeight @_uid
		, (val) ->
			expect(val).toBe.truthy().float()
			Impl.setTextLineHeight @_uid, val

		utils.defProp @::, 'font', 'e', ->
			self = @
			Font
		, (val) ->
			expect(val).toBe.simpleObject()
			self = @
			utils.merge Font, val

