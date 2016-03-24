neft:script @xml
================

	'use strict'

	fs = require 'fs'
	os = require 'os'

	uid = 0

	module.exports = (File) -> (file) ->
		scripts = []

		for tag in file.node.queryAll('neft:script')
			tag.parent = null

			# tag body
			str = tag.stringifyChildren()
			filename = tag.attrs.filename or "tmp#{uid++}.js"
			path = "#{os.tmpdir()}/#{filename}"
			fs.writeFileSync path, str, 'utf-8'
			scripts.push path

		if scripts.length > 0
			file.scripts = new File.Scripts file, scripts

		return
