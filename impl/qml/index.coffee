'use strict'

utils = require 'utils'

module.exports = (Networking) ->
	Request: require('./request.coffee') Networking
	Response: require('./response.coffee') Networking

	init: (networking) ->
		__location.change.connect (uri) ->
			# send internal request
			networking.createRequest
				method: Networking.Request.GET
				type: Networking.Request.HTML_TYPE
				uri: uri

		setImmediate ->
			__location.append '/'

	sendRequest: (req, res, callback) ->
		{Request} = Networking

		xhr = new XMLHttpRequest

		xhr.open req.method, req.uri, true

		for name, val of req.headers
			xhr.setRequestHeader name, val
		xhr.setRequestHeader 'X-Expected-Type', req.type

		if cookies = utils.tryFunction(JSON.stringify, null, [req.cookies], null)
			xhr.setRequestHeader 'X-Cookies', cookies

		xhr.onreadystatechange = ->
			return if xhr.readyState isnt 4

			response = xhr.responseText

			if req.type is Request.JSON_TYPE
				response = utils.tryFunction JSON.parse, null, [response], response

			if cookies = xhr.getResponseHeader('X-Cookies')
				cookies = utils.tryFunction JSON.parse, null, [cookies], null

			callback
				status: xhr.status
				data: response
				cookies: cookies

		xhr.send()