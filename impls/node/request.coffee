'use strict'

module.exports = (pending) ->

	getUserAgent: ->

		pending[@uid]?.serverReq.headers['user-agent']