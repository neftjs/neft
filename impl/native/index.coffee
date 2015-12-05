'use strict'

utils = require 'utils'
assert = require 'assert'

module.exports = (impl) ->

	exports =
	Types:
		Item: require './level0/item'
		Image: require './level0/image'
		Text: require './level0/text'
		TextInput: require './level0/textInput'
		FontLoader: require './level0/loader/font'
		ResourcesLoader: require './level0/loader/resources'
		Device: require './level0/device'
		Screen: require './level0/screen'
		Navigator: require './level0/navigator'
		RotationSensor: require './level0/sensor/rotation'
		AmbientSound: require './level0/sound/ambient'

		Rectangle: require './level1/rectangle'

	bridge: bridge = do ->
		itemsById = new Array 20000 # 20k
		listeners = Object.create null

		lastId = 0
		actions = []
		actionsIndex = 0
		booleans = []
		booleansIndex = 0
		integers = []
		integersIndex = 0
		floats = []
		floatsIndex = 0
		strings = []
		stringsIndex = 0

		pushActions = ->
			if actionsIndex > 0
				tmpActionsIndex = actionsIndex
				tmpBooleansIndex = booleansIndex
				tmpIntegersIndex = integersIndex
				tmpFloatsIndex = floatsIndex
				tmpStringsIndex = stringsIndex

				actionsIndex = 0
				booleansIndex = 0
				integersIndex = 0
				floatsIndex = 0
				stringsIndex = 0

				_neft.renderer.transferData actions, tmpActionsIndex,
					booleans, tmpBooleansIndex,
					integers, tmpIntegersIndex,
					floats, tmpFloatsIndex,
					strings, tmpStringsIndex
			return

		vsync = ->
			pushActions()
			requestAnimationFrame vsync

		requestAnimationFrame vsync

		_neft.renderer.onUpdateView do ->
			reader = Object.preventExtensions
				booleans: null
				booleansIndex: 0
				integers: null
				integersIndex: 0
				floats: null
				floatsIndex: 0
				strings: null
				stringsIndex: 0
				getItem: ->
					itemsById[@integers[@integersIndex++]]
				getBoolean: ->
					@booleans[@booleansIndex++]
				getInteger: ->
					@integers[@integersIndex++]
				getFloat: ->
					@floats[@floatsIndex++]
				getString: ->
					@strings[@stringsIndex++]

			(actions, booleans, integers, floats, strings) ->
				reader.booleans = booleans
				reader.booleansIndex = 0
				reader.integers = integers
				reader.integersIndex = 0
				reader.floats = floats
				reader.floatsIndex = 0
				reader.strings = strings
				reader.stringsIndex = 0

				for action in actions
					if arr = listeners[action]
						for func in arr
							func reader
					else
						console.error "Unknown native action got '#{action}'"

				pushActions()
				return

		inActions: do (i=0) ->
			SCREEN_SIZE: i++
			SCREEN_ORIENTATION: i++
			NAVIGATOR_LANGUAGE: i++
			NAVIGATOR_ONLINE: i++
			DEVICE_PIXEL_RATIO: i++
			DEVICE_IS_PHONE: i++
			POINTER_PRESS: i++
			POINTER_RELEASE: i++
			POINTER_MOVE: i++
			IMAGE_SIZE: i++
			TEXT_SIZE: i++
			FONT_LOAD: i++

		outActions: do (i=0) ->
			SET_WINDOW: i++

			CREATE_ITEM: i++
			SET_ITEM_PARENT: i++
			INSERT_ITEM_BEFORE: i++
			SET_ITEM_VISIBLE: i++
			SET_ITEM_CLIP: i++
			SET_ITEM_WIDTH: i++
			SET_ITEM_HEIGHT: i++
			SET_ITEM_X: i++
			SET_ITEM_Y: i++
			SET_ITEM_Z: i++
			SET_ITEM_SCALE: i++
			SET_ITEM_ROTATION: i++
			SET_ITEM_OPACITY: i++
			SET_ITEM_BACKGROUND: i++

			CREATE_IMAGE: i++
			SET_IMAGE_SOURCE: i++
			SET_IMAGE_SOURCE_WIDTH: i++
			SET_IMAGE_SOURCE_HEIGHT: i++
			SET_IMAGE_FILL_MODE: i++
			SET_IMAGE_OFFSET_X: i++
			SET_IMAGE_OFFSET_Y: i++

			CREATE_TEXT: i++
			SET_TEXT: i++
			SET_TEXT_WRAP: i++
			UPDATE_TEXT_CONTENT_SIZE: i++
			SET_TEXT_COLOR: i++
			SET_TEXT_LINE_HEIGHT: i++
			SET_TEXT_FONT_FAMILY: i++
			SET_TEXT_FONT_PIXEL_SIZE: i++
			SET_TEXT_FONT_WORD_SPACING: i++
			SET_TEXT_FONT_LETTER_SPACING: i++
			SET_TEXT_ALIGNMENT_HORIZONTAL: i++
			SET_TEXT_ALIGNMENT_VERTICAL: i++

			LOAD_FONT: i++

			CREATE_RECTANGLE: i++
			SET_RECTANGLE_COLOR: i++
			SET_RECTANGLE_RADIUS: i++
			SET_RECTANGLE_BORDER_COLOR: i++
			SET_RECTANGLE_BORDER_WIDTH: i++
		
		listen: (name, func) ->
			arr = listeners[name] ||= []
			arr.push func
			return

		getId: (item) ->
			assert.instanceOf item, impl.Renderer.Item
			itemsById[++lastId] = item
			lastId

		pushAction: (val) ->
			assert.isInteger val
			actions[actionsIndex++] = val
			return

		pushItem: (val) ->
			if val isnt null
				assert.instanceOf val, impl.Renderer.Item
			integers[integersIndex++] = if val isnt null then val._impl.id else 0
			return

		pushBoolean: (val) ->
			assert.isBoolean val
			booleans[booleansIndex++] = val
			return

		pushInteger: (val) ->
			assert.isInteger val
			integers[integersIndex++] = val
			return

		pushFloat: (val) ->
			assert.isFloat val
			floats[floatsIndex++] = val
			return

		pushString: (val) ->
			assert.isString val
			strings[stringsIndex++] = val
			return

	setWindow: (item) ->
		bridge.pushAction bridge.outActions.SET_WINDOW
		bridge.pushItem item
		return

	exports
