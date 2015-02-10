'use strict'

expect = require 'expect'
utils = require 'utils'
log = require 'log'

View = require 'view'
Networking = require 'networking'

{assert} = console
log = log.scope 'Template'

CONFIG_KEYS = [] # filled by the class properties

module.exports = (App) -> class AppTemplate

	constructor: (opts) ->
		expect(@).toBe.any AppTemplate
		expect(opts).toBe.simpleObject()

		# check for unprovided options
		assert do ->
			optsKeys = utils.merge Object.keys(opts), CONFIG_KEYS
			utils.isEqual(CONFIG_KEYS, optsKeys)
		, "Unprovided config key has been passed into `App.Template`:\n" +
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
		expect(ctx).toBe.any App.Template

		if typeof val is 'string'
			view = App.views[val]

			assert view
			, "`#{val}` view file can't be found"
		else
			assert val instanceof App.View
			, "Passed template view is not an instance of a App.View; `#{val}` given"

			view = val

		ctx.view = view

	targetElem: ''

	CONFIG_KEYS.push 'targetElem'

	setTargetElem = (ctx, val) ->
		expect(ctx).toBe.any App.Template

		assert val and typeof val is 'string'
		, "App.Template targetElem must be a name of the view element (string); `#{val}` given"

		ctx.targetElem = val

	storage: null

	CONFIG_KEYS.push 'storage'

	setStorage = (ctx, val) ->
		expect(ctx).toBe.any App.Template

		ctx.storage = val

	_render: (req) ->
		expect(@).toBe.any App.Template
		expect(req).toBe.any Networking.Request

		view = @view.render req, data: @storage

		view

	_renderTarget: (view, target) ->
		for use in view.uses
			if use.name is @targetElem
				elem = use
				break

		assert elem
		, "App.Template `#{@view.view.path}` view doesn't have any `#{@targetElem}` use"

		elem.usedFragment = null # avoid destroying target, it's AppRoute job
		elem.render target
