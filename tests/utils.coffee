'use strict'

View = Neft?.Document or require '../index.coffee.md'
utils = require 'neft-utils'

VIEWS_CACHE_FILE = "tmp/views.json"

loaded = false

exports.uid = do (i = 0) -> -> "index_#{i++}.html"

exports.createView = do ->
	getViewPath = (viewUid) ->
		"tmp/views/#{viewUid}.json"

	if utils.isNode
		(html, viewUid = exports.uid()) ->
			loaded = true
			view = View.fromHTML viewUid, html
			View.parse view
			view
	else
		cache = require VIEWS_CACHE_FILE
		if utils.isClient and modules?
			View.Scripts.scriptFiles = modules
		for _, json of cache
			View.fromJSON json
		(html, viewUid = exports.uid()) ->
			unless loaded
				loaded = true
			view = View._files[viewUid]
			view

exports.renderParse = (view, opts) ->
	view.render opts?.attrs, opts?.storage, opts?.source
	view.revert()
	view.render opts?.attrs, opts?.storage, opts?.source

if utils.isNode
	process.on 'exit', ->
		unless loaded
			return
		fs = require 'fs-extra'
		try
			fs.outputFileSync VIEWS_CACHE_FILE, JSON.stringify(View._files)
		catch err
			console.error err
