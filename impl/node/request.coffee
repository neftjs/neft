'use strict'

module.exports = (Networking, pending) ->

	getHeaders: (req) ->
		pending[req.uid]?.serverReq.headers

	getUserAgent: (req) ->
		pending[req.uid]?.serverReq.headers['user-agent']