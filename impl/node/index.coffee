'use strict'

[utils, http] = ['utils', 'http'].map require
expect = require 'expect'

pending = {}

module.exports = (Routing) ->

	Request: require('./request') Routing, pending
	Response: require('./response') Routing, pending

	init: (routing) ->
		expect(routing).toBe.any Routing

		# create server
		server = http.createServer()

		# start listening
		server.listen routing.port, routing.host

		# on request
		server.on 'request', (serverReq, serverRes) =>

			uid = utils.uid()

			# save in stack
			obj = pending[uid] =
				routing: routing
				server: server
				res: null
				serverReq: serverReq
				serverRes: serverRes

			type = serverReq.headers['x-expected-type']

			obj.res = routing.handleRequest
				uid: uid
				method: routing.constructor.Request[serverReq.method]
				uri: serverReq.url.slice 1
				data: undefined
				type: type