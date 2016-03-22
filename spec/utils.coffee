'use strict'

View = require '../index.coffee.md'
utils = require 'neft-utils'

exports.uid = do (i = 0) -> -> "index_#{i++}.html"

exports.renderParse = (view, opts) ->
	view.render opts?.storage, opts?.source
	view.revert()
	view.render opts?.storage, opts?.source
