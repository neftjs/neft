'use strict'

[utils] = ['utils'].map require

module.exports = (Routing) ->
	Request: require('./request.coffee') Routing
	Response: require('./response.coffee') Routing

	init: (routing) ->

		# Send internal request to change the page based on the URI
		changePage = (uri) =>

			# change browser URI in the history
			history.pushState null, '', uri

			# send internal request
			uid = utils.uid()

			res = routing.createRequest
				uid: uid
				method: Routing.Request.GET
				type: Routing.Request.VIEW_TYPE
				url: uri
				data: null

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
	sendRequest: (url, req, callback) ->

		{Request} = Routing

		xhr = new XMLHttpRequest

		xhr.open req.method, url, true
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