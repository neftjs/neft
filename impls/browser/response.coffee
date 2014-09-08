'use strict'

[log, View] = ['log', 'view'].map require

log = log.scope 'Routing'

module.exports = (impl) ->

	send: ->

		log.ok "Got response `#{@req.method} #{@req.uri}`"

		# mark previous response as unused
		impl.resp?.destroy()

		# save response into internal impl object
		impl.resp = @

		switch true
			when @data instanceof View
				# TODO: detect when styles are not using and serve HTML
				# document.body.innerHTML = @data.node.stringify()

				# destroy view on response destroy
				@on @constructor.DESTROY, -> @data.destroy()

			else
				document.body.innerHTML = "<pre>" + JSON.stringify(@data, 0, 4) + "</pre>"