Keys @extension
===============

```nml
`Rectangle {
`	width: 100
`	height: 100
`	color: 'green'
`	keys.focus: true
`	keys.onPressed: function(){
`		this.color = 'red';
`	}
`	keys.onReleased: function(){
`		this.color = 'green';
`	}
`}
```

	'use strict'

	utils = require 'utils'
	signal = require 'signal'
	assert = require 'assert'

	module.exports = (Renderer, Impl, itemUtils, Item) -> (ctor) -> class Keys extends itemUtils.DeepObject
		@__name__ = 'Keys'

		{Device} = Renderer

		itemUtils.defineProperty
			constructor: ctor
			name: 'keys'
			valueConstructor: Keys

*Boolean* Keys.focusWindowOnPointerPress = true
-----------------------------------------------

		@focusWindowOnPointerPress = true

*Keys* Keys()
-------------

		constructor: (ref) ->
			super ref
			@_focus = false
			Object.preventExtensions @

*Signal* Keys::onPress(*KeysEvent* event)
-----------------------------------------

*Signal* Keys::onHold(*KeysEvent* event)
----------------------------------------

*Signal* Keys::onRelease(*KeysEvent* event)
-------------------------------------------

*Signal* Keys::onInput(*KeysEvent* event)
-----------------------------------------

		@SIGNALS = ['onPress', 'onHold', 'onRelease', 'onInput']

		for signalName in @SIGNALS
			signal.Emitter.createSignal @, signalName

*Boolean* Keys::focus = false
-----------------------------

## *Signal* Keys::onFocusChange(*Boolean* oldValue)

		focusedKeys = null
		focusChangeOnPointerPress = false

		Renderer.onReady ->
			Renderer.Device.onPointerPress ->
				focusChangeOnPointerPress = false

		Renderer.onWindowChange ->
			@window.pointer.onPress ->
				if Keys.focusWindowOnPointerPress and not focusChangeOnPointerPress
					@keys.focus = true
			, @window

		itemUtils.defineProperty
			constructor: Keys
			name: 'focus'
			defaultValue: false
			implementation: Impl.setItemKeysFocus
			namespace: 'keys'
			parentConstructor: ctor
			developmentSetter: (val) ->
				assert.isBoolean val
			setter: (_super) -> (val) ->
				if val
					focusChangeOnPointerPress = true
				if @_focus isnt val
					if val and focusedKeys isnt @
						if focusedKeys
							oldVal = focusedKeys
							focusedKeys = null
							Impl.setItemKeysFocus.call oldVal._ref, false
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

		Device.onKeyPress (event) ->
			focusedKeys?.onPress.emit keysEvent

		Device.onKeyHold (event) ->
			focusedKeys?.onHold.emit keysEvent

		Device.onKeyRelease (event) ->
			focusedKeys?.onRelease.emit keysEvent

		Device.onKeyInput (event) ->
			focusedKeys?.onInput.emit keysEvent

*KeysEvent* KeysEvent() : *DeviceKeyboardEvent*
-----------------------------------------------

		@KeysEvent = class KeysEvent
			constructor: ->
				Object.preventExtensions @

			@:: = Object.create Device.keyboard
			@::constructor = KeysEvent

*KeysEvent* Keys.event
----------------------

		@event = keysEvent = new KeysEvent
