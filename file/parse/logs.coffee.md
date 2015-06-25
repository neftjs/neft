neft:log @xml
=============

	'use strict'

	module.exports = (File) -> (file) ->
		file.logs = []

		for node in file.node.queryAll('neft:log')
			file.logs.push new File.Log node

		return