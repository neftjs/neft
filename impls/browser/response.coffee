'use strict'

[log] = ['log'].map require

log = log.scope 'Routing'

module.exports = (pending) ->

	send: ->

		log.info "Got response `#{@req.method}` `#{@req.uri}`"

		document.body.innerHTML = "<pre>" + JSON.stringify(@data, 0, 4) + "</pre>"