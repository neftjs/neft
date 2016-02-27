'use strict'

utils = require 'neft-utils'

module.exports = (bridge) ->
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

	_neft.native =
		onData: bridge.onData

	sendData: ->
		if actions.length <= 0
			return
		webkit.messageHandlers.transferData.postMessage outDataObject
		utils.clear actions
		utils.clear booleans
		utils.clear integers
		utils.clear floats
		utils.clear strings
		return
	pushAction: (val) ->
		actions.push val
		return
	pushBoolean: (val) ->
		booleans.push val
		return
	pushInteger: (val) ->
		integers.push val
		return
	pushFloat: (val) ->
		floats.push val
		return
	pushString: (val) ->
		strings.push val
		return
