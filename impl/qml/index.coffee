'use strict'

utils = require 'utils'

module.exports = (Networking) ->
	Request: require('./request.coffee') Networking
	Response: require('./response.coffee') Networking

	init: (networking) ->

		setImmediate ->
			# send internal request
			res = networking.createRequest
				method: Networking.Request.GET
				uri: '/docs/log/null'
				data: null

	sendRequest: (networking, opts, callback) ->

		Request = Networking.Request

		xhr = new XMLHttpRequest

		xhr.open opts.method, opts.uri, true
		xhr.setRequestHeader 'X-Expected-Type', opts.type

		xhr.onreadystatechange = ->
			return if xhr.readyState isnt 4

			response = xhr.responseText

			if opts.type is Request.OBJECT_TYPE
				response = utils.tryFunction JSON.parse, null, [response], response

			callback xhr.status, response

		xhr.send()