Rectangle @class
=========

#### Draw a rectangle @snippet

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
	assert = require 'assert'
	utils = require 'utils'

	module.exports = (Renderer, Impl, itemUtils) ->

*Rectangle* Rectangle() : *Renderer.Item*
-----------------------------------------

*Renderer.Rectangle* represents filled rectangle with an optional border and corner radius.

		class Rectangle extends Renderer.Item
			@__name__ = 'Rectangle'
			@__path__ = 'Renderer.Rectangle'

			constructor: (component, opts) ->
				super component
				@_color = 'transparent'
				@_radius = 0
				@_border = null

				if opts
					itemUtils.Object.initialize @, opts

*String* Rectangle::color = 'transparent'
-----------------------------------------

### *Signal* Rectangle::onColorChange(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'color'
				defaultValue: 'transparent'
				implementation: Impl.setRectangleColor
				developmentSetter: (val) ->
					expect(val).toBe.string()

*Float* Rectangle::radius = 0
-----------------------------

### *Signal* Rectangle::onRadiusChange(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'radius'
				defaultValue: 0
				implementation: Impl.setRectangleRadius
				developmentSetter: (val) ->
					expect(val).toBe.float()

*Border* Rectangle::border
--------------------------

### *Signal* Rectangle::onBorderChange(*String* property, *Any* oldValue)

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

			constructor: (ref) ->
				@_width = 0
				@_color = 'transparent'
				super ref

*Float* Rectangle::border.width = 0
-----------------------------------

### *Signal* Rectangle::border.onWidthChange(*Float* oldValue)

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

### *Signal* Rectangle::border.onColorChange(*String* oldValue)

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
