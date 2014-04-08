'use strict'

[utils, Model] = ['utils', 'model'].map require

exports.Request = require('./request.coffee')()
exports.Response = require('./response.coffee')()

exports.init = ->

	uri = location.pathname

	uid = utils.uid()

	res = @onRequest
		uid: uid
		method: @constructor.GET
		uri: uri.slice 1
		data: null

exports.sendRequest = (opts, callback) ->

	xhr = new XMLHttpRequest

	xhr.open opts.method, opts.url, true
	xhr.setRequestHeader 'X-Expected-Type', Model.OBJECT
	xhr.onload = ->
		response = utils.tryFunc JSON.parse, null, xhr.response, xhr.response
		callback xhr.status, response

	xhr.send()