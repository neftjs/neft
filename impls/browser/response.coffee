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

		unless @data instanceof View
			data = do =>
				if @data isnt null and typeof @data is 'object'
					try JSON.stringify @data, null, 4
				else if @data instanceof Error
					@data.stack
				else
					@data
			document.body.innerHTML = data