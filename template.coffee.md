Template
========

	'use strict'

	assert = require 'neft-assert'
	utils = require 'utils'
	log = require 'log'

	Document = require 'document'
	Networking = require 'networking'

	log = log.scope 'App', 'Template'

	CONFIG_KEYS = [] # filled by the class properties

	module.exports = (app) -> class AppTemplate

*Template* Template(*Object* options)
-------------------------------------

		constructor: (opts) ->
			assert.instanceOf @, AppTemplate
			assert.isPlainObject opts

			# check for unprovided options
			assert do ->
				optsKeys = utils.merge Object.keys(opts), CONFIG_KEYS
				utils.isEqual(CONFIG_KEYS, optsKeys)
			, "Unprovided config key has been passed into `app.Template`:\n" +
			  "#{JSON.stringify opts, null, 4}"

			# view
			setView @, opts.view

			# viewTargetUse
			setViewTargetUse @, opts.viewTargetUse

			# data
			if opts.data?
				setData @, opts.data

			# set object as immutable
			Object.freeze @

*app.View* Template::view
-------------------------

		view: null

		CONFIG_KEYS.push 'view'

		setView = (ctx, val) ->
			assert.instanceOf ctx, AppTemplate

			if typeof val is 'string'
				view = app.views[val]

				assert view
				, "`#{val}` view file can't be found"
			else
				assert.instanceOf val, app.View

				view = val

			ctx.view = view

*String* Template::viewTargetUse
--------------------------------

		viewTargetUse: ''

		CONFIG_KEYS.push 'viewTargetUse'

		setViewTargetUse = (ctx, val) ->
			assert.instanceOf ctx, AppTemplate
			assert.isString val

			ctx.viewTargetUse = val

*Any* Template::data
--------------------

		data: null

		CONFIG_KEYS.push 'data'

		setData = (ctx, val) ->
			assert.instanceOf ctx, AppTemplate

			ctx.data = val

		_render: (req) ->
			assert.instanceOf @, AppTemplate
			assert.instanceOf req, Networking.Request

			view = @view.render req, @data

			view

		_renderTarget: (document, target) ->
			for use in document.uses
				if use.name is @viewTargetUse
					elem = use
					break

			assert elem
			, "app.Template `#{@view.document.path}` view doesn't have any `#{@viewTargetUse}` use"

			elem.usedFragment = null # avoid destroying target, it's AppRoute job
			elem.render target
