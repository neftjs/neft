'use strict'

log = require 'src/log'
utils = require 'src/utils'

exports.currentScope = null
exports.currentTest = null
exports.testsAmount = 0
exports.messages = []
exports.errors = []

exports.fail = (err) ->
	{errors, currentTest} = exports

	unless err instanceof Error
		err = new Error err

	errObj = utils.errorToObject err
	errObj.stack = err.stack
	utils.defineProperty errObj, 'test', 0, currentTest
	errors.push errObj
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
