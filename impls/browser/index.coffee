'use strict'

[utils] = ['utils'].map require

impl = {}

exports.Request = require('./request.coffee') impl
exports.Response = require('./response.coffee') impl

exports.init = ->

	# Send internal request to change the page based on the URI
	changePage = (uri) =>

		# change browser URI in the history
		history.pushState null, '', uri

		# send internal request
		uid = utils.uid()

		res = @handleRequest
			uid: uid
			method: @constructor.GET
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

exports.sendRequest = (opts, callback) ->

	xhr = new XMLHttpRequest

	xhr.open opts.method, opts.url, true
	xhr.setRequestHeader 'X-Expected-Type', 'object' # TODO: use `Request` type
	xhr.responseType = 'json'
	xhr.onload = ->
		response = xhr.response
		if typeof response is 'string'
			response = utils.tryFunc JSON.parse, null, [response], response
		callback xhr.status, response

	xhr.send()