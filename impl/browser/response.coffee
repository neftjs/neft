'use strict'

[log, View] = ['log', 'view'].map require

log = log.scope 'Routing'

module.exports = (Routing, impl) ->

	send: (res) ->

		log.ok "Got response `#{res.req.method} #{res.req.uri}`"

		# mark previous response as unused
		impl.resp?.destroy()

		# save response into internal impl object
		impl.resp = res

		unless res.data instanceof View
			data = do =>
				if res.data isnt null and typeof res.data is 'object'
					try JSON.stringify res.data, null, 4
				else if res.data instanceof Error
					res.data.stack
				else
					res.data
			document.body.innerHTML = data