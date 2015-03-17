Keyboard events
===============

```style
Rectangle {
\  width: 100
\  height: 100
\  color: 'green'
\  keys.onPressed: function(){
\    this.color = 'red';
\  }
\  keys.onReleased: function(){
\    this.color = 'green';
\  }
}
```

	'use strict'

	utils = require 'utils'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils, Item) ->
		class Keys extends itemUtils.DeepObject
			@__name__ = 'Keys'

*Keys* Keys()
-------------

			constructor: (ref) ->
				super ref

*Signal* Keys::pressed(*Object* event)
--------------------------------------

*Signal* Keys::hold(*Object* event)
-----------------------------------

*Signal* Keys::released(*Object* event)
---------------------------------------

*Signal* Keys::input(*Object* event)
------------------------------------

			onLazySignalInitialized = (keys, name) ->
				Impl.attachItemSignal.call keys, 'keys', name

			@SIGNALS = ['pressed', 'hold', 'released', 'input']

			for signalName in @SIGNALS
				signal.Emitter.createSignal @, signalName, onLazySignalInitialized

*Item* Item()
-------------

*Keys* Item::keys
-----------------

		itemUtils.defineProperty
			constructor: Item
			name: 'keys'
			valueConstructor: Keys

		Keys
