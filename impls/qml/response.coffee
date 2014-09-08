'use strict'

[log, View] = ['log', 'view'].map require

log = log.scope 'Routing'

prevResp = null

module.exports = (pending) ->

	send: ->

		log.info "Got response `#{@req.method}` `#{@req.uri}`"

		# mark previous response as unused
		prevResp?.destroy()
		prevResp = @

		switch true
			when @data instanceof View
				# webView.loadHtml @data.node.stringify()

				# destroy view when it won't be needed
				@on @constructor.DESTROY, -> @data.destroy()

			else
				# webView.loadHtml "<pre>" + JSON.stringify(@data, 0, 4) + "</pre>"