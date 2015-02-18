'use strict'

utils = require 'utils'
http = require 'http'
urlUtils = require 'url'
assert = require 'neft-assert'
nodeStatic = require 'node-static'

pending = {}

staticServer = new nodeStatic.Server gzip: true

module.exports = (Networking) ->

	Request: require('./request') Networking, pending
	Response: require('./response') Networking, pending

	init: (networking) ->
		assert.instanceOf networking, Networking

		# create server
		server = http.createServer()

		# start listening
		server.listen networking.port, networking.host

		# on request
		server.on 'request', (serverReq, serverRes) ->
			data = ''

			serverReq.on 'data', (chunk) ->
				data += chunk;

			serverReq.on 'end', ->
				if ///^\/static\////.test(serverReq.url)
					staticServer.serve serverReq, serverRes
					return

				uid = utils.uid()

				# save in the stack
				obj = pending[uid] =
					networking: networking
					server: server
					req: null
					serverReq: serverReq
					serverRes: serverRes

				type = serverReq.headers['x-expected-type']
				type ||= Networking.Request.HTML_TYPE

				if data isnt ''
					reqData = utils.tryFunction(JSON.parse, null, [data], data)
				else
					reqData = null

				obj.req = networking.createRequest
					uid: uid
					method: Networking.Request[serverReq.method]
					uri: serverReq.url
					data: reqData
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
				status = res.statusCode

				if req.type is Networking.Request.JSON_TYPE
					parsedData = utils.tryFunction JSON.parse, null, [data], data
					callback status, parsedData
				else
					callback status, data

		nodeReq.on 'error', (e) ->
			callback 500, e

		if req.data?
			nodeReq.write req.data

		nodeReq.end()
