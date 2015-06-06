Pointer @extension
==================

#### Rectangle hover action @snippet

```style
Rectangle {
\  width: 100
\  height: 100
\  color: 'green'
\
\  Class {
\    when: target.pointer.hover
\    changes: {
\      color: 'red'
\    }
\  }
}
```

	'use strict'

	utils = require 'utils'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils, Item) -> (ctor) -> class Pointer extends itemUtils.DeepObject
		@__name__ = 'Pointer'

		itemUtils.defineProperty
			constructor: ctor
			name: 'pointer'
			valueConstructor: Pointer

*Pointer* Pointer()
-------------------

This class enables mouse and touch handling.

		constructor: (ref) ->
			@_x = 0
			@_y = 0
			@_pressed = false
			@_hover = false
			@_pressedInitialized = false
			@_hoverInitialized = false
			super ref

*Signal* Pointer::onClick(*Object* event)
-----------------------------------------

This signal is called when there is a click.

*Signal* Pointer::onPress(*Object* event)
-----------------------------------------

This signal is called when the pointer has been pressed under the item.

The *event* object contains x and y position.

*Signal* Pointer::onRelease(*Object* event)
-------------------------------------------

The *event* object contains x and y position.

*Signal* Pointer::onEnter(*Object* event)
-----------------------------------------

This signal is called when the pointer enters the item.

The *event* object contains x and y position.

*Signal* Pointer::onExit()
--------------------------

This signal is called when the pointer leaves the item.

*Signal* Pointer::onWheel(*Object* event)
-----------------------------------------

The *event* object contains x and y delta.

*Signal* Pointer::onMove(*Object* event)
----------------------------------------

This signal is called when the pointer position changed.

		onLazySignalInitialized = (pointer, name) ->
			Impl.attachItemSignal.call pointer, 'pointer', name

		@SIGNALS = ['onClick', 'onPress', 'onRelease',
		            'onEnter', 'onExit', 'onWheel', 'onMove']

		for signalName in @SIGNALS
			signal.Emitter.createSignal @, signalName, onLazySignalInitialized

*Boolean* Pointer::pressed = false
----------------------------------

This property holds whether the pointer is currently pressed.

### *Signal* Pointer::onPressedChange(*Boolean* oldValue)

		pressedInitializer = do ->
			onPress = ->
				@pressed = true
				signal.STOP_PROPAGATION
			onRelease = ->
				@pressed = false

			(pointer) ->
				pointer.onPress onPress
				pointer.onRelease onRelease

		itemUtils.defineProperty
			constructor: Pointer
			name: 'pressed'
			defaultValue: false
			namespace: 'pointer'
			parentConstructor: ctor
			signalInitializer: pressedInitializer
			getter: (_super) -> ->
				unless @_pressedInitialized
					pressedInitializer @
					@_pressedInitialized = true
				_super.call @

*Boolean* Pointer::hover = false
--------------------------------

This property holds whether the pointer is currently under the item.

### *Signal* Pointer::onHoverChange(*Boolean* oldValue)

		hoverInitializer = do ->
			onEnter = ->
				@hover = true
			onExit = ->
				@hover = false

			(pointer) ->
				pointer.onEnter onEnter
				pointer.onExit onExit

		itemUtils.defineProperty
			constructor: Pointer
			name: 'hover'
			defaultValue: false
			namespace: 'pointer'
			parentConstructor: ctor
			signalInitializer: hoverInitializer
			getter: (_super) -> ->
				unless @_hoverInitialized
					hoverInitializer @
					@_hoverInitialized = true
				_super.call @
