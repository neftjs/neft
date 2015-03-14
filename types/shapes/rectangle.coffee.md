Drawing shapes/Rectangle
========================

```style
Rectangle {
  width: 150
  height: 100
  color: 'blue'
  border.color: 'black'
  border.width: 5
  radius: 10
}
```

	'use strict'

	expect = require 'expect'
	utils = require 'utils'

	module.exports = (Renderer, Impl, itemUtils) ->

*Rectangle* Rectangle() : *Renderer.Item*
-----------------------------------------

*Renderer.Item* represents filled rectangle with an optional border and corner radius.

		class Rectangle extends Renderer.Item
			@__name__ = 'Rectangle'
			@__path__ = 'Renderer.Rectangle'

			constructor: ->
				@_color = 'transparent'
				super()

*String* Rectangle::color = 'transparent'
-----------------------------------------

### *Signal* Rectangle::colorChanged(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'color'
				defaultValue: 'transparent'
				implementation: Impl.setRectangleColor
				developmentSetter: (val) ->
					expect(val).toBe.string()

*Float* Rectangle::radius = 0
-----------------------------

### *Signal* Rectangle::radiusChanged(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'radius'
				defaultValue: 0
				implementation: Impl.setRectangleRadius
				developmentSetter: (val) ->
					expect(val).toBe.float()

			clone: ->
				clone = super()
				clone.color = @_color
				clone.radius = @_radius
				clone.border = @border
				clone

*Border* Rectangle::border
--------------------------

### *Signal* Rectangle::borderChanged(*Border* border)

		class Border extends itemUtils.DeepObject
			@__name__ = 'Border'

			itemUtils.defineProperty
				constructor: Rectangle
				name: 'border'
				valueConstructor: Border
				developmentSetter: (val) ->
					assert.isObject val
				setter: (_super) -> (val) ->
					{border} = @
					border.width = val.width if val.width?
					border.color = val.color if val.color?
					_super.call @, val
					return

			constructor: ->
				super()

*Float* Rectangle::border.width = 0
-----------------------------------

### *Signal* Rectangle::border.widthChanged(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'width'
				defaultValue: 0
				namespace: 'border'
				parentConstructor: Rectangle
				implementation: Impl.setRectangleBorderWidth
				developmentSetter: (val) ->
					expect(val).toBe.float()

*String* Rectangle::border.color = 'transparent'
------------------------------------------------

### *Signal* Rectangle::border.colorChanged(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'color'
				defaultValue: 'transparent'
				namespace: 'border'
				parentConstructor: Rectangle
				implementation: Impl.setRectangleBorderColor
				developmentSetter: (val) ->
					expect(val).toBe.string()

			toJSON: ->
				width: @width
				color: @color

		Rectangle
