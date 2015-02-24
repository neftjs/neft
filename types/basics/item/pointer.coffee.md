Pointer events
==============

```
Rectangle {
\  width: 200
\  height: 200
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

```
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
\    rect.color = 'red';
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

*Signal* Pointer::move(*Object* event)
--------------------------------------

This signal is called when the pointer position changes.

The *event* object contains x and y position.

			onLazySignalInitialized = (pointer, signalName, uniqueName) ->
				Impl.attachItemSignal.call pointer._ref, 'pointer', uniqueName, signalName

			@SIGNALS = ['clicked', 'pressed', 'released',
			            'entered', 'exited', 'wheel', 'move']

			for signalName in @SIGNALS
				uniqueName = "pointer#{utils.capitalize(signalName)}"
				signal.Emitter.createSignal @, signalName, uniqueName, '_ref', onLazySignalInitialized

*Integer* Pointer::x
--------------------

This property refers to the current pointer x position relative to the item.

			onPositionSignalInitialized = do ->
				onMove = (e) ->
					@pointer.x = e.x
					@pointer.y = e.y
					return

				(pointer) ->
					pointer.onMove onMove

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

```
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

			itemUtils.defineProperty
				constructor: Pointer
				name: 'isPressed'
				defaultValue: false
				namespace: 'pointer'
				parentConstructor: Item
				signalInitializer: do ->
					onPressed = ->
						@pointer.isPressed = true
					onReleased = ->
						@pointer.isPressed = false

					(pointer) ->
						pointer.onPressed onPressed
						pointer.onReleased onReleased

*Boolean* Pointer::isHover = false
----------------------------------

This property holds whether the pointer is currently under the item.

			itemUtils.defineProperty
				constructor: Pointer
				name: 'isHover'
				defaultValue: false
				namespace: 'pointer'
				parentConstructor: Item
				signalInitializer: do ->
					onEntered = ->
						@pointer.isHover = true
					onExited = ->
						@pointer.isHover = false

					(pointer) ->
						pointer.onEntered onEntered
						pointer.onExited onExited

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
