'use strict'

expect = require 'expect'
utils = require 'utils'
log = require 'log'

Document = require 'document'
Networking = require 'networking'

{assert} = console
log = log.scope 'Template'

CONFIG_KEYS = [] # filled by the class properties

module.exports = (app) -> class AppTemplate

	constructor: (opts) ->
		expect(@).toBe.any AppTemplate
		expect(opts).toBe.simpleObject()

		# check for unprovided options
		assert do ->
			optsKeys = utils.merge Object.keys(opts), CONFIG_KEYS
			utils.isEqual(CONFIG_KEYS, optsKeys)
		, "Unprovided config key has been passed into `app.Template`:\n" +
		  "#{JSON.stringify opts, null, 4}"

		# view
		setView @, opts.view

		# targetElem
		setTargetElem @, opts.targetElem

		# storage
		if opts.storage?
			setStorage @, opts.storage

		# set object as immutable
		Object.freeze @

	view: null

	CONFIG_KEYS.push 'view'

	setView = (ctx, val) ->
		expect(ctx).toBe.any app.Template

		if typeof val is 'string'
			document = app.documents[val]

			assert document
			, "`#{val}` document file can't be found"
		else
			assert val instanceof app.View
			, "Passed template document is not an instance of a app.View; `#{val}` given"

			document = val

		ctx.view = document

	targetElem: ''

	CONFIG_KEYS.push 'targetElem'

	setTargetElem = (ctx, val) ->
		expect(ctx).toBe.any app.Template

		assert val and typeof val is 'string'
		, "app.Template targetElem must be a name of the view element (string); `#{val}` given"

		ctx.targetElem = val

	storage: null

	CONFIG_KEYS.push 'storage'

	setStorage = (ctx, val) ->
		expect(ctx).toBe.any app.Template

		ctx.storage = val

	_render: (req) ->
		expect(@).toBe.any app.Template
		expect(req).toBe.any Networking.Request

		view = @view.render req, data: @storage

		view

	_renderTarget: (document, target) ->
		for use in document.uses
			if use.name is @targetElem
				elem = use
				break

		assert elem
		, "app.Template `#{@view.document.path}` view doesn't have any `#{@targetElem}` use"

		elem.usedFragment = null # avoid destroying target, it's AppRoute job
		elem.render target
