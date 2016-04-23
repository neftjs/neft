'use strict'

log = require 'neft-log'
utils = require 'neft-utils'

exports.currentScope = null
exports.currentTest = null
exports.messages = []
exports.errors = []

if utils.isNode
	process.on 'uncaughtException', (err) ->
		exports.fail err

exports.fail = (err) ->
	{errors, currentTest} = exports

	unless err instanceof Error
		err = new Error err

	err.test = currentTest
	errors.push err
	currentTest.fulfilled = false
	unless currentTest._callbackCalled
		currentTest.onEnd()
	return

exports.callFunction = (func, context, args) ->
	try
		func.apply context, args
		true
	catch err
		exports.fail err
		false
