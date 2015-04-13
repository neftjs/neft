Item/Pointer
============

#### Rectangle hover action @snippet

```style
Rectangle {
\  width: 100
\  height: 100
\  color: 'green'
\
\  State {
\    when: target.pointer.isHover
\    changes: {
\      color: 'red'
\    }
\  }
}
```

	'use strict'

	utils = require 'utils'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils, Item) ->
		class Pointer extends itemUtils.DeepObject
			@__name__ = 'Pointer'

*Pointer* Pointer()
-------------------

This class enables mouse and touch handling.

			constructor: (ref) ->
				@_x = 0
				@_y = 0
				@_isPressed = false
				@_isHover = false
				@_isPressedInitialized = false
				@_isHoverInitialized = false
				super ref

*Signal* Pointer::clicked(*Object* event)
-----------------------------------------

This signal is called when there is a click.

The *event* object contains x and y position.

```style
Rectangle {
\  width: 200
\  height: 100
\  border.width: 5
\  border.color: 'red'
\
\  pointer.onClicked: function(e){
\    var rect = new Rectangle;
\    rect.parent = this;
\    rect.x = e.x - 5;
\    rect.y = e.y - 5;
\    rect.width = 10;
\    rect.height = 10;
\    rect.color = 'green';
\  }
}
```

*Signal* Pointer::pressed(*Object* event)
-----------------------------------------

This signal is called when the pointer has been pressed under the item.

The *event* object contains x and y position.

*Signal* Pointer::released(*Object* event)
------------------------------------------

The *event* object contains x and y position.

*Signal* Pointer::entered(*Object* event)
-----------------------------------------

This signal is called when the pointer enters the item.

The *event* object contains x and y position.

*Signal* Pointer::exited()
--------------------------

This signal is called when the pointer leaves the item.

*Signal* Pointer::wheel(*Object* event)
---------------------------------------

The *event* object contains x and y delta.

*Signal* Pointer::moved(*Object* event)
---------------------------------------

This signal is called when the pointer position changed.

			onLazySignalInitialized = (pointer, name) ->
				Impl.attachItemSignal.call pointer, 'pointer', name

			@SIGNALS = ['clicked', 'pressed', 'released',
			            'entered', 'exited', 'wheel', 'moved']

			for signalName in @SIGNALS
				signal.Emitter.createSignal @, signalName, onLazySignalInitialized

*Boolean* Pointer::isPressed = false
------------------------------------

This property holds whether the pointer is currently pressed.

### *Signal* Pointer::isPressedChanged(*Boolean* oldValue)

			isPressedInitializer = do ->
				onPressed = ->
					@isPressed = true
					signal.STOP_PROPAGATION
				onReleased = ->
					@isPressed = false

				(pointer) ->
					pointer.onPressed onPressed
					pointer.onReleased onReleased

			itemUtils.defineProperty
				constructor: Pointer
				name: 'isPressed'
				defaultValue: false
				namespace: 'pointer'
				parentConstructor: Item
				signalInitializer: isPressedInitializer
				getter: (_super) -> ->
					unless @_isPressedInitialized
						isPressedInitializer @
						@_isPressedInitialized = true
					_super.call @

*Boolean* Pointer::isHover = false
----------------------------------

This property holds whether the pointer is currently under the item.

### *Signal* Pointer::isHoverChanged(*Boolean* oldValue)

			isHoverInitializer = do ->
				onEntered = ->
					@isHover = true
				onExited = ->
					@isHover = false

				(pointer) ->
					pointer.onEntered onEntered
					pointer.onExited onExited

			itemUtils.defineProperty
				constructor: Pointer
				name: 'isHover'
				defaultValue: false
				namespace: 'pointer'
				parentConstructor: Item
				signalInitializer: isHoverInitializer
				getter: (_super) -> ->
					unless @_isHoverInitialized
						isHoverInitializer @
						@_isHoverInitialized = true
					_super.call @

*Item* Item()
-------------

*Pointer* Item::pointer
-----------------------

Reference to the **Pointer** class instance.

Always use access by item, because all [Renderer.Item][]s shares the same instance.

		itemUtils.defineProperty
			constructor: Item
			name: 'pointer'
			valueConstructor: Pointer

		Pointer
