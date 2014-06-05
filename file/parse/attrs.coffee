'use strict'

[utils] = ['utils'].map require
coffee = require 'coffee-script' if utils.isNode

attr = [null, null]

forNode = (elem) ->

	i = 0
	loop
		break unless elem.attrs
		elem.attrs.item i, attr
		break unless attr[0]

		if attr[1][0] is '[' or attr[1][0] is '{'
			try
				elem.attrs.set attr[0], coffee.eval attr[1]

		i++

	elem.children?.forEach forNode

module.exports = (File) -> (file) ->

	forNode file.node
