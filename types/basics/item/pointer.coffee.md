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
			super ref
			@_enabled = true
			@_draggable = false
			@_dragActive = false
			@_pressed = false
			@_hover = false
			@_pressedInitialized = false
			@_hoverInitialized = false

			Object.preventExtensions @

*Boolean* Pointer::enabled = true
---------------------------------

### *Signal* Pointer::onEnabledChange(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: Pointer
			name: 'enabled'
			defaultValue: true
			namespace: 'pointer'
			parentConstructor: ctor
			implementation: Impl.setItemPointerEnabled
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

*Boolean* Pointer::dragActive = false
-------------------------------------

### *Signal* Pointer::onDragActiveChange(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: Pointer
			name: 'dragActive'
			defaultValue: false
			namespace: 'pointer'
			parentConstructor: ctor
			implementation: Impl.setItemPointerDragActive
			developmentSetter: (val) ->
				assert.isBoolean val

*Signal* Pointer::onClick(*PointerEvent* event)
-----------------------------------------------

This signal is called when there is a click.

*Signal* Pointer::onPress(*PointerEvent* event)
-----------------------------------------------

This signal is called when the pointer has been pressed under the item.

*Signal* Pointer::onRelease(*PointerEvent* event)
-------------------------------------------------

The *event* object contains x and y position.

*Signal* Pointer::onEnter(*PointerEvent* event)
-----------------------------------------------

This signal is called when the pointer enters the item.

The *event* object contains x and y position.

*Signal* Pointer::onExit(*PointerEvent* event)
----------------------------------------------

This signal is called when the pointer leaves the item.

*Signal* Pointer::onWheel(*Object* event)
-----------------------------------------

The *event* object contains x and y delta.

*Signal* Pointer::onMove(*PointerEvent* event)
----------------------------------------------

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

*PointerEvent* PointerEvent()
-----------------------------

Events order:
 1. Press
 2. Enter
 3. Move
 4. Move (not captured ensured items)
 5. Exit
 6. Release
 7. Click
 8. Release (not captured ensured items)

Stopped 'Enter' event will emit 'Move' event on this item.

Stopped 'Exit' event will emit 'Release' event on this item.

		@PointerEvent = class PointerEvent
			constructor: ->
				@_stopPropagation = true
				@_ensureRelease = true
				@_ensureMove = true
				@_deltaX = 0
				@_deltaY = 0
				Object.preventExtensions @

*Boolean* PointerEvent::stopPropagation = true
----------------------------------------------

Disable this property in 'onPress' signal to propagate event further.

This property is 'false' by default except the 'onPress' signal.

			utils.defineProperty @::, 'stopPropagation', null, ->
				@_stopPropagation
			, (val) ->
				assert.isBoolean val
				@_stopPropagation = val

*Boolean* PointerEvent::ensureRelease = true
--------------------------------------------

Define whether pressed item should get 'onRelease' signal even
if pointer has been released outside of this item.

Can be changed only in 'onPress' signal.

			utils.defineProperty @::, 'ensureRelease', null, ->
				@_ensureRelease
			, (val) ->
				assert.isBoolean val
				@_ensureRelease = val

*Boolean* PointerEvent::ensureMove = true
-----------------------------------------

Define whether pressed item should get 'onMove' signals even
if pointer is outside of this item.

Can be changed only in 'onPress' signal.

			utils.defineProperty @::, 'ensureMove', null, ->
				@_ensureMove
			, (val) ->
				assert.isBoolean val
				@_ensureMove = val

ReadOnly *Float* PointerEvent::deltaX
-------------------------------------

			utils.defineProperty @::, 'deltaX', null, ->
				@_deltaX
			, null

ReadOnly *Float* PointerEvent::deltaY
-------------------------------------

			utils.defineProperty @::, 'deltaY', null, ->
				@_deltaY
			, null

*PointerEvent* Pointer.event
----------------------------

		@event = new PointerEvent
