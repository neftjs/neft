'use strict'

log = require 'log'
utils = require 'utils'
View = require 'view'
Renderer = require 'renderer'

log = log.scope 'Routing'

module.exports = (Routing) ->

	showAsStyles = (data) ->
		unless data instanceof View
			return false

		{styles} = data
		unless styles.length
			log.warn "Can't find any `neft:style` in main view file"
			return false

		hasItems = false
		for style in styles
			if style.item
				hasItems = true
				style.item.parent = Renderer.window

		hasItems

	uriPop = false
	window.addEventListener 'popstate', ->
		uriPop = true

	send: (res, data, callback) ->
		# render data
		if showAsStyles(data)
			# change browser URI in the history
			if uriPop
				uriPop = false
			else
				history.pushState null, '', res.request.uri

		callback()

	setHeader: ->
