'use strict'

[utils, Model] = ['utils', 'model'].map require

exports.Request = require('./request.coffee')()
exports.Response = require('./response.coffee')()

exports.init = ->

	setImmediate =>
		# send internal request
		uid = utils.uid()

		res = @handleRequest
			uid: uid
			method: @constructor.GET
			uri: 'items/0'
			data: null

exports.sendServerRequest = (opts, callback) ->

	Request = @constructor.Request

	xhr = new XMLHttpRequest

	xhr.open opts.method, opts.url, true
	xhr.setRequestHeader 'X-Expected-Type', opts.type

	xhr.onreadystatechange = ->
		return if xhr.readyState isnt 4

		response = xhr.responseText

		if opts.type is Request.OBJECT_TYPE
			response = utils.tryFunc JSON.parse, null, [response], response

		callback xhr.status, response

	xhr.send()