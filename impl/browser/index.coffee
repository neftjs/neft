'use strict'

utils = require 'utils'

module.exports = (Networking) ->
	impl = {}

	Request: require('./request.coffee') Networking
	Response: require('./response.coffee') Networking, impl

	init: (networking) ->
		# Send internal request to change the page based on the URI
		impl.changePage = (uri) ->
			# send internal request
			res = networking.createRequest
				method: Networking.Request.GET
				type: Networking.Request.HTML_TYPE
				uri: uri

		# synchronize with browser page changing
		window.addEventListener 'popstate', ->
			impl.changePage location.pathname

		# don't refresh page on click anchor
		document.addEventListener 'click', (e) ->
			{target} = e

			# consider only anchors
			# omit anchors with the `target` attribute
			return if target.nodeName isnt 'A' or target.getAttribute('target')

			if target.host is location.host and not ///^\/static\////.test(target.pathname)
				# avoid browser to refresh page
				e.preventDefault()

				# change page to the anchor pathname
				impl.changePage target.pathname

		# change page to the current one
		setTimeout ->
			impl.changePage location.pathname

	###
	Send a XHR request and call `callback` on response.
	###
	sendRequest: (req, callback) ->

		{Request} = Networking

		xhr = new XMLHttpRequest

		# prevent caching
		uri = "#{req.uri}?now=#{Date.now()}"

		xhr.open req.method, uri, true
		xhr.setRequestHeader 'X-Expected-Type', req.type

		if req.type is Request.JSON_TYPE
			xhr.responseType = 'json'

		xhr.onload = ->
			{response} = xhr

			if req.type is Request.JSON_TYPE and typeof response is 'string'
				response = utils.tryFunction JSON.parse, null, [response], response

			callback xhr.status, response

		xhr.onerror = ->
			callback xhr.status, xhr.response

		xhr.send()
