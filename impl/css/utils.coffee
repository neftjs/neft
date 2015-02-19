'use strict'

exports.getFontWeight = (val) ->
	Math.round(val * 8) * 100 + 100

exports.prependElement = (parent, child) ->
	if first = parent.firstChild
		parent.insertBefore child, first
	else
		parent.appendChild child