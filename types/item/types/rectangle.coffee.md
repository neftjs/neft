Renderer.Rectangle
==================

	'use strict'

	expect = require 'expect'
	utils = require 'utils'

	module.exports = (Renderer, Impl, itemUtils) ->

*Rectangle* Rectangle([*Object* options, *Array* children]) : Renderer.Item
---------------------------------------------------------------------------

		class Rectangle extends Renderer.Item
			@__name__ = 'Rectangle'
			@__path__ = 'Renderer.Rectangle'

			@DATA = utils.merge Object.create(Renderer.Item.DATA),
				color: 'transparent'
				radius: 0

*String* Rectangle::color
-------------------------

### Rectangle::colorChanged(*String* oldValue)

			itemUtils.defineProperty @::, 'color', Impl.setRectangleColor, null, (_super) -> (val) ->
				expect(val).toBe.string()
				_super.call @, val

*Float* Rectangle::radius
-------------------------

### Rectangle::radiusChanged(*Float* oldValue)

			itemUtils.defineProperty @::, 'radius', Impl.setRectangleRadius, null, (_super) -> (val) ->
				expect(val).toBe.float()
				expect(val).not().toBe.lessThan 0
				_super.call @, val

*Border* Rectangle::border
--------------------------

### Rectangle::borderChanged(*Border* border)

			Renderer.State.supportObjectProperty 'border'
			itemUtils.defineProperty @::, 'border', null, ((_super) -> ->
				if @_data.border is Rectangle.DATA.border
					@_data.border = new Border(@)
				_super.call @
			), (_super) -> (val) ->
				if val instanceof Border
					val = val._data

				{border} = @
				_super.call @, border

				if utils.isObject(val)
					utils.merge border, Border.DATA
					utils.merge border, val

*Border* Border()
-----------------

		class Border
			@__name__ = 'Border'

			@DATA = Rectangle.DATA.border =
				width: 0
				color: 'transparent'

			constructor: (item) ->
				expect(item).toBe.any Rectangle

				utils.defineProperty @, '_item', null, item

				data = Object.create Border.DATA
				utils.defineProperty @, '_data', null, data

*Float* Border::width
---------------------

### Border::widthChanged(*Float* oldValue)

			itemUtils.defineProperty @::, 'width', Impl.setRectangleBorderWidth, null, (_super) -> (val) ->
				expect(val).toBe.float()
				expect(val).not().toBe.lessThan 0
				_super.call @, val
				@_item.borderChanged? @

*String* Border::color
----------------------

### Border::colorChanged(*String* oldValue)

			itemUtils.defineProperty @::, 'color', Impl.setRectangleBorderColor, null, (_super) -> (val) ->
				expect(val).toBe.string()
				_super.call @, val
				@_item.borderChanged? @

		Rectangle