'use strict'

[utils, http] = ['utils', 'http'].map require

pending = {}

exports.Request = require('./request.coffee') pending
exports.Response = require('./response.coffee') pending

exports.init = ->

	# create server
	server = http.createServer()

	# start listening
	server.listen @port, @host

	# on request
	server.on 'request', (serverReq, serverRes) =>

		uid = utils.uid()

		# save in stack
		obj = pending[uid] =
			routing: @
			server: server
			res: null
			serverReq: serverReq
			serverRes: serverRes

		type = serverReq.headers['x-expected-type']

		obj.res = @handleRequest
			uid: uid
			method: @constructor.Request[serverReq.method]
			uri: serverReq.url.slice 1
			data: undefined
			type: type

		# run immediately if needed
		unless obj.res.req.pending
			exports.Response.send.call obj.res

exports.sendRequest = ->

	throw "Sending routing requests are not supported on the `node`"