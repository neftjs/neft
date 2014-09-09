'use strict'

module.exports = (Routing, pending) ->

	getHeaders: (req) ->
		pending[req.uid]?.serverReq.headers

	getUserAgent: (req) ->
		pending[req.uid]?.serverReq.headers['user-agent']