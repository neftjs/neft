'use strict'

utils = require 'utils'
http = require 'http'
urlUtils = require 'url'
expect = require 'expect'

pending = {}

module.exports = (Networking) ->

	Request: require('./request') Networking, pending
	Response: require('./response') Networking, pending

	init: (networking) ->
		expect(networking).toBe.any Networking

		# create server
		server = http.createServer()

		# start listening
		server.listen networking.port, networking.host

		# on request
		server.on 'request', (serverReq, serverRes) ->
			uid = utils.uid()

			# save in the stack
			obj = pending[uid] =
				networking: networking
				server: server
				req: null
				serverReq: serverReq
				serverRes: serverRes

			type = serverReq.headers['x-expected-type']
			type ||= Networking.Request.DOCUMENT_TYPE

			obj.req = networking.createRequest
				uid: uid
				method: Networking.Request[serverReq.method]
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
				status = res.statusCode

				if req.type is Networking.Request.OBJECT_TYPE
					parsedData = utils.tryFunction JSON.parse, null, [data], data
					callback status, parsedData
				else
					callback status, data

		nodeReq.on 'error', (e) ->
			callback 500, e

		if req.data?
			nodeReq.write req.data

		nodeReq.end()
