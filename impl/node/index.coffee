'use strict'

utils = require 'utils'
http = require 'http'
https = require 'https'
urlUtils = require 'url'
pathUtils = require 'path'
assert = require 'neft-assert'
nodeStatic = require 'node-static'

EXT_TYPES =
	__proto__: null
	'.js': 'text'
	'.txt': 'text'
	'.json': 'json'

pending = Object.create null

staticServer = new nodeStatic.Server gzip: true

module.exports = (Networking) ->

	Request: require('./request') Networking, pending
	Response: require('./response') Networking, pending

	init: (networking) ->
		assert.instanceOf networking, Networking

		# create server
		switch networking.protocol
			when 'http'
				server = http.createServer()
			when 'https'
				server = https.createServer()
			else
				throw new Error "Unsupported protocol '#{networking.protocol}'"

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
				parsedUrl = urlUtils.parse serverReq.url

				# save in the stack
				obj = pending[uid] =
					networking: networking
					server: server
					req: null
					serverReq: serverReq
					serverRes: serverRes

				type = serverReq.headers['x-expected-type']
				unless type
					extname = pathUtils.extname parsedUrl.pathname
					type = EXT_TYPES[extname]
				type ||= Networking.Request.HTML_TYPE

				# data
				if data isnt ''
					reqData = utils.tryFunction(JSON.parse, null, [data], data)
				else
					reqData = null

				# url
				url = serverReq.url
				if utils.has(url, '?')
					url = url.slice 0, url.indexOf('?')

				# cookies
				cookies = serverReq.headers['x-cookies']
				if typeof cookies is 'string'
					cookies = utils.tryFunction JSON.parse, null, [cookies], null

				obj.req = networking.createRequest
					uid: uid
					method: Networking.Request[serverReq.method]
					uri: url
					data: reqData
					type: type
					headers: serverReq.headers
					cookies: cookies

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

		if cookies = utils.tryFunction JSON.stringify, null, [req.cookies], null
			opts.headers['X-Cookies'] = cookies

		switch urlObject.protocol
			when 'http:'
				reqModule = http
			when 'https:'
				reqModule = https
			else
				callback
					status: 500
					data: new Error "Unsupported protocol '#{urlObject.protocol}'"
				return

		nodeReq = reqModule.request opts, (res) ->
			res.setEncoding 'utf-8'
			data = ''

			res.on 'data', (chunk) ->
				data += chunk

			res.on 'end', ->
				status = res.statusCode

				if req.type is Networking.Request.JSON_TYPE
					data = utils.tryFunction JSON.parse, null, [data], data

				if cookies = res.headers['x-cookies']
					cookies = utils.tryFunction JSON.parse, null, [cookies], null

				callback
					status: status
					data: data
					cookies: cookies

		nodeReq.on 'error', (e) ->
			callback
				status: 500
				data: e

		if req.data?
			if utils.isObject(req.data)
				data = utils.tryFunction JSON.stringify, null, [req.data], req.data
			else
				data = req.data
			nodeReq.write data

		nodeReq.end()
