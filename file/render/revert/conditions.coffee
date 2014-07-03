'use strict'

module.exports = (File) -> (file) ->

	{conditions, hidden} = file._tmp

	# back conditions
	while conditions.length
		attr = conditions.pop()
		node = conditions.pop()

		node.attrs.set 'if', attr

	# back hidden into visible
	while node = hidden.pop()
		node.visible = true

	null