'use strict'

utils = require 'neft-utils'
log = require 'neft-log'
stack = require './stack'
errorUtils = require './error'

SCOPE_PAD = '    '
MIN_TIME_WARN = 100

logs = []
pad = ''
testStartTime = 0

exports.printLogs = ->
	for type, i in logs by 2
		log[type] logs[i+1]
	return

exports.onScopeStart = (scope) ->
	{message} = scope
	if message is ''
		return

	logs.push 'log', pad + scope.message
	pad += SCOPE_PAD
	return

exports.onScopeEnd = (scope) ->
	{message} = scope
	if message is ''
		return

	pad = pad.slice SCOPE_PAD.length
	return

exports.onTestStart = (test) ->
	testStartTime = Date.now()
	return

exports.onTestEnd = (test) ->
	msg = pad + test.message

	duration = Date.now() - testStartTime
	if duration > MIN_TIME_WARN
		ms = duration.toFixed(2)
		msg += " (#{ms} ms)"

	if test.fulfilled
		logs.push 'ok', msg
	else
		error = utils.last stack.errors
		errorString = errorUtils.toString error
		errorString = errorString.replace /^/gm, pad + SCOPE_PAD
		logs.push 'error', msg
		logs.push 'error', errorString
	return
