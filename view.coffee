'use strict'

utils = require 'utils'
expect = require 'expect'
signal = require 'signal'
log = require 'log'

Dict = require 'dict'
View = require 'view'
Routing = require 'routing'

log = log.scope 'App', 'View'

module.exports = (App) -> class AppView

	constructor: (@view) ->
		expect(@).toBe.any AppView
		expect(view).toBe.any View
		expect(view.clone).toBe.function()

	view: null

	render: (req, storage) ->
		expect(req).toBe.any Routing.Request
		expect().defined(storage).toBe.object()

		view = @view.clone()

		# storage
		GlobalStorage.requestChanged req

		# BUG: can't use it, because accessors are used in the GlobalStorage
		storageObj = utils.setPrototypeOf GlobalStorage, storage
		view.storage = storageObj

		view.render()

		view

	GlobalStorage = {}
	signal.create GlobalStorage, 'requestChanged'

	utils.defProp GlobalStorage, '__uri__', '', do ->
		dict = new Dict
		req = null

		newRequestGoing = false
		onDictChanged = ->
			return if newRequestGoing

			savedReq = req
			setImmediate ->
				if savedReq isnt req
					log.info "Changed `__uri__` won't be proceeded due to new request"
					return

				App.routing.createRequest
					method: Routing.GET
					uri: req.handler.uri.toString dict

		dict.onChanged onDictChanged

		GlobalStorage.onRequestChanged (_req) ->
			req = _req

			dict.changed.disconnect onDictChanged

			# remove missed params
			for key in dict.keys()
				unless req.params.hasOwnProperty key
					dict.pop key

			# set new params
			for key, val of req.params
				dict.set key, val

			dict.onChanged onDictChanged

		dict.toString = ->
			req.uri

		-> dict

	, (val) ->
		App.routing.createRequest
			method: Routing.GET
			uri: val
