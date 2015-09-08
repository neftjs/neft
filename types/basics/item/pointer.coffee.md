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
	assert = require 'assert'

	NOP = ->

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
			@_captureEvents = true
			@_draggable = false
			@_dragging = false
			@_x = 0
			@_y = 0
			@_pressed = false
			@_hover = false
			@_pressedInitialized = false
			@_hoverInitialized = false
			super ref

*Boolean* Pointer::captureEvents = true
---------------------------------------

### *Signal* Pointer::onCaptureEventsChange(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: Pointer
			name: 'captureEvents'
			defaultValue: true
			namespace: 'pointer'
			parentConstructor: ctor
			implementation: Impl.setItemPointerCaptureEvents
			developmentSetter: (val) ->
				assert.isBoolean val

*Boolean* Pointer::draggable = false
------------------------------------

### *Signal* Pointer::onDraggableChange(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: Pointer
			name: 'draggable'
			defaultValue: false
			namespace: 'pointer'
			parentConstructor: ctor
			implementation: Impl.setItemPointerDraggable
			developmentSetter: (val) ->
				assert.isBoolean val

*Boolean* Pointer::dragging = false
-----------------------------------

### *Signal* Pointer::onDraggingChange(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: Pointer
			name: 'dragging'
			defaultValue: false
			namespace: 'pointer'
			parentConstructor: ctor
			implementation: Impl.setItemPointerDragging
			developmentSetter: (val) ->
				assert.isBoolean val

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

*Signal* Pointer::onDragStart()
-------------------------------

*Signal* Pointer::onDragEnd()
-----------------------------

*Signal* Pointer::onDragEnter()
-------------------------------

*Signal* Pointer::onDragExit()
------------------------------

*Signal* Pointer::onDrop()
--------------------------

		onLazySignalInitialized = (pointer, name) ->
			Impl.attachItemSignal.call pointer, 'pointer', name # TODO: send here an item

			if name is 'onPress' or name is 'onRelease'
				intitializePressed pointer
			if name is 'onEnter' or name is 'onExit'
				initializeHover pointer
			return

		@SIGNALS = ['onClick', 'onPress', 'onRelease',
		            'onEnter', 'onExit', 'onWheel', 'onMove',
		            'onDragStart', 'onDragEnd',
		            'onDragEnter', 'onDragExit', 'onDrop']

		for signalName in @SIGNALS
			signal.Emitter.createSignal @, signalName, onLazySignalInitialized

*Boolean* Pointer::pressed = false
----------------------------------

This property holds whether the pointer is currently pressed.

### *Signal* Pointer::onPressedChange(*Boolean* oldValue)

		intitializePressed = do ->
			onPress = ->
				@pressed = true
			onRelease = ->
				@pressed = false

			(pointer) ->
				unless pointer._pressedInitialized
					pointer._pressedInitialized = true
					pointer.onPress onPress
					pointer.onRelease onRelease
				return

		itemUtils.defineProperty
			constructor: Pointer
			name: 'pressed'
			defaultValue: false
			namespace: 'pointer'
			parentConstructor: ctor
			signalInitializer: intitializePressed
			getter: (_super) -> ->
				intitializePressed @
				_super.call @

*Boolean* Pointer::hover = false
--------------------------------

This property holds whether the pointer is currently under the item.

### *Signal* Pointer::onHoverChange(*Boolean* oldValue)

		initializeHover = do ->
			onEnter = ->
				@hover = true
			onExit = ->
				@hover = false

			(pointer) ->
				unless pointer._hoverInitialized
					pointer._hoverInitialized = true
					pointer.onEnter onEnter
					pointer.onExit onExit
				return

		itemUtils.defineProperty
			constructor: Pointer
			name: 'hover'
			defaultValue: false
			namespace: 'pointer'
			parentConstructor: ctor
			signalInitializer: initializeHover
			getter: (_super) -> ->
				initializeHover @
				_super.call @
