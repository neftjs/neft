'use strict'

[utils, Dict, List] = ['utils', 'dict', 'list'].map require
coffee = require 'coffee-script' if utils.isNode

attr = [null, null]

VALUE_TO_EVAL_RE = ///^(\[|\{|Dict|List)///

forNode = (elem) ->

	i = 0
	loop
		break unless elem.attrs
		elem.attrs.item i, attr

		[name, val] = attr
		break unless name

		if VALUE_TO_EVAL_RE.test val
			try
				code = coffee.compile attr[1], bare: true
				newVal = eval code
				elem.attrs.set attr[0], newVal

		i++

	elem.children?.forEach forNode

module.exports = (File) -> (file) ->

	forNode file.node
