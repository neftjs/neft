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

		if @data instanceof View
			html = @data.node.stringify()

			# destroy view when it won't be needed
			@on @constructor.DESTROY, -> @data.destroy()
		else
			html = "<pre>" + JSON.stringify(@data, 0, 4) + "</pre>"

		document.body.innerHTML = html