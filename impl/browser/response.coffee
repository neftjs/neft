'use strict'

[log, View] = ['log', 'view'].map require

log = log.scope 'Routing'

module.exports = (Routing) ->

	send: (res, data) ->

		log.ok "Got response `#{res.req.method} #{res.req.uri}`"

		unless data instanceof View
			data = do =>
				if data isnt null and typeof data is 'object'
					try JSON.stringify data, null, 4
				else if data instanceof Error
					data.stack
				else
					data
			document.body.innerHTML = data