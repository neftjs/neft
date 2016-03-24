'use strict'

log = require 'neft-log'

exports.currentScope = null
exports.currentTest = null
exports.messages = []
exports.errors = []

exports.fail = (err) ->
	{errors, currentTest} = exports

	err.test = currentTest
	errors.push err
	currentTest.fulfilled = false
	return

exports.callFunction = (func, context, args) ->
	try
		func.apply context, args
		true
	catch err
		exports.fail err
		false
