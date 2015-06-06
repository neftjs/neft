Item/Fill @extension
=========

#### Stretch an item to it's children @snippet

```style
Rectangle {
\  fill.width: true
\  fill.height: true
\  color: 'red'
\
\  Rectangle {
\    x: 30; y: 30; width: 50; height: 50; color: 'blue'
\  }
\  Rectangle {
\    x: 30; y: 0; width: 50; height: 30; color: 'yellow'
\  }
}
```

	'use strict'

	assert = require 'assert'
	utils = require 'utils'

	module.exports = (Renderer, Impl, itemUtils, Item) -> (ctor) -> class Fill extends itemUtils.DeepObject
		@__name__ = 'Fill'

		itemUtils.defineProperty
			constructor: ctor
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

		ctor::clone = do (_super = ctor::clone) -> ->
			clone = _super.call @
			if @_fill
				clone.fill = @fill
			clone

		constructor: (ref) ->
			@_width = false
			@_height = false
			super ref

*Fill* Fill()
-------------

*Boolean* Fill::width = false
-----------------------------

### *Signal* Fill::onWidthChange(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: Fill
			name: 'width'
			defaultValue: false
			implementation: do ->
				impl = Impl["set#{ctor.__name__}Fill"]
				(val) ->
					impl.call @, 'width', val
			namespace: 'fill'
			parentConstructor: ctor
			developmentSetter: (val) ->
				assert.isBoolean val

*Boolean* Fill::height = false
------------------------------

### *Signal* Fill::onHeightChange(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: Fill
			name: 'height'
			defaultValue: false
			implementation: do ->
				impl = Impl["set#{ctor.__name__}Fill"]
				(val) ->
					impl.call @, 'height', val
			namespace: 'fill'
			parentConstructor: ctor
			developmentSetter: (val) ->
				assert.isBoolean val

*Float* Fill::valueOf()
-----------------------

		valueOf: ->
			if @width is @height
				@width
			else
				throw new Error "fill values are different"

		toJSON: ->
			width: @width
			height: @height
