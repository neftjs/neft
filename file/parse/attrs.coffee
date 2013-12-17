'use strict'

coffee = require 'coffee-script'

attr = [null, null]

forNode = (elem) ->

	i = 0
	loop
		elem.attrs.item i, attr
		unless attr[0] then break

		if attr[1][0] is '[' or attr[1][0] is '{'
			try
				elem.attrs.set attr[0], coffee.eval attr[1]

		i++

	elem.children?.forEach forNode

module.exports = (File) -> (_super) -> (file) ->

	_super.call null, file

	forNode file.node
