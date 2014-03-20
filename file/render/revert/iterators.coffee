'use strict'

module.exports = (File) -> (file) ->
	
	{iterators} = file._tmp

	# back iterators
	while iterators.length
		attr = iterators.pop()
		node = iterators.pop()
		node.attrs.set 'each', attr

	null