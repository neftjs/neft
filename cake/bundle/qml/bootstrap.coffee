boot = ->
	require = (src, callback) ->

		Qt.include src, (e) ->
			switch e.status
				when e.OK
					callback?()
				when e.NETWORK_ERROR
					console.log "Cannot load #{src}"
				when e.EXCEPTION
					console.log "#{e.exception.name}: #{e.exception.message}"

	require 'bootstrap/timers.js', ->
		require 'script.js'
