'use strict'

utils = require 'utils'
assert = require 'assert'

module.exports = (impl) ->

	platform = do ->
		switch true
			when utils.isAndroid
				require('./android') impl
			when utils.isIOS
				require('./ios') impl

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

	bridge: bridge = platform.bridge

	setWindow: (item) ->
		bridge.pushAction bridge.outActions.SET_WINDOW
		bridge.pushItem item
		return

	exports
