'use strict'

[log, View] = ['log', 'view'].map require

log = log.scope 'Routing'

module.exports = (Routing) ->

	send: (res, data) ->

		log.info "Got response `#{res.req.method}` `#{res.req.uri}`"

		# webView.loadHtml "<pre>" + JSON.res.data, 0, 4) + "</pre>"