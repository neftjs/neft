View
====

	'use strict'

	utils = require 'utils'
	assert = require 'neft-assert'
	signal = require 'signal'
	log = require 'log'

	Dict = require 'dict'
	Document = require 'document'
	Networking = require 'networking'

	log = log.scope 'App', 'View'

	module.exports = (app) -> class AppView

*View* View(*Document* document)
--------------------------------

		constructor: (@document) ->
			assert.instanceOf @, AppView
			assert.instanceOf document, Document

*Document* View::document
-------------------------

		document: null

*Document* View::render(*Networking.Request* req, [*Object* data])
------------------------------------------------------------------

		render: (req, data) ->
			assert.instanceOf req, Networking.Request

			document = @document.clone()

			# data
			oldReq = DocumentGlobalData.request
			utils.defineProperty DocumentGlobalData, 'request', utils.CONFIGURABLE, req
			DocumentGlobalData.requestChanged(oldReq)

			dataObj = Object.create DocumentGlobalData
			dataObj.data = data
			document.storage = dataObj

			document.render()

			document

*Object* DocumentGlobalData
---------------------------

		DocumentGlobalData = {}
		DocumentGlobalData.global = DocumentGlobalData

*Any* DocumentGlobalData.data
-----------------------------

		DocumentGlobalData.data = null

*Signal* DocumentGlobalData.requestChanged(*Networking.Request* oldRequest)
---------------------------------------------------------------------------

		signal.create DocumentGlobalData, 'requestChanged'

*NeftApp* DocumentGlobalData.app
--------------------------------

		utils.defineProperty DocumentGlobalData, 'app', null, app

*Networking.Request* DocumentGlobalData.request
-----------------------------------------------

		utils.defineProperty DocumentGlobalData, 'request', utils.CONFIGURABLE, null

*Dict* DocumentGlobalData.uri
-----------------------------

		utils.defineProperty DocumentGlobalData, 'uri', null, do ->
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

			DocumentGlobalData.onRequestChanged ->
				req = @request

				dict.onChanged.disconnect onDictChanged

				# remove missed params
				for key in dict.keys()
					unless req.params.hasOwnProperty key
						dict.pop key

				# set new params
				for key, val of req.params
					dict.set key, val

				dict.onChanged onDictChanged

*Dict* DocumentGlobalData.uri.toString([*Any* params])
------------------------------------------------------

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
