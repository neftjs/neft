Basic elements/Rectangle
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

*Rectangle* Rectangle([*Object* options, *Array* children]) : *Renderer.Item*
-----------------------------------------------------------------------------

*Renderer.Item* represents filled rectangle with an optional border and corner radius.

		class Rectangle extends Renderer.Item
			@__name__ = 'Rectangle'
			@__path__ = 'Renderer.Rectangle'

			itemUtils.initConstructor @,
				extends: Renderer.Item
				data:
					color: 'transparent'
					radius: 0

*String* Rectangle::color = 'transparent'
-----------------------------------------

### *Signal* Rectangle::colorChanged(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'color'
				implementation: Impl.setRectangleColor
				developmentSetter: (val) ->
					expect(val).toBe.string()

*Float* Rectangle::radius = 0
-----------------------------

### *Signal* Rectangle::radiusChanged(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'radius',
				implementation: Impl.setRectangleRadius
				developmentSetter: (val) ->
					expect(val).toBe.float()
					expect(val).not().toBe.lessThan 0

*Border* Rectangle::border
--------------------------

### *Signal* Rectangle::borderChanged(*Border* border)

		class Border extends itemUtils.DeepObject
			@__name__ = 'Border'

			itemUtils.initConstructor @,
				data:
					width: 0
					color: 'transparent'

			itemUtils.defineProperty
				constructor: Rectangle
				name: 'border'
				valueConstructor: Border

*Float* Rectangle::border.width = 0
-----------------------------------

### *Signal* Rectangle::border.widthChanged(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'width'
				namespace: 'border'
				implementation: Impl.setRectangleBorderWidth
				developmentSetter: (val) ->
					expect(val).toBe.float()
					expect(val).not().toBe.lessThan 0

*String* Rectangle::border.color = 'transparent'
------------------------------------------------

### *Signal* Rectangle::border.colorChanged(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'color'
				namespace: 'border'
				implementation: Impl.setRectangleBorderColor
				developmentSetter: (val) ->
					expect(val).toBe.string()

		Rectangle
