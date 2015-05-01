'use strict'

utils = require 'utils'

exports.get = (key, callback) ->
	val = localStorage.getItem key
	val = utils.tryFunction JSON.parse, null, [val], val
	callback null, val

exports.set = (key, val, callback) ->
	if utils.isObject(val)
		val = utils.tryFunction JSON.stringify, null, [val], val
	localStorage.setItem key, val
	callback null

exports.remove = (key, callback) ->
	localStorage.removeItem key
	callback null