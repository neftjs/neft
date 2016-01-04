'use strict'

utils = require 'utils'

module.exports = (Networking) ->
	impl = {}

	Request: require('./request.coffee') Networking
	Response: require('./response.coffee') Networking, impl

	init: (networking) ->
		setImmediate ->
			networking.createLocalRequest
				method: Networking.Request.GET
				type: Networking.Request.HTML_TYPE
				uri: '/'
		return

	###
	Send a XHR request and call `callback` on response.
	###
	sendRequest: (req, res, callback) ->
		{Request} = Networking

		xhr = new XMLHttpRequest

		# prevent caching
		uri = req.uri.toString()
		if utils.has(uri, '?')
			uri = "#{uri}&now=#{Date.now()}"
		else
			uri = "#{uri}?now=#{Date.now()}"

		xhr.open req.method, uri, true

		for name, val of req.headers
			xhr.setRequestHeader name, val
		xhr.setRequestHeader 'X-Expected-Type', req.type

		if cookies = utils.tryFunction(JSON.stringify, null, [req.cookies], null)
			xhr.setRequestHeader 'X-Cookies', cookies

		xhr.onload = ->
			{response} = xhr

			if req.type is Request.JSON_TYPE and typeof response is 'string'
				response = utils.tryFunction JSON.parse, null, [response], response

			if cookies = xhr.getResponseHeader('X-Cookies')
				cookies = utils.tryFunction JSON.parse, null, [cookies], null

			callback
				status: xhr.status
				data: response
				cookies: cookies

		xhr.onerror = ->
			callback
				status: xhr.status
				data: xhr.response

		if utils.isObject(req.data)
			data = utils.tryFunction JSON.stringify, null, [req.data], req.data
		else
			data = req.data
		xhr.send data
