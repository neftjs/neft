Button @class
=============

#### Draw a button @snippet

```style
Button {
  label.text: 'Click!'
  label.font.pixelSize: 30
  label.color: 'white'
  label.margin: 20
  background.color: 'red'
  image.source: 'http://lorempixel.com/200/140/'
  image.opacity: 0.3
  linkUri: '/order'
}
```

	'use strict'

	assert = require 'assert'
	utils = require 'utils'

	module.exports = (Renderer, Impl, itemUtils) ->

*Button* Button() : *Renderer.Item*
-----------------------------------

		class Button extends Renderer.Item
			@__name__ = 'Button'
			@__path__ = 'Renderer.Button'

			onLabelWidthChanged = ->
				if @_fill._width
					width = @label._width
					if @label._margin
						width += @label._margin._left + @label._margin._right
					@_updatePending = true
					@width = width
					@_updatePending = false
				return

			onLabelHeightChanged = ->
				if @_fill._height
					height = @label._height
					if @label._margin
						height += @label._margin._top + @label._margin._bottom
					@_updatePending = true
					@height = height
					@_updatePending = false
				return

			onLabelMarginChanged = ->
				{label} = @
				padding = @label._margin
				label.x = padding._left
				label.y = padding._top

				if @_fill._width
					onLabelWidthChanged.call @
				else
					label.width = @_width - padding._left - padding._right

				if @_fill._height
					onLabelHeightChanged.call @
				else
					label.height = @_height - padding._top - padding._bottom
				return

			onWidthChanged = ->
				width = @_width
				@background.width = width
				@image.width = width
				unless @_fill._width
					if @label._margin
						@label.width = width - @label._margin._left - @label._margin._right
					else
						@label.width = width
				return

			onHeightChanged = ->
				height = @_height
				@background.height = height
				@image.height = height
				unless @_fill._height
					if @label._margin
						@label.height = height - @label._margin._top - @label._margin._bottom
					else
						@label.height = height
				return

			constructor: ->
				@_updatePending = false

				@background = Renderer.Rectangle.create()
				@image = Renderer.Image.create()
				@label = Renderer.Text.create()

				super()

				@fill.width = true
				@fill.height = true

				@onWidthChanged onWidthChanged, @
				@onHeightChanged onHeightChanged, @
				@label.onWidthChanged onLabelWidthChanged, @
				@label.onHeightChanged onLabelHeightChanged, @
				@label.onMarginChanged onLabelMarginChanged, @

				@background.parent = @
				@image.parent = @
				@label.parent = @

			@::_width = -1
			getter = utils.lookupGetter @::, 'width'
			setter = utils.lookupSetter @::, 'width'
			utils.defineProperty @::, 'width', null, getter, do (_super = setter) -> (val) ->
				unless @_updatePending
					if @fill.width = val is -1
						@label.width = 0
				_super.call @, val
				return

			@::_height = -1
			getter = utils.lookupGetter @::, 'height'
			setter = utils.lookupSetter @::, 'height'
			utils.defineProperty @::, 'height', null, getter, do (_super = setter) -> (val) ->
				unless @_updatePending
					if @fill.height = val is -1
						@label.height = 0
				_super.call @, val
				return

			clone: ->
				clone = super()
				clone

		Button
