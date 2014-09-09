'use strict'

[utils] = ['utils'].map require

impl = {}

module.exports = (Routing) ->
	Request: require('./request.coffee') Routing, impl
	Response: require('./response.coffee') Routing, impl

	init: (routing) ->

		# Send internal request to change the page based on the URI
		changePage = (uri) =>

			# change browser URI in the history
			history.pushState null, '', uri

			# send internal request
			uid = utils.uid()

			res = routing.handleRequest
				uid: uid
				method: routing.constructor.Request.GET
				uri: uri.slice 1
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
		changePage location.pathname

	###
	Send a XHR request and call `callback` on response.
	###
	sendServerRequest: (routing, opts, callback) ->

		Request = routing.constructor.Request

		xhr = new XMLHttpRequest

		xhr.open opts.method, opts.url, true
		xhr.setRequestHeader 'X-Expected-Type', opts.type

		if opts.type is Request.OBJECT_TYPE
			xhr.responseType = 'json'

		xhr.onload = ->
			{response} = xhr

			if opts.type is Request.OBJECT_TYPE and typeof response is 'string'
				response = utils.tryFunc JSON.parse, null, [response], response

			callback xhr.status, response

		xhr.onerror = ->
			# TODO

		xhr.send()