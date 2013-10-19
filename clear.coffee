'use strict'

forEach = Array::forEach
remove = []

WHITE_SPACE_RE = ///^\s*$///

removeEmptyTexts = (node) ->

	# find nodes to remove
	for elem in node.childNodes
		if elem.nodeName is '#text' and WHITE_SPACE_RE.test elem.textContent
			remove.push elem

	# remove found nodes
	for elem in remove
		node.removeChild elem

	# clear `remove` arr
	remove.pop() while remove.length

	# check nodes recursively
	for elem in node.childNodes
		removeEmptyTexts elem

exports = module.exports = (target, callback) ->

	# remove white charts
	removeEmptyTexts target.file

	callback null