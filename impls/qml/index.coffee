'use strict'

[utils, Model] = ['utils', 'model'].map require

exports.Request = require('./request.coffee')()
exports.Response = require('./response.coffee')()

exports.init = ->

	setImmediate =>
		# send internal request
		uid = utils.uid()

		res = @onRequest
			uid: uid
			method: @constructor.GET
			uri: 'items/0'
			data: null

exports.sendRequest = (opts, callback) ->

	xhr = new XMLHttpRequest

	xhr.open opts.method, opts.url, true
	xhr.setRequestHeader 'X-Expected-Type', Model.OBJECT
	xhr.onreadystatechange = ->
		return if xhr.readyState isnt 4

		response = utils.tryFunc JSON.parse, null, [xhr.responseText], xhr.responseText
		callback xhr.status, response

	xhr.send()