Keyboard events
===============

```
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

			constructor: ->
				super()

*Signal* Keys::pressed(*Object* event)
--------------------------------------

*Signal* Keys::hold(*Object* event)
-----------------------------------

*Signal* Keys::released(*Object* event)
---------------------------------------

*Signal* Keys::input(*Object* event)
------------------------------------

			onLazySignalInitialized = (keys, signalName, uniqueName) ->
				Impl.attachItemSignal.call keys._ref, 'keys', uniqueName, signalName

			@SIGNALS = ['pressed', 'hold', 'released', 'input']

			for signalName in @SIGNALS
				uniqueName = "keys#{utils.capitalize(signalName)}"
				signal.Emitter.createSignal @, signalName, uniqueName, '_ref', onLazySignalInitialized

*Item* Item()
-------------

*Keys* Item::keys
-----------------

		itemUtils.defineProperty
			constructor: Item
			name: 'keys'
			valueConstructor: Keys

		Keys
