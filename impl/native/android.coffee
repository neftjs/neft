'use strict'

assert = require 'assert'

actionsDef = require './actions'

module.exports = (impl) ->
	Types:
		Scrollable: require './level2/scrollable'

	bridge: do ->
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
			requestAnimationFrame vsync
			pushActions()

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

		inActions: actionsDef.in

		outActions: actionsDef.out
		
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
