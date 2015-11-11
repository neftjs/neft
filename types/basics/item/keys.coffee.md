Keys @extension
===============

#### Handle keyboard events @snippet

```style
Rectangle {
\  width: 100
\  height: 100
\  color: 'green'
\  keys.focus: true
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

	module.exports = (Renderer, Impl, itemUtils, Item) -> (ctor) -> class Keys extends itemUtils.DeepObject
		@__name__ = 'Keys'

		itemUtils.defineProperty
			constructor: ctor
			name: 'keys'
			valueConstructor: Keys

*Keys* Keys()
-------------

		constructor: (ref) ->
			super ref
			@_focus = false
			Object.preventExtensions @

*Signal* Keys::onPress(*Object* event)
--------------------------------------

*Signal* Keys::onHold(*Object* event)
-------------------------------------

*Signal* Keys::onRelease(*Object* event)
----------------------------------------

*Signal* Keys::onInput(*Object* event)
--------------------------------------

		onLazySignalInitialized = (keys, name) ->
			Impl.attachItemSignal.call keys, 'keys', name

		@SIGNALS = ['onPress', 'onHold', 'onRelease', 'onInput']

		for signalName in @SIGNALS
			signal.Emitter.createSignal @, signalName, onLazySignalInitialized

*Boolean* Keys::focus = false
-----------------------------

### *Signal* Keys::onFocusChange(*Boolean* oldValue)

		focusedKeys = null

		itemUtils.defineProperty
			constructor: Keys
			name: 'focus'
			defaultValue: false
			namespace: 'keys'
			parentConstructor: ctor
			implementation: Impl["set#{ctor.__name__}KeysFocus"]
			developmentSetter: (val) ->
				assert.isBoolean val
			setter: (_super) -> (val) ->
				if @_focus isnt val
					if val and focusedKeys isnt @
						if focusedKeys
							oldVal = focusedKeys
							focusedKeys = null
							oldVal._focus = false
							oldVal.onFocusChange.emit true
							oldVal._ref.onKeysChange.emit oldVal
						focusedKeys = @
					_super.call @, val
					if not val and focusedKeys is @
						focusedKeys = null
						if focusedKeys isnt Renderer.window.keys
							Renderer.window.keys.focus = true
				return
