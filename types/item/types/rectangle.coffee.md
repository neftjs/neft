Renderer.Rectangle
==================

	'use strict'

	expect = require 'expect'
	utils = require 'utils'
	Dict = require 'dict'

	module.exports = (Renderer, Impl, itemUtils) ->

*Rectangle* Rectangle([*Object* options, *Array* children])
-----------------------------------------------------------

**Extends:** `Renderer.Item`

		class Rectangle extends Renderer.Item
			@__name__ = 'Rectangle'
			@__path__ = 'Renderer.Rectangle'

			@DATA = utils.merge Object.create(Renderer.Item.DATA),
				color: 'transparent'
				radius: 0

*String* Rectangle::color
-------------------------

### Rectangle::colorChanged(*String* oldValue)

			itemUtils.defineProperty @::, 'color', null, (_super) -> (val) ->
				expect(val).toBe.string()
				_super.call @, val
				Impl.setRectangleColor.call @, val

*Float* Rectangle::radius
-------------------------

### Rectangle::radiusChanged(*Float* oldValue)

			itemUtils.defineProperty @::, 'radius', null, (_super) -> (val) ->
				expect(val).toBe.float()
				expect(val).not().toBe.lessThan 0
				_super.call @, val
				Impl.setRectangleRadius.call @, val

*Border* Rectangle::border
--------------------------

			Renderer.State.supportObjectProperty 'border'
			utils.defineProperty @::, 'border', utils.ENUMERABLE, ->
				utils.defineProperty @, 'border', utils.ENUMERABLE, val = new Border(@)
				val
			, (val) ->
				expect(val).toBe.simpleObject()
				utils.merge @border, Border.DATA
				utils.merge @border, val

*Border* Border()
-----------------

**Extends:** `Dict`

		class Border extends Dict
			@__name__ = 'Border'

			@DATA = Rectangle.DATA.border =
				width: 0
				color: 'transparent'

			constructor: (item) ->
				expect(item).toBe.any Rectangle

				utils.defineProperty @, '_item', null, item

				super Object.create Border.DATA

*Float* Border::width
---------------------

### Border::widthChanged(*Float* oldValue)

			itemUtils.defineProperty @::, 'width', null, (_super) -> (val) ->
				expect(val).toBe.float()
				expect(val).not().toBe.lessThan 0
				_super.call @, val
				Impl.setRectangleBorderWidth.call @_item, val

*String* Border::color
----------------------

### Border::colorChanged(*String* oldValue)

			itemUtils.defineProperty @::, 'color', null, (_super) -> (val) ->
				expect(val).toBe.string()
				_super.call @, val
				Impl.setRectangleBorderColor.call @_item, val

		Rectangle