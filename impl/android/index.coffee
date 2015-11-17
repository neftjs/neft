'use strict'

utils = require 'utils'

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
		listeners = Object.create null

		vsync = ->
			if actions.length
				_neft.renderer.transferData actions, items, booleans, ints, floats, strings

				utils.clear actions
				utils.clear items
				utils.clear booleans
				utils.clear ints
				utils.clear floats
				utils.clear strings

			requestAnimationFrame vsync

		requestAnimationFrame vsync

		_neft.renderer.onUpdateView do ->
			event = Object.create null
			(actions, items, booleans, integers, floats, strings) ->
				event.items = items
				event.itemsIndex = 0
				event.booleans = booleans
				event.booleansIndex = 0
				event.integers = integers
				event.integersIndex = 0
				event.floats = floats
				event.floatsIndex = 0
				event.strings = strings
				event.stringsIndex = 0

				for action in actions
					if arr = listeners[action]
						for func in arr
							func event
				return

		inActions: do (i=0) ->
			SCREEN_SIZE: i++

		outActions: do (i=0) ->
			SET_WINDOW: i++

			CREATE_ITEM: i++
			SET_ITEM_PARENT: i++
			SET_ITEM_INDEX: i++
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

			CREATE_IMAGE: i++
			SET_IMAGE_SOURCE: i++
			# SET_IMAGE_SOURCE_WIDTH: i++
			# SET_IMAGE_SOURCE_HEIGHT: i++
			# SET_IMAGE_FILL_MODE: i++
			# SET_IMAGE_OFFSET_X: i++
			# SET_IMAGE_OFFSET_Y: i++

			CREATE_TEXT: i++
			SET_TEXT: i++
			SET_TEXT_COLOR: i++
			SET_TEXT_LINE_HEIGHT: i++
			# SET_TEXT_FONT_FAMILY: i++
			SET_TEXT_FONT_PIXEL_SIZE: i++
			# SET_TEXT_FONT_WEIGHT: i++
			# SET_TEXT_FONT_WORD_SPACING: i++
			# SET_TEXT_FONT_LETTER_SPACING: i++
			SET_TEXT_FONT_ITALIC: i++
			# SET_TEXT_ALIGNMENT_HORIZONTAL: i++
			# SET_TEXT_ALIGNMENT_VERTICAL: i++
			
			CREATE_RECTANGLE: i++
			SET_RECTANGLE_COLOR: i++
			SET_RECTANGLE_RADIUS: i++
			SET_RECTANGLE_BORDER_COLOR: i++
			SET_RECTANGLE_BORDER_WIDTH: i++
		
		listen: (name, func) ->
			arr = listeners[name] ||= []
			arr.push func
			return

		lastId: 1
		actions: actions = []
		items: items = []
		booleans: booleans = []
		ints: ints = []
		floats: floats = []
		strings: strings = []

	setWindow: (item) ->
		bridge.actions.push bridge.SET_WINDOW
		bridge.items.push 0, item._impl.id

		item.width = screenWidth
		item.height = screenHeight
		return

	screenWidth = screenHeight = 0

	exports.bridge.listen exports.bridge.inActions.SCREEN_SIZE, (event) ->
		screenWidth = event.integers[event.integersIndex++]
		screenHeight = event.integers[event.integersIndex++]
		if impl.window
			impl.window.width = screenWidth
			impl.window.height = screenHeight
		return

	exports
