'use strict'

utils = require 'utils'

module.exports = (Routing) ->
	Request: require('./request.coffee') Routing
	Response: require('./response.coffee') Routing

	init: (routing) ->

		setImmediate ->
			# send internal request
			res = routing.createRequest
				method: Routing.Request.GET
				uri: 'docs/log/null'
				data: null

	sendServerRequest: (routing, opts, callback) ->

		Request = Routing.Request

		xhr = new XMLHttpRequest

		xhr.open opts.method, opts.url, true
		xhr.setRequestHeader 'X-Expected-Type', opts.type

		xhr.onreadystatechange = ->
			return if xhr.readyState isnt 4

			response = xhr.responseText

			if opts.type is Request.OBJECT_TYPE
				response = utils.tryFunction JSON.parse, null, [response], response

			callback xhr.status, response

		xhr.send()