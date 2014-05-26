'use strict'

[log, View, StylesView] = ['log', 'view', 'styles/view'].map require

log = log.scope 'Routing'

prevResp = null

module.exports = (pending) ->

	send: ->

		log.info "Got response `#{@req.method}` `#{@req.uri}`"

		# mark previous response as unused
		prevResp?.destroy()
		prevResp = @

		switch true
			when @data instanceof StylesView

				# clear styles and destroy view when it won't be needed
				@on @constructor.DESTROY, ->
					@data.clear()
					@data.view.destroy()

			when @data instanceof View
				document.body.innerHTML = @data.node.stringify()

				# destroy view when it won't be needed
				@on @constructor.DESTROY, -> @data.destroy()

			else
				document.body.innerHTML = "<pre>" + JSON.stringify(@data, 0, 4) + "</pre>"