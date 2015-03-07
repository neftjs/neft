Pointer events
==============

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

			constructor: ->
				super()

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

This signal is called when the pointer position changes.

The *event* object contains x and y position.

			onLazySignalInitialized = (pointer, signalName, uniqueName) ->
				Impl.attachItemSignal.call pointer._ref, 'pointer', uniqueName, signalName

			@SIGNALS = ['clicked', 'pressed', 'released',
			            'entered', 'exited', 'wheel', 'moved']

			for signalName in @SIGNALS
				uniqueName = "pointer#{utils.capitalize(signalName)}"
				signal.Emitter.createSignal @, signalName, uniqueName, '_ref', onLazySignalInitialized

*Integer* Pointer::x
--------------------

This property refers to the current pointer x position relative to the item.

### *Signal* Pointer::xChanged(*Integer* oldValue)

			onPositionSignalInitialized = do ->
				onMoved = (e) ->
					@pointer.x = e.x
					@pointer.y = e.y
					return

				(pointer) ->
					pointer.onMoved onMoved

			itemUtils.defineProperty
				constructor: Pointer
				name: 'x'
				defaultValue: 0
				namespace: 'pointer'
				parentConstructor: Item
				signalInitializer: onPositionSignalInitialized

*Integer* Pointer::y
--------------------

This property refers to the current pointer y position relative to the item.

```style
var signal = require('signal');

Rectangle {
\  width: 200
\  height: 100
\  border.width: 5
\  border.color: 'red'
\
\  Rectangle {
\    width: 20
\    height: 20
\    color: 'green'
\    x: parent.pointer.x - this.width / 2
\    y: parent.pointer.y - this.height / 2
\    pointer.onPressed: function(){
\      // prevent page scrolling on touch devices
\      return signal.STOP_PROPAGATION;
\    }
\  }
}
```

### *Signal* Pointer::yChanged(*Integer* oldValue)

			itemUtils.defineProperty
				constructor: Pointer
				name: 'y'
				defaultValue: 0
				namespace: 'pointer'
				parentConstructor: Item
				signalInitializer: onPositionSignalInitialized

*Boolean* Pointer::isPressed = false
------------------------------------

This property holds whether the pointer is currently pressed.

### *Signal* Pointer::isPressedChanged(*Boolean* oldValue)

			isPressedInitializer = do ->
				onPressed = ->
					@pointer.isPressed = true
					signal.STOP_PROPAGATION
				onReleased = ->
					@pointer.isPressed = false

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
					unless @_ref.hasOwnProperty '_pointerIsPressed'
						isPressedInitializer @
						@_ref._pointerIsPressed = false
					_super.call @

*Boolean* Pointer::isHover = false
----------------------------------

This property holds whether the pointer is currently under the item.

### *Signal* Pointer::isHoverChanged(*Boolean* oldValue)

			isHoverInitializer = do ->
				onEntered = ->
					@pointer.isHover = true
				onExited = ->
					@pointer.isHover = false

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
					unless @_ref.hasOwnProperty '_pointerIsHover'
						isHoverInitializer @
						@_ref._pointerIsHover = false
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
