'use strict'

log = require 'log'
utils = require 'utils'
Document = require 'document'
Renderer = require 'renderer'

log = log.scope 'Networking'

module.exports = (Networking) ->
	showAsStyles = (data) ->
		unless data instanceof Document
			return false

		{styles} = data
		unless styles?.length
			log.warn "No `neft:style` found in main view"
			return false

		Renderer.window.document.node = data.node
		hasItems = false
		for style in styles
			if style.item
				hasItems = true
				style.item.parent ?= Renderer.window
				if style.isScope
					style.item.document.onShow.emit()

		hasItems

	send: (res, data, callback) ->
		# render data
		showAsStyles(data)

		callback()

	setHeader: ->

	redirect: (res, status, uri, callback) ->
		__location.append uri
		callback()
