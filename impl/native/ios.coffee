'use strict'

utils = require 'utils'
assert = require 'assert'

actionsDef = require './actions'

_neft.renderer = {}

module.exports = (impl) ->
	bridge: do ->
		itemsById = new Array 20000 # 20k
		listeners = Object.create null

		lastId = 0
		actions = []
		booleans = []
		integers = []
		floats = []
		strings = []

		outDataObject =
			actions: actions
			booleans: booleans
			integers: integers
			floats: floats
			strings: strings

		pushActions = ->
			if actions.length > 0
				webkit.messageHandlers.updateView.postMessage outDataObject
				utils.clear actions
				utils.clear booleans
				utils.clear integers
				utils.clear floats
				utils.clear strings
			return

		vsync = ->
			requestAnimationFrame vsync
			pushActions()

		requestAnimationFrame vsync

		_neft.renderer.onUpdateView = do ->
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
				if actions.length is 0
					return

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
			itemsById[lastId] = item
			lastId++

		pushAction: (val) ->
			assert.isInteger val
			actions.push val
			return

		pushItem: (val) ->
			if val isnt null
				assert.instanceOf val, impl.Renderer.Item
			integers.push if val isnt null then val._impl.id else -1
			return

		pushBoolean: (val) ->
			assert.isBoolean val
			booleans.push val
			return

		pushInteger: (val) ->
			assert.isInteger val
			integers.push val
			return

		pushFloat: (val) ->
			assert.isFloat val
			floats.push val
			return

		pushString: (val) ->
			assert.isString val
			strings.push val
			return
