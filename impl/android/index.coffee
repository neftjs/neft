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
		_neft.http.request 'http://example.com/', 'get', [], ''

		headers = []
		for name, val of req.headers
			headers.push name, val

		if typeof (data = req.data) isnt 'string'
			data = utils.tryFunction JSON.stringify, null, [data], data+''

		id = _neft.http.request req.uri, req.method, headers, data

		requests[id] =
			type: req.type
			callback: callback
		return
