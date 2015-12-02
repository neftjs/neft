'use strict'

utils = require 'utils'

module.exports = (Networking) ->

	requests = Object.create null

	_neft.http.onResponse (id, error, code, resp, cookies) ->
		request = requests[id]
		delete requests[id]

		if request.type is Networking.Request.JSON_TYPE
			resp = utils.tryFunction JSON.parse, null, [resp], resp
		cookies = utils.tryFunction JSON.parse, null, [cookies], null

		request.callback
			status: code
			data: resp or error
			cookies: cookies
		return

	Request: require('./request') Networking
	Response: require('./response') Networking

	init: (networking) ->
		# send internal request
		setImmediate ->
			networking.createLocalRequest
				method: Networking.Request.GET
				type: Networking.Request.HTML_TYPE
				uri: '/'

	sendRequest: (req, res, callback) ->
		headers = []
		for name, val of req.headers
			headers.push name, val
		headers.push 'content-type', 'text/plain'
		headers.push 'charset', 'utf-8'
		headers.push 'x-expected-type', req.type

		if cookies = utils.tryFunction(JSON.stringify, null, [req.cookies], null)
			headers.push 'x-cookies', cookies

		if typeof (data = req.data) isnt 'string'
			data = utils.tryFunction JSON.stringify, null, [data], data+''

		if typeof data is 'string'
			headers.push 'content-length', data.length

		id = _neft.http.request req.uri, req.method, headers, data

		requests[id] =
			type: req.type
			callback: callback
		return
