'use strict'

utils = require 'utils'

module.exports = (Networking) ->
	Request: require('./request.coffee') Networking
	Response: require('./response.coffee') Networking

	init: (networking) ->
		# Send internal request to change the page based on the URI
		changePage = (uri) =>
			# send internal request
			uid = utils.uid()

			res = networking.createRequest
				uid: uid
				method: Networking.Request.GET
				type: Networking.Request.DOCUMENT_TYPE
				uri: uri
				data: null

		# synchronize with browser page changing
		window.addEventListener 'popstate', ->
			changePage location.pathname

		# don't refresh page on click anchor
		document.addEventListener 'click', (e) ->
			{target} = e

			# consider only anchors
			# omit anchors with the `target` attribute
			return if target.nodeName isnt 'A' or target.getAttribute('target')

			# avoid browser to refresh page
			e.preventDefault()

			# change page to the anchor pathname
			changePage target.pathname

		# change page to the current one
		setTimeout ->
			changePage location.pathname

	###
	Send a XHR request and call `callback` on response.
	###
	sendRequest: (req, callback) ->

		{Request} = Networking

		xhr = new XMLHttpRequest

		xhr.open req.method, req.uri, true
		xhr.setRequestHeader 'X-Expected-Type', req.type

		if req.type is Request.OBJECT_TYPE
			xhr.responseType = 'json'

		xhr.onload = ->
			{response} = xhr

			if req.type is Request.OBJECT_TYPE and typeof response is 'string'
				response = utils.tryFunction JSON.parse, null, [response], response

			callback xhr.status, response

		xhr.onerror = ->
			callback xhr.status, xhr.response

		xhr.send()
