'use strict'

exports.getFontWeight = (val) ->
	Math.round(val * 8) * 100 + 100

exports.prependElement = (parent, child) ->
	if first = parent.firstChild
		parent.insertBefore child, first
	else
		parent.appendChild child

exports.encodeImageSrc = do ->
	DATA_URI_RE = ///^data:([a-z+/]+),(.*)$///

	(val) ->
		if DATA_URI_RE.test(val)
			val.replace ///\#///g, encodeURIComponent('#')
		else
			val
