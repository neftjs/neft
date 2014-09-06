'use strict'

module.exports = (pending) ->

	getHeaders: ->
		pending[@uid]?.serverReq.headers

	getUserAgent: ->
		pending[@uid]?.serverReq.headers['user-agent']