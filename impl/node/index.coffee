'use strict'

utils = require 'utils'
http = require 'http'
urlUtils = require 'url'
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
		server.on 'request', (serverReq, serverRes) ->
			uid = utils.uid()

			# save in the stack
			obj = pending[uid] =
				routing: routing
				server: server
				req: null
				serverReq: serverReq
				serverRes: serverRes

			type = serverReq.headers['x-expected-type']
			type ||= Routing.Request.VIEW_TYPE

			obj.req = routing.createRequest
				uid: uid
				method: Routing.Request[serverReq.method]
				uri: serverReq.url
				data: undefined
				type: type

	sendRequest: (req, callback) ->
		urlObject = urlUtils.parse req.uri

		opts =
			protocol: urlObject.protocol
			hostname: urlObject.hostname
			port: urlObject.port
			auth: urlObject.auth
			path: urlObject.path
			method: req.method
			headers:
				'X-Expected-Type': req.type

		nodeReq = http.request opts, (res) ->
			res.setEncoding 'utf-8'
			data = ''

			res.on 'data', (chunk) ->
				data += chunk

			res.on 'end', ->
				status = nodeReq.statusCode

				if req.type is Routing.Request.OBJECT_TYPE
					parsedData = utils.tryFunction JSON.parse, null, [data], data
					callback status, parsedData
				else
					callback status, data

		nodeReq.on 'error', (e) ->
			callback nodeReq.statusCode, e

		if req.data?
			nodeReq.write req.data

		nodeReq.end()
