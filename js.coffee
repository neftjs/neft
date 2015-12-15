window._createOnCompletion = (id) ->
	(data) ->
		webkit.messageHandlers.response.postMessage
			id: id
			response: data
		return
