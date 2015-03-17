Positioning/Fill
================

	'use strict'

	assert = require 'assert'
	utils = require 'utils'

	module.exports = (Renderer, Impl, itemUtils, Item) ->

		class Fill extends itemUtils.DeepObject
			@__name__ = 'Fill'

			constructor: (ref) ->
				@_width = false
				@_height = false
				super ref

*Fill* Fill()
-------------

*Boolean* Fill::width = false
-----------------------------

### *Signal* Fill::widthChanged(*Boolean* oldValue)

			itemUtils.defineProperty
				constructor: Fill
				name: 'width'
				defaultValue: false
				implementation: (val) ->
					Impl.setItemFill.call @, 'width', val
				namespace: 'fill'
				parentConstructor: Item
				developmentSetter: (val) ->
					assert.isBoolean val

*Boolean* Fill::height = false
------------------------------

### *Signal* Fill::heightChanged(*Boolean* oldValue)

			itemUtils.defineProperty
				constructor: Fill
				name: 'height'
				defaultValue: false
				implementation: (val) ->
					Impl.setItemFill.call @, 'height', val
				namespace: 'fill'
				parentConstructor: Item
				developmentSetter: (val) ->
					assert.isBoolean val

*Float* Fill::valueOf()
-----------------------

			valueOf: ->
				if @width is @height
					@width
				else
					throw new Error "Item::fill values are different"

			toJSON: ->
				width: @width
				height: @height

*Item* Item()
-------------

*Fill* Item::fill
-----------------

### *Signal* Item::fillChanged(*Fill* fill)

		itemUtils.defineProperty
			constructor: Item
			name: 'fill'
			valueConstructor: Fill
			setter: (_super) -> (val) ->
				{fill} = @
				if utils.isObject(val)
					fill.width = val.width if val.width?
					fill.height = val.height if val.height?
				else
					fill.width = fill.height = val
				_super.call @, val
				return

		Item::clone = do (_super = Item::clone) -> ->
			clone = _super.call @
			if @_fill
				clone.fill = @fill
			clone

		Fill
