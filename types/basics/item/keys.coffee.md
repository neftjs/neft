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
	assert = require 'assert'

	module.exports = (Renderer, Impl, itemUtils, Item) ->
		class Keys extends itemUtils.DeepObject
			@__name__ = 'Keys'

*Keys* Keys()
-------------

			constructor: (ref) ->
				@_focus = false
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

*Boolean* Keys::focus = false
-----------------------------

### *Signal* Keys::focusChanged(*Boolean* oldValue)

			focusedKeys = null

			itemUtils.defineProperty
				constructor: Keys
				name: 'focus'
				defaultValue: false
				namespace: 'keys'
				parentConstructor: Item
				implementation: Impl.setItemKeysFocus
				developmentSetter: (val) ->
					assert.isBoolean val
				setter: (_super) -> (val) ->
					if @_focus isnt val
						if val and focusedKeys isnt @
							focusedKeys?.focus = false
							focusedKeys = @
						_super.call @, val
						if not val and focusedKeys is @
							focusedKeys = null
							if focusedKeys isnt Renderer.window.keys
								Renderer.window.keys.focus = true
					return

*Item* Item()
-------------

*Keys* Item::keys
-----------------

		itemUtils.defineProperty
			constructor: Item
			name: 'keys'
			valueConstructor: Keys

		Keys
