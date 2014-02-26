'use strict'

[utils, http] = ['utils', 'http'].map require

pending = {}

exports.Response = require('./response.coffee') pending

exports.init = ->

	# create server
	server = http.createServer()

	# start listening
	server.listen @port, @host

	# on request
	server.on 'request', (serverReq, serverRes) =>

		# call request
		res = @request
			method: @constructor[serverReq.method]
			url: serverReq.url.slice 1
			body: null

		# save in stack
		pending[res.req.uid] =
			routing: @
			server: server
			res: res
			serverReq: serverReq
			serverRes: serverRes

		# run immediately if needed
		unless res.req.pending
			exports.Response.send.call res