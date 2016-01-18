'use strict'

utils = require 'utils'
log = require 'log'
assert = require 'neft-assert'

listeners = Object.create null

reader =
	booleans: null
	booleansIndex: 0
	integers: null
	integersIndex: 0
	floats: null
	floatsIndex: 0
	strings: null
	stringsIndex: 0
	getBoolean: ->
		@booleans[@booleansIndex++]
	getInteger: ->
		@integers[@integersIndex++]
	getFloat: ->
		@floats[@floatsIndex++]
	getString: ->
		@strings[@stringsIndex++]
Object.preventExtensions reader

exports.onData = (actions, booleans, integers, floats, strings) ->
	reader.booleans = booleans
	reader.booleansIndex = 0
	reader.integers = integers
	reader.integersIndex = 0
	reader.floats = floats
	reader.floatsIndex = 0
	reader.strings = strings
	reader.stringsIndex = 0

	for action in actions
		func = listeners[action]
		assert.isFunction func, "unknown native action got '#{action}'"
		func reader

	exports.pushData()
	return

exports.addActionListener = (action, listener) ->
	assert.isInteger action
	assert.isFunction listener
	assert.isNotDefined listeners[action], "action '#{action}' already has a listener"

	listeners[action] = listener
	return

exports.sendData = ->

exports.pushAction = (val) ->

exports.pushBoolean = (val) ->

exports.pushInteger = (val) ->

exports.pushFloat = (val) ->

exports.pushString = (val) ->


impl = switch true
	when utils.isAndroid
		require './impl/android/bridge'
	when utils.isIOS
		require './impl/ios/bridge'
if impl?
	utils.merge exports, impl(exports)

`//<development>`
exports.pushAction = do (_super = exports.pushAction) -> (val) ->
	assert.isInteger val, "integer expected, but '#{val}' given"
	_super val
	return
exports.pushBoolean = do (_super = exports.pushBoolean) -> (val) ->
	assert.isBoolean val, "boolean expected, but '#{val}' given"
	_super val
	return
exports.pushInteger = do (_super = exports.pushInteger) -> (val) ->
	assert.isInteger val, "integer expected, but '#{val}' given"
	_super val
	return
exports.pushFloat = do (_super = exports.pushFloat) -> (val) ->
	assert.isFloat val, "float expected, but '#{val}' given"
	_super val
	return
exports.pushString = do (_super = exports.pushString) -> (val) ->
	assert.isString val, "string expected, but '#{val}' given"
	_super val
	return
`//</development>`
