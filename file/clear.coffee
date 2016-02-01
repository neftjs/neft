'use strict'

module.exports = (File) ->
	{Element} = File
	{Tag, Text} = Element

	checkNode = (node) ->
		if node instanceof Text
			# trim
			node.text = node.text.replace /^[\s\uFEFF\xA0]+/g, ''
			node.text = node.text.replace /([^\r\n]+)(?:[\s\uFEFF\xA0]+)$/g, '$1'

			# remove empty texts
			if node.text.length is 0
				node.parent = null

		# check nodes recursively
		if node instanceof Tag
			for child in node.children by -1
				checkNode child

		return
