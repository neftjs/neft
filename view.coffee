'use strict'

utils = require 'utils'
expect = require 'expect'
signal = require 'signal'
log = require 'log'

Dict = require 'dict'
Document = require 'document'
Networking = require 'networking'

log = log.scope 'App', 'View'

module.exports = (app) -> class AppView

	constructor: (@document) ->
		expect(@).toBe.any AppView
		expect(document).toBe.any Document
		expect(document.clone).toBe.function()

	document: null

	render: (req, storage) ->
		expect(req).toBe.any Networking.Request
		expect().defined(storage).toBe.object()

		document = @document.clone()

		# storage
		utils.defineProperty GlobalStorage, 'request', utils.CONFIGURABLE, req
		GlobalStorage.requestChanged req

		unless typeof storage is 'object'
			storage = null
		storageObj = Object.create storage
		storageObj.app = app
		storageObj.global = GlobalStorage
		document.storage = storageObj

		document.render()

		document

	GlobalStorage = {}
	signal.create GlobalStorage, 'requestChanged'

	utils.defineProperty GlobalStorage, 'app', null, app

	utils.defineProperty GlobalStorage, 'request', utils.CONFIGURABLE, null

	utils.defineProperty GlobalStorage, 'uri', null, do ->
		dict = new Dict
		req = null

		newRequestGoing = false
		onDictChanged = ->
			return if newRequestGoing
			newRequestGoing = true

			savedReq = req
			setImmediate ->
				newRequestGoing = false

				if savedReq isnt req
					log.info "Changed `uri` won't be proceeded due to new request"
					return

				app.httpNetworking.createRequest
					method: Networking.Request.GET
					type: Networking.Request.VIEW_TYPE
					uri: req.handler.uri.toString dict

		dict.onChanged onDictChanged

		GlobalStorage.onRequestChanged (_req) ->
			req = _req

			dict.onChanged.disconnect onDictChanged

			# remove missed params
			for key in dict.keys()
				unless req.params.hasOwnProperty key
					dict.pop key

			# set new params
			for key, val of req.params
				dict.set key, val

			dict.onChanged onDictChanged

		dict.toString = (params) ->
			if params
				req.handler.uri.toString params
			else
				req.uri

		-> dict

	, (val) ->
		app.httpNetworking.createRequest
			method: Networking.Request.GET
			type: Networking.Request.VIEW_TYPE
			uri: val
