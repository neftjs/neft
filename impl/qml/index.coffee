'use strict'

[utils, Model] = ['utils', 'model'].map require

module.exports = (Routing) ->
	Request: require('./request.coffee') Routing
	Response: require('./response.coffee') Routing

	init: (routing) ->

		setImmediate ->
			# send internal request
			uid = utils.uid()

			res = routing.handleRequest
				uid: uid
				method: routing.constructor.Request.GET
				uri: 'items/0'
				data: null

	sendServerRequest: (routing, opts, callback) ->

		Request = routing.constructor.Request

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