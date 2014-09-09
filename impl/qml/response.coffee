'use strict'

[log, View] = ['log', 'view'].map require

log = log.scope 'Routing'

prevResp = null

module.exports = (Routing, pending) ->

	send: (res) ->

		log.info "Got response `#{res.req.method}` `#{res.req.uri}`"

		# mark previous response as unused
		prevResp?.destroy()
		prevResp = res.

		switch true
			when res.data instanceof View
				# webView.loadHtml res.data.node.stringify()

				# destroy view when it won't be needed
				res.on res.constructor.DESTROY, -> res.data.destroy()

			else
				# webView.loadHtml "<pre>" + JSON.stringify(res.data, 0, 4) + "</pre>"