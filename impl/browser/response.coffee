'use strict'

[log, View] = ['log', 'view'].map require
utils = require 'utils'
Renderer = require 'renderer'

log = log.scope 'Routing'

messagesContainer = document.createElement 'div'
window.addEventListener 'load', ->
	document.body.insertBefore messagesContainer, document.body.firstChild

module.exports = (Routing) ->

	showAsJson = (data) ->
		unless utils.isPlainObject data
			return false

		unless json = utils.tryFunction(JSON.stringify, null, [data, null, 4])
			log.warn "Response is an object but can't be stringified into JSON"
			return false

		messagesContainer.innerHTML = "<pre>#{json}</pre>"
		true

	showAsError = (data) ->
		unless data instanceof Error
			return false

		unless showAsJson(utils.errorToObject data)
			return false

		true

	showAsResponseError = (data) ->
		unless data instanceof Routing.Response.Error
			return false

		messagesContainer.innerHTML = "<h1>Error #{data.status}</h1>" +
		                              "<h2>#{data.message}</h2>" +
		                              "<em>#{data.name}</em>"
		true

	showAsHtml = (data) ->
		unless data instanceof View
			return false

		messagesContainer.innerHTML = data.node.stringify()

		true

	showAsStyles = (data) ->
		unless data instanceof View
			return false

		{styles} = data
		unless styles.length
			log.warn "Can't find any `neft:style` in main view file"
			return false

		for style in styles
			style.item.parent = Renderer.window

		true

	send: (res, data, callback) ->
		log.ok "Got response `#{res.request.method} #{res.request.url}`"

		# clear messages container
		while child = messagesContainer.firstChild
			messagesContainer.removeChild child

		# render data
		if showAsStyles(data)
			log.ok "Response has been showed as styles"
		else if showAsHtml(data)
			log.ok "Response has been showed as HTML"
		else if showAsResponseError(data)
			log.ok "Response has been showed as a response error"
		else if showAsError(data)
			log.ok "Response has been showed as an error"
		else if showAsJson(data)
			log.ok "Response has been showed as JSON"
		else
			log.error "Can't find a data handler for the response"

		callback()

	setHeader: ->