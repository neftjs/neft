'use strict'

utils = require 'src/utils'
http = require 'http'
https = require 'https'
urlUtils = require 'url'
pathUtils = require 'path'
assert = require 'src/assert'
nodeStatic = require 'node-static'
FormData = require 'form-data'
qs = require 'qs'

EXT_TYPES =
	__proto__: null
	'.js': 'text'
	'.txt': 'text'
	'.json': 'json'

pending = Object.create null

staticServer = new nodeStatic.Server gzip: true

module.exports = (Networking) ->

	Request: require('./request') Networking, pending
	Response: Response = require('./response') Networking, pending

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
				if ///^(?:\/static\/|\/build\/static\/)///.test(serverReq.url)
					staticServer.serve serverReq, serverRes
					return

				{url} = serverReq

				# remove 'now'
				url = url.replace /(?:&|\?)now=\d+/, ''

				uid = utils.uid()
				parsedUrl = urlUtils.parse url

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
					switch serverReq.headers['content-type']
						when 'application/x-www-form-urlencoded'
							reqData = qs.parse data
						else
							reqData = utils.tryFunction(JSON.parse, null, [data], data)
				else
					reqData = null

				# cookies
				cookies = serverReq.headers['x-cookies']
				if typeof cookies is 'string'
					cookies = utils.tryFunction JSON.parse, null, [cookies], null

				obj.req = networking.createLocalRequest
					uid: uid
					method: Networking.Request[serverReq.method]
					uri: url
					data: reqData
					type: type
					headers: serverReq.headers
					cookies: cookies

	sendRequest: (req, res, callback) ->
		urlObject = urlUtils.parse req.uri.toString()

		opts =
			protocol: urlObject.protocol
			hostname: urlObject.hostname
			port: urlObject.port
			auth: urlObject.auth
			path: urlObject.path
			method: req.method
			headers: utils.clone(req.headers)

		opts.headers['X-Expected-Type'] = req.type

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

		nodeReq = reqModule.request opts, (nodeRes) ->
			nodeRes.setEncoding res.encoding

			data = ''

			nodeRes.on 'data', (chunk) ->
				data += chunk

			nodeRes.on 'end', ->
				status = nodeRes.statusCode

				if req.type is Networking.Request.JSON_TYPE
					data = utils.tryFunction JSON.parse, null, [data], data

				if cookies = nodeRes.headers['x-cookies']
					cookies = utils.tryFunction JSON.parse, null, [cookies], null

				callback
					status: status
					data: data
					headers: nodeRes.headers
					cookies: cookies

		nodeReq.on 'error', (e) ->
			callback
				status: 500
				data: e

		data = Response._prepareData req.type, nodeReq, req.data
		Response._sendData req.type, null, nodeReq, data, (err) ->
			if err
				callback err
