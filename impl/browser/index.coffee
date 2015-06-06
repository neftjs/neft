'use strict'

utils = require 'utils'

module.exports = (Networking) ->
	impl = {}

	Request: require('./request.coffee') Networking
	Response: require('./response.coffee') Networking, impl

	init: (networking) ->
		isReady = false

		# Send internal request to change the page based on the URI
		impl.changePage = window.location.neftChangePage = (uri) ->
			# send internal request
			res = networking.createRequest
				method: Networking.Request.GET
				type: Networking.Request.HTML_TYPE
				uri: uri

		# synchronize with browser page changing
		window.addEventListener 'popstate', ->
			if isReady
				impl.changePage location.pathname + location.search

		# don't refresh page on click anchor
		document.addEventListener 'click', (e) ->
			{target} = e

			# consider only anchors
			# omit anchors with the `target` attribute
			return if target.nodeName isnt 'A' or target.getAttribute('target')

			if target.href.indexOf(networking.url) is 0 and not ///^\/static\////.test(target.pathname)
				# avoid browser to refresh page
				e.preventDefault()

				# change page to the anchor pathname
				impl.changePage target.pathname + target.search

		# change page to the current one
		onLoaded = ->
			if document.readyState is 'complete'
				setTimeout ->
					isReady = true
					impl.changePage location.pathname + location.search
			return

		if document.readyState is 'complete'
			onLoaded()
		else
			document.addEventListener 'readystatechange', onLoaded

		return

	###
	Send a XHR request and call `callback` on response.
	###
	sendRequest: (req, res, callback) ->
		{Request} = Networking

		xhr = new XMLHttpRequest

		# prevent caching
		if utils.has(req.uri, '?')
			uri = "#{req.uri}&now=#{Date.now()}"
		else
			uri = "#{req.uri}?now=#{Date.now()}"

		xhr.open req.method, uri, true

		for name, val of req.headers
			xhr.setRequestHeader name, val
		xhr.setRequestHeader 'X-Expected-Type', req.type

		if cookies = utils.tryFunction(JSON.stringify, null, [req.cookies], null)
			xhr.setRequestHeader 'X-Cookies', cookies

		# if req.type is Request.JSON_TYPE
		# 	xhr.responseType = 'json'

		xhr.onload = ->
			{response} = xhr

			if req.type is Request.JSON_TYPE and typeof response is 'string'
				response = utils.tryFunction JSON.parse, null, [response], response

			if cookies = xhr.getResponseHeader('X-Cookies')
				cookies = utils.tryFunction JSON.parse, null, [cookies], null

			callback
				status: xhr.status
				data: response
				cookies: cookies

		xhr.onerror = ->
			callback
				status: xhr.status
				data: xhr.response

		if utils.isObject req.data
			data = utils.tryFunction JSON.stringify, null, [req.data], req.data
		else
			data = req.data
		xhr.send data
