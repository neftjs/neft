'use strict'

View = require '../index.coffee.md'
utils = require 'neft-utils'

exports.uid = do (i = 0) -> -> "index_#{i++}.html"

exports.renderParse = (view, opts) ->
	view.storage = opts?.storage
	view.render opts?.source

	view.revert()

	view.storage = opts?.storage
	view.render opts?.source
